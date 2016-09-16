From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Fri, 16 Sep 2016 15:00:26 +0200
Subject: [PATCH v2 1/3] ipmi: add an Aspeed BT IPMI BMC driver
In-Reply-To: <20160916122949.GA23381@Red>
References: <1474022367-21029-1-git-send-email-clg@kaod.org>
 <1474022367-21029-2-git-send-email-clg@kaod.org> <20160916122949.GA23381@Red>
Message-ID: <fb5eceb0-a546-6d8b-949e-7191f2d0073d@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2016 02:29 PM, LABBE Corentin wrote:
> Hello
> 
> I have some minor comment below:
> 
> On Fri, Sep 16, 2016 at 12:39:25PM +0200, C?dric Le Goater wrote:
>> From: Alistair Popple <alistair@popple.id.au>
>>
>> This patch adds a simple device driver to expose the iBT interface on
>> Aspeed SOCs (AST2400 and AST2500) as a character device. Such SOCs are
>> commonly used as BMCs (BaseBoard Management Controllers) and this
>> driver implements the BMC side of the BT interface.
>>
>> The BT (Block Transfer) interface is used to perform in-band IPMI
>> communication between a host and its BMC. Entire messages are buffered
>> before sending a notification to the other end, host or BMC, that
>> there is data to be read. Usually, the host emits requests and the BMC
>> responses but the specification provides a mean for the BMC to send
>> SMS Attention (BMC-to-Host attention or System Management Software
>> attention) messages.
>>
>> For this purpose, the driver introduces a specific ioctl on the
>> device: 'BT_BMC_IOCTL_SMS_ATN' that can be used by the system running
>> on the BMC to signal the host of such an event.
>>
>> The device name defaults to '/dev/ipmi-bt-host'
>>
>> Signed-off-by: Alistair Popple <alistair@popple.id.au>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> [clg: - checkpatch fixes
>>       - added a devicetree binding documentation
>>       - replace 'bt_host' by 'bt_bmc' to reflect that the driver is
>>         the BMC side of the IPMI BT interface
>>       - renamed the device to 'ipmi-bt-host'
>>       - introduced a temporary buffer to copy_{to,from}_user
>>       - used platform_get_irq()
>>       - moved the driver under drivers/char/ipmi/ but kept it as a misc
>>         device
>>       - changed the compatible cell to "aspeed,ast2400-bt-bmc"
>> ]
>> Signed-off-by: C?dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v1:
>>
>>  - replace 'bt_host' by 'bt_bmc' to reflect that the driver is
>>    the BMC side of the IPMI BT interface
>>  - renamed the device to 'ipmi-bt-host'
>>  - introduced a temporary buffer to copy_{to,from}_user
>>  - used platform_get_irq()
>>  - moved the driver under drivers/char/ipmi/ but kept it as a misc
>>    device
>>  - changed the compatible cell to "aspeed,ast2400-bt-bmc"
>>
>>  .../bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt   |  23 +
>>  drivers/Makefile                                   |   2 +-
>>  drivers/char/ipmi/Kconfig                          |   7 +
>>  drivers/char/ipmi/Makefile                         |   1 +
>>  drivers/char/ipmi/bt-bmc.c                         | 486 +++++++++++++++++++++
>>  include/uapi/linux/Kbuild                          |   1 +
>>  include/uapi/linux/bt-bmc.h                        |  18 +
>>  7 files changed, 537 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
>>  create mode 100644 drivers/char/ipmi/bt-bmc.c
>>  create mode 100644 include/uapi/linux/bt-bmc.h
>>
>> diff --git a/Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt b/Documentation/devicetree/bindings/char/ipmi/aspeed,ast2400-bt-bmc.txt
>> new file mode 100644
>> index 000000000000..fbbacd958240
>> --- /dev/null
> 
> [..]
> 
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/errno.h>
>> +#include <linux/poll.h>
>> +#include <linux/sched.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/slab.h>
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/delay.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/timer.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/bt-bmc.h>
> 
> Please sort them in alphabetical order, some of them seems not needed also (like spinlock.h)

sure. I will clean them up.

>> +
>> +/*
>> + * This is a BMC device used to communicate to the host
>> + */
>> +#define DEVICE_NAME	"ipmi-bt-host"
>> +
>> +#define BT_IO_BASE	0xe4
>> +#define BT_IRQ		10
>> +
>> +#define BT_CR0		0x0
>> +#define   BT_CR0_IO_BASE		16
>> +#define   BT_CR0_IRQ			12
>> +#define   BT_CR0_EN_CLR_SLV_RDP		0x8
>> +#define   BT_CR0_EN_CLR_SLV_WRP		0x4
>> +#define   BT_CR0_ENABLE_IBT		0x1
>> +#define BT_CR1		0x4
>> +#define   BT_CR1_IRQ_H2B	0x01
>> +#define   BT_CR1_IRQ_HBUSY	0x40
>> +#define BT_CR2		0x8
>> +#define   BT_CR2_IRQ_H2B	0x01
>> +#define   BT_CR2_IRQ_HBUSY	0x40
>> +#define BT_CR3		0xc
>> +#define BT_CTRL		0x10
>> +#define   BT_CTRL_B_BUSY		0x80
>> +#define   BT_CTRL_H_BUSY		0x40
>> +#define   BT_CTRL_OEM0			0x20
>> +#define   BT_CTRL_SMS_ATN		0x10
>> +#define   BT_CTRL_B2H_ATN		0x08
>> +#define   BT_CTRL_H2B_ATN		0x04
>> +#define   BT_CTRL_CLR_RD_PTR		0x02
>> +#define   BT_CTRL_CLR_WR_PTR		0x01
>> +#define BT_BMC2HOST	0x14
>> +#define BT_INTMASK	0x18
>> +#define   BT_INTMASK_B2H_IRQEN		0x01
>> +#define   BT_INTMASK_B2H_IRQ		0x02
>> +#define   BT_INTMASK_BMC_HWRST		0x80
> 
> Why to use 3 space after some define ?

