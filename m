From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Tue, 7 Jul 2015 10:49:53 +0530
Subject: [RFC PATCH v6 3/3] drivers: nvmem: Add Vybrid OCOTP support
In-Reply-To: <1877493336.206622.1436177794342.JavaMail.open-xchange@oxbsltgw01.schlund.de>
References: <cover.1435574288.git.maitysanchayan@gmail.com>
 <9593ca1f925aff20a6671262efd2f45e256ea676.1435574288.git.maitysanchayan@gmail.com>
 <1877493336.206622.1436177794342.JavaMail.open-xchange@oxbsltgw01.schlund.de>
Message-ID: <20150707051953.GA3712@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On 15-07-06 12:16:34, Stefan Wahren wrote:
> Hi Sanchayan,
> 
> > Sanchayan Maity <maitysanchayan@gmail.com> hat am 29. Juni 2015 um 13:22
> > geschrieben:
> >
> >
> > The patch adds support for the On Chip One Time Programmable Peripheral
> > (OCOTP) on the Vybrid platform.
> 
> please provide a changelog in your cover letter and a new version after changes.
> 
> I think it's important to note that the driver only support read-only access.

Ok. Will mention this explicitly in the next version.

> 
> >
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> > drivers/nvmem/Kconfig | 10 ++
> > drivers/nvmem/Makefile | 2 +
> > drivers/nvmem/vf610-ocotp.c | 250 ++++++++++++++++++++++++++++++++++++++++++++
> > 3 files changed, 262 insertions(+)
> > create mode 100644 drivers/nvmem/vf610-ocotp.c
> >
> > diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> > index 17f1a57..84c830d 100644
> > --- a/drivers/nvmem/Kconfig
> > +++ b/drivers/nvmem/Kconfig
> > @@ -33,4 +33,14 @@ config NVMEM_SUNXI_SID
> > This driver can also be built as a module. If so, the module
> > will be called eeprom-sunxi-sid.
> >
> > +config NVMEM_VF610_OCOTP
> > + tristate "VF610 SoCs OCOTP support"
> > + depends on SOC_VF610
> > + help
> > + This is a driver for the 'OCOTP' available on various Vybrid
> > + devices.
> 
> I don't know much about Vybrid. But this driver is specific for VF610, isn't it?

Sorry. I only checked on VF50 and VF61. Will check if is it available with the
other Vybrid devices and change if it is not so.

> 
> > +
> > + This driver can also be built as a module. If so, the module
> > + will be called nvmem-vf610-ocotp.
> > +
> > endif
> > diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> > index cc46791..a9ed113 100644
> > --- a/drivers/nvmem/Makefile
> > +++ b/drivers/nvmem/Makefile
> > @@ -11,3 +11,5 @@ obj-$(CONFIG_QCOM_QFPROM) += nvmem_qfprom.o
> > nvmem_qfprom-y := qfprom.o
> > obj-$(CONFIG_NVMEM_SUNXI_SID) += nvmem-sunxi-sid.o
> > nvmem-sunxi-sid-y := sunxi-sid.o
> > +obj-$(CONFIG_NVMEM_VF610_OCOTP) += nvmem-vf610-ocotp.o
> > +nvmem-vf610-ocotp-y := vf610-ocotp.o
> > diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
> > new file mode 100644
> > index 0000000..b7a782c
> > --- /dev/null
> > +++ b/drivers/nvmem/vf610-ocotp.c
> > @@ -0,0 +1,250 @@
> > +/*
> > + * Copyright (C) 2015 Sanchayan Maity <sanchayan.maity@toradex.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 and
> > + * only version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +/* OCOTP Register Offsets */
> > +#define OCOTP_CTRL_REG 0x00
> > +#define OCOTP_CTRL_SET 0x04
> > +#define OCOTP_CTRL_CLR 0x08
> > +#define OCOTP_TIMING 0x10
> > +#define OCOTP_DATA 0x20
> > +#define OCOTP_READ_CTRL_REG 0x30
> > +#define OCOTP_READ_FUSE_DATA 0x40
> > +
> > +/* OCOTP Register bits and masks */
> > +#define OCOTP_CTRL_WR_UNLOCK 16
> > +#define OCOTP_CTRL_WR_UNLOCK_KEY 0x3E77
> > +#define OCOTP_CTRL_WR_UNLOCK_MASK 0xFFFF0000
> > +#define OCOTP_CTRL_ADDR 0
> > +#define OCOTP_CTRL_ADDR_MASK 0x7F
> > +#define OCOTP_CTRL_RELOAD_SHADOWS (0x1 << 10)
> > +#define OCOTP_CTRL_ERROR (0x1 << 9)
> > +#define OCOTP_CTRL_BUSY (0x1 << 8)
> 
> You can use the BIT() macro here.

