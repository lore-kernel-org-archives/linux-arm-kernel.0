From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 10 May 2016 10:55:49 +0200
Subject: [PATCH 1/2] Revert "mtd: atmel_nand: Support variable RB_EDGE
 interrupts"
In-Reply-To: <1462776680-5284-2-git-send-email-wenyou.yang@atmel.com>
References: <1462776680-5284-1-git-send-email-wenyou.yang@atmel.com>
 <1462776680-5284-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160510105549.50b60d8c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

Can you add NAND maintainers/reviewers in Cc next time. And since you
revert a commit, you should also add the commit author in the loop.

On Mon, 9 May 2016 14:51:18 +0800
Wenyou Yang <wenyou.yang@atmel.com> wrote:

> This reverts commit 5ddc7bd43ccc ("mtd: atmel_nand: Support variable
> RB_EDGE interrupts")
> 
> Because for current SoCs, the RB_EDGE3(i.e. bit 27) of HSMC_SR
> register does not exist, the RB_EDGE0 (i.e. bit 24) is the ready/busy
> line edge status bit. It is a datasheet bug.

Romain, I thought you had a real use case on sama5d4 where this patch
was needed to make the whole thing work. Not sure why you submitted this
patch if you couldn't test it on a real board.

Wenyou, can you confirm that none of the existing SoCs support more
than one "native" R/B pin?

Thanks,

Boris

> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
>  .../devicetree/bindings/mtd/atmel-nand.txt         |  2 +-
>  drivers/mtd/nand/atmel_nand.c                      | 35 +++++-----------------
>  drivers/mtd/nand/atmel_nand_nfc.h                  |  3 +-
>  3 files changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> index d53aba9..3e7ee99 100644
> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> @@ -39,7 +39,7 @@ Optional properties:
>  
>  Nand Flash Controller(NFC) is an optional sub-node
>  Required properties:
> -- compatible : "atmel,sama5d3-nfc" or "atmel,sama5d4-nfc".
> +- compatible : "atmel,sama5d3-nfc".
>  - reg : should specify the address and size used for NFC command registers,
>          NFC registers and NFC SRAM. NFC SRAM address and size can be absent
>          if don't want to use it.
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index efc8ea2..68b9160 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -67,10 +67,6 @@ struct atmel_nand_caps {
>  	uint8_t pmecc_max_correction;
>  };
>  
> -struct atmel_nand_nfc_caps {
> -	uint32_t rb_mask;
> -};
> -
>  /*
>   * oob layout for large page size
>   * bad block info is on bytes 0 and 1
> @@ -129,7 +125,6 @@ struct atmel_nfc {
>  	/* Point to the sram bank which include readed data via NFC */
>  	void			*data_in_sram;
>  	bool			will_write_sram;
> -	const struct atmel_nand_nfc_caps *caps;
>  };
>  static struct atmel_nfc	nand_nfc;
>  
> @@ -1715,9 +1710,9 @@ static irqreturn_t hsmc_interrupt(int irq, void *dev_id)
>  		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_XFR_DONE);
>  		ret = IRQ_HANDLED;
>  	}
> -	if (pending & host->nfc->caps->rb_mask) {
> +	if (pending & NFC_SR_RB_EDGE) {
>  		complete(&host->nfc->comp_ready);
> -		nfc_writel(host->nfc->hsmc_regs, IDR, host->nfc->caps->rb_mask);
> +		nfc_writel(host->nfc->hsmc_regs, IDR, NFC_SR_RB_EDGE);
>  		ret = IRQ_HANDLED;
>  	}
>  	if (pending & NFC_SR_CMD_DONE) {
> @@ -1735,7 +1730,7 @@ static void nfc_prepare_interrupt(struct atmel_nand_host *host, u32 flag)
>  	if (flag & NFC_SR_XFR_DONE)
>  		init_completion(&host->nfc->comp_xfer_done);
>  
> -	if (flag & host->nfc->caps->rb_mask)
> +	if (flag & NFC_SR_RB_EDGE)
>  		init_completion(&host->nfc->comp_ready);
>  
>  	if (flag & NFC_SR_CMD_DONE)
> @@ -1753,7 +1748,7 @@ static int nfc_wait_interrupt(struct atmel_nand_host *host, u32 flag)
>  	if (flag & NFC_SR_XFR_DONE)
>  		comp[index++] = &host->nfc->comp_xfer_done;
>  
> -	if (flag & host->nfc->caps->rb_mask)
> +	if (flag & NFC_SR_RB_EDGE)
>  		comp[index++] = &host->nfc->comp_ready;
>  
>  	if (flag & NFC_SR_CMD_DONE)
> @@ -1821,7 +1816,7 @@ static int nfc_device_ready(struct mtd_info *mtd)
>  		dev_err(host->dev, "Lost the interrupt flags: 0x%08x\n",
>  				mask & status);
>  
> -	return status & host->nfc->caps->rb_mask;
> +	return status & NFC_SR_RB_EDGE;
>  }
>  
>  static void nfc_select_chip(struct mtd_info *mtd, int chip)
> @@ -1994,8 +1989,8 @@ static void nfc_nand_command(struct mtd_info *mtd, unsigned int command,
>  		}
>  		/* fall through */
>  	default:
> -		nfc_prepare_interrupt(host, host->nfc->caps->rb_mask);
> -		nfc_wait_interrupt(host, host->nfc->caps->rb_mask);
> +		nfc_prepare_interrupt(host, NFC_SR_RB_EDGE);
> +		nfc_wait_interrupt(host, NFC_SR_RB_EDGE);
>  	}
>  }
>  
> @@ -2426,11 +2421,6 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	nfc->caps = (const struct atmel_nand_nfc_caps *)
> -		of_device_get_match_data(&pdev->dev);
> -	if (!nfc->caps)
> -		return -ENODEV;
> -
>  	nfc_writel(nfc->hsmc_regs, IDR, 0xffffffff);
>  	nfc_readl(nfc->hsmc_regs, SR);	/* clear the NFC_SR */
>  
> @@ -2459,17 +2449,8 @@ static int atmel_nand_nfc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct atmel_nand_nfc_caps sama5d3_nfc_caps = {
> -	.rb_mask = NFC_SR_RB_EDGE0,
> -};
> -
> -static const struct atmel_nand_nfc_caps sama5d4_nfc_caps = {
> -	.rb_mask = NFC_SR_RB_EDGE3,
> -};
> -
>  static const struct of_device_id atmel_nand_nfc_match[] = {
> -	{ .compatible = "atmel,sama5d3-nfc", .data = &sama5d3_nfc_caps },
> -	{ .compatible = "atmel,sama5d4-nfc", .data = &sama5d4_nfc_caps },
> +	{ .compatible = "atmel,sama5d3-nfc" },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, atmel_nand_nfc_match);
> diff --git a/drivers/mtd/nand/atmel_nand_nfc.h b/drivers/mtd/nand/atmel_nand_nfc.h
> index 0bbc1fa..4d5d262 100644
> --- a/drivers/mtd/nand/atmel_nand_nfc.h
> +++ b/drivers/mtd/nand/atmel_nand_nfc.h
> @@ -42,8 +42,7 @@
>  #define		NFC_SR_UNDEF		(1 << 21)
>  #define		NFC_SR_AWB		(1 << 22)
>  #define		NFC_SR_ASE		(1 << 23)
> -#define		NFC_SR_RB_EDGE0		(1 << 24)
> -#define		NFC_SR_RB_EDGE3		(1 << 27)
> +#define		NFC_SR_RB_EDGE		(1 << 24)
>  
>  #define ATMEL_HSMC_NFC_IER	0x0c
>  #define ATMEL_HSMC_NFC_IDR	0x10



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
