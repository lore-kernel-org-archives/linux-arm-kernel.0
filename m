From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Sun, 18 Dec 2016 19:00:49 -0800
Subject: [PATCH v4 1/2] FPGA: Add TS-7300 FPGA manager
In-Reply-To: <alpine.DEB.2.10.1612181959060.2528@atull-730U3E-740U3E>
References: <20161218202158.10582-1-f.fainelli@gmail.com>
 <20161218202158.10582-2-f.fainelli@gmail.com>
 <alpine.DEB.2.10.1612181959060.2528@atull-730U3E-740U3E>
Message-ID: <CAAtXAHeSrs1J13DspW-_MmGkFgeZfRCLxMgmZfO7RJ1onyxcDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2016 at 6:09 PM, Alan Tull <atull@kernel.org> wrote:
> On Sun, 18 Dec 2016, Florian Fainelli wrote:
>
> Hi Florain,
>
>> Add support for loading bitstreams on the Altera Cyclone II FPGA
>> populated on the TS-7300 board. This is done through the configuration
>> and data registers offered through a memory interface between the EP93xx
>> SoC and the FPGA via an intermediate CPLD device.
>>
>> The EP93xx SoC on the TS-7300 does not have direct means of configuring
>> the on-board FPGA other than by using the special memory mapped
>> interface to the CPLD. No other entity on the system can control the
>> FPGA bitstream.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/fpga/Kconfig       |   7 ++
>>  drivers/fpga/Makefile      |   1 +
>>  drivers/fpga/ts73xx-fpga.c | 163 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 171 insertions(+)
>>  create mode 100644 drivers/fpga/ts73xx-fpga.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index ce861a2853a4..d9cbef60db80 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -33,6 +33,13 @@ config FPGA_MGR_SOCFPGA_A10
>>       help
>>         FPGA manager driver support for Altera Arria10 SoCFPGA.
>>
>> +config FPGA_MGR_TS73XX
>> +     tristate "Technologic Systems TS-73xx SBC FPGA Manager"
>> +     depends on ARCH_EP93XX && MACH_TS72XX
>> +     help
>> +       FPGA manager driver support for the Altera Cyclone II FPGA
>> +       present on the TS-73xx SBC boards.
>> +
>>  config FPGA_MGR_ZYNQ_FPGA
>>       tristate "Xilinx Zynq FPGA"
>>       depends on ARCH_ZYNQ || COMPILE_TEST
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 8df07bcf42a6..a1160169e6d9 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_FPGA)                    += fpga-mgr.o
>>  # FPGA Manager Drivers
>>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)               += socfpga.o
>>  obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)   += socfpga-a10.o
>> +obj-$(CONFIG_FPGA_MGR_TS73XX)                += ts73xx-fpga.o
>>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)     += zynq-fpga.o
>>
>>  # FPGA Bridge Drivers
>> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
>> new file mode 100644
>> index 000000000000..5acdbcfe447b
>> --- /dev/null
>> +++ b/drivers/fpga/ts73xx-fpga.c
>> @@ -0,0 +1,163 @@
>> +/*
>> + * Technologic Systems TS-73xx SBC FPGA loader
>> + *
>> + * Copyright (C) 2016 Florian Fainelli <f.fainelli@gmail.com>
>> + *
>> + * FPGA Manager Driver for the on-board Altera Cyclone II FPGA found on
>> + * TS-7300, heavily based on load_fpga.c in their vendor tree.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/string.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +
>> +#define TS73XX_FPGA_DATA_REG         0
>> +#define TS73XX_FPGA_CONFIG_REG               1
>> +
>> +#define TS73XX_FPGA_WRITE_DONE               0x1
>> +#define TS73XX_FPGA_WRITE_DONE_TIMEOUT       1000    /* us */
>
> If you add units to these timeouts/delays, it could prevent
> issues in the future.  Such as _USEC
>
>> +#define TS73XX_FPGA_RESET            0x2
>> +#define TS73XX_FPGA_RESET_LOW_DELAY  30      /* us */
>> +#define TS73XX_FPGA_RESET_HIGH_DELAY 80      /* us */
>> +#define TS73XX_FPGA_LOAD_OK          0x4
>> +#define TS73XX_FPGA_CONFIG_LOAD              0x8
>> +
>> +struct ts73xx_fpga_priv {
>> +     void __iomem    *io_base;
>> +     struct device   *dev;
>> +};
>> +
>> +static enum fpga_mgr_states ts73xx_fpga_state(struct fpga_manager *mgr)
>> +{
>> +     return FPGA_MGR_STATE_UNKNOWN;
>> +}
>> +
>> +static int ts73xx_fpga_write_init(struct fpga_manager *mgr,
>> +                               struct fpga_image_info *info,
>> +                               const char *buf, size_t count)
>> +{
>> +     struct ts73xx_fpga_priv *priv = mgr->priv;
>> +
>> +     /* Reset the FPGA */
>> +     writeb(0, priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +     udelay(TS73XX_FPGA_RESET_LOW_DELAY);
>> +     writeb(TS73XX_FPGA_RESET, priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +     udelay(TS73XX_FPGA_RESET_HIGH_DELAY);
>> +
>> +     return 0;
>> +}
>> +
>> +static int ts73xx_fpga_write(struct fpga_manager *mgr, const char *buf,
>> +                          size_t count)
>> +{
>> +     struct ts73xx_fpga_priv *priv = mgr->priv;
>> +     size_t i = 0;
>> +     int ret;
>> +     u8 reg;
>> +
>> +     while (count--) {
>> +             ret = readb_poll_timeout(priv->io_base + TS73XX_FPGA_CONFIG_REG,
>> +                                      reg, !(reg & TS73XX_FPGA_WRITE_DONE),
>> +                                      1, TS73XX_FPGA_WRITE_DONE_TIMEOUT);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             writeb(buf[i], priv->io_base + TS73XX_FPGA_DATA_REG);
>> +             i++;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int ts73xx_fpga_write_complete(struct fpga_manager *mgr,
>> +                                   struct fpga_image_info *info)
>> +{
>> +     struct ts73xx_fpga_priv *priv = mgr->priv;
>> +     u8 reg;
>> +
>> +     usleep_range(1000, 2000);
>> +     reg = readb(priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +     reg |= TS73XX_FPGA_CONFIG_LOAD;
>> +     writeb(reg, priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +
>> +     usleep_range(1000, 2000);
>> +     reg = readb(priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +     reg &= ~TS73XX_FPGA_CONFIG_LOAD;
>> +     writeb(reg, priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +
>> +     reg = readb(priv->io_base + TS73XX_FPGA_CONFIG_REG);
>> +     if ((reg & TS73XX_FPGA_LOAD_OK) != TS73XX_FPGA_LOAD_OK)
>> +             return -ETIMEDOUT;
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct fpga_manager_ops ts73xx_fpga_ops = {
>> +     .state          = ts73xx_fpga_state,
>> +     .write_init     = ts73xx_fpga_write_init,
>> +     .write          = ts73xx_fpga_write,
>> +     .write_complete = ts73xx_fpga_write_complete,
>> +};
>> +
>> +static int ts73xx_fpga_probe(struct platform_device *pdev)
>> +{
>> +     struct device *kdev = &pdev->dev;
>> +     struct ts73xx_fpga_priv *priv;
>> +     struct resource *res;
>> +     int err;
>> +
>> +     priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
>> +     if (!priv)
>> +             return -ENOMEM;
>> +
>> +     priv->dev = kdev;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     priv->io_base = devm_ioremap_resource(kdev, res);
>> +     if (IS_ERR(priv->io_base)) {
>> +             dev_err(kdev, "unable to remap registers\n");
>> +             return PTR_ERR(priv->io_base);
>> +     }
>> +
>> +     err = fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
>> +                             &ts73xx_fpga_ops, priv);
>> +     if (err) {
>> +             dev_err(kdev, "failed to register FPGA manager\n");
>> +             return err;
>> +     }
>
>
> You can just 'return fpga_mgr_register(..); here.
>
> Thanks for your responsiveness.  You can leave things up longer so
> that people have time to review.  That way you don't have to go
> through so many versions so quickly.
>
> Acked-by: Alan Tull <atull@opensource.altera.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

Cheers,

Moritz