The difference in alignment is to distinguish the register number from 
the bits signification. Is that OK ? 

> [..]
> 
>> +
>> +#define BT_BMC_BUFFER_SIZE 256
> 
> Put this define with others
> 
> [..]

ok

>> +
>> +static irqreturn_t bt_bmc_irq(int irq, void *arg)
>> +{
>> +	struct bt_bmc *bt_bmc = arg;
>> +	uint32_t reg;
> 
> u32 is prefered other uint32_t, do you have run checkpatch --strict ?

no. I just did and I see it is catching quite a few new issues. I will 
send a v3 with fixes.

>> +
>> +	reg = ioread32(bt_bmc->base + BT_CR2);
>> +	reg &= BT_CR2_IRQ_H2B | BT_CR2_IRQ_HBUSY;
>> +	if (!reg)
>> +		return IRQ_NONE;
>> +
>> +	/* ack pending IRQs */
>> +	iowrite32(reg, bt_bmc->base + BT_CR2);
>> +
>> +	wake_up(&bt_bmc->queue);
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
>> +		struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	uint32_t reg;
>> +	int rc;
>> +
>> +	bt_bmc->irq = platform_get_irq(pdev, 0);
>> +	if (!bt_bmc->irq)
>> +		return -ENODEV;
>> +
>> +	rc = devm_request_irq(dev, bt_bmc->irq, bt_bmc_irq, IRQF_SHARED,
>> +			DEVICE_NAME, bt_bmc);
>> +	if (rc < 0) {
>> +		dev_warn(dev, "Unable to request IRQ %d\n", bt_bmc->irq);
>> +		bt_bmc->irq = 0;
>> +		return rc;
>> +	}
>> +
>> +	/* Configure IRQs on the bmc clearing the H2B and HBUSY bits;
>> +	 * H2B will be asserted when the bmc has data for us; HBUSY
>> +	 * will be cleared (along with B2H) when we can write the next
>> +	 * message to the BT buffer
>> +	 */
> 
> This comment doesnt have the style recommended for new driver.

ah yes. I missed that one. 

>> +	reg = ioread32(bt_bmc->base + BT_CR1);
>> +	reg |= BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY;
>> +	iowrite32(reg, bt_bmc->base + BT_CR1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int bt_bmc_probe(struct platform_device *pdev)
>> +{
>> +	struct bt_bmc *bt_bmc;
>> +	struct device *dev;
>> +	struct resource *res;
>> +	int rc;
>> +
>> +	if (!pdev || !pdev->dev.of_node)
>> +		return -ENODEV;
>> +
>> +	dev = &pdev->dev;
>> +	dev_info(dev, "Found bt bmc device\n");
>> +
>> +	bt_bmc = devm_kzalloc(dev, sizeof(*bt_bmc), GFP_KERNEL);
>> +	if (!bt_bmc)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(&pdev->dev, bt_bmc);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "Unable to find resources\n");
>> +		rc = -ENXIO;
>> +		goto out_free;
>> +	}
>> +
>> +	bt_bmc->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (!bt_bmc->base) {
>> +		rc = -ENOMEM;
>> +		goto out_free;
>> +	}
>> +
>> +	init_waitqueue_head(&bt_bmc->queue);
>> +
>> +	bt_bmc->miscdev.minor	= MISC_DYNAMIC_MINOR,
>> +	bt_bmc->miscdev.name	= DEVICE_NAME,
>> +	bt_bmc->miscdev.fops	= &bt_bmc_fops,
>> +	bt_bmc->miscdev.parent = dev;
>> +	rc = misc_register(&bt_bmc->miscdev);
>> +	if (rc) {
>> +		dev_err(dev, "Unable to register device\n");
> 
> Be more precise by saying misc device

ok

> 
>> +		goto out_unmap;
>> +	}
>> +
>> +	bt_bmc_config_irq(bt_bmc, pdev);
>> +
>> +	if (bt_bmc->irq) {
>> +		dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
>> +	} else {
>> +		dev_info(dev, "No IRQ; using timer\n");
>> +		setup_timer(&bt_bmc->poll_timer, poll_timer,
>> +				(unsigned long)bt_bmc);
>> +		bt_bmc->poll_timer.expires = jiffies + msecs_to_jiffies(10);
>> +		add_timer(&bt_bmc->poll_timer);
>> +	}
>> +
>> +	iowrite32((BT_IO_BASE << BT_CR0_IO_BASE) |
>> +		  (BT_IRQ << BT_CR0_IRQ) |
>> +		  BT_CR0_EN_CLR_SLV_RDP |
>> +		  BT_CR0_EN_CLR_SLV_WRP |
>> +		  BT_CR0_ENABLE_IBT,
>> +		  bt_bmc->base + BT_CR0);
>> +
>> +	clr_b_busy(bt_bmc);
>> +
>> +	return 0;
>> +
>> +out_unmap:
>> +	devm_iounmap(&pdev->dev, bt_bmc->base);
> 
> Why do you use devm_iounmap/devm_kfree since the interest with devm_ functions 
> is that all cleanup is done when driver is removed.

Indeed. So I can cleanup bt_bmc_remove() also.

>> +
>> +out_free:
>> +	devm_kfree(dev, bt_bmc);
>> +	return rc;
> 
> I think you should remove the space after this return


Thanks,

C.


> Regards
> 
> Corentin Labbe
> 
