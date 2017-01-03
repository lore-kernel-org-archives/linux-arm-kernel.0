From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 3 Jan 2017 11:54:35 +0100
Subject: [PATCH] mtd: nand: fsmc: remove stale non-DT probe path
In-Reply-To: <1482060895-26838-1-git-send-email-linus.walleij@linaro.org>
References: <1482060895-26838-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20170103115435.60fc1bc1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 Dec 2016 12:34:55 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The FSMC driver has an execution path and a header file in
> <linux/mtd/fsmc.h> that serves to support passing in platform
> data through board files, albeit no upstream users of this
> mechanism exist.
> 
> The header file also contains function headers for functions that
> do not exist in the kernel.
> 
> Delete this and move the platform data struct, parsing and
> handling into the driver, assume we are using OF and make the
> driver depend on OF, remove the ifdefs making that optional.

Applied.

Thanks,

Boris

> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Vipin Kumar <vipin.kumar@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mtd/nand/Kconfig     |   1 +
>  drivers/mtd/nand/fsmc_nand.c | 153 ++++++++++++++++++++++++++++++++++++------
>  include/linux/mtd/fsmc.h     | 156 -------------------------------------------
>  3 files changed, 133 insertions(+), 177 deletions(-)
>  delete mode 100644 include/linux/mtd/fsmc.h
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 353a9ddf6b97..7d5a9cb4594d 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -534,6 +534,7 @@ config MTD_NAND_JZ4780
>  
>  config MTD_NAND_FSMC
>  	tristate "Support for NAND on ST Micros FSMC"
> +	depends on OF
>  	depends on PLAT_SPEAR || ARCH_NOMADIK || ARCH_U8500 || MACH_U300
>  	help
>  	  Enables support for NAND Flash chips on the ST Microelectronics
> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
> index 4924b43977ef..bda1e4667138 100644
> --- a/drivers/mtd/nand/fsmc_nand.c
> +++ b/drivers/mtd/nand/fsmc_nand.c
> @@ -35,10 +35,133 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> -#include <linux/mtd/fsmc.h>
>  #include <linux/amba/bus.h>
>  #include <mtd/mtd-abi.h>
>  
> +#define FSMC_NAND_BW8		1
> +#define FSMC_NAND_BW16		2
> +
> +#define FSMC_MAX_NOR_BANKS	4
> +#define FSMC_MAX_NAND_BANKS	4
> +
> +#define FSMC_FLASH_WIDTH8	1
> +#define FSMC_FLASH_WIDTH16	2
> +
> +/* fsmc controller registers for NOR flash */
> +#define CTRL			0x0
> +	/* ctrl register definitions */
> +	#define BANK_ENABLE		(1 << 0)
> +	#define MUXED			(1 << 1)
> +	#define NOR_DEV			(2 << 2)
> +	#define WIDTH_8			(0 << 4)
> +	#define WIDTH_16		(1 << 4)
> +	#define RSTPWRDWN		(1 << 6)
> +	#define WPROT			(1 << 7)
> +	#define WRT_ENABLE		(1 << 12)
> +	#define WAIT_ENB		(1 << 13)
> +
> +#define CTRL_TIM		0x4
> +	/* ctrl_tim register definitions */
> +
> +#define FSMC_NOR_BANK_SZ	0x8
> +#define FSMC_NOR_REG_SIZE	0x40
> +
> +#define FSMC_NOR_REG(base, bank, reg)		(base + \
> +						FSMC_NOR_BANK_SZ * (bank) + \
> +						reg)
> +
> +/* fsmc controller registers for NAND flash */
> +#define PC			0x00
> +	/* pc register definitions */
> +	#define FSMC_RESET		(1 << 0)
> +	#define FSMC_WAITON		(1 << 1)
> +	#define FSMC_ENABLE		(1 << 2)
> +	#define FSMC_DEVTYPE_NAND	(1 << 3)
> +	#define FSMC_DEVWID_8		(0 << 4)
> +	#define FSMC_DEVWID_16		(1 << 4)
> +	#define FSMC_ECCEN		(1 << 6)
> +	#define FSMC_ECCPLEN_512	(0 << 7)
> +	#define FSMC_ECCPLEN_256	(1 << 7)
> +	#define FSMC_TCLR_1		(1)
> +	#define FSMC_TCLR_SHIFT		(9)
> +	#define FSMC_TCLR_MASK		(0xF)
> +	#define FSMC_TAR_1		(1)
> +	#define FSMC_TAR_SHIFT		(13)
> +	#define FSMC_TAR_MASK		(0xF)
> +#define STS			0x04
> +	/* sts register definitions */
> +	#define FSMC_CODE_RDY		(1 << 15)
> +#define COMM			0x08
> +	/* comm register definitions */
> +	#define FSMC_TSET_0		0
> +	#define FSMC_TSET_SHIFT		0
> +	#define FSMC_TSET_MASK		0xFF
> +	#define FSMC_TWAIT_6		6
> +	#define FSMC_TWAIT_SHIFT	8
> +	#define FSMC_TWAIT_MASK		0xFF
> +	#define FSMC_THOLD_4		4
> +	#define FSMC_THOLD_SHIFT	16
> +	#define FSMC_THOLD_MASK		0xFF
> +	#define FSMC_THIZ_1		1
> +	#define FSMC_THIZ_SHIFT		24
> +	#define FSMC_THIZ_MASK		0xFF
> +#define ATTRIB			0x0C
> +#define IOATA			0x10
> +#define ECC1			0x14
> +#define ECC2			0x18
> +#define ECC3			0x1C
> +#define FSMC_NAND_BANK_SZ	0x20
> +
> +#define FSMC_NAND_REG(base, bank, reg)		(base + FSMC_NOR_REG_SIZE + \
> +						(FSMC_NAND_BANK_SZ * (bank)) + \
> +						reg)
> +
> +#define FSMC_BUSY_WAIT_TIMEOUT	(1 * HZ)
> +
> +struct fsmc_nand_timings {
> +	uint8_t tclr;
> +	uint8_t tar;
> +	uint8_t thiz;
> +	uint8_t thold;
> +	uint8_t twait;
> +	uint8_t tset;
> +};
> +
> +enum access_mode {
> +	USE_DMA_ACCESS = 1,
> +	USE_WORD_ACCESS,
> +};
> +
> +/**
> + * fsmc_nand_platform_data - platform specific NAND controller config
> + * @nand_timings: timing setup for the physical NAND interface
> + * @partitions: partition table for the platform, use a default fallback
> + * if this is NULL
> + * @nr_partitions: the number of partitions in the previous entry
> + * @options: different options for the driver
> + * @width: bus width
> + * @bank: default bank
> + * @select_bank: callback to select a certain bank, this is
> + * platform-specific. If the controller only supports one bank
> + * this may be set to NULL
> + */
> +struct fsmc_nand_platform_data {
> +	struct fsmc_nand_timings *nand_timings;
> +	struct mtd_partition	*partitions;
> +	unsigned int		nr_partitions;
> +	unsigned int		options;
> +	unsigned int		width;
> +	unsigned int		bank;
> +
> +	enum access_mode	mode;
> +
> +	void			(*select_bank)(uint32_t bank, uint32_t busw);
> +
> +	/* priv structures for dma accesses */
> +	void			*read_dma_priv;
> +	void			*write_dma_priv;
> +};
> +
>  static int fsmc_ecc1_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				   struct mtd_oob_region *oobregion)
>  {
> @@ -714,7 +837,6 @@ static bool filter(struct dma_chan *chan, void *slave)
>  	return true;
>  }
>  
> -#ifdef CONFIG_OF
>  static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
>  				     struct device_node *np)
>  {
> @@ -757,13 +879,6 @@ static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
>  	}
>  	return 0;
>  }
> -#else
> -static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
> -				     struct device_node *np)
> -{
> -	return -ENOSYS;
> -}
> -#endif
>  
>  /*
>   * fsmc_nand_probe - Probe function
> @@ -782,19 +897,15 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
>  	u32 pid;
>  	int i;
>  
> -	if (np) {
> -		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> -		pdev->dev.platform_data = pdata;
> -		ret = fsmc_nand_probe_config_dt(pdev, np);
> -		if (ret) {
> -			dev_err(&pdev->dev, "no platform data\n");
> -			return -ENODEV;
> -		}
> -	}
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
>  
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "platform data is NULL\n");
> -		return -EINVAL;
> +	pdev->dev.platform_data = pdata;
> +	ret = fsmc_nand_probe_config_dt(pdev, np);
> +	if (ret) {
> +		dev_err(&pdev->dev, "no platform data\n");
> +		return -ENODEV;
>  	}
>  
>  	/* Allocate memory for the device structure (and zero it) */
> diff --git a/include/linux/mtd/fsmc.h b/include/linux/mtd/fsmc.h
> deleted file mode 100644
> index ad3c3488073c..000000000000
> --- a/include/linux/mtd/fsmc.h
> +++ /dev/null
> @@ -1,156 +0,0 @@
> -/*
> - * incude/mtd/fsmc.h
> - *
> - * ST Microelectronics
> - * Flexible Static Memory Controller (FSMC)
> - * platform data interface and header file
> - *
> - * Copyright ? 2010 ST Microelectronics
> - * Vipin Kumar <vipin.kumar@st.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __MTD_FSMC_H
> -#define __MTD_FSMC_H
> -
> -#include <linux/io.h>
> -#include <linux/platform_device.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/types.h>
> -#include <linux/mtd/partitions.h>
> -#include <asm/param.h>
> -
> -#define FSMC_NAND_BW8		1
> -#define FSMC_NAND_BW16		2
> -
> -#define FSMC_MAX_NOR_BANKS	4
> -#define FSMC_MAX_NAND_BANKS	4
> -
> -#define FSMC_FLASH_WIDTH8	1
> -#define FSMC_FLASH_WIDTH16	2
> -
> -/* fsmc controller registers for NOR flash */
> -#define CTRL			0x0
> -	/* ctrl register definitions */
> -	#define BANK_ENABLE		(1 << 0)
> -	#define MUXED			(1 << 1)
> -	#define NOR_DEV			(2 << 2)
> -	#define WIDTH_8			(0 << 4)
> -	#define WIDTH_16		(1 << 4)
> -	#define RSTPWRDWN		(1 << 6)
> -	#define WPROT			(1 << 7)
> -	#define WRT_ENABLE		(1 << 12)
> -	#define WAIT_ENB		(1 << 13)
> -
> -#define CTRL_TIM		0x4
> -	/* ctrl_tim register definitions */
> -
> -#define FSMC_NOR_BANK_SZ	0x8
> -#define FSMC_NOR_REG_SIZE	0x40
> -
> -#define FSMC_NOR_REG(base, bank, reg)		(base + \
> -						FSMC_NOR_BANK_SZ * (bank) + \
> -						reg)
> -
> -/* fsmc controller registers for NAND flash */
> -#define PC			0x00
> -	/* pc register definitions */
> -	#define FSMC_RESET		(1 << 0)
> -	#define FSMC_WAITON		(1 << 1)
> -	#define FSMC_ENABLE		(1 << 2)
> -	#define FSMC_DEVTYPE_NAND	(1 << 3)
> -	#define FSMC_DEVWID_8		(0 << 4)
> -	#define FSMC_DEVWID_16		(1 << 4)
> -	#define FSMC_ECCEN		(1 << 6)
> -	#define FSMC_ECCPLEN_512	(0 << 7)
> -	#define FSMC_ECCPLEN_256	(1 << 7)
> -	#define FSMC_TCLR_1		(1)
> -	#define FSMC_TCLR_SHIFT		(9)
> -	#define FSMC_TCLR_MASK		(0xF)
> -	#define FSMC_TAR_1		(1)
> -	#define FSMC_TAR_SHIFT		(13)
> -	#define FSMC_TAR_MASK		(0xF)
> -#define STS			0x04
> -	/* sts register definitions */
> -	#define FSMC_CODE_RDY		(1 << 15)
> -#define COMM			0x08
> -	/* comm register definitions */
> -	#define FSMC_TSET_0		0
> -	#define FSMC_TSET_SHIFT		0
> -	#define FSMC_TSET_MASK		0xFF
> -	#define FSMC_TWAIT_6		6
> -	#define FSMC_TWAIT_SHIFT	8
> -	#define FSMC_TWAIT_MASK		0xFF
> -	#define FSMC_THOLD_4		4
> -	#define FSMC_THOLD_SHIFT	16
> -	#define FSMC_THOLD_MASK		0xFF
> -	#define FSMC_THIZ_1		1
> -	#define FSMC_THIZ_SHIFT		24
> -	#define FSMC_THIZ_MASK		0xFF
> -#define ATTRIB			0x0C
> -#define IOATA			0x10
> -#define ECC1			0x14
> -#define ECC2			0x18
> -#define ECC3			0x1C
> -#define FSMC_NAND_BANK_SZ	0x20
> -
> -#define FSMC_NAND_REG(base, bank, reg)		(base + FSMC_NOR_REG_SIZE + \
> -						(FSMC_NAND_BANK_SZ * (bank)) + \
> -						reg)
> -
> -#define FSMC_BUSY_WAIT_TIMEOUT	(1 * HZ)
> -
> -struct fsmc_nand_timings {
> -	uint8_t tclr;
> -	uint8_t tar;
> -	uint8_t thiz;
> -	uint8_t thold;
> -	uint8_t twait;
> -	uint8_t tset;
> -};
> -
> -enum access_mode {
> -	USE_DMA_ACCESS = 1,
> -	USE_WORD_ACCESS,
> -};
> -
> -/**
> - * fsmc_nand_platform_data - platform specific NAND controller config
> - * @nand_timings: timing setup for the physical NAND interface
> - * @partitions: partition table for the platform, use a default fallback
> - * if this is NULL
> - * @nr_partitions: the number of partitions in the previous entry
> - * @options: different options for the driver
> - * @width: bus width
> - * @bank: default bank
> - * @select_bank: callback to select a certain bank, this is
> - * platform-specific. If the controller only supports one bank
> - * this may be set to NULL
> - */
> -struct fsmc_nand_platform_data {
> -	struct fsmc_nand_timings *nand_timings;
> -	struct mtd_partition	*partitions;
> -	unsigned int		nr_partitions;
> -	unsigned int		options;
> -	unsigned int		width;
> -	unsigned int		bank;
> -
> -	enum access_mode	mode;
> -
> -	void			(*select_bank)(uint32_t bank, uint32_t busw);
> -
> -	/* priv structures for dma accesses */
> -	void			*read_dma_priv;
> -	void			*write_dma_priv;
> -};
> -
> -extern int __init fsmc_nor_init(struct platform_device *pdev,
> -		unsigned long base, uint32_t bank, uint32_t width);
> -extern void __init fsmc_init_board_info(struct platform_device *pdev,
> -		struct mtd_partition *partitions, unsigned int nr_partitions,
> -		unsigned int width);
> -
> -#endif /* __MTD_FSMC_H */
