From: bayi.cheng@mediatek.com (bayi.cheng)
Date: Fri, 18 Sep 2015 16:14:22 +0800
Subject: [PATCH v2 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <20150918072710.GA30710@free64-pc.asiapac.arm.com>
References: <1442559533-17552-1-git-send-email-bayi.cheng@mediatek.com>
 <1442559533-17552-3-git-send-email-bayi.cheng@mediatek.com>
 <20150918072710.GA30710@free64-pc.asiapac.arm.com>
Message-ID: <1442564062.27250.36.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-18 at 15:27 +0800, Huang Shijie wrote:
> On Fri, Sep 18, 2015 at 02:58:52PM +0800, Bayi Cheng wrote:
> > add spi nor flash driver for mediatek controller
> > 
> > Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> > ---
> >  drivers/mtd/spi-nor/Kconfig       |   7 +
> >  drivers/mtd/spi-nor/Makefile      |   1 +
> >  drivers/mtd/spi-nor/mtk_quadspi.c | 483 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 491 insertions(+)
> >  create mode 100644 drivers/mtd/spi-nor/mtk_quadspi.c
> > 
> > diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> > index 89bf4c1..f433890 100644
> > --- a/drivers/mtd/spi-nor/Kconfig
> > +++ b/drivers/mtd/spi-nor/Kconfig
> > @@ -7,6 +7,13 @@ menuconfig MTD_SPI_NOR
> >  
> >  if MTD_SPI_NOR
> >  
> > +config MTD_MT81xx_NOR
> > +	tristate "Support SPI flash Controller MTD_MT81xx_NOR"
> > +	help
> > +	  This enables access to SPI Nor flash, using MTD_MT81XX_NOR controller.
> > +	  This controller does nor support generic SPI BUS, It only supports
> > +	  SPI NOR Flash.
> > +
> >  config MTD_SPI_NOR_USE_4K_SECTORS
> >  	bool "Use small 4096 B erase sectors"
> >  	default y
> > diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> > index e53333e..138cfea 100644
> > --- a/drivers/mtd/spi-nor/Makefile
> > +++ b/drivers/mtd/spi-nor/Makefile
> > @@ -1,3 +1,4 @@
> > +obj-$(CONFIG_MTD_MT81xx_NOR)	+= mtk_quadspi.o
> >  obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
> >  obj-$(CONFIG_SPI_FSL_QUADSPI)	+= fsl-quadspi.o
> >  obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
> > diff --git a/drivers/mtd/spi-nor/mtk_quadspi.c b/drivers/mtd/spi-nor/mtk_quadspi.c
> > new file mode 100644
> > index 0000000..f60560e
> > --- /dev/null
> > +++ b/drivers/mtd/spi-nor/mtk_quadspi.c
> > @@ -0,0 +1,483 @@
> > +/*
> > + * Copyright (c) 2015 MediaTek Inc.
> > + * Author: Bayi Cheng <bayi.cheng@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/ioport.h>
> > +#include <linux/math64.h>
> > +#include <linux/module.h>
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mutex.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/pinctrl/consumer.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/mtd/partitions.h>
> > +#include <linux/mtd/spi-nor.h>
> > +
> > +#define MTK_NOR_CMD_REG			0x00
> > +#define MTK_NOR_CNT_REG			0x04
> > +#define MTK_NOR_RDSR_REG		0x08
> > +#define MTK_NOR_RDATA_REG		0x0c
> > +#define MTK_NOR_RADR0_REG		0x10
> > +#define MTK_NOR_RADR1_REG		0x14
> > +#define MTK_NOR_RADR2_REG		0x18
> > +#define MTK_NOR_WDATA_REG		0x1c
> > +#define MTK_NOR_PRGDATA0_REG		0x20
> > +#define MTK_NOR_PRGDATA1_REG		0x24
> > +#define MTK_NOR_PRGDATA2_REG		0x28
> > +#define MTK_NOR_PRGDATA3_REG		0x2c
> > +#define MTK_NOR_PRGDATA4_REG		0x30
> > +#define MTK_NOR_PRGDATA5_REG		0x34
> > +#define MTK_NOR_SHREG0_REG		0x38
> > +#define MTK_NOR_SHREG1_REG		0x3c
> > +#define MTK_NOR_SHREG2_REG		0x40
> > +#define MTK_NOR_SHREG3_REG		0x44
> > +#define MTK_NOR_SHREG4_REG		0x48
> > +#define MTK_NOR_SHREG5_REG		0x4c
> > +#define MTK_NOR_SHREG6_REG		0x50
> > +#define MTK_NOR_SHREG7_REG		0x54
> > +#define MTK_NOR_SHREG8_REG		0x58
> > +#define MTK_NOR_SHREG9_REG		0x5c
> > +#define MTK_NOR_FLHCFG_REG		0x84
> > +#define MTK_NOR_PP_DATA_REG		0x98
> > +#define MTK_NOR_PREBUF_STUS_REG		0x9c
> > +#define MTK_NOR_INTRSTUS_REG		0xa8
> > +#define MTK_NOR_INTREN_REG		0xac
> > +#define MTK_NOR_TIME_REG		0x94
> > +#define MTK_NOR_CHKSUM_CTL_REG		0xb8
> > +#define MTK_NOR_CHKSUM_REG		0xbc
> > +#define MTK_NOR_CMD2_REG		0xc0
> > +#define MTK_NOR_WRPROT_REG		0xc4
> > +#define MTK_NOR_RADR3_REG		0xc8
> > +#define MTK_NOR_DUAL_REG		0xcc
> > +#define MTK_NOR_DELSEL0_REG		0xa0
> > +#define MTK_NOR_DELSEL1_REG		0xa4
> > +#define MTK_NOR_DELSEL2_REG		0xd0
> > +#define MTK_NOR_DELSEL3_REG		0xd4
> > +#define MTK_NOR_DELSEL4_REG		0xd8
> > +#define MTK_NOR_CFG1_REG		0x60
> > +#define MTK_NOR_CFG2_REG		0x64
> > +#define MTK_NOR_CFG3_REG		0x68
> > +#define MTK_NOR_STATUS0_REG		0x70
> > +#define MTK_NOR_STATUS1_REG		0x74
> > +#define MTK_NOR_STATUS2_REG		0x78
> > +#define MTK_NOR_STATUS3_REG		0x7c
> > +/* commands for mtk nor controller */
> > +#define MTK_NOR_READ_CMD		0x0
> > +#define MTK_NOR_RDSR_CMD		0x2
> > +#define MTK_NOR_PRG_CMD			0x4
> > +#define MTK_NOR_WR_CMD			0x10
> > +#define MTK_NOR_WRSR_CMD		0x20
> > +#define MTK_NOR_PIO_READ_CMD		0x81
> > +#define MTK_NOR_WR_BUF_ENABLE		0x1
> > +#define MTK_NOR_WR_BUF_DISABLE		0x0
> > +#define MTK_NOR_ENABLE_SF_CMD		0x30
> > +#define MTK_NOR_DUAD_ADDR_EN		0x8
> > +#define MTK_NOR_QUAD_READ_EN		0x4
> > +#define MTK_NOR_DUAL_ADDR_EN		0x2
> > +#define MTK_NOR_DUAL_READ_EN		0x1
> > +#define MTK_NOR_DUAL_DISABLE		0x0
> > +#define MTK_NOR_FAST_READ		0x1
> > +
> > +#define SFLASH_WRBUF_SIZE		128
> > +#define MAX_FLASHCOUNT			1
> > +#define SFLASHHWNAME_LEN		12
> > +#define SFLASH_MAX_DMA_SIZE		(1024 * 8)
> > +
> > +#define LOCAL_BUF_SIZE		(SFLASH_MAX_DMA_SIZE * 20)
> > +
> > +struct mt8173_nor {
> > +	struct mtd_info mtd;
> > +	struct spi_nor nor;
> > +	struct device *dev;
> > +	void __iomem *base;	/* nor flash base address */
> > +	struct clk *spi_clk;
> > +	struct clk *nor_clk;
> > +};
> > +
> > +static void mt8173_nor_set_read_mode(struct mt8173_nor *mt8173_nor)
> > +{
> > +	struct spi_nor *nor = &mt8173_nor->nor;
> > +
> > +	switch (nor->flash_read) {
> > +	case SPI_NOR_FAST:
> > +		writeb(SPINOR_OP_READ_FAST, mt8173_nor->base +
> > +		       MTK_NOR_PRGDATA3_REG);
> > +		writeb(MTK_NOR_FAST_READ, mt8173_nor->base +
> > +		       MTK_NOR_CFG1_REG);
> > +		break;
> > +	case SPI_NOR_DUAL:
> > +		writeb(SPINOR_OP_READ_1_1_2, mt8173_nor->base +
> > +		       MTK_NOR_PRGDATA3_REG);
> > +		writeb(MTK_NOR_DUAL_READ_EN, mt8173_nor->base +
> > +		       MTK_NOR_DUAL_REG);
> > +		break;
> > +	case SPI_NOR_QUAD:
> > +		writeb(SPINOR_OP_READ_1_1_4, mt8173_nor->base +
> > +		       MTK_NOR_PRGDATA3_REG);
> > +		writeb(MTK_NOR_QUAD_READ_EN, mt8173_nor->base +
> > +		       MTK_NOR_DUAL_REG);
> > +		break;
> > +	default:
> > +		writeb(SPINOR_OP_READ, mt8173_nor->base +
> > +		       MTK_NOR_PRGDATA3_REG);
> > +		writeb(MTK_NOR_DUAL_DISABLE, mt8173_nor->base +
> > +		       MTK_NOR_DUAL_REG);
> > +		break;
> > +	}
> > +}
> > +
> > +static int mt8173_nor_execute_cmd(struct mt8173_nor *mt8173_nor, u8 cmdval)
> > +{
> > +	int reg;
> > +	u8 val = cmdval & 0x1f;
> > +
> > +	writeb(cmdval, mt8173_nor->base + MTK_NOR_CMD_REG);
> > +	return readl_poll_timeout(mt8173_nor->base + MTK_NOR_CMD_REG, reg,
> > +				  !(reg & val), 100, 10000);
> > +}
> > +
> > +static int mt8173_nor_set_cmd(struct mt8173_nor *mt8173_nor, int addr, int len,
> > +			      int op)
> > +{
> > +	writeb(op, mt8173_nor->base + MTK_NOR_PRGDATA5_REG);
> > +	/*  send the address to nor flash
> > +	 *  MTK_NOR_PRGDATA5_REG is shifted first
> > +	 *  MTK_NOR_PRGDATA0_REG is shifted last
> > +	 */
> > +	writeb(((addr >> 16) & 0xff), mt8173_nor->base + MTK_NOR_PRGDATA4_REG);
> > +	writeb(((addr >> 8) & 0xff), mt8173_nor->base + MTK_NOR_PRGDATA3_REG);
> > +	writeb((addr & 0xff), mt8173_nor->base + MTK_NOR_PRGDATA2_REG);
> Why not use some macros to wrap the hardcode such as:
> 	     (addr >> 16) & 0xff.
> 
> thanks
> Huang Shijie
> 
Hi, Shijie, this is the review comments of Sascha Hauer, So I adopt this
pattern .
"
> > +   writeb(LoByte(HiWord(addr)), mt8173_nor->base +
MTK_NOR_PRGDATA4_REG);
> > +   writeb(HiByte(LoWord(addr)), mt8173_nor->base +
MTK_NOR_PRGDATA3_REG);
> > +   writeb(LoByte(LoWord(addr)), mt8173_nor->base +
MTK_NOR_PRGDATA2_REG);
> 

> Just do a:
> 
> (addr >> 16) & 0xff
> (addr >> 8) & 0xff
> addr & 0xff
> 
"

Thanks
Bayi Cheng
