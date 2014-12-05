From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 5 Dec 2014 21:19:33 +0100
Subject: [PATCH v3 2/3] ARM: socfpga: Add driver for the L3 interconnect
In-Reply-To: <alpine.DEB.2.02.1412051349080.15664@linuxheads99>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
 <1417292052-12974-3-git-send-email-s.trumtrar@pengutronix.de>
 <547DECB8.3070801@opensource.altera.com>
 <alpine.DEB.2.02.1412051349080.15664@linuxheads99>
Message-ID: <20141205201933.GC28110@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Fri, Dec 05, 2014 at 01:51:48PM -0600, atull wrote:
> On Tue, 2 Dec 2014, Dinh Nguyen wrote:
> 
> > +CC: Alan Tull
> > 
> > On 11/29/2014 02:14 PM, Steffen Trumtrar wrote:
> > > The L3 interconnect provides Global Programmer View (GPV) registers for every
> > > AXI master and slave on the SoC.
> > > Although this is just a bunch of bits, syscon is not the right approach for
> > > this IP core.
> > > The L3 interconnect is configured with a lot of reserved "holes" in its memory
> > > space. Just mapping this with regmap, what syscon would do, would lead to the
> > > system completely hanging, if one of those areas would be touched.
> > > One example for when this might happen is the regmap registers dump in the
> > > debugfs.
> > > 
> > > This driver specifies also the valid readable and writable ranges of the L3
> > > interconnect. Other drivers that want to access their GPV registers can do
> > > so with this driver via socfpga_l3nic_regmap_by_phandle.
> > > 
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > ---
> > >  drivers/soc/Kconfig          |   1 +
> > >  drivers/soc/Makefile         |   1 +
> > >  drivers/soc/socfpga/Kconfig  |  10 ++
> > >  drivers/soc/socfpga/Makefile |   1 +
> > >  drivers/soc/socfpga/l3nic.c  | 221 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/soc/socfpga/gpv.h    |  63 ++++++++++++
> > >  include/soc/socfpga/l3regs.h | 192 +++++++++++++++++++++++++++++++++++++
> > >  7 files changed, 489 insertions(+)
> > >  create mode 100644 drivers/soc/socfpga/Kconfig
> > >  create mode 100644 drivers/soc/socfpga/Makefile
> > >  create mode 100644 drivers/soc/socfpga/l3nic.c
> > >  create mode 100644 include/soc/socfpga/gpv.h
> > >  create mode 100644 include/soc/socfpga/l3regs.h
> > > 
> > > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > > index 76d6bd4da138..11db07da894f 100644
> > > --- a/drivers/soc/Kconfig
> > > +++ b/drivers/soc/Kconfig
> > > @@ -1,6 +1,7 @@
> > >  menu "SOC (System On Chip) specific Drivers"
> > >  
> > >  source "drivers/soc/qcom/Kconfig"
> > > +source "drivers/soc/socfpga/Kconfig"
> > >  source "drivers/soc/ti/Kconfig"
> > >  source "drivers/soc/versatile/Kconfig"
> > >  
> > > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > > index 063113d0bd38..0f89173e328a 100644
> > > --- a/drivers/soc/Makefile
> > > +++ b/drivers/soc/Makefile
> > > @@ -3,6 +3,7 @@
> > >  #
> > >  
> > >  obj-$(CONFIG_ARCH_QCOM)		+= qcom/
> > > +obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
> > >  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
> > >  obj-$(CONFIG_SOC_TI)		+= ti/
> > >  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
> > > diff --git a/drivers/soc/socfpga/Kconfig b/drivers/soc/socfpga/Kconfig
> > > new file mode 100644
> > > index 000000000000..533c59449fb8
> > > --- /dev/null
> > > +++ b/drivers/soc/socfpga/Kconfig
> > > @@ -0,0 +1,10 @@
> > > +#
> > > +# SoCFPGA Soc drivers
> > > +#
> > > +
> > > +config SOCFPGA_L3NIC
> > > +	tristate "SoCFPGA L3 NIC-301 driver"
> > > +	depends on ARCH_SOCFPGA
> > > +	select REGMAP_MMIO
> > > +	help
> > > +	  Enable configuration support for the SoCFPGA L3 AMBA Network Interconnect.
> > > diff --git a/drivers/soc/socfpga/Makefile b/drivers/soc/socfpga/Makefile
> > > new file mode 100644
> > > index 000000000000..e6616d079226
> > > --- /dev/null
> > > +++ b/drivers/soc/socfpga/Makefile
> > > @@ -0,0 +1 @@
> > > +obj-$(CONFIG_SOCFPGA_L3NIC) += l3nic.o
> > > diff --git a/drivers/soc/socfpga/l3nic.c b/drivers/soc/socfpga/l3nic.c
> > > new file mode 100644
> > > index 000000000000..c1f36e2ec9cb
> > > --- /dev/null
> > > +++ b/drivers/soc/socfpga/l3nic.c
> > > @@ -0,0 +1,221 @@
> > > +/*
> > > + * Copyright 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > > + *
> > > + * This program is free software; you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License as published by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/types.h>
> > > +#include <soc/socfpga/gpv.h>
> > > +#include <soc/socfpga/l3regs.h>
> > > +
> > > +static const struct regmap_range l3nic_write_regs_range[] = {
> > > +	regmap_reg_range(L3NIC_REMAP, L3NIC_REMAP),
> > > +	regmap_reg_range(L3NIC_L4MAIN, L3NIC_LWHPS2FPGAREGS),
> > > +	regmap_reg_range(L3NIC_USB1, L3NIC_NANDDATA),
> > > +	regmap_reg_range(L3NIC_USB0, L3NIC_SDRDATA),
> > > +	regmap_reg_range(L3NIC_L4_MAIN_FN_MOD_BM_ISS, L3NIC_L4_MAIN_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_L4_SP_FN_MOD_BM_ISS, L3NIC_L4_SP_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_L4_MP_FN_MOD_BM_ISS, L3NIC_L4_MP_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_L4_OSC1_FN_MOD_BM_ISS, L3NIC_L4_OSC1_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_L4_SPIM_FN_MOD_BM_ISS, L3NIC_L4_SPIM_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_STM_FN_MOD_BM_ISS, L3NIC_STM_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_STM_FN_MOD, L3NIC_STM_FN_MOD),
> > > +	regmap_reg_range(L3NIC_LWHPS2FPGA_FN_MOD_BM_ISS, L3NIC_LWHPS2FPGA_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_LWHPS2FPGA_FN_MOD, L3NIC_LWHPS2FPGA_FN_MOD),
> > > +	regmap_reg_range(L3NIC_USB1_FN_MOD_BM_ISS, L3NIC_USB1_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_USB1_AHB_CNTL, L3NIC_USB1_AHB_CNTL),
> > > +	regmap_reg_range(L3NIC_NANDDATA_FN_MOD_BM_ISS, L3NIC_NANDDATA_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_NANDDATA_FN_MOD, L3NIC_NANDDATA_FN_MOD),
> > > +	regmap_reg_range(L3NIC_USB0_FN_MOD_BM_ISS, L3NIC_USB0_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_USB0_AHB_CNTL, L3NIC_USB0_AHB_CNTL),
> > > +	regmap_reg_range(L3NIC_QSPIDATA_FN_MOD_BM_ISS, L3NIC_QSPIDATA_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_QSPIDATA_AHB_CNTL, L3NIC_QSPIDATA_AHB_CNTL),
> > > +	regmap_reg_range(L3NIC_FPGAMGRDATA_FN_MOD_BM_ISS, L3NIC_FPGAMGRDATA_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_FPGAMGRDATA_WR_TIDEMARK, L3NIC_FPGAMGRDATA_WR_TIDEMARK),
> > > +	regmap_reg_range(L3NIC_FPGAMGRDATA_FN_MOD, L3NIC_FPGAMGRDATA_FN_MOD),
> > > +	regmap_reg_range(L3NIC_HPS2FPGA_FN_MOD_BM_ISS, L3NIC_HPS2FPGA_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_HPS2FPGA_WR_TIDEMARK, L3NIC_HPS2FPGA_WR_TIDEMARK),
> > > +	regmap_reg_range(L3NIC_HPS2FPGA_FN_MOD, L3NIC_HPS2FPGA_FN_MOD),
> > > +	regmap_reg_range(L3NIC_ACP_FN_MOD_BM_ISS, L3NIC_ACP_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_ACP_FN_MOD, L3NIC_ACP_FN_MOD),
> > > +	regmap_reg_range(L3NIC_BOOT_ROM_FN_MOD_BM_ISS, L3NIC_BOOT_ROM_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_BOOT_ROM_FN_MOD, L3NIC_BOOT_ROM_FN_MOD),
> > > +	regmap_reg_range(L3NIC_OCRAM_FN_MOD_BM_ISS, L3NIC_OCRAM_FN_MOD_BM_ISS),
> > > +	regmap_reg_range(L3NIC_OCRAM_WR_TIDEMARK, L3NIC_OCRAM_WR_TIDEMARK),
> > > +	regmap_reg_range(L3NIC_OCRAM_FN_MOD, L3NIC_OCRAM_FN_MOD),
> > > +	regmap_reg_range(L3NIC_DAP_FN_MOD2, L3NIC_DAP_FN_MOD_AHB),
> > > +	regmap_reg_range(L3NIC_DAP_READ_QOS, L3NIC_DAP_FN_MOD),
> > > +	regmap_reg_range(L3NIC_MPU_READ_QOS, L3NIC_MPU_FN_MOD),
> > > +	regmap_reg_range(L3NIC_SDMMC_FN_MOD_AHB, L3NIC_SDMMC_FN_MOD_AHB),
> > > +	regmap_reg_range(L3NIC_SDMMC_READ_QOS, L3NIC_SDMMC_FN_MOD),
> > > +	regmap_reg_range(L3NIC_DMA_READ_QOS, L3NIC_DMA_FN_MOD),
> > > +	regmap_reg_range(L3NIC_FPGA2HPS_WR_TIDEMARK, L3NIC_FPGA2HPS_WR_TIDEMARK),
> > > +	regmap_reg_range(L3NIC_FPGA2HPS_READ_QOS, L3NIC_FPGA2HPS_FN_MOD),
> > > +	regmap_reg_range(L3NIC_ETR_READ_QOS, L3NIC_ETR_FN_MOD),
> > > +	regmap_reg_range(L3NIC_EMAC0_READ_QOS, L3NIC_EMAC0_FN_MOD),
> > > +	regmap_reg_range(L3NIC_EMAC1_READ_QOS, L3NIC_EMAC1_FN_MOD),
> > > +	regmap_reg_range(L3NIC_USB0_FN_MOD_AHB, L3NIC_USB0_FN_MOD_AHB),
> > > +	regmap_reg_range(L3NIC_USB0_READ_QOS, L3NIC_USB0_FN_MOD),
> > > +	regmap_reg_range(L3NIC_NAND_READ_QOS, L3NIC_NAND_FN_MOD),
> > > +	regmap_reg_range(L3NIC_USB1_FN_MOD_AHB, L3NIC_USB1_FN_MOD_AHB),
> > > +	regmap_reg_range(L3NIC_USB1_READ_QOS, L3NIC_USB1_FN_MOD),
> > > +};
> > > +
> > > +static const struct regmap_range l3nic_read_regs_range[] = {
> > > +	regmap_reg_range(L3NIC_REMAP, L3NIC_REMAP),
> 
> Hi Steffen,
> 
> We may have discussed this a bit, but I want to make sure that this is
> made obvious here: some of these registers are not readable. L3NIC_REMAP
> is one of these for example.
> 

You can read just fine from the register, but you will always
get a 0 back.

> So please mark the appropriate registers as not being readable. Then
> anyone who does a regmap_update_bits() will get an error, which is
> what we want.
> 
> It would probably be good to add a note to the patch header warning
> people that some of these regs are write-only.
> 

Regmap has a cache for the value. When you do a read on these
registers, you get the cached value, consequently you can also
do a regmap_update_bits from different drivers and will always
have the correct value written to the register.

The registers you can NOT read from are the ones not in the
specified ranges and the whole reason why I wrote this driver.

> I also would request that you post future versions, please keep me and all
> the other people who originally had replied to v1, v2, etc in the cc.
> 

Yes, I forgot to add you. Sorry.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
