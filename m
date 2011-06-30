From: B32955@freescale.com (Huang Shijie-B32955)
Date: Thu, 30 Jun 2011 15:21:21 +0000
Subject: reply: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC
	controller driver
Message-ID: <14C4E31473AF7E4B98176CB73615181C19FB3C@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Wolfram:

> +static int mil_ecc_write_oob(struct mtd_info *mtd,
> +                             struct nand_chip *nand, int page)
> +{
> +     struct gpmi_nfc_data *this = nand->priv;
> +     struct device *dev = this->dev;
> +     struct mil *mil = &this->mil;
> +     uint8_t *block_mark;
> +     int block_mark_column;
> +     int status;
> +     int error = 0;
> +
> +     /* Only marking a block bad is permitted to write the OOB. */
> +     if (!mil->marking_a_bad_block) {
> +             dev_emerg(dev, "This driver doesn't support writing the OOB\n");
> +             WARN_ON(1);
> +             error = -EIO;
> +             goto exit;
> +     }

Huh? Why is that? This will break JFFS2, for example.

-----------------------------------------------------------------
The GPMI-NFC driver will use the OOB(BCH will use the OOB for a special layout), so we forbid any others to use the OOB.
But marking a block bad is permitted.

If the JFFS2 use the OOB, we have to disable it
We use UBIFS by default.

Thanks.

Best Regards
Huang Shijie




-----------------------------------------------------------------

--
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
