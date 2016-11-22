From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Nov 2016 11:52:53 +0100
Subject: [PATCH 8/9] mtd: nand: mxc: implement onfi get/set features
In-Reply-To: <20161121145643.7804e28f@bbrezillon>
References: <1473928373-8680-1-git-send-email-s.hauer@pengutronix.de>
 <1473928373-8680-9-git-send-email-s.hauer@pengutronix.de>
 <20161121145643.7804e28f@bbrezillon>
Message-ID: <20161122105253.tzz2hvzhkse7telr@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Mon, Nov 21, 2016 at 02:56:43PM +0100, Boris Brezillon wrote:
> Hi Sascha,
> 
> On Thu, 15 Sep 2016 10:32:52 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > To be able to support different ONFI timing modes we have to implement
> > the onfi_set_features and onfi_get_features. Tested on an i.MX25 SoC.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mtd/nand/mxc_nand.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> > index 5173fad..1db8299 100644
> > --- a/drivers/mtd/nand/mxc_nand.c
> > +++ b/drivers/mtd/nand/mxc_nand.c
> > @@ -1239,6 +1239,57 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
> >  	}
> >  }
> >  
> > +static int mxc_nand_onfi_set_features(struct mtd_info *mtd, struct nand_chip *chip,
> > +			int addr, uint8_t *subfeature_param)
> > +{
> > +	struct nand_chip *nand_chip = mtd_to_nand(mtd);
> > +	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
> > +	int i;
> > +
> > +	if (!chip->onfi_version ||
> > +	    !(le16_to_cpu(chip->onfi_params.opt_cmd)
> > +	      & ONFI_OPT_CMD_SET_GET_FEATURES))
> > +		return -EINVAL;
> > +
> > +	host->buf_start = 0;
> > +
> > +	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
> > +		chip->write_byte(mtd, subfeature_param[i]);
> > +
> > +	memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
> > +	host->devtype_data->send_cmd(host, NAND_CMD_SET_FEATURES, false);
> > +	mxc_do_addr_cycle(mtd, addr, -1);
> > +	host->devtype_data->send_page(mtd, NFC_INPUT);
> 
> I've been working with an mx27 board embedding a NAND device lately,
> and had a closer look at the NAND controller IP.
> With this IP, you're not able to send only 4 bytes of data, and I'm
> sure sure what you're doing here (sending a full page of data) works
> for a SET_FEATURE command.
> 
> Do you have a way to test it (my NAND is not ONFI compliant)? By test
> it, I mean, set a timing mode using SET_FEATURE and check if the new
> mode has been applied using GET_FEATURE.

I have an i.MX27 board with ONFI flash, but this one does not have the
ONFI_OPT_CMD_SET_GET_FEATURES bit set, so I can't test it there.
However, I can confirm that it works on an i.MX25. With the attached
patch applied on vanilla v4.9-rc5 I get:

GET FEATURES. chip->onfi_timing_mode_default: 4
timing before: 0x00
timing after: 0x04

Sascha

-------------------------8<-------------------------------

>From 38e45851a796ba47e25c72ebc58e358c70e18275 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 22 Nov 2016 11:48:36 +0100
Subject: [PATCH] wip

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/nand_base.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 3bde96a..5b5be2b 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1017,12 +1017,24 @@ static int nand_setup_data_interface(struct nand_chip *chip)
 		u8 tmode_param[ONFI_SUBFEATURE_PARAM_LEN] = {
 			chip->onfi_timing_mode_default,
 		};
+		u8 rmode_param[ONFI_SUBFEATURE_PARAM_LEN] = {};
+
+		printk("GET FEATURES. chip->onfi_timing_mode_default: %d\n", chip->onfi_timing_mode_default);
+		ret = chip->onfi_get_features(mtd, chip, ONFI_FEATURE_ADDR_TIMING_MODE, rmode_param);
+		if (ret)
+			goto err;
+		printk("timing before: 0x%02x\n", rmode_param[0]);
 
 		ret = chip->onfi_set_features(mtd, chip,
 				ONFI_FEATURE_ADDR_TIMING_MODE,
 				tmode_param);
 		if (ret)
 			goto err;
+
+		ret = chip->onfi_get_features(mtd, chip, ONFI_FEATURE_ADDR_TIMING_MODE, rmode_param);
+		if (ret)
+			goto err;
+		printk("timing after: 0x%02x\n", rmode_param[0]);
 	}
 
 	ret = chip->setup_data_interface(mtd, chip->data_interface, false);
-- 
2.10.2

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
