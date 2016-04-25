From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 25 Apr 2016 14:53:02 +0200
Subject: [PATCH v2] gpmi-nand: Handle ECC Errors in erased pages
In-Reply-To: <1461587712-16403-1-git-send-email-mpa@pengutronix.de>
References: <1461587712-16403-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20160425145302.27b10c78@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Mon, 25 Apr 2016 14:35:12 +0200
Markus Pargmann <mpa@pengutronix.de> wrote:

> ECC is only calculated for written pages. As erased pages are not
> actively written the ECC is always invalid. For this purpose the
> Hardware BCH unit is able to check for erased pages and does not raise
> an ECC error in this case. This behaviour can be influenced using the
> BCH_MODE register which sets the number of allowed bitflips in an erased
> page. Unfortunately the unit is not capable of fixing the bitflips in
> memory.
> 
> To avoid complete software checks for erased pages, we can simply check
> buffers with uncorrectable ECC errors because we know that any erased
> page with errors is uncorrectable by the BCH unit.
> 
> This patch adds the generic nand_check_erased_ecc_chunk() to gpmi-nand
> to correct erased pages. To have the valid data in the buffer before
> using them, this patch moves the read_page_swap_end() call before the
> ECC status checking for-loop.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> [Squashed patches by Stefan and Boris to check ECC area]
> Cc: Stefan Christ <s.christ@phytec.de>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Duplicate SoB (no need to resend, I'll drop it while applying the
patch).

Otherwise, it looks good to me. Stefan, could you add your Tested-by,
and I'd also like to have an Ack from Han.

Thanks,

Boris

> ---
> Hi,
> 
> thanks for the patches Stefan and Boris, I squashed it into this patch.
> 
> Best Regards,
> 
> Markus
> 
> 
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 78 +++++++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> index 235ddcb58f39..71ee1696bcd1 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -1035,14 +1035,87 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>  	/* Loop over status bytes, accumulating ECC status. */
>  	status = auxiliary_virt + nfc_geo->auxiliary_status_offset;
>  
> +	read_page_swap_end(this, buf, nfc_geo->payload_size,
> +			   this->payload_virt, this->payload_phys,
> +			   nfc_geo->payload_size,
> +			   payload_virt, payload_phys);
> +
>  	for (i = 0; i < nfc_geo->ecc_chunk_count; i++, status++) {
>  		if ((*status == STATUS_GOOD) || (*status == STATUS_ERASED))
>  			continue;
>  
>  		if (*status == STATUS_UNCORRECTABLE) {
> +			int eccbits = nfc_geo->ecc_strength * nfc_geo->gf_len;
> +			u8 *eccbuf = this->raw_buffer;
> +			int offset, bitoffset;
> +			int eccbytes;
> +			int flips;
> +
> +			/* Read ECC bytes into our internal raw_buffer */
> +			offset = nfc_geo->metadata_size * 8;
> +			offset += ((8 * nfc_geo->ecc_chunk_size) + eccbits) * (i + 1);
> +			offset -= eccbits;
> +			bitoffset = offset % 8;
> +			eccbytes = DIV_ROUND_UP(offset + eccbits, 8);
> +			offset /= 8;
> +			eccbytes -= offset;
> +			chip->cmdfunc(mtd, NAND_CMD_RNDOUT, offset, -1);
> +			chip->read_buf(mtd, eccbuf, eccbytes);
> +
> +			/*
> +			 * ECC data are not byte aligned and we may have
> +			 * in-band data in the first and last byte of
> +			 * eccbuf. Set non-eccbits to one so that
> +			 * nand_check_erased_ecc_chunk() does not count them
> +			 * as bitflips.
> +			 */
> +			if (bitoffset)
> +				eccbuf[0] |= GENMASK(bitoffset - 1, 0);
> +
> +			bitoffset = (bitoffset + eccbits) % 8;
> +			if (bitoffset)
> +				eccbuf[eccbytes - 1] |= GENMASK(7, bitoffset);
> +
> +			/*
> +			 * The ECC hardware has an uncorrectable ECC status
> +			 * code in case we have bitflips in an erased page. As
> +			 * nothing was written into this subpage the ECC is
> +			 * obviously wrong and we can not trust it. We assume
> +			 * at this point that we are reading an erased page and
> +			 * try to correct the bitflips in buffer up to
> +			 * ecc_strength bitflips. If this is a page with random
> +			 * data, we exceed this number of bitflips and have a
> +			 * ECC failure. Otherwise we use the corrected buffer.
> +			 */
> +			if (i == 0) {
> +				/* The first block includes metadata */
> +				flips = nand_check_erased_ecc_chunk(
> +						buf + i * nfc_geo->ecc_chunk_size,
> +						nfc_geo->ecc_chunk_size,
> +						eccbuf, eccbytes,
> +						auxiliary_virt,
> +						nfc_geo->metadata_size,
> +						nfc_geo->ecc_strength);
> +			} else {
> +				flips = nand_check_erased_ecc_chunk(
> +						buf + i * nfc_geo->ecc_chunk_size,
> +						nfc_geo->ecc_chunk_size,
> +						eccbuf, eccbytes,
> +						NULL, 0,
> +						nfc_geo->ecc_strength);
> +			}
> +
> +			if (flips > 0) {
> +				max_bitflips = max_t(unsigned int, max_bitflips,
> +						     flips);
> +				mtd->ecc_stats.corrected += flips;
> +				continue;
> +			}
> +
>  			mtd->ecc_stats.failed++;
>  			continue;
>  		}
> +
>  		mtd->ecc_stats.corrected += *status;
>  		max_bitflips = max_t(unsigned int, max_bitflips, *status);
>  	}
> @@ -1062,11 +1135,6 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>  		chip->oob_poi[0] = ((uint8_t *) auxiliary_virt)[0];
>  	}
>  
> -	read_page_swap_end(this, buf, nfc_geo->payload_size,
> -			this->payload_virt, this->payload_phys,
> -			nfc_geo->payload_size,
> -			payload_virt, payload_phys);
> -
>  	return max_bitflips;
>  }
>  



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
