From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 07 Dec 2016 11:04:41 +1100
Subject: [PATCH] ipmi: bt-bmc: Use a regmap for register access
In-Reply-To: <36014e0c-82f8-eeaf-ee2a-6c1e413b957d@kaod.org>
References: <20161206025715.2002-1-andrew@aj.id.au>
 <36014e0c-82f8-eeaf-ee2a-6c1e413b957d@kaod.org>
Message-ID: <1481069081.7840.3.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-12-06 at 16:02 +0100, C?dric Le Goater wrote:
> [ this is a resend bc of some mailing list issues]?

Thanks for resending.

> 
> On 12/06/2016 03:57 AM, Andrew Jeffery wrote:
> > The registers for the bt-bmc device live under the Aspeed LPC
> > controller. Devicetree bindings have recently been introduced for the
> > LPC controller where the "host" portion of the LPC register space is
> > described as a syscon device. Future devicetrees describing the bt-bmc
> > device should nest its node under the appropriate "simple-mfd", "syscon"
> > compatible node.
> > 
> > This change allows the bt-bmc driver to function with both syscon and
> > non-syscon- based devicetree descriptions by always using a regmap for
> > register access, either retrieved from the parent syscon device or
> > instantiated if none exists.
> > 
> > The patch has been tested on an OpenPOWER Palmetto machine, successfully
> > booting, rebooting and powering down the host.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> It would be nice to have an example of the associated binding.?
> I did not see it.

Essentially because the approach of the patch means there's no required
change to the bindings documentation. So, pulling together the various
patches I've sent out, a partial devicetree using the new bindings
might look something like:

lpc: lpc at 1e789000 {
	compatible = "aspeed,ast2500-lpc", "simple-mfd";
	reg = <0x1e789000 0x1000>;

	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0x1e789000 0x1000>;

	lpc_bmc: lpc-bmc at 0 {
		compatible = "aspeed,ast2500-lpc-bmc";
		reg = <0x0 0x80>;
		reg-io-width = <1>;
	};

	lpc_host: lpc-host at 80 {
		compatible = "aspeed,ast2500-lpc-host", "simple-mfd", "syscon";
		reg = <0x80 0x1e0>;

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0 0x80 0x1e0>;

		reg-io-width = <4>;

		ibt: ibt at c0 {
			compatible = "aspeed,ast2400-bt-bmc";
			reg = <0xc0 0x18>;
			interrupts = <8>;
		};
	};
};

It's a bit tedious, but as mentioned in the commit message we need a
way to arbitrate access to other registers in the "host" portion of the
LPC controller amongst other complications, and this layout gives us
that capability without breaking any existing bindings.

Andrew


