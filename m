From: stefan@agner.ch (Stefan Agner)
Date: Mon, 03 Aug 2015 11:28:43 +0200
Subject: [PATCH v10 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <1438594050-4595-3-git-send-email-stefan@agner.ch>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-3-git-send-email-stefan@agner.ch>
Message-ID: <ff2e2716578a1ae5f0c4b0e0ca8bbdc3@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On 2015-08-03 11:27, Stefan Agner wrote:
<snip>
> +static inline int vf610_nfc_correct_data(struct mtd_info *mtd, uint8_t *dat,
> +					 uint8_t *oob, int oob_loaded)
> +{
> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> +	u8 ecc_status;
> +	u8 ecc_count;
> +	int flip;
> +
> +	ecc_status = __raw_readb(nfc->regs + ECC_SRAM_ADDR * 8 + ECC_OFFSET);
> +	ecc_count = ecc_status & ECC_ERR_COUNT;
> +
> +	if (!(ecc_status & ECC_STATUS_MASK))
> +		return ecc_count;
> +
> +	if (!oob_loaded)
> +		vf610_nfc_read_buf(mtd, oob, mtd->oobsize);
> +
> +	/*
> +	 * On an erased page, bit count (including OOB) should be zero or
> +	 * at least less then half of the ECC strength.
> +	 */
> +	flip = count_written_bits(dat, nfc->chip.ecc.size, ecc_count);
> +	flip += count_written_bits(oob, mtd->oobsize - nfc->chip.ecc.bytes,
> +				   ecc_count);

With ECC the controller seems to clear the ECC bytes in SRAM buffer.
This is a dump of 64 Bit OOB with the 32-error ECC mode which requires
60 bytes of OOB for ECC:

[   22.190273] ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   22.209698] vf610_nfc_correct_data, flips 1

Not sure if this is acceptable, but I now only count the bits in the
non-ECC area of the OOB.

Btw, if the ECC check fails, the controller seems kind of count the
amount of bitflips. It works for most devices reliable, but we had
devices for which that number was not accurate, see:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/357439

--
Stefan