Ok.

> 
> > +
> > +#define OCOTP_TIMING_STROBE_READ 16
> > +#define OCOTP_TIMING_STROBE_READ_MASK 0x003F0000
> > +#define OCOTP_TIMING_RELAX 12
> > +#define OCOTP_TIMING_RELAX_MASK 0x0000F000
> > +#define OCOTP_TIMING_STROBE_PROG 0
> > +#define OCOTP_TIMING_STROBE_PROG_MASK 0x00000FFF
> > +
> > +#define OCOTP_READ_CTRL_READ_FUSE 0x1
> > +
> > +#define VF610_OCOTP_TIMEOUT 100000
> > +
> > +#define BF(value, field) (((value) << field) & field##_MASK)
> > +
> > +#define DEF_RELAX 20
> > +
> > +struct vf610_ocotp_dev {
> > + void __iomem *base;
> > + struct clk *clk;
> > + struct device *dev;
> > + struct resource *res;
> > + struct regmap *regmap;
> > + struct nvmem_device *nvmem;
> > +};
> 
> Some member of this struct seems unnecessary to me. Please
> remove the unused one.
> 
> > +
> > +static int ocotp_timing;
> 
> How about storing the timings in struct above?

Ok.

> 
> > +
> > +static u8 valid_fuse_addr[] = {
> > + 0x00, 0x01, 0x02, 0x04, 0x0F, 0x20, 0x21, 0x22, 0x23, 0x24,
> > + 0x25, 0x26, 0x27, 0x28, 0x2F, 0x38, 0x39, 0x3A, 0x3B, 0x3C,
> > + 0x3D, 0x3E, 0x3F
> > +};
> 
> const?

Right.