>  A part from that :
> 
> > Reviewed-by: C?dric Le Goater <clg@kaod.org>
> 
> Thanks,
> 
> C.
> 
> > ---
> > ?drivers/char/ipmi/Kconfig??|??1 +
> > ?drivers/char/ipmi/bt-bmc.c | 82 ++++++++++++++++++++++++++++++++++------------
> > ?2 files changed, 62 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
> > index 7f816655cbbf..b5d48d9af124 100644
> > --- a/drivers/char/ipmi/Kconfig
> > +++ b/drivers/char/ipmi/Kconfig
> > @@ -79,6 +79,7 @@ endif # IPMI_HANDLER
> > ?
> > ?config ASPEED_BT_IPMI_BMC
> > > > ?	depends on ARCH_ASPEED
> > +????????depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
> > > > ?	tristate "BT IPMI bmc driver"
> > > > ?	help
> > > > ?	??Provides a driver for the BT (Block Transfer) IPMI interface
> > diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> > index fc9e8891eae3..ca1e20f6c6c5 100644
> > --- a/drivers/char/ipmi/bt-bmc.c
> > +++ b/drivers/char/ipmi/bt-bmc.c
> > @@ -12,10 +12,13 @@
> > ?#include <linux/errno.h>
> > ?#include <linux/interrupt.h>
> > ?#include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> > ?#include <linux/miscdevice.h>
> > ?#include <linux/module.h>
> > +#include <linux/of.h>
> > ?#include <linux/platform_device.h>
> > ?#include <linux/poll.h>
> > +#include <linux/regmap.h>
> > ?#include <linux/sched.h>
> > ?#include <linux/timer.h>
> > ?
> > @@ -60,7 +63,8 @@
> > ?struct bt_bmc {
> > > > > > ?	struct device		dev;
> > > > > > ?	struct miscdevice	miscdev;
> > > > > > -	void __iomem		*base;
> > > > > > +	struct regmap		*map;
> > > > > > +	int			offset;
> > > > > > ?	int			irq;
> > > > > > ?	wait_queue_head_t	queue;
> > > > > > ?	struct timer_list	poll_timer;
> > @@ -69,14 +73,31 @@ struct bt_bmc {
> > ?
> > ?static atomic_t open_count = ATOMIC_INIT(0);
> > ?
> > +static struct regmap_config bt_regmap_cfg = {
> > > > +	.reg_bits = 32,
> > > > +	.val_bits = 32,
> > > > +	.reg_stride = 4,
> > +};
> > +
> > ?static u8 bt_inb(struct bt_bmc *bt_bmc, int reg)
> > ?{
> > > > -	return ioread8(bt_bmc->base + reg);
> > > > +	uint32_t val = 0;
> > > > +	int rc;
> > +
> > > > +	rc = regmap_read(bt_bmc->map, bt_bmc->offset + reg, &val);
> > > > +	WARN(rc != 0, "%s:%d: regmap_read() failed: %d\n",
> > > > +			__FILE__, __LINE__, rc);
> > +
> > > > +	return rc == 0 ? (u8) val : 0;
> > ?}
> > ?
> > ?static void bt_outb(struct bt_bmc *bt_bmc, u8 data, int reg)
> > ?{
> > > > -	iowrite8(data, bt_bmc->base + reg);
> > > > +	int rc;
> > +
> > > > +	rc = regmap_write(bt_bmc->map, bt_bmc->offset + reg, data);
> > > > +	WARN(rc != 0, "%s:%d: regmap_write() failed: %d\n",
> > > > +			__FILE__, __LINE__, rc);
> > ?}
> > ?
> > ?static void clr_rd_ptr(struct bt_bmc *bt_bmc)
> > @@ -367,14 +388,18 @@ static irqreturn_t bt_bmc_irq(int irq, void *arg)
> > ?{
> > > > ?	struct bt_bmc *bt_bmc = arg;
> > > > ?	u32 reg;
> > > > +	int rc;
> > +
> > > > +	rc = regmap_read(bt_bmc->map, bt_bmc->offset + BT_CR2, &reg);
> > > > +	if (rc)
> > > > +		return IRQ_NONE;
> > ?
> > > > -	reg = ioread32(bt_bmc->base + BT_CR2);
> > > > ?	reg &= BT_CR2_IRQ_H2B | BT_CR2_IRQ_HBUSY;
> > > > ?	if (!reg)
> > > > ?		return IRQ_NONE;
> > ?
> > > > ?	/* ack pending IRQs */
> > > > -	iowrite32(reg, bt_bmc->base + BT_CR2);
> > > > +	regmap_write(bt_bmc->map, bt_bmc->offset + BT_CR2, reg);
> > ?
> > > > ?	wake_up(&bt_bmc->queue);
> > > > ?	return IRQ_HANDLED;
> > @@ -384,7 +409,6 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
> > > > ?			?????struct platform_device *pdev)
> > ?{
> > > > ?	struct device *dev = &pdev->dev;
> > > > -	u32 reg;
> > > > ?	int rc;
> > ?
> > > > ?	bt_bmc->irq = platform_get_irq(pdev, 0);
> > @@ -405,18 +429,17 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
> > > > ?	?* will be cleared (along with B2H) when we can write the next
> > > > ?	?* message to the BT buffer
> > > > ?	?*/
> > > > -	reg = ioread32(bt_bmc->base + BT_CR1);
> > > > -	reg |= BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY;
> > > > -	iowrite32(reg, bt_bmc->base + BT_CR1);
> > > > +	rc = regmap_update_bits(bt_bmc->map, bt_bmc->offset + BT_CR1,
> > > > +				(BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY),
> > > > +				(BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY));
> > ?
> > > > -	return 0;
> > > > +	return rc;
> > ?}
> > ?
> > ?static int bt_bmc_probe(struct platform_device *pdev)
> > ?{
> > > > ?	struct bt_bmc *bt_bmc;
> > > > ?	struct device *dev;
> > > > -	struct resource *res;
> > > > ?	int rc;
> > ?
> > > > ?	if (!pdev || !pdev->dev.of_node)
> > @@ -431,10 +454,27 @@ static int bt_bmc_probe(struct platform_device *pdev)
> > ?
> > > > ?	dev_set_drvdata(&pdev->dev, bt_bmc);
> > ?
> > > > -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > -	bt_bmc->base = devm_ioremap_resource(&pdev->dev, res);
> > > > -	if (IS_ERR(bt_bmc->base))
> > > > -		return PTR_ERR(bt_bmc->base);
> > > > +	bt_bmc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
> > > > +	if (IS_ERR(bt_bmc->map)) {
> > > > +		struct resource *res;
> > > > +		void __iomem *base;
> > +
> > > > +		/*
> > > > +		?* Assume it's not the MFD-based devicetree description, in
> > > > +		?* which case generate a regmap ourselves
> > > > +		?*/
> > > > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +		base = devm_ioremap_resource(&pdev->dev, res);
> > > > +		if (IS_ERR(base))
> > > > +			return PTR_ERR(base);
> > +
> > > > +		bt_bmc->map = devm_regmap_init_mmio(dev, base, &bt_regmap_cfg);
> > > > +		bt_bmc->offset = 0;
> > > > +	} else {
> > > > +		rc = of_property_read_u32(dev->of_node, "reg", &bt_bmc->offset);
> > > > +		if (rc)
> > > > +			return rc;
> > > > +	}
> > ?
> > > > ?	mutex_init(&bt_bmc->mutex);
> > > > ?	init_waitqueue_head(&bt_bmc->queue);
> > @@ -461,12 +501,12 @@ static int bt_bmc_probe(struct platform_device *pdev)
> > > > ?		add_timer(&bt_bmc->poll_timer);
> > > > ?	}
> > ?
> > > > -	iowrite32((BT_IO_BASE << BT_CR0_IO_BASE) |
> > > > -		??(BT_IRQ << BT_CR0_IRQ) |
> > > > -		??BT_CR0_EN_CLR_SLV_RDP |
> > > > -		??BT_CR0_EN_CLR_SLV_WRP |
> > > > -		??BT_CR0_ENABLE_IBT,
> > > > -		??bt_bmc->base + BT_CR0);
> > > > +	regmap_write(bt_bmc->map, bt_bmc->offset + BT_CR0,
> > > > +		?????(BT_IO_BASE << BT_CR0_IO_BASE) |
> > > > +		?????(BT_IRQ << BT_CR0_IRQ) |
> > > > +		?????BT_CR0_EN_CLR_SLV_RDP |
> > > > +		?????BT_CR0_EN_CLR_SLV_WRP |
> > > > +		?????BT_CR0_ENABLE_IBT);
> > ?
> > > > ?	clr_b_busy(bt_bmc);
> > ?
> > 
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/5506c9cf/attachment-0001.sig>
