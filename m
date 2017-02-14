From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 14 Feb 2017 13:58:30 +0100
Subject: [PATCH RESEND 3/5] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <1485535324-28393-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1485535324-28393-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485535324-28393-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1be79cf2-0318-8d07-0df4-911db18f5285@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Le 27/01/2017 ? 17:42, Boris Brezillon a ?crit :
> This is a complete rewrite of the driver whose main purpose is to
> support the new DT representation where the NAND controller node is now
> really visible in the DT and appears under the EBI bus. With this new
> representation, we can add other devices under the EBI bus without
> risking pinmuxing conflicts (the NAND controller is under the EBI
> bus logic and as such, share some of its pins with other devices
> connected on this bus).
> 
> Even though the goal of this rework was not necessarily to add new
> features, the new driver has been designed with this in mind. With a
> clearer separation between the different blocks and different IP
> revisions, adding new functionalities should be easier (we already
> have plans to support SMC timing configuration so that we no longer
> have to rely on the configuration done by the bootloader/bootstrap).
> 
> Also note that we no longer have a custom ->cmdfunc() implementation,
> which means we can now benefit from new features added in the core
> implementation for free (support for new NAND operations for example).
> 
> The last thing that we gain with this rework is support for multi-chips
> and multi-dies chips, thanks to the clean NAND controller <-> NAND
> devices representation.

Thanks for the comprehensive commit message!

> This new driver has been tested on several platforms (at91sam9261,
> at91sam9g45, at91sam9x5, sama5d3 and sama5d4) to make sure it did not
> introduce regressions, and it's worth mentioning that old bindings are
> still supported (which partly explain the positive diffstat).

