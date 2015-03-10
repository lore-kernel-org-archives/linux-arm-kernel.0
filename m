From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Mar 2015 17:10:49 +0100
Subject: [PATCH 2/2] soc: mediatek: Add PMIC wrapper for MT8135 and
 MT8173 SoCs
In-Reply-To: <20150310154610.GP8656@n2100.arm.linux.org.uk>
References: <1426000954-7647-1-git-send-email-s.hauer@pengutronix.de>
 <1426000954-7647-3-git-send-email-s.hauer@pengutronix.de>
 <20150310154610.GP8656@n2100.arm.linux.org.uk>
Message-ID: <20150310161049.GI24885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 03:46:11PM +0000, Russell King - ARM Linux wrote:
> On Tue, Mar 10, 2015 at 04:22:34PM +0100, Sascha Hauer wrote:
> > +	for (i = 0; i < 4; i++) {
> > +		pwrap_writel(wrp, i, PWRAP_SIDLY);
> > +		pwrap_read(wrp, PWRAP_DEW_READ_TEST, &rdata);
> > +		printk("%s: 0x%04x\n", __func__, rdata);
> 
> Is this really ready for submission, or is this just a hidden oversight?
> 
> What I tend to do with such debugging is _not_ to indent it at all, which
> means when the file is reviewed before sending it out (or indeed, when
> diffing it to review the updates before committing those changes or an
> amendment to the previous commit) that it sticks out like a sore thumb.

I often do this aswell, apparently not all the time :-/

This message is also not seen often during booting since the driver has
this in it:

	/*
	 * The PMIC could already be initialized by the bootloader.
	 * Skip initialization here in this case.
	 */
	if (!pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
		ret = pwrap_init(wrp);
		if (ret) {
			dev_dbg(wrp->dev, "init failed with %d\n", ret);
			goto err_out2;
		}
	}

I first have to comment out the already initialized check to see this
message. I just rechecked, yes, the initialisation still works as
expected.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
