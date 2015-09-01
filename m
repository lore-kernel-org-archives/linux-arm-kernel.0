From: stefan@agner.ch (Stefan Agner)
Date: Tue, 01 Sep 2015 09:55:48 -0700
Subject: [PATCH v11 2/5] mtd: nand: vf610_nfc: add hardware BCH-ECC support
In-Reply-To: <1440722100-25388-3-git-send-email-stefan@agner.ch>
References: <1440722100-25388-1-git-send-email-stefan@agner.ch>
 <1440722100-25388-3-git-send-email-stefan@agner.ch>
Message-ID: <575f176ee9d5e6d785ed2352887d5336@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-08-27 17:34, Stefan Agner wrote:
> +static inline int vf610_nfc_correct_data(struct mtd_info *mtd, uint8_t *dat,
> +					 uint8_t *oob, int page)
> +{
> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> +	u32 ecc_status_off = NFC_MAIN_AREA(0) + ECC_SRAM_ADDR + ECC_STATUS;
> +	u8 ecc_status;
> +	u8 ecc_count;
> +	int flips;
> +	int flips_threshold = nfc->chip.ecc.strength / 2;
> +
> +	ecc_status = vf610_nfc_read(nfc, ecc_status_off) & 0xff;
> +	ecc_count = ecc_status & ECC_STATUS_ERR_COUNT;
> +
> +	if (!(ecc_status & ECC_STATUS_MASK))
> +		return ecc_count;
> +
> +	/* Read OOB without ECC unit enabled */
> +	vf610_nfc_command(mtd, NAND_CMD_READOOB, 0, page);
> +	vf610_nfc_read_buf(mtd, oob, mtd->oobsize);
> +
> +	/*
> +	 * On an erased page, bit count (including OOB) should be zero or
> +	 * at least less then half of the ECC strength.
> +	 */
> +	flips = count_written_bits(dat, nfc->chip.ecc.size, flips_threshold);
> +	flips += count_written_bits(oob, mtd->oobsize, flips_threshold);
> +
> +	if (unlikely(flips > flips_threshold))
> +		return -EINVAL;
> +
> +	/* Erased page. */
> +	memset(dat, 0xff, nfc->chip.ecc.size);
> +	memset(oob, 0xff, mtd->oobsize);
> +	return 0;

I guess I should return the amount of bitflips here. Will send out a v12
today.

--
Stefan