Great!

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  MAINTAINERS                       |    2 +-
>  drivers/mtd/nand/Makefile         |    2 +-
>  drivers/mtd/nand/atmel/Makefile   |    4 +
>  drivers/mtd/nand/atmel/nfc.c      | 2168 ++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/atmel/pmecc.c    | 1011 +++++++++++++++
>  drivers/mtd/nand/atmel/pmecc.h    |   73 ++
>  drivers/mtd/nand/atmel_nand.c     | 2479 -------------------------------------
>  drivers/mtd/nand/atmel_nand_ecc.h |  163 ---
>  drivers/mtd/nand/atmel_nand_nfc.h |  103 --
>  9 files changed, 3258 insertions(+), 2747 deletions(-)
>  create mode 100644 drivers/mtd/nand/atmel/Makefile
>  create mode 100644 drivers/mtd/nand/atmel/nfc.c
>  create mode 100644 drivers/mtd/nand/atmel/pmecc.c
>  create mode 100644 drivers/mtd/nand/atmel/pmecc.h
>  delete mode 100644 drivers/mtd/nand/atmel_nand.c
>  delete mode 100644 drivers/mtd/nand/atmel_nand_ecc.h
>  delete mode 100644 drivers/mtd/nand/atmel_nand_nfc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26edd832c64e..4248f46e224d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2233,7 +2233,7 @@ M:	Wenyou Yang <wenyou.yang@atmel.com>
>  M:	Josh Wu <rainyfeeling@outlook.com>
>  L:	linux-mtd at lists.infradead.org
>  S:	Supported
> -F:	drivers/mtd/nand/atmel_nand*
> +F:	drivers/mtd/nand/atmel/*
>  
>  ATMEL SDMMC DRIVER
>  M:	Ludovic Desroches <ludovic.desroches@atmel.com>
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 19a66e404d5b..aec629bbe26f 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -25,7 +25,7 @@ obj-$(CONFIG_MTD_NAND_SHARPSL)		+= sharpsl.o
>  obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
>  obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
>  obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
> -obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel_nand.o
> +obj-$(CONFIG_MTD_NAND_ATMEL)		+= atmel/
>  obj-$(CONFIG_MTD_NAND_GPIO)		+= gpio.o
>  omap2_nand-objs := omap2.o
>  obj-$(CONFIG_MTD_NAND_OMAP2) 		+= omap2_nand.o
> diff --git a/drivers/mtd/nand/atmel/Makefile b/drivers/mtd/nand/atmel/Makefile
> new file mode 100644
> index 000000000000..15bc4a014f33
> --- /dev/null
> +++ b/drivers/mtd/nand/atmel/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_MTD_NAND_ATMEL)	+= atmel-nand-controller.o atmel-pmecc.o
> +
> +atmel-nand-controller-objs	:= nfc.o

I have doubts about the name "nfc" as we have *a part* of the newest
nand flash controller and its associated register set that is named
"NFC" in the datasheet: it may lead to some kind of confusion...


> +atmel-pmecc-objs		:= pmecc.o
> diff --git a/drivers/mtd/nand/atmel/nfc.c b/drivers/mtd/nand/atmel/nfc.c
> new file mode 100644
> index 000000000000..3173e5f6c450
> --- /dev/null
> +++ b/drivers/mtd/nand/atmel/nfc.c
> @@ -0,0 +1,2168 @@
> +/*
> + * ? Copyright 2016 ATMEL

Yes, I know it comes from the previous driver but could you please
remove the UTF-8 (or other character encoding).

> + * ? Copyright 2016 Free Electrons

2017?

> + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> + *
> + * Derived from the atmel_nand.c driver which contained the following
> + * copyrights:
> + *
> + *    Copyright ? 2003 Rick Bronson
> + *
> + *    Derived from drivers/mtd/nand/autcpu12.c
> + *        Copyright ? 2001 Thomas Gleixner (gleixner at autronix.de)
> + *
> + *    Derived from drivers/mtd/spia.c
> + *        Copyright ? 2000 Steven J. Hill (sjhill at cotw.com)
> + *
> + *
> + *    Add Hardware ECC support for AT91SAM9260 / AT91SAM9263
> + *        Richard Genoud (richard.genoud at gmail.com), Adeneo Copyright ? 2007
> + *
> + *        Derived from Das U-Boot source code
> + *              (u-boot-1.1.5/board/atmel/at91sam9263ek/nand.c)
> + *        ? Copyright 2006 ATMEL Rousset, Lacressonniere Nicolas
> + *
> + *    Add Programmable Multibit ECC support for various AT91 SoC
> + *        ? Copyright 2012 ATMEL, Hong Xu
> + *
> + *    Add Nand Flash Controller support for SAMA5 SoC
> + *        ? Copyright 2013 ATMEL, Josh Wu (josh.wu at atmel.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/genalloc.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/atmel-matrix.h>
> +#include <linux/module.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/iopoll.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/atmel.h>
> +#include <linux/regmap.h>
> +
> +#include "pmecc.h"
> +
> +#define ATMEL_HSMC_NFC_CFG			0x0
> +#define ATMEL_HSMC_NFC_CFG_SPARESIZE(x)		((x) << 24)
> +#define ATMEL_HSMC_NFC_CFG_DTO(cyc, mul)	(((cyc) << 16) | ((mul) << 20))
> +#define ATMEL_HSMC_NFC_CFG_DTO_MAX		GENMASK(22, 16)
> +#define ATMEL_HSMC_NFC_CFG_RBEDGE		BIT(13)
> +#define ATMEL_HSMC_NFC_CFG_FALLING_EDGE		BIT(12)
> +#define ATMEL_HSMC_NFC_CFG_RSPARE		BIT(9)
> +#define ATMEL_HSMC_NFC_CFG_WSPARE		BIT(8)
> +#define ATMEL_HSMC_NFC_CFG_PAGESIZE_MASK	GENMASK(2, 0)
> +#define ATMEL_HSMC_NFC_CFG_PAGESIZE(x)		(fls((x) / 512) - 1)
> +
> +#define ATMEL_HSMC_NFC_CTRL			0x4
> +#define ATMEL_HSMC_NFC_CTRL_EN			BIT(0)
> +#define ATMEL_HSMC_NFC_CTRL_DIS			BIT(1)
> +
> +#define ATMEL_HSMC_NFC_SR			0x8
> +#define ATMEL_HSMC_NFC_IER			0xc
> +#define ATMEL_HSMC_NFC_IDR			0x10
> +#define ATMEL_HSMC_NFC_IMR			0x14
> +#define ATMEL_HSMC_NFC_SR_ENABLED		BIT(1)
> +#define ATMEL_HSMC_NFC_SR_RB_RISE		BIT(4)
> +#define ATMEL_HSMC_NFC_SR_RB_FALL		BIT(5)
> +#define ATMEL_HSMC_NFC_SR_BUSY			BIT(8)
> +#define ATMEL_HSMC_NFC_SR_WR			BIT(11)
> +#define ATMEL_HSMC_NFC_SR_CSID			GENMASK(14, 12)
> +#define ATMEL_HSMC_NFC_SR_XFRDONE		BIT(16)
> +#define ATMEL_HSMC_NFC_SR_CMDDONE		BIT(17)
> +#define ATMEL_HSMC_NFC_SR_DTOE			BIT(20)
> +#define ATMEL_HSMC_NFC_SR_UNDEF			BIT(21)
> +#define ATMEL_HSMC_NFC_SR_AWB			BIT(22)
> +#define ATMEL_HSMC_NFC_SR_NFCASE		BIT(23)
> +#define ATMEL_HSMC_NFC_SR_RBEDGE(x)		BIT((x) + 24)
> +
> +#define ATMEL_HSMC_NFC_ADDR			0x18
> +#define ATMEL_HSMC_NFC_BANK			0x1c
> +
> +#define ATMEL_NFC_MAX_RB_ID			7
> +
> +#define ATMEL_NFC_SRAM_SIZE			0x2400
> +
> +#define ATMEL_NFC_CMD(pos, cmd)			((cmd) << (((pos) * 8) + 2))
> +#define ATMEL_NFC_VCMD2				BIT(18)
> +#define ATMEL_NFC_ACYCLE(naddrs)		((naddrs) << 19)
> +#define ATMEL_NFC_CSID(cs)			((cs) << 22)
> +#define ATMEL_NFC_DATAEN			BIT(25)
> +#define ATMEL_NFC_NFCWR				BIT(26)
> +
> +#define ATMEL_NAND_ALE_OFFSET			BIT(21)
> +#define ATMEL_NAND_CLE_OFFSET			BIT(22)
> +
> +#define DEFAULT_TIMEOUT_MS			1000
> +
> +#define ATMEL_NFC_MIN_DMA_LEN			64
> +
> +enum atmel_nand_rb_type {
> +	ATMEL_NAND_NO_RB,
> +	ATMEL_NAND_NATIVE_RB,
> +	ATMEL_NAND_GPIO_RB,
> +};
> +
> +struct atmel_nand_rb {
> +	enum atmel_nand_rb_type type;
> +	union {
> +		struct gpio_desc *gpio;
> +		int id;
> +	};
> +};
> +
> +struct atmel_nand_cs {
> +	int id;
> +	struct atmel_nand_rb rb;
> +	struct gpio_desc *csgpio;
> +	struct {
> +		void __iomem *virt;
> +		dma_addr_t dma;
> +	} io;
> +};
> +
> +struct atmel_nand {
> +	struct list_head node;
> +	struct device *dev;
> +	struct nand_chip base;
> +	struct atmel_nand_cs *activecs;
> +	struct atmel_pmecc_user *pmecc;
> +	struct gpio_desc *cdgpio;
> +	int numcs;
> +	struct atmel_nand_cs cs[];
> +};
> +
> +static inline struct atmel_nand *to_atmel_nand(struct nand_chip *chip)
> +{
> +	return container_of(chip, struct atmel_nand, base);
> +}
> +
> +enum atmel_sama5_data_xfer {

Well, sama5 would then mean "all controllers compatible with the one
found on sama5d3"... And even if some SoC doesn't contain the substrig
"sama5"... So maybe think about another way to generically call this
variant of the nand flash controller...

> +	ATMEL_NFC_NO_DATA,
> +	ATMEL_NFC_READ_DATA,
> +	ATMEL_NFC_WRITE_DATA,
> +};
> +
> +struct atmel_sama5_op {
> +	u8 cs;
> +	u8 ncmds;
> +	u8 cmds[2];
> +	u8 naddrs;
> +	u8 addrs[5];
> +	enum atmel_sama5_data_xfer data;
> +};
> +
> +struct atmel_nfc;

Here again: nitpicking about names, but nfc can be confusing with the
NFC register defined in the datasheet.

An idea: when you find good naming scheme, you can add a little glossary
in the header to explain acronyms and naming convention of the driver like:
http://lxr.free-electrons.com/source/drivers/dma/at_hdmac.c#L33


> +struct atmel_nfc_caps;
> +
> +struct atmel_nfc_ops {
> +	int (*probe)(struct platform_device *pdev,
> +		     const struct atmel_nfc_caps *caps);
> +	int (*remove)(struct atmel_nfc *nfc);
> +	void (*nand_init)(struct atmel_nfc *nfc, struct atmel_nand *nand);
> +	int (*ecc_init)(struct atmel_nand *nand);
> +};
> +
> +struct atmel_nfc_caps {
> +	bool has_dma;
> +	bool legacy_of_bindings;
> +	u32 ale_offs;
> +	u32 cle_offs;
> +	const struct atmel_nfc_ops *ops;
> +};
> +
> +struct atmel_nfc {
> +	struct nand_hw_control base;
> +	const struct atmel_nfc_caps *caps;
> +	struct device *dev;
> +	struct regmap *smc;
> +	struct regmap *matrix;
> +	unsigned int ebi_csa_offs;
> +	struct dma_chan *dmac;
> +	struct atmel_pmecc *pmecc;
> +	struct list_head chips;
> +};
> +
> +static inline struct atmel_nfc *to_nfc(struct nand_hw_control *ctl)
> +{
> +	return container_of(ctl, struct atmel_nfc, base);
> +}
> +
> +struct atmel_sama5_nfc {
> +	struct atmel_nfc base;
> +	struct {
> +		struct gen_pool *pool;
> +		void __iomem *virt;
> +		dma_addr_t dma;
> +	} sram;
> +	struct regmap *io;
> +	struct atmel_sama5_op op;
> +	struct completion complete;
> +	int irq;
> +
> +	/* Only used when instantiating from legacy DT bindings. */
> +	struct clk *clk;
> +};
> +
> +static inline struct atmel_sama5_nfc *to_sama5_nfc(struct nand_hw_control *ctl)
> +{
> +	return container_of(to_nfc(ctl), struct atmel_sama5_nfc, base);
> +}
> +
> +static irqreturn_t atmel_sama5_nfc_interrupt(int irq, void *data)
> +{
> +	struct atmel_sama5_nfc *nfc = data;
> +	u32 imr, sr;
> +
> +	regmap_read(nfc->base.smc, ATMEL_HSMC_NFC_IMR, &imr);
> +	regmap_read(nfc->base.smc, ATMEL_HSMC_NFC_SR, &sr);
> +
> +	sr &= imr;
> +
> +	if (sr)
> +		regmap_write(nfc->base.smc, ATMEL_HSMC_NFC_IDR, sr);
> +
> +	if (sr == imr)
> +		complete(&nfc->complete);
> +
> +	return sr ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +static bool atmel_sama5_nfc_op_done(u32 *events, u32 status)
> +{
> +	*events ^= (status & *events);
> +
> +	return !*events;
> +}
> +
> +static int atmel_sama5_nfc_wait(struct atmel_sama5_nfc *nfc, u32 events,
> +				bool poll, unsigned int timeout_ms)
> +{
> +	int ret;
> +
> +	if (!timeout_ms)
> +		timeout_ms = DEFAULT_TIMEOUT_MS;
> +
> +	if (poll) {
> +		u32 status;
> +
> +		ret = regmap_read_poll_timeout(nfc->base.smc,
> +					       ATMEL_HSMC_NFC_SR, status,
> +					       atmel_sama5_nfc_op_done(&events,
> +								       status),
> +					       0, timeout_ms * 1000);
> +	} else {
> +		init_completion(&nfc->complete);
> +		regmap_write(nfc->base.smc, ATMEL_HSMC_NFC_IER, events);
> +		ret = wait_for_completion_timeout(&nfc->complete,
> +						msecs_to_jiffies(timeout_ms));
> +		regmap_write(nfc->base.smc, ATMEL_HSMC_NFC_IDR, 0xffffffff);
> +	}
> +
> +	return ret;
> +}
> +
> +static void atmel_nfc_dma_transfer_finished(void *data)
> +{
> +	struct completion *finished = data;
> +
> +	complete(finished);
> +}
> +
> +static int atmel_nfc_dma_transfer(struct atmel_nfc *nfc, void *buf,
> +				  dma_addr_t dev_dma, size_t len,
> +				  enum dma_data_direction dir)
> +{
> +	DECLARE_COMPLETION_ONSTACK(finished);
> +	dma_addr_t src_dma, dst_dma, buf_dma;
> +	struct dma_async_tx_descriptor *tx;
> +	dma_cookie_t cookie;
> +
> +	buf_dma = dma_map_single(nfc->dev, buf, len, dir);
> +	if (dma_mapping_error(nfc->dev, dev_dma)) {
> +		dev_err(nfc->dev,
> +			"Failed to prepare a buffer for DMA access\n");
> +		goto err;
> +	}
> +
> +	if (dir == DMA_FROM_DEVICE) {
> +		src_dma = dev_dma;
> +		dst_dma = buf_dma;
> +	} else {
> +		src_dma = buf_dma;
> +		dst_dma = dev_dma;
> +	}
> +
> +	tx = dmaengine_prep_dma_memcpy(nfc->dmac, dst_dma, src_dma, len,
> +				       DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
> +	if (!tx) {
> +		dev_err(nfc->dev, "Failed to prepare DMA memcpy\n");
> +		goto err_unmap;
> +	}
> +
> +	tx->callback = atmel_nfc_dma_transfer_finished;
> +	tx->callback_param = &finished;
> +
> +	cookie = dmaengine_submit(tx);
> +	if (dma_submit_error(cookie)) {
> +		dev_err(nfc->dev, "Failed to do DMA tx_submit\n");
> +		goto err_unmap;
> +	}
> +
> +	dma_async_issue_pending(nfc->dmac);
> +	wait_for_completion(&finished);
> +
> +	return 0;
> +
> +err_unmap:
> +	dma_unmap_single(nfc->dev, buf_dma, len, dir);
> +
> +err:
> +	dev_dbg(nfc->dev, "Fall back to CPU I/O\n");
> +
> +	return -EIO;
> +}
> +
> +static u8 atmel_nand_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +
> +	return ioread8(nand->activecs->io.virt);
> +}
> +
> +static u16 atmel_nand_read_word(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +
> +	return ioread16(nand->activecs->io.virt);
> +}
> +
> +static void atmel_nand_write_byte(struct mtd_info *mtd, u8 byte)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		iowrite16(byte | (byte << 8), nand->activecs->io.virt);
> +	else
> +		iowrite8(byte, nand->activecs->io.virt);
> +}
> +
> +static void atmel_nand_read_buf(struct mtd_info *mtd, u8 *buf, int len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +
> +	/*
> +	 * If the controller supports DMA, the buffer address is DMA-able and
> +	 * len is long enough to make DMA transfers profitable, let's trigger
> +	 * a DMA transfer. If it fails, fallback to PIO mode.
> +	 */
> +	if (nfc->dmac && virt_addr_valid(buf) &&
> +	    len >= ATMEL_NFC_MIN_DMA_LEN &&
> +	    !atmel_nfc_dma_transfer(nfc, buf, nand->activecs->io.dma, len,
> +				    DMA_FROM_DEVICE))
> +		return;
> +
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		ioread16_rep(nand->activecs->io.virt, buf, len / 2);
> +	else
> +		ioread8_rep(nand->activecs->io.virt, buf, len);
> +}
> +
> +static void atmel_nand_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +
> +	/*
> +	 * If the controller supports DMA, the buffer address is DMA-able and
> +	 * len is long enough to make DMA transfers profitable, let's trigger
> +	 * a DMA transfer. If it fails, fallback to PIO mode.
> +	 */
> +	if (nfc->dmac && virt_addr_valid(buf) &&
> +	    len >= ATMEL_NFC_MIN_DMA_LEN &&
> +	    !atmel_nfc_dma_transfer(nfc, (void *)buf, nand->activecs->io.dma,
> +				    len, DMA_TO_DEVICE))
> +		return;
> +
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		iowrite16_rep(nand->activecs->io.virt, buf, len / 2);
> +	else
> +		iowrite8_rep(nand->activecs->io.virt, buf, len);
> +}
> +
> +static int atmel_nand_dev_ready(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +
> +	return gpiod_get_value(nand->activecs->rb.gpio);
> +}
> +
> +static void atmel_nand_select_chip(struct mtd_info *mtd, int cs)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +
> +	if (cs < 0 || cs >= nand->numcs) {
> +		nand->activecs = NULL;
> +		chip->dev_ready = NULL;
> +		return;
> +	}
> +
> +	nand->activecs = &nand->cs[cs];
> +
> +	if (nand->activecs->rb.type == ATMEL_NAND_GPIO_RB)
> +		chip->dev_ready = atmel_nand_dev_ready;
> +}
> +
> +static int atmel_sama5_nfc_dev_ready(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_sama5_nfc *nfc = to_sama5_nfc(chip->controller);
> +	u32 status;
> +
> +	regmap_read(nfc->base.smc, ATMEL_HSMC_NFC_SR, &status);
> +
> +	return status & ATMEL_HSMC_NFC_SR_RBEDGE(nand->activecs->rb.id);
> +}
> +
> +static void atmel_sama5_nfc_select_chip(struct mtd_info *mtd, int cs)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_sama5_nfc *nfc = to_sama5_nfc(chip->controller);
> +
> +	atmel_nand_select_chip(mtd, cs);
> +
> +	if (!nand->activecs) {
> +		regmap_write(nfc->base.smc, ATMEL_HSMC_NFC_CTRL,
> +			     ATMEL_HSMC_NFC_CTRL_DIS);
> +		return;
> +	}
> +
> +	if (nand->activecs->rb.type == ATMEL_NAND_NATIVE_RB)
> +		chip->dev_ready = atmel_sama5_nfc_dev_ready;
> +
> +	regmap_update_bits(nfc->base.smc, ATMEL_HSMC_NFC_CFG,
> +			   ATMEL_HSMC_NFC_CFG_PAGESIZE_MASK,
> +			   ATMEL_HSMC_NFC_CFG_PAGESIZE(mtd->writesize));
> +	regmap_write(nfc->base.smc, ATMEL_HSMC_NFC_CTRL,
> +		     ATMEL_HSMC_NFC_CTRL_EN);
> +}
> +
> +static int atmel_sama5_nfc_exec_op(struct atmel_sama5_nfc *nfc)
> +{
> +	u32 addr, val, wait = ATMEL_HSMC_NFC_SR_CMDDONE;
> +	u8 *addrs = nfc->op.addrs;
> +	unsigned int op = 0;
> +	int i, ret;
> +
> +	for (i = 0; i < nfc->op.ncmds; i++)
> +		op |= ATMEL_NFC_CMD(i, nfc->op.cmds[i]);
> +
> +	if (nfc->op.naddrs == 5)

Use a #define for this value.

> +		regmap_write(nfc->base.smc, ATMEL_HSMC_NFC_ADDR, *addrs++);
> +
> +	op |= ATMEL_NFC_CSID(nfc->op.cs) |
> +	      ATMEL_NFC_ACYCLE(nfc->op.naddrs);
> +
> +	if (nfc->op.ncmds > 1)
> +		op |= ATMEL_NFC_VCMD2;
> +
> +	addr = addrs[0] | (addrs[1] << 8) | (addrs[2] << 16) |
> +	       (addrs[3] << 24);
> +
> +	if (nfc->op.data != ATMEL_NFC_NO_DATA) {
> +		op |= ATMEL_NFC_DATAEN;
> +		wait |= ATMEL_HSMC_NFC_SR_XFRDONE;
> +
> +		if (nfc->op.data == ATMEL_NFC_WRITE_DATA)
> +			op |= ATMEL_NFC_NFCWR;
> +	}
> +
> +	/* Clear all flags. */
> +	regmap_read(nfc->base.smc, ATMEL_HSMC_NFC_SR, &val);
> +
> +	/* Send the command. */
> +	regmap_write(nfc->io, op, addr);
> +
> +	ret = atmel_sama5_nfc_wait(nfc, wait, true, 0);
> +	if (ret)
> +		dev_err(nfc->base.dev,
> +			"Failed to send NAND command (err = %d)!",
> +			ret);
> +
> +	/* Reset the op state. */
> +	memset(&nfc->op, 0, sizeof(nfc->op));
> +
> +	return ret;
> +}
> +
> +static void atmel_sama5_nfc_cmd_ctrl(struct mtd_info *mtd, int dat,
> +				     unsigned int ctrl)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_sama5_nfc *nfc = to_sama5_nfc(chip->controller);
> +
> +	if (ctrl & NAND_ALE) {
> +		if (nfc->op.naddrs > 4)

Here also, I guess it's the same test as "if (nfc->op.naddrs == 5)"
above: so try to use same test to make us understand that it's the same
condition. With the #defined value it also should help...

> +			return;
> +
> +		nfc->op.addrs[nfc->op.naddrs++] = dat;
> +	} else if (ctrl & NAND_CLE) {
> +		if (nfc->op.ncmds > 1)
> +			return;
> +
> +		nfc->op.cmds[nfc->op.ncmds++] = dat;
> +	}
> +
> +	if (dat == NAND_CMD_NONE) {
> +		nfc->op.cs = nand->activecs->id;
> +		atmel_sama5_nfc_exec_op(nfc);
> +	}
> +}
> +
> +static void atmel_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> +				unsigned int ctrl)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +
> +	if (ctrl & NAND_CTRL_CHANGE && nand->activecs->csgpio) {
> +		if (ctrl & NAND_NCE)
> +			gpiod_set_value(nand->activecs->csgpio, 0);
> +		else
> +			gpiod_set_value(nand->activecs->csgpio, 1);
> +	}
> +
> +	if (ctrl & NAND_ALE)
> +		writeb(cmd, nand->activecs->io.virt + nfc->caps->ale_offs);
> +	else if (ctrl & NAND_CLE)
> +		writeb(cmd, nand->activecs->io.virt + nfc->caps->cle_offs);
> +}
> +
> +static void atmel_sama5_nfc_copy_to_sram(struct nand_chip *chip, const u8 *buf,
> +					 bool oob_required)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_sama5_nfc *nfc = to_sama5_nfc(chip->controller);
> +	int ret = -EIO;
> +
> +	if (nfc->base.dmac)
> +		ret = atmel_nfc_dma_transfer(&nfc->base, (void *)buf,
> +					     nfc->sram.dma, mtd->writesize,
> +					     DMA_TO_DEVICE);
> +
> +	/* Falling back to CPU copy. */
> +	if (ret)
> +		memcpy_toio(nfc->sram.virt, buf, mtd->writesize);
> +
> +	if (oob_required)
> +		memcpy_toio(nfc->sram.virt + mtd->writesize, chip->oob_poi,
> +			    mtd->oobsize);
> +}
> +
> +static void atmel_sama5_nfc_copy_from_sram(struct nand_chip *chip, u8 *buf,
> +					   bool oob_required)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_sama5_nfc *nfc = to_sama5_nfc(chip->controller);
> +	int ret = -EIO;
> +
> +	if (nfc->base.dmac)
> +		ret = atmel_nfc_dma_transfer(&nfc->base, buf, nfc->sram.dma,
> +					     mtd->writesize, DMA_FROM_DEVICE);
> +
> +	/* Falling back to CPU copy. */
> +	if (ret)
> +		memcpy_fromio(buf, nfc->sram.virt, mtd->writesize);
> +
> +	if (oob_required)
> +		memcpy_fromio(chip->oob_poi, nfc->sram.virt + mtd->writesize,
> +			      mtd->oobsize);
> +}
> +
> +static void atmel_sama5_nfc_set_op_addr(struct nand_chip *chip, int page,
> +					int column)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_sama5_nfc *nfc = to_sama5_nfc(chip->controller);
> +
> +	if (column >= 0) {
> +		nfc->op.addrs[nfc->op.naddrs++] = column;
> +
> +		/*
> +		 * 2 address cycles for the column offset on large page NANDs.
> +		 */
> +		if (mtd->writesize > 512)
> +			nfc->op.addrs[nfc->op.naddrs++] = column >> 8;
> +	}
> +
> +	if (page >= 0) {
> +		nfc->op.addrs[nfc->op.naddrs++] = page;
> +		nfc->op.addrs[nfc->op.naddrs++] = page >> 8;
> +
> +		if ((mtd->writesize > 512 && chip->chipsize > SZ_128M) ||
> +		    (mtd->writesize <= 512 && chip->chipsize > SZ_32M))
> +			nfc->op.addrs[nfc->op.naddrs++] = page >> 16;
> +	}
> +}
> +
> +static int atmel_nfc_pmecc_enable(struct nand_chip *chip, int op, bool raw)
> +{
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +	int ret;
> +
> +	if (raw)
> +		return 0;
> +
> +	ret = atmel_pmecc_enable(nand->pmecc, op);
> +	if (ret)
> +		dev_err(nfc->dev,
> +			"Failed to enable ECC engine (err = %d)\n", ret);
> +
> +	return ret;
> +}
> +
> +static void atmel_nfc_pmecc_disable(struct nand_chip *chip, bool raw)
> +{
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +
> +	if (!raw)
> +		atmel_pmecc_disable(nand->pmecc);
> +}
> +
> +static int atmel_nfc_pmecc_generate_eccbytes(struct nand_chip *chip, bool raw)
> +{
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +	struct mtd_oob_region oobregion;
> +	void *eccbuf;
> +	int ret, i;
> +
> +	if (raw)
> +		return 0;
> +
> +	ret = atmel_pmecc_wait_rdy(nand->pmecc);
> +	if (ret) {
> +		dev_err(nfc->dev,
> +			"Failed to transfer NAND page data (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	mtd_ooblayout_ecc(mtd, 0, &oobregion);
> +	eccbuf = chip->oob_poi + oobregion.offset;
> +
> +	for (i = 0; i < chip->ecc.steps; i++) {
> +		atmel_pmecc_get_generated_eccbytes(nand->pmecc, i,
> +						   eccbuf);
> +		eccbuf += chip->ecc.bytes;
> +	}
> +
> +	return 0;
> +}
> +
> +static int atmel_nfc_pmecc_correct_data(struct nand_chip *chip, void *buf,
> +					bool raw)
> +{
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +	struct mtd_oob_region oobregion;
> +	int ret, i, max_bitflips = 0;
> +	void *databuf, *eccbuf;
> +
> +	if (raw)
> +		return 0;
> +
> +	ret = atmel_pmecc_wait_rdy(nand->pmecc);
> +	if (ret) {
> +		dev_err(nfc->dev,
> +			"Failed to read NAND page data (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	mtd_ooblayout_ecc(mtd, 0, &oobregion);
> +	eccbuf = chip->oob_poi + oobregion.offset;
> +	databuf = buf;
> +
> +	for (i = 0; i < chip->ecc.steps; i++) {
> +		ret = atmel_pmecc_correct_sector(nand->pmecc, i, databuf,
> +						 eccbuf);
> +		if (ret < 0 && !atmel_pmecc_correct_erased_chunks(nand->pmecc))
> +			ret = nand_check_erased_ecc_chunk(databuf,
> +							  chip->ecc.size,
> +							  eccbuf,
> +							  chip->ecc.bytes,
> +							  NULL, 0,
> +							  chip->ecc.strength);
> +
> +		if (ret >= 0)
> +			max_bitflips = max(ret, max_bitflips);
> +		else
> +			mtd->ecc_stats.failed++;
> +
> +		databuf += chip->ecc.size;
> +		eccbuf += chip->ecc.bytes;
> +	}
> +
> +	return max_bitflips;
> +}
> +
> +static int atmel_nfc_pmecc_write_pg(struct nand_chip *chip, const u8 *buf,
> +				    bool oob_required, int page, bool raw)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	int ret;
> +
> +	ret = atmel_nfc_pmecc_enable(chip, NAND_ECC_WRITE, raw);
> +	if (ret)
> +		return ret;
> +
> +	atmel_nand_write_buf(mtd, buf, mtd->writesize);
> +
> +	ret = atmel_nfc_pmecc_generate_eccbytes(chip, raw);
> +	if (ret) {
> +		atmel_pmecc_disable(nand->pmecc);
> +		return ret;
> +	}
> +
> +	atmel_nfc_pmecc_disable(chip, raw);
> +
> +	atmel_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
> +
> +	return 0;
> +}
> +
> +static int atmel_nfc_pmecc_write_page(struct mtd_info *mtd,
> +				      struct nand_chip *chip, const u8 *buf,
> +				      int oob_required, int page)
> +{
> +	return atmel_nfc_pmecc_write_pg(chip, buf, oob_required, page, false);
> +}
> +
> +static int atmel_nfc_pmecc_write_page_raw(struct mtd_info *mtd,
> +					  struct nand_chip *chip,
> +					  const u8 *buf, int oob_required,
> +					  int page)
> +{
> +	return atmel_nfc_pmecc_write_pg(chip, buf, oob_required, page, true);
> +}
> +
> +static int atmel_nfc_pmecc_read_pg(struct nand_chip *chip, u8 *buf,
> +				   bool oob_required, int page, bool raw)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	int ret;
> +
> +	ret = atmel_nfc_pmecc_enable(chip, NAND_ECC_READ, raw);
> +	if (ret)
> +		return ret;
> +
> +	atmel_nand_read_buf(mtd, buf, mtd->writesize);
> +	atmel_nand_read_buf(mtd, chip->oob_poi, mtd->oobsize);
> +
> +	ret = atmel_nfc_pmecc_correct_data(chip, buf, raw);
> +
> +	atmel_nfc_pmecc_disable(chip, raw);
> +
> +	return ret;
> +}
> +
> +static int atmel_nfc_pmecc_read_page(struct mtd_info *mtd,
> +				     struct nand_chip *chip, u8 *buf,
> +				     int oob_required, int page)
> +{
> +	return atmel_nfc_pmecc_read_pg(chip, buf, oob_required, page, false);
> +}
> +
> +static int atmel_nfc_pmecc_read_page_raw(struct mtd_info *mtd,
> +					 struct nand_chip *chip, u8 *buf,
> +					 int oob_required, int page)
> +{
> +	return atmel_nfc_pmecc_read_pg(chip, buf, oob_required, page, true);
> +}
> +
> +static int atmel_sama5_nfc_pmecc_write_pg(struct nand_chip *chip,
> +					  const u8 *buf, bool oob_required,
> +					  int page, bool raw)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_sama5_nfc *nfc = to_sama5_nfc(chip->controller);
> +	int ret;
> +
> +	atmel_sama5_nfc_copy_to_sram(chip, buf, false);
> +
> +	nfc->op.cmds[0] = NAND_CMD_SEQIN;
> +	nfc->op.ncmds = 1;
> +	atmel_sama5_nfc_set_op_addr(chip, page, 0x0);
> +	nfc->op.cs = nand->activecs->id;
> +	nfc->op.data = ATMEL_NFC_WRITE_DATA;
> +
> +	ret = atmel_nfc_pmecc_enable(chip, NAND_ECC_WRITE, raw);
> +	if (ret)
> +		return ret;
> +
> +	ret = atmel_sama5_nfc_exec_op(nfc);
> +	if (ret) {
> +		atmel_nfc_pmecc_disable(chip, raw);
> +		dev_err(nfc->base.dev,
> +			"Failed to transfer NAND page data (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = atmel_nfc_pmecc_generate_eccbytes(chip, raw);
> +
> +	atmel_nfc_pmecc_disable(chip, raw);
> +
> +	if (ret)
> +		return ret;
> +
> +	atmel_nand_write_buf(mtd, chip->oob_poi, mtd->oobsize);
> +
> +	nfc->op.cmds[0] = NAND_CMD_PAGEPROG;
> +	nfc->op.ncmds = 1;
> +	nfc->op.cs = nand->activecs->id;
> +	ret = atmel_sama5_nfc_exec_op(nfc);
> +	if (ret)
> +		dev_err(nfc->base.dev, "Failed to program NAND page (err = %d)\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +static int atmel_sama5_nfc_pmecc_write_page(struct mtd_info *mtd,
> +					    struct nand_chip *chip,
> +					    const u8 *buf, int oob_required,
> +					    int page)
> +{
> +	return atmel_sama5_nfc_pmecc_write_pg(chip, buf, oob_required, page,
> +					      false);
> +}
> +
> +static int atmel_sama5_nfc_pmecc_write_page_raw(struct mtd_info *mtd,
> +						struct nand_chip *chip,
> +						const u8 *buf,
> +						int oob_required, int page)
> +{
> +	return atmel_sama5_nfc_pmecc_write_pg(chip, buf, oob_required, page,
> +					      true);
> +}
> +
> +static int atmel_sama5_nfc_pmecc_read_pg(struct nand_chip *chip, u8 *buf,
> +					 bool oob_required, int page, bool raw)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_sama5_nfc *nfc = to_sama5_nfc(chip->controller);
> +	int ret;
> +
> +	/*
> +	 * Optimized read page accessors only work when the NAND R/B pin is
> +	 * connected to a native SoC R/B pin. If that's not the case, fallback
> +	 * to the non-optimized one.
> +	 */
> +	if (nand->activecs->rb.type != ATMEL_NAND_NATIVE_RB) {

Can't we optimize this path by not having to test this for each page read?

> +		chip->cmdfunc(mtd, NAND_CMD_READ0, 0x00, page);
> +
> +		return atmel_nfc_pmecc_read_pg(chip, buf, oob_required, page,
> +					       raw);
> +	}
> +
> +	nfc->op.cmds[nfc->op.ncmds++] = NAND_CMD_READ0;
> +
> +	if (mtd->writesize > 512)
> +		nfc->op.cmds[nfc->op.ncmds++] = NAND_CMD_READSTART;
> +
> +	atmel_sama5_nfc_set_op_addr(chip, page, 0x0);
> +	nfc->op.cs = nand->activecs->id;
> +	nfc->op.data = ATMEL_NFC_READ_DATA;
> +
> +	ret = atmel_nfc_pmecc_enable(chip, NAND_ECC_READ, raw);
> +	if (ret)
> +		return ret;
> +
> +	ret = atmel_sama5_nfc_exec_op(nfc);
> +	if (ret) {
> +		atmel_nfc_pmecc_disable(chip, raw);
> +		dev_err(nfc->base.dev,
> +			"Failed to load NAND page data (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	atmel_sama5_nfc_copy_from_sram(chip, buf, false);
> +	atmel_nand_read_buf(mtd, chip->oob_poi, mtd->oobsize);
> +
> +	ret = atmel_nfc_pmecc_correct_data(chip, buf, raw);
> +
> +	atmel_nfc_pmecc_disable(chip, raw);
> +
> +	return ret;
> +}
> +
> +static int atmel_sama5_nfc_pmecc_read_page(struct mtd_info *mtd,
> +					   struct nand_chip *chip, u8 *buf,
> +					   int oob_required, int page)
> +{
> +	return atmel_sama5_nfc_pmecc_read_pg(chip, buf, oob_required, page,
> +					     false);
> +}
> +
> +static int atmel_sama5_nfc_pmecc_read_page_raw(struct mtd_info *mtd,
> +					       struct nand_chip *chip, u8 *buf,
> +					       int oob_required, int page)
> +{
> +	return atmel_sama5_nfc_pmecc_read_pg(chip, buf, oob_required, page,
> +					     true);
> +}
> +
> +static int atmel_nand_pmecc_init(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct atmel_nand *nand = to_atmel_nand(chip);
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +	struct atmel_pmecc_user_req req;
> +
> +	if (!nfc->pmecc) {
> +		dev_err(nfc->dev, "HW ECC not supported\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	if (nfc->caps->legacy_of_bindings) {
> +		u32 val;
> +
> +		if (!of_property_read_u32(nfc->dev->of_node, "atmel,pmecc-cap",
> +					  &val))
> +			chip->ecc.strength = val;
> +
> +		if (!of_property_read_u32(nfc->dev->of_node,
> +					  "atmel,pmecc-sector-size",
> +					  &val))
> +			chip->ecc.size = val;
> +	}
> +
> +	if (chip->ecc.options & NAND_ECC_MAXIMIZE)
> +		req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
> +	else if (chip->ecc.strength)
> +		req.ecc.strength = chip->ecc.strength;
> +	else if (chip->ecc_strength_ds)
> +		req.ecc.strength = chip->ecc_strength_ds;
> +	else
> +		req.ecc.strength = ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH;
> +
> +	if (chip->ecc.size)
> +		req.ecc.sectorsize = chip->ecc.size;
> +	else if (chip->ecc_step_ds)
> +		req.ecc.sectorsize = chip->ecc_step_ds;
> +	else
> +		req.ecc.sectorsize = ATMEL_PMECC_SECTOR_SIZE_AUTO;
> +
> +	req.pagesize = mtd->writesize;
> +	req.oobsize = mtd->oobsize;
> +
> +	if (mtd->writesize <= 512) {
> +		req.ecc.bytes = 4;
> +		req.ecc.ooboffset = 0;
> +	} else {
> +		req.ecc.bytes = mtd->oobsize - 2;
> +		req.ecc.ooboffset = ATMEL_PMECC_OOBOFFSET_AUTO;
> +	}
> +
> +	nand->pmecc = atmel_pmecc_create_user(nfc->pmecc, &req);
> +	if (IS_ERR(nand->pmecc))
> +		return PTR_ERR(nand->pmecc);
> +
> +	chip->ecc.algo = NAND_ECC_BCH;
> +	chip->ecc.size = req.ecc.sectorsize;
> +	chip->ecc.bytes = req.ecc.bytes / req.ecc.nsectors;
> +	chip->ecc.strength = req.ecc.strength;
> +
> +	chip->options |= NAND_NO_SUBPAGE_WRITE;
> +
> +	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> +
> +	return 0;
> +}
> +
> +static int atmel_nfc_ecc_init(struct atmel_nand *nand)
> +{
> +	struct nand_chip *chip = &nand->base;
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +	int ret;
> +
> +	switch (chip->ecc.mode) {
> +	case NAND_ECC_NONE:
> +	case NAND_ECC_SOFT:
> +		/*
> +		 * Nothing to do, the core will initialize everything for us.
> +		 */
> +		break;
> +
> +	case NAND_ECC_HW:
> +		ret = atmel_nand_pmecc_init(chip);
> +		if (ret)
> +			return ret;
> +
> +		chip->ecc.read_page = atmel_nfc_pmecc_read_page;
> +		chip->ecc.write_page = atmel_nfc_pmecc_write_page;
> +		chip->ecc.read_page_raw = atmel_nfc_pmecc_read_page_raw;
> +		chip->ecc.write_page_raw = atmel_nfc_pmecc_write_page_raw;
> +		break;
> +
> +	default:
> +		/* Other modes are not supported. */
> +		dev_err(nfc->dev, "Unsupported ECC mode: %d\n",
> +			chip->ecc.mode);
> +		return -ENOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int atmel_sama5_nfc_ecc_init(struct atmel_nand *nand)
> +{
> +	struct nand_chip *chip = &nand->base;
> +	int ret;
> +
> +	ret = atmel_nfc_ecc_init(nand);
> +	if (ret)
> +		return ret;
> +
> +	if (chip->ecc.mode != NAND_ECC_HW)
> +		return 0;
> +
> +	/* Adjust the ECC operations for the SAMA5 IP. */
> +	chip->ecc.read_page = atmel_sama5_nfc_pmecc_read_page;
> +	chip->ecc.write_page = atmel_sama5_nfc_pmecc_write_page;
> +	chip->ecc.read_page_raw = atmel_sama5_nfc_pmecc_read_page_raw;
> +	chip->ecc.write_page_raw = atmel_sama5_nfc_pmecc_write_page_raw;
> +	chip->ecc.options |= NAND_ECC_CUSTOM_PAGE_ACCESS;
> +
> +	return 0;
> +}
> +
> +static void atmel_nfc_nand_init(struct atmel_nfc *nfc, struct atmel_nand *nand)
> +{
> +	struct nand_chip *chip = &nand->base;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +
> +	mtd->dev.parent = nfc->dev;
> +	nand->base.controller = &nfc->base;
> +
> +	chip->cmd_ctrl = atmel_nand_cmd_ctrl;
> +	chip->read_byte = atmel_nand_read_byte;
> +	chip->read_word = atmel_nand_read_word;
> +	chip->write_byte = atmel_nand_write_byte;
> +	chip->read_buf = atmel_nand_read_buf;
> +	chip->write_buf = atmel_nand_write_buf;
> +	chip->select_chip = atmel_nand_select_chip;
> +
> +	/*
> +	 * Use a bounce buffer when the buffer passed by the MTD user is not
> +	 * suitable for DMA.
> +	 */
> +	if (nfc->dmac)
> +		chip->options |= NAND_USE_BOUNCE_BUFFER;
> +
> +	/* Default to HW ECC if pmecc is available. */
> +	if (nfc->pmecc)
> +		chip->ecc.mode = NAND_ECC_HW;
> +}
> +
> +static void atmel_sama5_nfc_nand_init(struct atmel_nfc *nfc,
> +				      struct atmel_nand *nand)
> +{
> +	struct nand_chip *chip = &nand->base;
> +
> +	atmel_nfc_nand_init(nfc, nand);
> +
> +	/* Overload some methods for the SAMA5 controller. */

"for the SAMA5D3-compatible controller"

> +	chip->cmd_ctrl = atmel_sama5_nfc_cmd_ctrl;
> +	chip->select_chip = atmel_sama5_nfc_select_chip;
> +}
> +
> +static int atmel_nfc_nand_detect(struct atmel_nand *nand)
> +{
> +	struct nand_chip *chip = &nand->base;
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	int ret;
> +
> +	ret = nand_scan_ident(mtd, nand->numcs, NULL);
> +	if (ret)
> +		dev_err(nfc->dev, "nand_scan_ident() failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int atmel_nfc_nand_unregister(struct atmel_nand *nand)
> +{
> +	struct nand_chip *chip = &nand->base;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	int ret;
> +
> +	ret = mtd_device_unregister(mtd);
> +	if (ret)
> +		return ret;
> +
> +	nand_cleanup(chip);
> +	list_del(&nand->node);
> +
> +	return 0;
> +}
> +
> +static int atmel_nfc_nand_register(struct atmel_nand *nand)
> +{
> +	struct nand_chip *chip = &nand->base;
> +	struct atmel_nfc *nfc = to_nfc(chip->controller);
> +	struct atmel_nand_data *pdata = dev_get_platdata(nfc->dev);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	const struct mtd_partition *parts = NULL;
> +	int nparts = 0, ret;
> +
> +	if (nfc->caps->legacy_of_bindings || !nfc->dev->of_node) {
> +		/*
> +		 * We keep the MTD name unchanged to avoid breaking platforms
> +		 * where the MTD cmdline parser is used and the bootloader
> +		 * has not been updated to use the new naming scheme.
> +		 */
> +		mtd->name = "atmel_nand";
> +	} else if (!mtd->name) {
> +		/*
> +		 * If the new bindings are used and the bootloader has not been
> +		 * updated to pass a new mtdparts parameter on the cmdline, you
> +		 * should define the following property in your nand node:
> +		 *
> +		 *	label = "atmel_nand";

I don't see this in the new binding documentation. It is useful to
document it.


> +		 *
> +		 * This way, mtd->name will be set by the core when
> +		 * nand_set_flash_node() is called.
> +		 */
> +		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
> +					   "%s:nand.%d", dev_name(nfc->dev),
> +					   nand->cs[0].id);
> +		if (!mtd->name) {
> +			dev_err(nfc->dev, "Failed to allocate mtd->name\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	ret = nand_scan_tail(mtd);
> +	if (ret) {
> +		dev_err(nfc->dev, "nand_scan_tail() failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (pdata) {
> +		parts = pdata->parts;
> +		nparts = pdata->num_parts;
> +	}
> +
> +	ret = mtd_device_register(mtd, parts, nparts);
> +	if (ret) {
> +		dev_err(nfc->dev, "Failed to register mtd device: %d\n", ret);
> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	list_add_tail(&nand->node, &nfc->chips);
> +
> +	return 0;
> +}
> +
> +struct gpio_desc *atmel_nand_of_get_gpio(struct atmel_nfc *nfc,
> +					 struct device_node *np,
> +					 const char *name, int index,
> +					 enum gpiod_flags flags)
> +{
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	gpio = devm_get_index_gpiod_from_child(nfc->dev, name, index,
> +					       &np->fwnode);
> +	if (IS_ERR(gpio)) {
> +		if (PTR_ERR(gpio) == -ENOENT)
> +			return NULL;
> +
> +		return gpio;
> +	}
> +
> +	if (!(flags & GPIOD_FLAGS_BIT_DIR_SET))
> +		return gpio;
> +
> +	/* Process flags */

Nit: "." at the end like other comments in the file

> +	if (flags & GPIOD_FLAGS_BIT_DIR_OUT)
> +		ret = gpiod_direction_output(gpio,
> +					!!(flags & GPIOD_FLAGS_BIT_DIR_VAL));
> +	else
> +		ret = gpiod_direction_input(gpio);
> +
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return gpio;
> +}
> +
> +struct gpio_desc *atmel_nand_pdata_get_gpio(struct atmel_nfc *nfc,
> +					    int gpioid, const char *name,
> +					    bool active_low,
> +					    enum gpiod_flags flags)
> +{
> +	unsigned long oflags;
> +	int ret;
> +
> +	if (!gpio_is_valid(gpioid))
> +		return NULL;
> +
> +	switch (flags) {
> +	case GPIOD_IN:
> +		oflags = GPIOF_IN;
> +		break;
> +	case GPIOD_OUT_LOW:
> +		oflags = GPIOF_OUT_INIT_LOW;
> +		break;
> +	case GPIOD_OUT_HIGH:
> +		oflags = GPIOF_OUT_INIT_HIGH;
> +		break;
> +	default:
> +		dev_err(nfc->dev, "Unsupported GPIO config\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (active_low)
> +		oflags |= GPIOF_ACTIVE_LOW;
> +
> +	ret = devm_gpio_request_one(nfc->dev, gpioid, oflags, name);
> +	if (ret < 0) {
> +		dev_err(nfc->dev, "Could not request %s GPIO (err = %d)\n",
> +			name, ret);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return gpio_to_desc(gpioid);
> +}
> +
> +static struct atmel_nand *atmel_nfc_of_nand_create(struct atmel_nfc *nfc,
> +						   struct device_node *np,
> +						   int reg_cells)
> +{
> +	struct atmel_nand *nand;
> +	struct gpio_desc *gpio;
> +	int numcs, ret, i;
> +
> +	numcs = of_property_count_elems_of_size(np, "reg",
> +						reg_cells * sizeof(u32));
> +	if (numcs < 1) {
> +		dev_err(nfc->dev, "Missing or invalid reg property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	nand = devm_kzalloc(nfc->dev,
> +			    sizeof(*nand) + (numcs * sizeof(*nand->cs)),
> +			    GFP_KERNEL);
> +	if (!nand) {
> +		dev_err(nfc->dev, "Failed to allocate NAND object\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	nand->numcs = numcs;
> +
> +	gpio = atmel_nand_of_get_gpio(nfc, np, "det", 0, GPIOD_IN);
> +	if (IS_ERR(gpio)) {
> +		dev_err(nfc->dev,
> +			"Failed to get detect gpio (err = %ld)\n",
> +			PTR_ERR(gpio));
> +		return ERR_CAST(gpio);
> +	}
> +
> +	nand->cdgpio = gpio;
> +
> +	for (i = 0; i < numcs; i++) {
> +		struct resource res;
> +		u32 val;
> +
> +		ret = of_address_to_resource(np, 0, &res);
> +		if (ret) {
> +			dev_err(nfc->dev, "Invalid reg property (err = %d)\n",
> +				ret);
> +			return ERR_PTR(ret);
> +		}
> +
> +		ret = of_property_read_u32_index(np, "reg", i * reg_cells,
> +						 &val);
> +		if (ret) {
> +			dev_err(nfc->dev, "Invalid reg property (err = %d)\n",
> +				ret);
> +			return ERR_PTR(ret);
> +		}
> +
> +		nand->cs[i].id = val;
> +
> +		nand->cs[i].io.dma = res.start;
> +		nand->cs[i].io.virt = devm_ioremap_resource(nfc->dev, &res);
> +		if (IS_ERR(nand->cs[i].io.virt))
> +			return ERR_CAST(nand->cs[i].io.virt);
> +
> +		if (!of_property_read_u32(np, "atmel,rb", &val)) {
> +			if (val > ATMEL_NFC_MAX_RB_ID)
> +				return ERR_PTR(-EINVAL);
> +
> +			nand->cs[i].rb.type = ATMEL_NAND_NATIVE_RB;
> +			nand->cs[i].rb.id = val;
> +		} else {
> +			gpio = atmel_nand_of_get_gpio(nfc, np, "rb", i,
> +						      GPIOD_IN);
> +			if (IS_ERR(gpio)) {
> +				dev_err(nfc->dev,
> +					"Failed to get R/B gpio (err = %ld)\n",
> +					PTR_ERR(gpio));
> +				return ERR_CAST(gpio);
> +			}
> +
> +			if (gpio) {
> +				nand->cs[i].rb.type = ATMEL_NAND_GPIO_RB;
> +				nand->cs[i].rb.gpio = gpio;
> +			}
> +		}
> +
> +		gpio = atmel_nand_of_get_gpio(nfc, np, "cs", i,
> +					      GPIOD_OUT_HIGH);
> +		if (IS_ERR(gpio)) {
> +			dev_err(nfc->dev,
> +				"Failed to get CS gpio (err = %ld)\n",
> +				PTR_ERR(gpio));
> +			return ERR_CAST(gpio);
> +		}
> +
> +		nand->cs[i].csgpio = gpio;
> +	}
> +
> +	nand_set_flash_node(&nand->base, np);
> +
> +	return nand;
> +}
> +
> +static int atmel_nfc_add_nand(struct atmel_nfc *nfc, struct atmel_nand *nand)
> +{
> +	int ret;
> +
> +	/* No card inserted, skip this NAND. */
> +	if (nand->cdgpio && gpiod_get_value(nand->cdgpio)) {
> +		dev_info(nfc->dev, "No SmartMedia card inserted.\n");
> +		return 0;
> +	}
> +
> +	nfc->caps->ops->nand_init(nfc, nand);
> +
> +	/*
> +	 * Attach the CS to the NAND Flash logic. Only required on pre-sama5
> +	 * SoCs.
> +	 */
> +	if (nfc->matrix) {
> +		int i;
> +
> +		for (i = 0; i < nand->numcs; i++)
> +			regmap_update_bits(nfc->matrix, nfc->ebi_csa_offs,
> +					   BIT(nand->cs[i].id),
> +					   BIT(nand->cs[i].id));
> +	}
> +
> +	ret = atmel_nfc_nand_detect(nand);
> +	if (ret)
> +		return ret;
> +
> +	ret = nfc->caps->ops->ecc_init(nand);
> +	if (ret)
> +		return ret;
> +
> +	return atmel_nfc_nand_register(nand);
> +}
> +
> +static int atmel_nfc_remove_nands(struct atmel_nfc *nfc)
> +{
> +	struct atmel_nand *nand, *tmp;
> +	int ret;
> +
> +	list_for_each_entry_safe(nand, tmp, &nfc->chips, node) {
> +		ret = atmel_nfc_nand_unregister(nand);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int atmel_nfc_of_add_nands(struct atmel_nfc *nfc)
> +{
> +	struct device_node *np, *nand_np;
> +	struct device *dev = nfc->dev;
> +	int ret, reg_cells;
> +	u32 val;
> +
> +	np = dev->of_node;
> +
> +	ret = of_property_read_u32(np, "#address-cells", &val);
> +	if (ret) {
> +		dev_err(dev, "missing #address-cells property\n");
> +		return ret;
> +	}
> +
> +	reg_cells = val;
> +
> +	ret = of_property_read_u32(np, "#size-cells", &val);
> +	if (ret) {
> +		dev_err(dev, "missing #address-cells property\n");
> +		return ret;
> +	}
> +
> +	reg_cells += val;
> +
> +	for_each_child_of_node(np, nand_np) {
> +		struct atmel_nand *nand;
> +
> +		nand = atmel_nfc_of_nand_create(nfc, nand_np, reg_cells);
> +		if (IS_ERR(nand)) {
> +			ret = PTR_ERR(nand);
> +			goto err;
> +		}
> +
> +		ret = atmel_nfc_add_nand(nfc, nand);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	atmel_nfc_remove_nands(nfc);
> +
> +	return ret;
> +}
> +
> +static int atmel_nfc_legacy_add_nands(struct atmel_nfc *nfc)
> +{
> +	struct device *dev = nfc->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct atmel_nand_data *pdata = dev_get_platdata(dev);
> +	struct atmel_nand *nand;
> +	struct gpio_desc *gpio;
> +	struct resource *res;
> +
> +	/*
> +	 * Legacy bindings only allow connecting a single NAND with a unique CS
> +	 * line to the controller.
> +	 */
> +	nand = devm_kzalloc(nfc->dev, sizeof(*nand) + sizeof(*nand->cs),
> +			    GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand->numcs = 1;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	nand->cs[0].io.virt = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(nand->cs[0].io.virt))
> +		return PTR_ERR(nand->cs[0].io.virt);
> +
> +	nand->cs[0].io.dma = res->start;
> +
> +	/*
> +	 * The old driver was hardcoding the CS id to 3 for all sama5
> +	 * controllers. Since this id is only meaningful for the sama5
> +	 * controller we can safely assign this id to 3 no matter the
> +	 * controller.
> +	 * If one wants to connect a NAND to a different CS line, he will
> +	 * have to use the new bindings.

Yes!

> +	 */
> +	nand->cs[0].id = 3;
> +
> +	/* R/B GPIO. */
> +	if (pdata)
> +		gpio = atmel_nand_pdata_get_gpio(nfc, pdata->rdy_pin,
> +						 "nand-rb",
> +						 pdata->rdy_pin_active_low,
> +						 GPIOD_IN);
> +	else
> +		gpio = devm_gpiod_get_index_optional(dev, NULL, 0,
> +						     GPIOD_IN);
> +	if (IS_ERR(gpio)) {
> +		dev_err(dev, "Failed to get R/B gpio (err = %ld)\n",
> +			PTR_ERR(gpio));
> +		return PTR_ERR(gpio);
> +	}
> +
> +	if (gpio) {
> +		nand->cs[0].rb.type = ATMEL_NAND_GPIO_RB;
> +		nand->cs[0].rb.gpio = gpio;
> +	}
> +
> +	/* CS GPIO. */
> +	if (pdata)
> +		gpio = atmel_nand_pdata_get_gpio(nfc, pdata->enable_pin,
> +						 "nand-cs", 0, GPIOD_OUT_HIGH);
> +	else
> +		gpio = devm_gpiod_get_index_optional(dev, NULL, 1,
> +						     GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpio)) {
> +		dev_err(dev, "Failed to get CS gpio (err = %ld)\n",
> +			PTR_ERR(gpio));
> +		return PTR_ERR(gpio);
> +	}
> +
> +	nand->cs[0].csgpio = gpio;
> +
> +	/* Card detect GPIO. */
> +	if (pdata)
> +		gpio = atmel_nand_pdata_get_gpio(nfc, pdata->det_pin,
> +						 "nand-cd", 0, GPIOD_IN);
> +	else
> +		gpio = devm_gpiod_get_index_optional(nfc->dev, NULL, 2,
> +						     GPIOD_IN);
> +	if (IS_ERR(gpio)) {
> +		dev_err(dev,
> +			"Failed to get detect gpio (err = %ld)\n",
> +			PTR_ERR(gpio));
> +		return PTR_ERR(gpio);
> +	}
> +
> +	nand->cdgpio = gpio;
> +
> +	if (pdata) {
> +		if (pdata->bus_width_16)
> +			nand->base.options |= NAND_BUSWIDTH_16;
> +
> +		/*
> +		 * The only supported mode when pdata is involved is software
> +		 * hamming ECC. Fallback to no ECC at all in other case.
> +		 */
> +		if (pdata->ecc_mode == NAND_ECC_SOFT) {
> +			nand->base.ecc.mode = NAND_ECC_SOFT;
> +			nand->base.ecc.algo = NAND_ECC_HAMMING;
> +		}
> +
> +		if (pdata->on_flash_bbt)
> +			nand->base.bbt_options |= NAND_BBT_USE_FLASH;
> +	}
> +
> +	nand_set_flash_node(&nand->base, nfc->dev->of_node);
> +
> +	return atmel_nfc_add_nand(nfc, nand);
> +}
> +
> +static int atmel_nfc_add_nands(struct atmel_nfc *nfc)
> +{
> +	/* We do not retrieve the SMC syscon when parsing old DTs or pdata. */
> +	if (nfc->caps->legacy_of_bindings || !nfc->dev->of_node)
> +		return atmel_nfc_legacy_add_nands(nfc);
> +
> +	return atmel_nfc_of_add_nands(nfc);
> +}
> +
> +static void atmel_nfc_cleanup(struct atmel_nfc *nfc)
> +{
> +	if (nfc->dmac)
> +		dma_release_channel(nfc->dmac);
> +}
> +
> +static const struct of_device_id atmel_matrix_of_ids[] = {
> +	{
> +		.compatible = "atmel,at91sam9260-matrix",
> +		.data = (void *)AT91SAM9260_MATRIX_EBICSA,
> +	},
> +	{
> +		.compatible = "atmel,at91sam9261-matrix",
> +		.data = (void *)AT91SAM9261_MATRIX_EBICSA,
> +	},
> +	{
> +		.compatible = "atmel,at91sam9263-matrix",
> +		.data = (void *)AT91SAM9263_MATRIX_EBI0CSA,
> +	},
> +	{
> +		.compatible = "atmel,at91sam9rl-matrix",
> +		.data = (void *)AT91SAM9RL_MATRIX_EBICSA,
> +	},
> +	{
> +		.compatible = "atmel,at91sam9g45-matrix",
> +		.data = (void *)AT91SAM9G45_MATRIX_EBICSA,
> +	},
> +	{
> +		.compatible = "atmel,at91sam9n12-matrix",
> +		.data = (void *)AT91SAM9N12_MATRIX_EBICSA,
> +	},
> +	{
> +		.compatible = "atmel,at91sam9x5-matrix",
> +		.data = (void *)AT91SAM9X5_MATRIX_EBICSA,
> +	},
> +};
> +
> +static int atmel_nfc_init(struct atmel_nfc *nfc, struct platform_device *pdev,
> +			  const struct atmel_nfc_caps *caps)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct of_device_id *match;
> +	int ret;
> +
> +	nand_hw_control_init(&nfc->base);
> +	INIT_LIST_HEAD(&nfc->chips);
> +	nfc->dev = dev;
> +	nfc->caps = caps;
> +
> +	platform_set_drvdata(pdev, nfc);
> +
> +	nfc->pmecc = devm_atmel_pmecc_get(dev);
> +	if (IS_ERR(nfc->pmecc)) {
> +		ret = PTR_ERR(nfc->pmecc);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Could not get PMECC object (err = %d)\n",
> +				ret);
> +		return ret;
> +	}
> +
> +	if (nfc->caps->has_dma) {
> +		dma_cap_mask_t mask;
> +
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_MEMCPY, mask);
> +
> +		nfc->dmac = dma_request_channel(mask, NULL, NULL);
> +		if (!nfc->dmac)
> +			dev_err(nfc->dev, "Failed to request DMA channel\n");
> +	}
> +
> +	/* We do not retrieve the SMC syscon when parsing old DTs or pdata. */
> +	if (nfc->caps->legacy_of_bindings || !nfc->dev->of_node)
> +		return 0;
> +
> +	np = of_parse_phandle(dev->parent->of_node, "atmel,smc", 0);
> +	if (!np) {
> +		dev_err(dev, "Missing or invalid atmel,smc property\n");
> +		return -EINVAL;
> +	}
> +
> +	nfc->smc = syscon_node_to_regmap(np);
> +	of_node_put(np);
> +	if (IS_ERR(nfc->smc)) {
> +		ret = IS_ERR(nfc->smc);
> +		dev_err(dev, "Could not get SMC regmap (err = %d)\n", ret);
> +		return ret;
> +	}
> +
> +	np = of_parse_phandle(dev->parent->of_node, "atmel,matrix", 0);
> +	if (!np)
> +		return 0;
> +
> +	match = of_match_node(atmel_matrix_of_ids, np);
> +	if (!match) {
> +		of_node_put(np);
> +		return 0;
> +	}
> +
> +	nfc->matrix = syscon_node_to_regmap(np);
> +	of_node_put(np);
> +	if (IS_ERR(nfc->matrix)) {
> +		ret = IS_ERR(nfc->matrix);
> +		dev_err(dev, "Could not get SMC regmap (err = %d)\n", ret);
> +		return ret;
> +	}
> +
> +	nfc->ebi_csa_offs = (unsigned int)match->data;
> +
> +	/*
> +	 * The at91sam9263 has 2 EBIs, if the NAND controller is under EBI1
> +	 * add 4 to ->ebi_csa_offs.
> +	 */
> +	if (of_device_is_compatible(dev->parent->of_node,
> +				    "atmel,at91sam9263-ebi1"))
> +		nfc->ebi_csa_offs += 4;
> +
> +	return 0;
> +}
> +
> +static int atmel_sama5_nfc_legacy_init(struct atmel_sama5_nfc *nfc)
> +{
> +	struct regmap_config regmap_conf = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 4,
> +		.val_bits = 32,
> +	};
> +
> +	struct device *dev = nfc->base.dev;
> +	struct device_node *nand_np, *nfc_np;
> +	void __iomem *iomem;
> +	struct resource res;
> +	int ret;
> +
> +	nand_np = dev->of_node;
> +	nfc_np = of_find_compatible_node(dev->of_node, NULL,
> +					 "atmel,sama5d3-nfc");
> +
> +	nfc->clk = of_clk_get(nfc_np, 0);
> +	if (IS_ERR(nfc->clk)) {
> +		ret = PTR_ERR(nfc->clk);
> +		dev_err(dev, "Failed to retrieve HSMC clock (err = %d)\n",
> +			ret);
> +		goto out;
> +	}
> +
> +	ret = clk_prepare_enable(nfc->clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable the HSMC clock (err = %d)\n",
> +			ret);
> +		goto out;
> +	}
> +
> +	nfc->irq = of_irq_get(nand_np, 0);
> +	if (nfc->irq < 0) {
> +		ret = nfc->irq;
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get IRQ number (err = %d)\n",
> +				ret);
> +		goto out;
> +	}
> +
> +	ret = of_address_to_resource(nfc_np, 0, &res);
> +	if (ret) {
> +		dev_err(dev, "Invalid or missing NFC IO resource (err = %d)\n",
> +			ret);
> +		goto out;
> +	}
> +
> +	iomem = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(iomem)) {
> +		ret = PTR_ERR(iomem);
> +		goto out;
> +	}
> +
> +	regmap_conf.name = "nfc-io";
> +	regmap_conf.max_register = resource_size(&res) - 4;
> +	nfc->io = devm_regmap_init_mmio(dev, iomem, &regmap_conf);
> +	if (IS_ERR(nfc->io)) {
> +		ret = PTR_ERR(nfc->io);
> +		dev_err(dev, "Could not create NFC IO regmap (err = %d)\n",
> +			ret);
> +		goto out;
> +	}
> +
> +	ret = of_address_to_resource(nfc_np, 1, &res);
> +	if (ret) {
> +		dev_err(dev, "Invalid or missing HSMC resource (err = %d)\n",
> +			ret);
> +		goto out;
> +	}
> +
> +	iomem = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(iomem)) {
> +		ret = PTR_ERR(iomem);
> +		goto out;
> +	}
> +
> +	regmap_conf.name = "smc";
> +	regmap_conf.max_register = resource_size(&res) - 4;
> +	nfc->base.smc = devm_regmap_init_mmio(dev, iomem, &regmap_conf);
> +	if (IS_ERR(nfc->base.smc)) {
> +		ret = PTR_ERR(nfc->base.smc);
> +		dev_err(dev, "Could not create NFC IO regmap (err = %d)\n",
> +			ret);
> +		goto out;
> +	}
> +
> +	ret = of_address_to_resource(nfc_np, 2, &res);
> +	if (ret) {
> +		dev_err(dev, "Invalid or missing SRAM resource (err = %d)\n",
> +			ret);
> +		goto out;
> +	}
> +
> +	nfc->sram.virt = devm_ioremap_resource(dev, &res);
> +	if (IS_ERR(nfc->sram.virt)) {
> +		ret = PTR_ERR(nfc->sram.virt);
> +		goto out;
> +	}
> +
> +	nfc->sram.dma = res.start;
> +
> +out:
> +	of_node_put(nfc_np);
> +
> +	return ret;
> +}
> +
> +static int atmel_sama5_nfc_init(struct atmel_sama5_nfc *nfc)
> +{
> +	struct device *dev = nfc->base.dev;
> +	struct device_node *np;
> +	int ret;
> +
> +	np = of_parse_phandle(dev->parent->of_node, "atmel,smc", 0);
> +	if (!np) {
> +		dev_err(dev, "Missing or invalid atmel,smc property\n");
> +		return -EINVAL;
> +	}
> +
> +	nfc->irq = of_irq_get(np, 0);
> +	of_node_put(np);
> +	if (nfc->irq < 0) {
> +		if (nfc->irq != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get IRQ number (err = %d)\n",
> +				nfc->irq);
> +		return nfc->irq;
> +	}
> +
> +	np = of_parse_phandle(dev->of_node, "atmel,nfc-io", 0);
> +	if (!np) {
> +		dev_err(dev, "Missing or invalid atmel,nfc-io property\n");
> +		return -EINVAL;
> +	}
> +
> +	nfc->io = syscon_node_to_regmap(np);
> +	of_node_put(np);
> +	if (IS_ERR(nfc->io)) {
> +		ret = PTR_ERR(nfc->io);
> +		dev_err(dev, "Could not get NFC IO regmap (err = %d)\n", ret);
> +		return ret;
> +	}
> +
> +	nfc->sram.pool = of_gen_pool_get(nfc->base.dev->of_node,
> +					 "atmel,nfc-sram", 0);
> +	if (!nfc->sram.pool) {
> +		dev_err(nfc->base.dev, "Missing SRAM\n");
> +		return -ENOMEM;
> +	}
> +
> +	nfc->sram.virt = gen_pool_dma_alloc(nfc->sram.pool,
> +					    ATMEL_NFC_SRAM_SIZE,
> +					    &nfc->sram.dma);
> +	if (!nfc->sram.virt) {
> +		dev_err(nfc->base.dev,
> +			"Could not allocate memory from the NFC SRAM pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int atmel_sama5_nfc_remove(struct atmel_nfc *nfc)
> +{
> +	struct atmel_sama5_nfc *sama5_nfc;
> +	int ret;
> +
> +	ret = atmel_nfc_remove_nands(nfc);
> +	if (ret)
> +		return ret;
> +
> +	sama5_nfc = container_of(nfc, struct atmel_sama5_nfc, base);
> +	if (sama5_nfc->sram.pool)
> +		gen_pool_free(sama5_nfc->sram.pool,
> +			      (unsigned long)sama5_nfc->sram.virt,
> +			      ATMEL_NFC_SRAM_SIZE);
> +
> +	if (sama5_nfc->clk) {
> +		clk_disable_unprepare(sama5_nfc->clk);
> +		clk_put(sama5_nfc->clk);
> +	}
> +
> +	atmel_nfc_cleanup(nfc);
> +
> +	return 0;
> +}
> +
> +static int atmel_sama5_nfc_probe(struct platform_device *pdev,
> +				 const struct atmel_nfc_caps *caps)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct atmel_sama5_nfc *nfc;
> +	int ret;
> +
> +	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> +	if (!nfc)
> +		return -ENOMEM;
> +
> +	ret = atmel_nfc_init(&nfc->base, pdev, caps);
> +	if (ret)
> +		return ret;
> +
> +	if (caps->legacy_of_bindings)
> +		ret = atmel_sama5_nfc_legacy_init(nfc);
> +	else
> +		ret = atmel_sama5_nfc_init(nfc);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Make sure all irqs are masked before registering our IRQ handler. */
> +	regmap_write(nfc->base.smc, ATMEL_HSMC_NFC_IDR, 0xffffffff);
> +	ret = devm_request_irq(dev, nfc->irq, atmel_sama5_nfc_interrupt,
> +			       IRQF_SHARED, "nfc", nfc);
> +	if (ret) {
> +		dev_err(dev,
> +			"Could not get register NFC interrupt handler (err = %d)\n",
> +			ret);
> +		goto err;
> +	}
> +
> +	/* Initial NFC configuration. */
> +	regmap_write(nfc->base.smc, ATMEL_HSMC_NFC_CFG,
> +		     ATMEL_HSMC_NFC_CFG_DTO_MAX);
> +
> +	ret = atmel_nfc_add_nands(&nfc->base);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	atmel_sama5_nfc_remove(&nfc->base);
> +
> +	return ret;
> +}
> +
> +const struct atmel_nfc_ops atmel_sama5_nfc_ops = {
> +	.probe = atmel_sama5_nfc_probe,
> +	.remove = atmel_sama5_nfc_remove,
> +	.ecc_init = atmel_sama5_nfc_ecc_init,
> +	.nand_init = atmel_sama5_nfc_nand_init,
> +};
> +
> +static const struct atmel_nfc_caps atmel_sama5_nfc_caps = {
> +	.has_dma = true,
> +	.ale_offs = 1 << 21,
> +	.cle_offs = 1 << 22,
> +	.ops = &atmel_sama5_nfc_ops,
> +};
> +
> +/* Only used to parse old bindings. */
> +static const struct atmel_nfc_caps atmel_sama5_nand_caps = {
> +	.has_dma = true,
> +	.ale_offs = 1 << 21,
> +	.cle_offs = 1 << 22,
> +	.ops = &atmel_sama5_nfc_ops,
> +	.legacy_of_bindings = true,
> +};
> +
> +static int atmel_rm9200_nfc_probe(struct platform_device *pdev,
> +				  const struct atmel_nfc_caps *caps)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct atmel_nfc *nfc;
> +	int ret;
> +
> +	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> +	if (!nfc)
> +		return -ENOMEM;
> +
> +	ret = atmel_nfc_init(nfc, pdev, caps);
> +	if (ret)
> +		return ret;
> +
> +	return atmel_nfc_add_nands(nfc);
> +}
> +
> +static int atmel_rm9200_nfc_remove(struct atmel_nfc *nfc)
> +{
> +	int ret;
> +
> +	ret = atmel_nfc_remove_nands(nfc);
> +	if (ret)
> +		return ret;
> +
> +	atmel_nfc_cleanup(nfc);
> +
> +	return 0;
> +}
> +
> +const struct atmel_nfc_ops atmel_rm9200_nfc_ops = {
> +	.probe = atmel_rm9200_nfc_probe,
> +	.remove = atmel_rm9200_nfc_remove,
> +	.ecc_init = atmel_nfc_ecc_init,
> +	.nand_init = atmel_nfc_nand_init,
> +};
> +
> +static const struct atmel_nfc_caps atmel_rm9200_nfc_caps = {
> +	.ale_offs = 1 << 21,
> +	.cle_offs = 1 << 22,
> +	.ops = &atmel_rm9200_nfc_ops,
> +};
> +
> +static const struct atmel_nfc_caps atmel_sam9261_nfc_caps = {
> +	.ale_offs = 1 << 22,
> +	.cle_offs = 1 << 21,
> +	.ops = &atmel_rm9200_nfc_ops,
> +};
> +
> +static const struct atmel_nfc_caps atmel_sam9g45_nfc_caps = {
> +	.has_dma = true,
> +	.ale_offs = 1 << 21,
> +	.cle_offs = 1 << 22,
> +	.ops = &atmel_rm9200_nfc_ops,
> +};
> +
> +/* Only used to parse old bindings. */
> +static const struct atmel_nfc_caps atmel_rm9200_nand_caps = {
> +	.ale_offs = 1 << 21,
> +	.cle_offs = 1 << 22,
> +	.ops = &atmel_rm9200_nfc_ops,
> +	.legacy_of_bindings = true,
> +};
> +
> +static const struct atmel_nfc_caps atmel_sam9261_nand_caps = {
> +	.ale_offs = 1 << 22,
> +	.cle_offs = 1 << 21,
> +	.ops = &atmel_rm9200_nfc_ops,
> +	.legacy_of_bindings = true,
> +};
> +
> +static const struct atmel_nfc_caps atmel_sam9g45_nand_caps = {
> +	.has_dma = true,
> +	.ale_offs = 1 << 21,
> +	.cle_offs = 1 << 22,
> +	.ops = &atmel_rm9200_nfc_ops,
> +	.legacy_of_bindings = true,
> +};
> +
> +static const struct of_device_id atmel_nfc_of_ids[] = {
> +	{
> +		.compatible = "atmel,at91rm9200-nand-controller",
> +		.data = &atmel_rm9200_nfc_caps,
> +	},
> +	{
> +		.compatible = "atmel,at91sam9261-nand-controller",
> +		.data = &atmel_sam9261_nfc_caps,
> +	},
> +	{
> +		.compatible = "atmel,at91sam9g45-nand-controller",
> +		.data = &atmel_sam9g45_nfc_caps,
> +	},
> +	{
> +		.compatible = "atmel,sama5d3-nand-controller",
> +		.data = &atmel_sama5_nfc_caps,
> +	},
> +	/* Support for old/deprecated bindings: */
> +	{
> +		.compatible = "atmel,at91rm9200-nand",
> +		.data = &atmel_rm9200_nand_caps,
> +	},
> +	{
> +		.compatible = "atmel,sama5d4-nand",
> +		.data = &atmel_rm9200_nand_caps,
> +	},
> +	{
> +		.compatible = "atmel,sama5d2-nand",
> +		.data = &atmel_rm9200_nand_caps,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, atmel_nfc_id_table);
> +
> +static const struct platform_device_id atmel_nfc_platform_ids[] = {
> +	{
> +		.name = "atmel_nand",
> +		.driver_data = (kernel_ulong_t)&atmel_rm9200_nfc_caps,
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, atmel_nfc_platform_ids);
> +
> +static int atmel_nfc_probe(struct platform_device *pdev)
> +{
> +	const struct atmel_nfc_caps *caps;
> +
> +	if (pdev->id_entry)
> +		caps = (void *)pdev->id_entry->driver_data;
> +	else
> +		caps = of_device_get_match_data(&pdev->dev);
> +
> +	if (!caps) {
> +		dev_err(&pdev->dev, "Could not retrieve NFC caps\n");
> +		return -EINVAL;
> +	}
> +
> +	if (caps->legacy_of_bindings && pdev->dev.of_node) {
> +		u32 ale_offs = 21;
> +
> +		/*
> +		 * If we are parsing legacy DT props and the DT contains a
> +		 * valid NFC node, forward the request to the sama5 logic.
> +		 */
> +		if (of_find_compatible_node(pdev->dev.of_node, NULL,
> +					    "atmel,sama5d3-nfc"))
> +			caps = &atmel_sama5_nand_caps;
> +
> +		/*
> +		 * Even if the compatible says we are dealing with an
> +		 * at91rm9200 controller, the atmel,nand-has-dma specify that
> +		 * this controller supports DMA, which means we are in fact
> +		 * dealing with an at91sam9g45+ controller.
> +		 */
> +		if (!caps->has_dma &&
> +		    of_property_read_bool(pdev->dev.of_node,
> +					  "atmel,nand-has-dma"))
> +			caps = &atmel_sam9g45_nand_caps;
> +
> +		/*
> +		 * All SoCs except the at91sam9261 are assigning ALE to A21 and
> +		 * CLE to A22. If atmel,nand-addr-offset != 21 this means we're
> +		 * actually dealing with an at91sam9261 controller.
> +		 */
> +		of_property_read_u32(pdev->dev.of_node,
> +				     "atmel,nand-addr-offset", &ale_offs);
> +		if (ale_offs != 21)
> +			caps = &atmel_sam9261_nand_caps;
> +	}
> +
> +	return caps->ops->probe(pdev, caps);
> +}
> +
> +static int atmel_nfc_remove(struct platform_device *pdev)
> +{
> +	struct atmel_nfc *nfc = platform_get_drvdata(pdev);
> +
> +	return nfc->caps->ops->remove(nfc);
> +}
> +
> +static struct platform_driver atmel_nfc_driver = {
> +	.driver = {
> +		.name = "atmel-nand-controller",
> +		.of_match_table = of_match_ptr(atmel_nfc_of_ids),
> +	},
> +	.probe = atmel_nfc_probe,
> +	.remove = atmel_nfc_remove,
> +	.id_table = atmel_nfc_platform_ids
> +};
> +module_platform_driver(atmel_nfc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
> +MODULE_DESCRIPTION("NAND Flash Controller driver for Atmel SoCs");
> +MODULE_ALIAS("platform:atmel-nand-controller");
> diff --git a/drivers/mtd/nand/atmel/pmecc.c b/drivers/mtd/nand/atmel/pmecc.c
> new file mode 100644
> index 000000000000..9baccae5d5a5
> --- /dev/null
> +++ b/drivers/mtd/nand/atmel/pmecc.c
> @@ -0,0 +1,1011 @@
> +/*
> + * ? Copyright 2016 ATMEL
> + * ? Copyright 2016 Free Electrons

Ditto about (c)

> + *
> + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> + *
> + * Derived from the atmel_nand.c driver which contained the following
> + * copyrights:
> + *
> + *    Copyright ? 2003 Rick Bronson
> + *
> + *    Derived from drivers/mtd/nand/autcpu12.c
> + *        Copyright ? 2001 Thomas Gleixner (gleixner at autronix.de)
> + *
> + *    Derived from drivers/mtd/spia.c
> + *        Copyright ? 2000 Steven J. Hill (sjhill at cotw.com)
> + *
> + *
> + *    Add Hardware ECC support for AT91SAM9260 / AT91SAM9263
> + *        Richard Genoud (richard.genoud at gmail.com), Adeneo Copyright ? 2007
> + *
> + *        Derived from Das U-Boot source code
> + *              (u-boot-1.1.5/board/atmel/at91sam9263ek/nand.c)
> + *        ? Copyright 2006 ATMEL Rousset, Lacressonniere Nicolas
> + *
> + *    Add Programmable Multibit ECC support for various AT91 SoC
> + *        ? Copyright 2012 ATMEL, Hong Xu
> + *
> + *    Add Nand Flash Controller support for SAMA5 SoC
> + *        ? Copyright 2013 ATMEL, Josh Wu (josh.wu at atmel.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/genalloc.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "pmecc.h"
> +
> +/* Galois field dimension */
> +#define PMECC_GF_DIMENSION_13			13
> +#define PMECC_GF_DIMENSION_14			14
> +
> +/* Primitive Polynomial used by PMECC */
> +#define PMECC_GF_13_PRIMITIVE_POLY		0x201b
> +#define PMECC_GF_14_PRIMITIVE_POLY		0x4443
> +
> +#define PMECC_LOOKUP_TABLE_SIZE_512		0x2000
> +#define PMECC_LOOKUP_TABLE_SIZE_1024		0x4000
> +
> +/* Time out value for reading PMECC status register */
> +#define PMECC_MAX_TIMEOUT_MS			100
> +
> +/* PMECC Register Definitions */
> +#define ATMEL_PMECC_CFG				0x0
> +#define PMECC_CFG_BCH_STRENGTH(x)		(x)
> +#define PMECC_CFG_BCH_STRENGTH_MASK		GENMASK(2, 0)
> +#define PMECC_CFG_SECTOR512			(0 << 4)
> +#define PMECC_CFG_SECTOR1024			(1 << 4)
> +#define PMECC_CFG_NSECTORS(x)			((fls(x) - 1) << 8)
> +#define PMECC_CFG_READ_OP			(0 << 12)
> +#define PMECC_CFG_WRITE_OP			(1 << 12)
> +#define PMECC_CFG_SPARE_ENABLE			BIT(16)
> +#define PMECC_CFG_AUTO_ENABLE			BIT(20)
> +
> +#define ATMEL_PMECC_SAREA			0x4
> +#define ATMEL_PMECC_SADDR			0x8
> +#define ATMEL_PMECC_EADDR			0xc
> +
> +#define ATMEL_PMECC_CLK				0x10
> +#define PMECC_CLK_133MHZ			(2 << 0)
> +
> +#define ATMEL_PMECC_CTRL			0x14
> +#define PMECC_CTRL_RST				BIT(0)
> +#define PMECC_CTRL_DATA				BIT(1)
> +#define PMECC_CTRL_USER				BIT(2)
> +#define PMECC_CTRL_ENABLE			BIT(4)
> +#define PMECC_CTRL_DISABLE			BIT(5)
> +
> +#define ATMEL_PMECC_SR				0x18
> +#define PMECC_SR_BUSY				BIT(0)
> +#define PMECC_SR_ENABLE				BIT(4)
> +
> +#define ATMEL_PMECC_IER				0x1c
> +#define ATMEL_PMECC_IDR				0x20
> +#define ATMEL_PMECC_IMR				0x24
> +#define ATMEL_PMECC_ISR				0x28
> +#define PMECC_ERROR_INT				BIT(0)
> +
> +#define ATMEL_PMECC_ECC(sector, n)		\
> +	((((sector) + 1) * 0x40) + (n))
> +
> +#define ATMEL_PMECC_REM(sector, n)		\
> +	((((sector) + 1) * 0x40) + ((n) * 4) + 0x200)
> +
> +/* PMERRLOC Register Definitions */
> +#define ATMEL_PMERRLOC_ELCFG			0x0
> +#define PMERRLOC_ELCFG_SECTOR_512		(0 << 0)
> +#define PMERRLOC_ELCFG_SECTOR_1024		(1 << 0)
> +#define PMERRLOC_ELCFG_NUM_ERRORS(n)		((n) << 16)
> +
> +#define ATMEL_PMERRLOC_ELPRIM			0x4
> +#define ATMEL_PMERRLOC_ELEN			0x8
> +#define ATMEL_PMERRLOC_ELDIS			0xc
> +#define PMERRLOC_DISABLE			BIT(0)
> +
> +#define ATMEL_PMERRLOC_ELSR			0x10
> +#define PMERRLOC_ELSR_BUSY			BIT(0)
> +
> +#define ATMEL_PMERRLOC_ELIER			0x14
> +#define ATMEL_PMERRLOC_ELIDR			0x18
> +#define ATMEL_PMERRLOC_ELIMR			0x1c
> +#define ATMEL_PMERRLOC_ELISR			0x20
> +#define PMERRLOC_ERR_NUM_MASK			GENMASK(12, 8)
> +#define PMERRLOC_CALC_DONE			BIT(0)
> +
> +#define ATMEL_PMERRLOC_SIGMA(x)			(((x) * 0x4) + 0x28)
> +
> +#define ATMEL_PMERRLOC_EL(offs, x)		(((x) * 0x4) + (offs))
> +
> +struct atmel_pmecc_gf_tables {
> +	u16 *alpha_to;
> +	u16 *index_of;
> +};
> +
> +struct atmel_pmecc_caps {
> +	const int *strengths;
> +	int nstrengths;
> +	int el_offset;
> +	bool correct_erased_chunks;
> +};
> +
> +struct atmel_pmecc {
> +	struct device *dev;
> +	const struct atmel_pmecc_caps *caps;
> +
> +	struct {
> +		void __iomem *base;
> +		void __iomem *errloc;
> +	} regs;
> +
> +	struct mutex lock;
> +};
> +
> +struct atmel_pmecc_user_conf_cache {
> +	u32 cfg;
> +	u32 sarea;
> +	u32 saddr;
> +	u32 eaddr;
> +};
> +
> +struct atmel_pmecc_user {
> +	struct atmel_pmecc_user_conf_cache cache;
> +	struct atmel_pmecc *pmecc;
> +	const struct atmel_pmecc_gf_tables *gf_tables;
> +	int eccbytes;
> +	s16 *partial_syn;
> +	s16 *si;
> +	s16 *lmu;
> +	s16 *smu;
> +	s32 *mu;
> +	s32 *dmu;
> +	s32 *delta;
> +	u32 isr;
> +};
> +
> +static DEFINE_MUTEX(pmecc_gf_tables_lock);
> +static const struct atmel_pmecc_gf_tables *pmecc_gf_tables_512;
> +static const struct atmel_pmecc_gf_tables *pmecc_gf_tables_1024;
> +
> +static inline int deg(unsigned int poly)
> +{
> +	/* polynomial degree is the most-significant bit index */
> +	return fls(poly) - 1;
> +}
> +
> +static int atmel_pmecc_build_gf_tables(int mm, unsigned int poly,
> +				       struct atmel_pmecc_gf_tables *gf_tables)
> +{
> +	unsigned int i, x = 1;
> +	const unsigned int k = 1 << deg(poly);
> +	unsigned int nn = (1 << mm) - 1;
> +
> +	/* primitive polynomial must be of degree m */
> +	if (k != (1u << mm))
> +		return -EINVAL;
> +
> +	for (i = 0; i < nn; i++) {
> +		gf_tables->alpha_to[i] = x;
> +		gf_tables->index_of[x] = i;
> +		if (i && (x == 1))
> +			/* polynomial is not primitive (a^i=1 with 0<i<2^m-1) */
> +			return -EINVAL;
> +		x <<= 1;
> +		if (x & k)
> +			x ^= poly;
> +	}
> +	gf_tables->alpha_to[nn] = 1;
> +	gf_tables->index_of[0] = 0;
> +
> +	return 0;
> +}
> +
> +static const struct atmel_pmecc_gf_tables *
> +atmel_pmecc_create_gf_tables(const struct atmel_pmecc_user_req *req)
> +{
> +	struct atmel_pmecc_gf_tables *gf_tables;
> +	unsigned int poly, degree, table_size;
> +	int ret;
> +
> +	if (req->ecc.sectorsize == 512) {
> +		degree = PMECC_GF_DIMENSION_13;
> +		poly = PMECC_GF_13_PRIMITIVE_POLY;
> +		table_size = PMECC_LOOKUP_TABLE_SIZE_512;
> +	} else {
> +		degree = PMECC_GF_DIMENSION_14;
> +		poly = PMECC_GF_14_PRIMITIVE_POLY;
> +		table_size = PMECC_LOOKUP_TABLE_SIZE_1024;
> +	}
> +
> +	gf_tables = kzalloc(sizeof(*gf_tables) +
> +			    (2 * table_size * sizeof(u16)),
> +			    GFP_KERNEL);
> +	if (!gf_tables)
> +		return ERR_PTR(-ENOMEM);
> +
> +	gf_tables->alpha_to = (void *)(gf_tables + 1);
> +	gf_tables->index_of = gf_tables->alpha_to + table_size;
> +
> +	ret = atmel_pmecc_build_gf_tables(degree, poly, gf_tables);
> +	if (ret) {
> +		kfree(gf_tables);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return gf_tables;
> +}
> +
> +static const struct atmel_pmecc_gf_tables *
> +atmel_pmecc_get_gf_tables(const struct atmel_pmecc_user_req *req)
> +{
> +	const struct atmel_pmecc_gf_tables **gf_tables, *ret;
> +
> +	mutex_lock(&pmecc_gf_tables_lock);
> +	if (req->ecc.sectorsize == 512)
> +		gf_tables = &pmecc_gf_tables_512;
> +	else
> +		gf_tables = &pmecc_gf_tables_1024;
> +
> +	ret = *gf_tables;
> +
> +	if (!ret) {
> +		ret = atmel_pmecc_create_gf_tables(req);
> +		if (!IS_ERR(ret))
> +			*gf_tables = ret;
> +	}
> +	mutex_unlock(&pmecc_gf_tables_lock);
> +
> +	return ret;
> +}
> +
> +static int atmel_pmecc_prepare_user_req(struct atmel_pmecc *pmecc,
> +					struct atmel_pmecc_user_req *req)
> +{
> +	int i, max_eccbytes, eccbytes = 0, eccstrength = 0;
> +
> +	if (req->pagesize <= 0 || req->oobsize <= 0 || req->ecc.bytes <= 0)
> +		return -EINVAL;
> +
> +	if (req->ecc.ooboffset >= 0 &&
> +	    req->ecc.ooboffset + req->ecc.bytes > req->oobsize)
> +		return -EINVAL;
> +
> +	if (req->ecc.sectorsize == ATMEL_PMECC_SECTOR_SIZE_AUTO) {
> +		if (req->ecc.strength != ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH)
> +			return -EINVAL;
> +
> +		if (req->pagesize > 512)
> +			req->ecc.sectorsize = 1024;
> +		else
> +			req->ecc.sectorsize = 512;
> +	}
> +
> +	if (req->ecc.sectorsize != 512 && req->ecc.sectorsize != 1024)
> +		return -EINVAL;
> +
> +	if (req->pagesize % req->ecc.sectorsize)
> +		return -EINVAL;
> +
> +	req->ecc.nsectors = req->pagesize / req->ecc.sectorsize;
> +
> +	max_eccbytes = req->ecc.bytes;
> +
> +	for (i = 0; i < pmecc->caps->nstrengths; i++) {
> +		int nbytes, strength = pmecc->caps->strengths[i];
> +
> +		if (req->ecc.strength != ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH &&
> +		    strength < req->ecc.strength)
> +			continue;
> +
> +		nbytes = DIV_ROUND_UP(strength * fls(8 * req->ecc.sectorsize),
> +				      8);
> +		nbytes *= req->ecc.nsectors;
> +
> +		if (nbytes > max_eccbytes)
> +			break;
> +
> +		eccstrength = strength;
> +		eccbytes = nbytes;
> +
> +		if (req->ecc.strength != ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH)
> +			break;
> +	}
> +
> +	if (!eccstrength)
> +		return -EINVAL;
> +
> +	req->ecc.bytes = eccbytes;
> +	req->ecc.strength = eccstrength;
> +
> +	if (req->ecc.ooboffset < 0)
> +		req->ecc.ooboffset = req->oobsize - eccbytes;
> +
> +	return 0;
> +}
> +
> +struct atmel_pmecc_user *
> +atmel_pmecc_create_user(struct atmel_pmecc *pmecc,
> +			struct atmel_pmecc_user_req *req)
> +{
> +	struct atmel_pmecc_user *user;
> +	const struct atmel_pmecc_gf_tables *gf_tables;
> +	int strength, size, ret;
> +
> +	ret = atmel_pmecc_prepare_user_req(pmecc, req);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	size = sizeof(*user);
> +	size = ALIGN(size, sizeof(u16));
> +	/* Reserve space for partial_syn, si and smu */
> +	size += ((2 * req->ecc.strength) + 1) * sizeof(u16) *
> +		(2 + req->ecc.strength + 2);
> +	/* Reserve space for lmu. */
> +	size += (req->ecc.strength + 1) * sizeof(u16);
> +	/* Reserve space for mu, dmu and delta. */
> +	size = ALIGN(size, sizeof(s32));
> +	size += (req->ecc.strength + 1) * sizeof(s32);
> +
> +	user = kzalloc(size, GFP_KERNEL);
> +	if (!user)
> +		return ERR_PTR(-ENOMEM);
> +
> +	user->pmecc = pmecc;
> +
> +	user->partial_syn = (u16 *)PTR_ALIGN(user + 1, sizeof(u16));
> +	user->si = user->partial_syn + ((2 * req->ecc.strength) + 1);
> +	user->lmu = user->si + ((2 * req->ecc.strength) + 1);
> +	user->smu = user->lmu + (req->ecc.strength + 1);
> +	user->mu = (s32 *)PTR_ALIGN(user->smu +
> +				    (((2 * req->ecc.strength) + 1) *
> +				     (req->ecc.strength + 2)),
> +				    sizeof(s32));
> +	user->dmu = user->mu + req->ecc.strength + 1;
> +	user->delta = user->dmu + req->ecc.strength + 1;
> +
> +	gf_tables = atmel_pmecc_get_gf_tables(req);
> +	if (IS_ERR(gf_tables)) {
> +		kfree(user);
> +		return ERR_CAST(gf_tables);
> +	}
> +
> +	user->gf_tables = gf_tables;
> +
> +	user->eccbytes = req->ecc.bytes / req->ecc.nsectors;
> +
> +	for (strength = 0; strength < pmecc->caps->nstrengths; strength++) {
> +		if (pmecc->caps->strengths[strength] == req->ecc.strength)
> +			break;
> +	}
> +
> +	user->cache.cfg = PMECC_CFG_BCH_STRENGTH(strength) |
> +			  PMECC_CFG_NSECTORS(req->ecc.nsectors);
> +
> +	if (req->ecc.sectorsize == 1024)
> +		user->cache.cfg |= PMECC_CFG_SECTOR1024;
> +
> +	user->cache.sarea = req->oobsize - 1;
> +	user->cache.saddr = req->ecc.ooboffset;
> +	user->cache.eaddr = req->ecc.ooboffset + req->ecc.bytes - 1;
> +
> +	return user;
> +}
> +EXPORT_SYMBOL_GPL(atmel_pmecc_create_user);
> +
> +void atmel_pmecc_destroy_user(struct atmel_pmecc_user *user)
> +{
> +	kfree(user);
> +}
> +EXPORT_SYMBOL_GPL(atmel_pmecc_destroy_user);
> +
> +static int get_strength(struct atmel_pmecc_user *user)
> +{
> +	const int *strengths = user->pmecc->caps->strengths;
> +
> +	return strengths[user->cache.cfg & PMECC_CFG_BCH_STRENGTH_MASK];
> +}
> +
> +static int get_sectorsize(struct atmel_pmecc_user *user)
> +{
> +	return user->cache.cfg & PMECC_LOOKUP_TABLE_SIZE_1024 ? 1024 : 512;
> +}
> +
> +static void atmel_pmecc_gen_syndrome(struct atmel_pmecc_user *user, int sector)
> +{
> +	int strength = get_strength(user);
> +	u32 value;
> +	int i;
> +
> +	/* Fill odd syndromes */
> +	for (i = 0; i < strength; i++) {
> +		value = readl_relaxed(user->pmecc->regs.base +
> +				      ATMEL_PMECC_REM(sector, i / 2));
> +		if (i & 1)
> +			value >>= 16;
> +
> +		user->partial_syn[(2 * i) + 1] = value;
> +	}
> +}

What about saying somewhere in this file (header?) that all this
computation is described in the product datasheet and that a hardware
software bit correction is put in place following the recomandation of
the datasheet?


> +static void atmel_pmecc_substitute(struct atmel_pmecc_user *user)
> +{
> +	int degree = get_sectorsize(user) == 512 ? 13 : 14;
> +	int cw_len = (1 << degree) - 1;
> +	int strength = get_strength(user);
> +	s16 *alpha_to = user->gf_tables->alpha_to;
> +	s16 *index_of = user->gf_tables->index_of;
> +	s16 *partial_syn = user->partial_syn;
> +	s16 *si;
> +	int i, j;
> +
> +	/*
> +	 * si[] is a table that holds the current syndrome value,
> +	 * an element of that table belongs to the field
> +	 */
> +	si = user->si;
> +
> +	memset(&si[1], 0, sizeof(s16) * ((2 * strength) - 1));
> +
> +	/* Computation 2t syndromes based on S(x) */
> +	/* Odd syndromes */
> +	for (i = 1; i < 2 * strength; i += 2) {
> +		for (j = 0; j < degree; j++) {
> +			if (partial_syn[i] & ((unsigned short)0x1 << j))
> +				si[i] = alpha_to[i * j] ^ si[i];
> +		}
> +	}
> +	/* Even syndrome = (Odd syndrome) ** 2 */
> +	for (i = 2, j = 1; j <= strength; i = ++j << 1) {
> +		if (si[j] == 0) {
> +			si[i] = 0;
> +		} else {
> +			s16 tmp;
> +
> +			tmp = index_of[si[j]];
> +			tmp = (tmp * 2) % cw_len;
> +			si[i] = alpha_to[tmp];
> +		}
> +	}
> +}
> +
> +static void atmel_pmecc_get_sigma(struct atmel_pmecc_user *user)
> +{
> +	s16 *lmu = user->lmu;
> +	s16 *si = user->si;
> +	s32 *mu = user->mu;
> +	s32 *dmu = user->dmu;
> +	s32 *delta = user->delta;
> +	int degree = get_sectorsize(user) == 512 ? 13 : 14;
> +	int cw_len = (1 << degree) - 1;
> +	int strength = get_strength(user);
> +	int num = 2 * strength + 1;
> +	s16 *index_of = user->gf_tables->index_of;
> +	s16 *alpha_to = user->gf_tables->alpha_to;
> +	int i, j, k;
> +	u32 dmu_0_count, tmp;
> +	s16 *smu = user->smu;
> +
> +	/* index of largest delta */
> +	int ro;
> +	int largest;
> +	int diff;
> +
> +	dmu_0_count = 0;
> +
> +	/* First Row */
> +
> +	/* Mu */
> +	mu[0] = -1;
> +
> +	memset(smu, 0, sizeof(s16) * num);
> +	smu[0] = 1;
> +
> +	/* discrepancy set to 1 */
> +	dmu[0] = 1;
> +	/* polynom order set to 0 */
> +	lmu[0] = 0;
> +	delta[0] = (mu[0] * 2 - lmu[0]) >> 1;
> +
> +	/* Second Row */
> +
> +	/* Mu */
> +	mu[1] = 0;
> +	/* Sigma(x) set to 1 */
> +	memset(&smu[num], 0, sizeof(s16) * num);
> +	smu[num] = 1;
> +
> +	/* discrepancy set to S1 */
> +	dmu[1] = si[1];
> +
> +	/* polynom order set to 0 */
> +	lmu[1] = 0;
> +
> +	delta[1] = (mu[1] * 2 - lmu[1]) >> 1;
> +
> +	/* Init the Sigma(x) last row */
> +	memset(&smu[(strength + 1) * num], 0, sizeof(s16) * num);
> +
> +	for (i = 1; i <= strength; i++) {
> +		mu[i + 1] = i << 1;
> +		/* Begin Computing Sigma (Mu+1) and L(mu) */
> +		/* check if discrepancy is set to 0 */
> +		if (dmu[i] == 0) {
> +			dmu_0_count++;
> +
> +			tmp = ((strength - (lmu[i] >> 1) - 1) / 2);
> +			if ((strength - (lmu[i] >> 1) - 1) & 0x1)
> +				tmp += 2;
> +			else
> +				tmp += 1;
> +
> +			if (dmu_0_count == tmp) {
> +				for (j = 0; j <= (lmu[i] >> 1) + 1; j++)
> +					smu[(strength + 1) * num + j] =
> +							smu[i * num + j];
> +
> +				lmu[strength + 1] = lmu[i];
> +				return;
> +			}
> +
> +			/* copy polynom */
> +			for (j = 0; j <= lmu[i] >> 1; j++)
> +				smu[(i + 1) * num + j] = smu[i * num + j];
> +
> +			/* copy previous polynom order to the next */
> +			lmu[i + 1] = lmu[i];
> +		} else {
> +			ro = 0;
> +			largest = -1;
> +			/* find largest delta with dmu != 0 */
> +			for (j = 0; j < i; j++) {
> +				if ((dmu[j]) && (delta[j] > largest)) {
> +					largest = delta[j];
> +					ro = j;
> +				}
> +			}
> +
> +			/* compute difference */
> +			diff = (mu[i] - mu[ro]);
> +
> +			/* Compute degree of the new smu polynomial */
> +			if ((lmu[i] >> 1) > ((lmu[ro] >> 1) + diff))
> +				lmu[i + 1] = lmu[i];
> +			else
> +				lmu[i + 1] = ((lmu[ro] >> 1) + diff) * 2;
> +
> +			/* Init smu[i+1] with 0 */
> +			for (k = 0; k < num; k++)
> +				smu[(i + 1) * num + k] = 0;
> +
> +			/* Compute smu[i+1] */
> +			for (k = 0; k <= lmu[ro] >> 1; k++) {
> +				s16 a, b, c;
> +
> +				if (!(smu[ro * num + k] && dmu[i]))
> +					continue;
> +
> +				a = index_of[dmu[i]];
> +				b = index_of[dmu[ro]];
> +				c = index_of[smu[ro * num + k]];
> +				tmp = a + (cw_len - b) + c;
> +				a = alpha_to[tmp % cw_len];
> +				smu[(i + 1) * num + (k + diff)] = a;
> +			}
> +
> +			for (k = 0; k <= lmu[i] >> 1; k++)
> +				smu[(i + 1) * num + k] ^= smu[i * num + k];
> +		}
> +
> +		/* End Computing Sigma (Mu+1) and L(mu) */
> +		/* In either case compute delta */
> +		delta[i + 1] = (mu[i + 1] * 2 - lmu[i + 1]) >> 1;
> +
> +		/* Do not compute discrepancy for the last iteration */
> +		if (i >= strength)
> +			continue;
> +
> +		for (k = 0; k <= (lmu[i + 1] >> 1); k++) {
> +			tmp = 2 * (i - 1);
> +			if (k == 0) {
> +				dmu[i + 1] = si[tmp + 3];
> +			} else if (smu[(i + 1) * num + k] && si[tmp + 3 - k]) {
> +				s16 a, b, c;
> +
> +				a = index_of[smu[(i + 1) * num + k]];
> +				b = si[2 * (i - 1) + 3 - k];
> +				c = index_of[b];
> +				tmp = a + c;
> +				tmp %= cw_len;
> +				dmu[i + 1] = alpha_to[tmp] ^ dmu[i + 1];
> +			}
> +		}
> +	}
> +}
> +
> +static int atmel_pmecc_err_location(struct atmel_pmecc_user *user)
> +{
> +	int sector_size = get_sectorsize(user);
> +	int degree = sector_size == 512 ? 13 : 14;
> +	struct atmel_pmecc *pmecc = user->pmecc;
> +	int strength = get_strength(user);
> +	int ret, roots_nbr, i, err_nbr = 0;
> +	int num = (2 * strength) + 1;
> +	s16 *smu = user->smu;
> +	u32 val;
> +
> +	writel(PMERRLOC_DISABLE, pmecc->regs.errloc + ATMEL_PMERRLOC_ELDIS);
> +
> +	for (i = 0; i <= user->lmu[strength + 1] >> 1; i++) {
> +		writel_relaxed(smu[(strength + 1) * num + i],
> +			       pmecc->regs.errloc + ATMEL_PMERRLOC_SIGMA(i));
> +		err_nbr++;
> +	}
> +
> +	val = (err_nbr - 1) << 16;
> +	if (sector_size == 1024)
> +		val |= 1;
> +
> +	writel(val, pmecc->regs.errloc + ATMEL_PMERRLOC_ELCFG);
> +	writel((sector_size * 8) + (degree * strength),
> +	       pmecc->regs.errloc + ATMEL_PMERRLOC_ELEN);
> +
> +	ret = readl_relaxed_poll_timeout(pmecc->regs.errloc +
> +					 ATMEL_PMERRLOC_ELISR,
> +					 val, val & PMERRLOC_CALC_DONE, 0,
> +					 PMECC_MAX_TIMEOUT_MS * 1000);
> +	if (ret) {
> +		dev_err(pmecc->dev,
> +			"PMECC: Timeout to calculate error location.\n");
> +		return ret;
> +	}
> +
> +	roots_nbr = (val & PMERRLOC_ERR_NUM_MASK) >> 8;
> +	/* Number of roots == degree of smu hence <= cap */
> +	if (roots_nbr == user->lmu[strength + 1] >> 1)
> +		return err_nbr - 1;
> +
> +	/*
> +	 * Number of roots does not match the degree of smu
> +	 * unable to correct error.
> +	 */
> +	return -EBADMSG;
> +}
> +
> +int atmel_pmecc_correct_sector(struct atmel_pmecc_user *user, int sector,
> +			       void *data, void *ecc)
> +{
> +	struct atmel_pmecc *pmecc = user->pmecc;
> +	int sectorsize = get_sectorsize(user);
> +	int eccbytes = user->eccbytes;
> +	int i, nerrors;
> +
> +	if (!(user->isr & BIT(sector)))
> +		return 0;
> +
> +	atmel_pmecc_gen_syndrome(user, sector);
> +	atmel_pmecc_substitute(user);
> +	atmel_pmecc_get_sigma(user);
> +
> +	nerrors = atmel_pmecc_err_location(user);
> +	if (nerrors < 0)
> +		return nerrors;
> +
> +	for (i = 0; i < nerrors; i++) {
> +		const char *area;
> +		int byte, bit;
> +		u32 errpos;
> +		u8 *ptr;
> +
> +		errpos = readl_relaxed(pmecc->regs.errloc +
> +				ATMEL_PMERRLOC_EL(pmecc->caps->el_offset, i));
> +		errpos--;
> +
> +		byte = errpos / 8;
> +		bit = errpos % 8;
> +
> +		if (byte < sectorsize) {
> +			ptr = data + byte;
> +			area = "data";
> +		} else if (byte < sectorsize + eccbytes) {
> +			ptr = ecc + byte - sectorsize;
> +			area = "ECC";
> +		} else {
> +			dev_dbg(pmecc->dev,
> +				"Invalid errpos value (%d, max is %d)\n",
> +				errpos, (sectorsize + eccbytes) * 8);
> +			return -EINVAL;
> +		}
> +
> +		dev_dbg(pmecc->dev,
> +			"Bit flip in %s area, byte %d: 0x%02x -> 0x%02x\n",
> +			area, byte, *ptr, (unsigned int)(*ptr ^ BIT(bit)));
> +
> +		*ptr ^= BIT(bit);
> +	}
> +
> +	return nerrors;
> +}
> +EXPORT_SYMBOL_GPL(atmel_pmecc_correct_sector);
> +
> +bool atmel_pmecc_correct_erased_chunks(struct atmel_pmecc_user *user)
> +{
> +	return user->pmecc->caps->correct_erased_chunks;
> +}
> +EXPORT_SYMBOL_GPL(atmel_pmecc_correct_erased_chunks);
> +
> +void atmel_pmecc_get_generated_eccbytes(struct atmel_pmecc_user *user,
> +					int sector, void *ecc)
> +{
> +	struct atmel_pmecc *pmecc = user->pmecc;
> +	u8 *ptr = ecc;
> +	int i;
> +
> +	for (i = 0; i < user->eccbytes; i++)
> +		ptr[i] = readb_relaxed(pmecc->regs.base +
> +				       ATMEL_PMECC_ECC(sector, i));
> +}
> +EXPORT_SYMBOL_GPL(atmel_pmecc_get_generated_eccbytes);
> +
> +int atmel_pmecc_enable(struct atmel_pmecc_user *user, int op)
> +{
> +	struct atmel_pmecc *pmecc = user->pmecc;
> +	u32 cfg;
> +
> +	if (op != NAND_ECC_READ && op != NAND_ECC_WRITE) {
> +		dev_err(pmecc->dev, "Bad ECC operation!");
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&user->pmecc->lock);
> +
> +	cfg = user->cache.cfg;
> +	if (op == NAND_ECC_WRITE)
> +		cfg |= PMECC_CFG_WRITE_OP;
> +	else
> +		cfg |= PMECC_CFG_AUTO_ENABLE;
> +
> +	writel(cfg, pmecc->regs.base + ATMEL_PMECC_CFG);
> +	writel(user->cache.sarea, pmecc->regs.base + ATMEL_PMECC_SAREA);
> +	writel(user->cache.saddr, pmecc->regs.base + ATMEL_PMECC_SADDR);
> +	writel(user->cache.eaddr, pmecc->regs.base + ATMEL_PMECC_EADDR);
> +
> +	writel(PMECC_CTRL_ENABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
> +	writel(PMECC_CTRL_DATA, pmecc->regs.base + ATMEL_PMECC_CTRL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(atmel_pmecc_enable);
> +
> +void atmel_pmecc_disable(struct atmel_pmecc_user *user)
> +{
> +	struct atmel_pmecc *pmecc = user->pmecc;
> +
> +	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
> +	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
> +	mutex_unlock(&user->pmecc->lock);
> +}
> +EXPORT_SYMBOL_GPL(atmel_pmecc_disable);
> +
> +int atmel_pmecc_wait_rdy(struct atmel_pmecc_user *user)
> +{
> +	struct atmel_pmecc *pmecc = user->pmecc;
> +	u32 status;
> +	int ret;
> +
> +	ret = readl_relaxed_poll_timeout(pmecc->regs.base +
> +					 ATMEL_PMECC_SR,
> +					 status, !(status & PMECC_SR_BUSY), 0,
> +					 PMECC_MAX_TIMEOUT_MS * 1000);
> +	if (ret) {
> +		dev_err(pmecc->dev,
> +			"Timeout while waiting for PMECC ready.\n");
> +		return ret;
> +	}
> +
> +	user->isr = readl_relaxed(pmecc->regs.base + ATMEL_PMECC_ISR);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(atmel_pmecc_wait_rdy);
> +
> +static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
> +					const struct atmel_pmecc_caps *caps,
> +					int pmecc_res_idx, int errloc_res_idx)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct atmel_pmecc *pmecc;
> +	struct resource *res;
> +
> +	pmecc = devm_kzalloc(dev, sizeof(*pmecc), GFP_KERNEL);
> +	if (!pmecc)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pmecc->caps = caps;
> +	pmecc->dev = dev;
> +	mutex_init(&pmecc->lock);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, pmecc_res_idx);
> +	pmecc->regs.base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pmecc->regs.base))
> +		return ERR_CAST(pmecc->regs.base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, errloc_res_idx);
> +	pmecc->regs.errloc = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pmecc->regs.errloc))
> +		return ERR_CAST(pmecc->regs.errloc);
> +
> +	/* Disable all interrupts before registering the PMECC handler. */
> +	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
> +
> +	/* Reset the ECC engine */
> +	writel(PMECC_CTRL_RST, pmecc->regs.base + ATMEL_PMECC_CTRL);
> +	writel(PMECC_CTRL_DISABLE, pmecc->regs.base + ATMEL_PMECC_CTRL);
> +
> +	return pmecc;
> +}
> +
> +static void devm_atmel_pmecc_put(struct device *dev, void *res)
> +{
> +	struct atmel_pmecc **pmecc = res;
> +
> +	put_device((*pmecc)->dev);
> +}
> +
> +static struct atmel_pmecc *atmel_pmecc_get_by_node(struct device *userdev,
> +						   struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	struct atmel_pmecc *pmecc, **ptr;
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev || !platform_get_drvdata(pdev))
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	ptr = devres_alloc(devm_atmel_pmecc_put, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	get_device(&pdev->dev);
> +	pmecc = platform_get_drvdata(pdev);
> +
> +	*ptr = pmecc;
> +
> +	devres_add(userdev, ptr);
> +
> +	return pmecc;
> +}
> +
> +static const int atmel_pmecc_strengths[] = { 2, 4, 8, 12, 24, 32 };
> +
> +struct atmel_pmecc_caps at91sam9g45_caps = {
> +	.strengths = atmel_pmecc_strengths,
> +	.nstrengths = 5,
> +	.el_offset = 0x8c,
> +};
> +
> +struct atmel_pmecc_caps sama5d4_caps = {
> +	.strengths = atmel_pmecc_strengths,
> +	.nstrengths = 5,
> +	.el_offset = 0x8c,
> +	.correct_erased_chunks = true,
> +};
> +
> +struct atmel_pmecc_caps sama5d2_caps = {
> +	.strengths = atmel_pmecc_strengths,
> +	.nstrengths = 6,
> +	.el_offset = 0xac,
> +	.correct_erased_chunks = true,
> +};
> +
> +static const struct of_device_id atmel_pmecc_legacy_match[] = {
> +	{ .compatible = "atmel,sama5d4-nand", &sama5d4_caps },
> +	{ .compatible = "atmel,sama5d2-nand", &sama5d2_caps },
> +	{ /* sentinel */ }
> +};
> +
> +struct atmel_pmecc *devm_atmel_pmecc_get(struct device *userdev)
> +{
> +	struct atmel_pmecc *pmecc;
> +	struct device_node *np;
> +
> +	if (!userdev)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!userdev->of_node)
> +		return NULL;
> +
> +	np = of_parse_phandle(userdev->of_node, "ecc-engine", 0);
> +	if (np) {
> +		pmecc = atmel_pmecc_get_by_node(userdev, np);
> +		of_node_put(np);
> +	} else {
> +		/*
> +		 * Support old DT bindings: in this case the PMECC iomem
> +		 * resources are directly defined in the user pdev at position
> +		 * 1 and 2. Extract all relevant information from there.
> +		 */
> +		struct platform_device *pdev = to_platform_device(userdev);
> +		const struct atmel_pmecc_caps *caps;
> +
> +		/* No PMECC engine available. */
> +		if (!of_property_read_bool(userdev->of_node,
> +					   "atmel,has-pmecc"))
> +			return NULL;
> +
> +		caps = &at91sam9g45_caps;
> +
> +		/*
> +		 * Try to find the NFC subnode and extract the associated caps
> +		 * from there.
> +		 */
> +		np = of_find_compatible_node(userdev->of_node, NULL,
> +					     "atmel,sama5d3-nfc");
> +		if (np) {
> +			const struct of_device_id *match;
> +
> +			match = of_match_node(atmel_pmecc_legacy_match, np);
> +			if (match && match->data)
> +				caps = match->data;
> +
> +			of_node_put(np);
> +		}
> +
> +		pmecc = atmel_pmecc_create(pdev, caps, 1, 2);
> +	}
> +
> +	return pmecc;
> +}
> +EXPORT_SYMBOL(devm_atmel_pmecc_get);
> +
> +static const struct of_device_id atmel_pmecc_match[] = {
> +	{ .compatible = "atmel,at91sam9g45-pmecc", &at91sam9g45_caps },
> +	{ .compatible = "atmel,sama5d4-pmecc", &sama5d4_caps },
> +	{ .compatible = "atmel,sama5d2-pmecc", &sama5d2_caps },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, atmel_pmecc_match);
> +
> +static int atmel_pmecc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct atmel_pmecc_caps *caps;
> +	struct atmel_pmecc *pmecc;
> +
> +	caps = of_device_get_match_data(&pdev->dev);
> +	if (!caps) {
> +		dev_err(dev, "Invalid caps\n");
> +		return -EINVAL;
> +	}
> +
> +	pmecc = atmel_pmecc_create(pdev, caps, 0, 1);
> +	if (IS_ERR(pmecc))
> +		return PTR_ERR(pmecc);
> +
> +	platform_set_drvdata(pdev, pmecc);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver atmel_pmecc_driver = {
> +	.driver = {
> +		.name = "atmel-pmecc",
> +		.of_match_table = of_match_ptr(atmel_pmecc_match),
> +	},
> +	.probe = atmel_pmecc_probe,
> +};
> +module_platform_driver(atmel_pmecc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
> +MODULE_DESCRIPTION("PMECC engine driver");
> +MODULE_ALIAS("platform:atmel_pmecc");
> diff --git a/drivers/mtd/nand/atmel/pmecc.h b/drivers/mtd/nand/atmel/pmecc.h
> new file mode 100644
> index 000000000000..a8ddbfca2ea5
> --- /dev/null
> +++ b/drivers/mtd/nand/atmel/pmecc.h
> @@ -0,0 +1,73 @@
> +/*
> + * ? Copyright 2016 ATMEL
> + * ? Copyright 2016 Free Electrons

Ditto.

> + * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
> + *
> + * Derived from the atmel_nand.c driver which contained the following
> + * copyrights:
> + *
> + *    Copyright ? 2003 Rick Bronson
> + *
> + *    Derived from drivers/mtd/nand/autcpu12.c
> + *        Copyright ? 2001 Thomas Gleixner (gleixner at autronix.de)
> + *
> + *    Derived from drivers/mtd/spia.c
> + *        Copyright ? 2000 Steven J. Hill (sjhill at cotw.com)
> + *
> + *
> + *    Add Hardware ECC support for AT91SAM9260 / AT91SAM9263
> + *        Richard Genoud (richard.genoud at gmail.com), Adeneo Copyright ? 2007
> + *
> + *        Derived from Das U-Boot source code
> + *              (u-boot-1.1.5/board/atmel/at91sam9263ek/nand.c)
> + *        ? Copyright 2006 ATMEL Rousset, Lacressonniere Nicolas
> + *
> + *    Add Programmable Multibit ECC support for various AT91 SoC
> + *        ? Copyright 2012 ATMEL, Hong Xu
> + *
> + *    Add Nand Flash Controller support for SAMA5 SoC
> + *        ? Copyright 2013 ATMEL, Josh Wu (josh.wu at atmel.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef ATMEL_PMECC_H
> +#define ATMEL_PMECC_H
> +
> +#define ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH	0
> +#define ATMEL_PMECC_SECTOR_SIZE_AUTO		0
> +#define ATMEL_PMECC_OOBOFFSET_AUTO		-1
> +
> +struct atmel_pmecc_user_req {
> +	int pagesize;
> +	int oobsize;
> +	struct {
> +		int strength;
> +		int bytes;
> +		int sectorsize;
> +		int nsectors;
> +		int ooboffset;
> +	} ecc;
> +};
> +
> +struct atmel_pmecc *devm_atmel_pmecc_get(struct device *dev);
> +
> +struct atmel_pmecc_user *
> +atmel_pmecc_create_user(struct atmel_pmecc *pmecc,
> +			struct atmel_pmecc_user_req *req);
> +void atmel_pmecc_destroy_user(struct atmel_pmecc_user *user);
> +
> +int atmel_pmecc_enable(struct atmel_pmecc_user *user, int op);
> +void atmel_pmecc_disable(struct atmel_pmecc_user *user);
> +int atmel_pmecc_wait_rdy(struct atmel_pmecc_user *user);
> +int atmel_pmecc_correct_sector(struct atmel_pmecc_user *user, int sector,
> +			       void *data, void *ecc);
> +bool atmel_pmecc_correct_erased_chunks(struct atmel_pmecc_user *user);
> +void atmel_pmecc_get_generated_eccbytes(struct atmel_pmecc_user *user,
> +					int sector, void *ecc);
> +
> +#endif /* ATMEL_PMECC_H */
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> deleted file mode 100644
> index 9ebd5ecefea6..000000000000
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ /dev/null

[..]


-- 
Nicolas Ferre