> 
> > +
> > +static int vf610_ocotp_wait_busy(void __iomem *base)
> > +{
> > + int timeout = VF610_OCOTP_TIMEOUT;
> > +
> > + while ((readl(base) & OCOTP_CTRL_BUSY) && --timeout)
> > + udelay(10);
> > +
> > + if (!timeout) {
> > + writel(OCOTP_CTRL_ERROR, base + OCOTP_CTRL_CLR);
> > + return -ETIMEDOUT;
> > + }
> > +
> > + udelay(10);
> > +
> > + return 0;
> > +}
> > +
> > +static int vf610_ocotp_calculate_timing(struct vf610_ocotp_dev *ocotp_dev)
> > +{
> > + u32 clk_rate;
> > + u32 relax, strobe_read, strobe_prog;
> > + u32 timing;
> > +
> > + clk_rate = clk_get_rate(ocotp_dev->clk);
> 
> If clk_get_rate() fails, then we should abort with a warning.

Correct. Will fix this.

> 
> > +
> > + relax = clk_rate / (1000000000 / DEF_RELAX) - 1;
> > + strobe_prog = clk_rate / (1000000000 / 10000) + 2 * (DEF_RELAX + 1) - 1;
> > + strobe_read = clk_rate / (1000000000 / 40) + 2 * (DEF_RELAX + 1) - 1;
> 
> A little explanation of the calculation would be helpful.

Ok. Will add the relevant comments.

For now just to be clear, this is taken from from Barebox and as per Section 35.3.2.
DEF_RELAX is defined to be 20 as tRELAX is expected to be greated than 16.2ns with
the first primary equation being

tRELAX = tHP_PG = (OCOTP_TIMING[RELAX]+1)/ipg_frequency > 16.2ns

The rest of the equations follow the relax value defined.

> 
> > +
> > + timing = BF(relax, OCOTP_TIMING_RELAX);
> > + timing |= BF(strobe_read, OCOTP_TIMING_STROBE_READ);
> > + timing |= BF(strobe_prog, OCOTP_TIMING_STROBE_PROG);
> > +
> > + return timing;
> > +}
> > +
> > +static int vf610_ocotp_set_timing(void __iomem *base, int timing)
> > +{
> > + writel(timing, base + OCOTP_TIMING);
> > +
> > + return 0;
> > +}
> > +
> > +static int vf610_ocotp_write(void *context, const void *data, size_t count)
> > +{
> > + return 0;
> > +}
> > +
> > +static int vf610_ocotp_read(void *context,
> > + const void *offset, size_t reg_size,
> > + void *val, size_t val_size)
> > +{
> > + void __iomem *ocotp_base = context;
> > + u32 *buf = val;
> > + u32 reg;
> > + int ret;
> > + int i;
> > +
> > + for (i = 0; i < ARRAY_SIZE(valid_fuse_addr); i++) {
> > + vf610_ocotp_set_timing(ocotp_base, ocotp_timing);
> > + ret = vf610_ocotp_wait_busy(ocotp_base + OCOTP_CTRL_REG);
> > + if (ret)
> > + return ret;
> 
> Is it really necessary to set the timing in the loop, instead before?

I will test it once. From my understanding of 35.3.1.5 I thought the timing
needs to explicitly programmed on every read. Perhaps I took it too literally.

> 
> > +
> > + reg = readl(ocotp_base + OCOTP_CTRL_REG);
> > + reg &= ~OCOTP_CTRL_ADDR_MASK;
> > + reg &= ~OCOTP_CTRL_WR_UNLOCK_MASK;
> > + reg |= BF(valid_fuse_addr[i], OCOTP_CTRL_ADDR);
> > + writel(reg, ocotp_base + OCOTP_CTRL_REG);
> > +
> > + writel(OCOTP_READ_CTRL_READ_FUSE,
> > + ocotp_base + OCOTP_READ_CTRL_REG);
> > + ret = vf610_ocotp_wait_busy(ocotp_base + OCOTP_CTRL_REG);
> > + if (ret)
> > + return ret;
> > +
> > + if (readl(ocotp_base) & OCOTP_CTRL_ERROR) {
> > + pr_err("Error reading from fuse address %d\n",
> > + valid_fuse_addr[i]);
> 
> You could use dev_err() when storing vf610_ocotp_dev in the context.

Ok.

> 
> > + writel(OCOTP_CTRL_ERROR, ocotp_base + OCOTP_CTRL_CLR);
> 
> Shouldn't the function abort here?

I am not sure about what usage I should follow here. I went for an
explicit error message and since 0xBADABADA is expected to be returned
on a read locked shadow register, the user would get the above for this
particular fuse address and the rest can still be valid since the TRM
mentions "subsequent reads to unlocked shadow locations will still work
successfully." So I did not abort on the error. Should I?

> 
> > + }
> > +
> > + *buf++ = readl(ocotp_base + OCOTP_READ_FUSE_DATA);
> > + }
> > +
> > + return 0;
> > +}
> > +
> > +static struct regmap_bus vf610_ocotp_bus = {
> > + .read = vf610_ocotp_read,
> > + .write = vf610_ocotp_write,
> > + .reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
> > + .val_format_endian_default = REGMAP_ENDIAN_NATIVE,
> > +};
> > +
> > +static struct regmap_config ocotp_regmap_config = {
> > + .reg_bits = 32,
> > + .val_bits = 32,
> > + .reg_stride = 4,
> > +};
> > +
> > +static struct nvmem_config ocotp_config = {
> > + .name = "ocotp",
> > + .owner = THIS_MODULE,
> > +};
> > +
> > +static const struct of_device_id ocotp_of_match[] = {
> > + { .compatible = "fsl,vf610-ocotp",},
> > + {/* sentinel */},
> > +};
> > +MODULE_DEVICE_TABLE(of, ocotp_of_match);
> > +
> > +static int vf610_ocotp_remove(struct platform_device *pdev)
> > +{
> > + struct vf610_ocotp_dev *ocotp_dev = platform_get_drvdata(pdev);
> > +
> > + return nvmem_unregister(ocotp_dev->nvmem);
> > +}
> > +
> > +static int vf610_ocotp_probe(struct platform_device *pdev)
> > +{
> > + struct vf610_ocotp_dev *ocotp_dev;
> > +
> > + ocotp_dev = devm_kzalloc(&pdev->dev,
> > + sizeof(struct vf610_ocotp_dev), GFP_KERNEL);
> > + if (!ocotp_dev)
> > + return -ENOMEM;
> > +
> > + ocotp_dev->dev = &pdev->dev;
> > +
> > + ocotp_dev->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > + ocotp_dev->base = devm_ioremap_resource(ocotp_dev->dev, ocotp_dev->res);
> > + if (IS_ERR(ocotp_dev->base))
> > + return PTR_ERR(ocotp_dev->base);
> > +
> > + ocotp_dev->clk = devm_clk_get(ocotp_dev->dev, "ocotp");
> > + if (IS_ERR(ocotp_dev->clk)) {
> > + dev_err(ocotp_dev->dev, "failed getting clock, err = %ld\n",
> > + PTR_ERR(ocotp_dev->clk));
> > + return PTR_ERR(ocotp_dev->clk);
> > + }
> > +
> > + ocotp_regmap_config.max_register = resource_size(ocotp_dev->res) - 1;
> 
> Looking at valid_fuse_addr shows me 0x3F as last valid register. So the rest
> of the buffer ( 0xD00 - sizeof(valid_fuse_addr) ) in case of raw access could be
> uninitializied.

Sorry I did not exactly get you here. The intention behind using the valid_fuse_addr
is to allow reading only from valid fuse addresses and avoid reading from all other
locations as per the Fuse map address table 35-1.

Thanks for the review.

Regards,
Sanchayan.
