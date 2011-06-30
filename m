From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 30 Jun 2011 19:04:32 +0200
Subject: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC controller
	driver
In-Reply-To: <20110630102728.GB1997@pengutronix.de>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
	<1309335878-16678-2-git-send-email-b32955@freescale.com>
	<20110630102728.GB1997@pengutronix.de>
Message-ID: <20110630170432.GA20948@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 12:27:28PM +0200, Wolfram Sang wrote:
> 
> > +static int mil_ecc_write_oob(struct mtd_info *mtd,
> > +				struct nand_chip *nand, int page)
> > +{
> > +	struct gpmi_nfc_data *this = nand->priv;
> > +	struct device *dev = this->dev;
> > +	struct mil *mil	= &this->mil;
> > +	uint8_t *block_mark;
> > +	int block_mark_column;
> > +	int status;
> > +	int error = 0;
> > +
> > +	/* Only marking a block bad is permitted to write the OOB. */
> > +	if (!mil->marking_a_bad_block) {
> > +		dev_emerg(dev, "This driver doesn't support writing the OOB\n");
> > +		WARN_ON(1);
> > +		error = -EIO;
> > +		goto exit;
> > +	}
> 
> Huh? Why is that? This will break JFFS2, for example.

-----------------------------------------------------------------
The GPMI-NFC driver will use the OOB(BCH will use the OOB for a special layout), so we forbid any others to use the OOB.
But marking a block bad is permitted.

If the JFFS2 use the OOB, we have to disable it
We use UBIFS by default.

-----------------------------------------------------------------

(Please use a proper mailer)

Why can't you define a nand_ecclayout with no free space?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110630/d4438e44/attachment.sig>
