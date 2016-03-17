From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 17 Mar 2016 15:06:19 +0100
Subject: [PATCH 6/7] mtd: nand: sunxi: add support for DMA assisted
 operations
In-Reply-To: <1457435715-24740-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1457435715-24740-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457435715-24740-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160317150619.7d6b5f37@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  8 Mar 2016 12:15:14 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> The sunxi NAND controller is able to pipeline ECC operations only when
> operated in DMA mode, which improves a lot NAND throughput while keeping
> CPU usage low.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/sunxi_nand.c | 301 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 297 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index 07c3af7..7ba285e 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c

[...]

> +static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
> +					   struct nand_chip *chip,
> +					   const u8 *buf,
> +					   int oob_required,
> +					   int page)
> +{
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
> +	struct nand_ecc_ctrl *ecc = &nand->ecc;
> +	struct sg_table sgt;
> +	int ret, i;
> +
> +	ret = sunxi_nfc_wait_cmd_fifo_empty(nfc);
> +	if (ret)
> +		return ret;
> +
> +	ret = sunxi_nfc_dma_op_prepare(mtd, buf, ecc->size, ecc->steps,
> +				       DMA_TO_DEVICE, &sgt);
> +	if (ret)
> +		goto pio_fallback;
> +
> +	for (i = 0; i < ecc->steps; i++) {
> +		const u8 *oob = nand->oob_poi + (i * (ecc->bytes + 4));
> +
> +		sunxi_nfc_hw_ecc_set_prot_oob_bytes(mtd, oob, i, !i, page);
> +	}
> +
> +	sunxi_nfc_hw_ecc_enable(mtd);
> +	sunxi_nfc_randomizer_config(mtd, page, false);
> +	sunxi_nfc_randomizer_enable(mtd);
> +
> +	writel((NAND_CMD_RNDIN << 8) | NAND_CMD_PAGEPROG,
> +	       nfc->regs + NFC_REG_RCMD_SET);
> +
> +	dma_async_issue_pending(nfc->dmac);
> +
> +	writel(NFC_PAGE_OP | NFC_DATA_SWAP_METHOD |
> +	       NFC_DATA_TRANS | NFC_ACCESS_DIR,
> +	       nfc->regs + NFC_REG_CMD);
> +
> +	ret = sunxi_nfc_wait_events(nfc, NFC_CMD_INT_FLAG, true, 0);
> +	if (ret)
> +		dmaengine_terminate_all(nfc->dmac);
> +
> +	sunxi_nfc_randomizer_disable(mtd);
> +	sunxi_nfc_hw_ecc_disable(mtd);
> +
> +	sunxi_nfc_dma_op_cleanup(mtd, DMA_FROM_DEVICE, &sgt);

		Should be DMA_TO_DEVICE here ^

> +
> +	if (ret)
> +		return ret;
> +
> +	if (oob_required || (chip->options & NAND_NEED_SCRAMBLING))
> +		/* TODO: use DMA to transfer extra OOB bytes ? */
> +		sunxi_nfc_hw_ecc_write_extra_oob(mtd, chip->oob_poi,
> +						 NULL, page);
> +
> +	return 0;
> +
> +pio_fallback:
> +	return sunxi_nfc_hw_ecc_write_page(mtd, chip, buf, oob_required, page);
> +}




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
