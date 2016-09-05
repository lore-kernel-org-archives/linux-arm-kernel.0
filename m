From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Sep 2016 13:09:32 +0200
Subject: [PATCH 1/2] mtd: nand: automate NAND timings selection
In-Reply-To: <20160905085146.239129bd@bbrezillon>
References: <1472820149-24241-1-git-send-email-s.hauer@pengutronix.de>
 <1472820149-24241-2-git-send-email-s.hauer@pengutronix.de>
 <20160905085146.239129bd@bbrezillon>
Message-ID: <20160905110932.jkt3ixxrsqj5emzu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 08:51:46AM +0200, Boris Brezillon wrote:
> Hi Sascha,
> 
> It feels weird to review his own patch, but I have a few comments. :)

I know this feeling. Suddenly you have to criticise code you previously
hoped to get through with ;)

> 
> On Fri,  2 Sep 2016 14:42:28 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> > The NAND framework provides several helpers to query timing modes supported
> > by a NAND chip, but this implies that all NAND controller drivers have
> > to implement the same timings selection dance.
> > 
> > Provide a common logic to select the best timings based on ONFI or
> > ->onfi_timing_mode_default information.  
> > NAND controller willing to support timings adjustment should just
> > implement the ->setup_data_interface() method.
> 
> Now I remember one of the reason I did not post a v2 (apart from not
> having the time).
> 
> If understand the ONFI spec correctly, when you reset the NAND chip,
> you get back to SDR+timing-mode0. In the core we do not control when
> the reset command (0xff) is issued, and this prevents us from
> re-applying the correct timing mode after a reset.
> 
> Maybe we should provide a nand_reset() helper to hide this complexity,
> and patch all ->cmdfunc(NAND_CMD_RESET) callers to call nand_reset()
> instead.
> 
> Note that the interface+timing-mode config is not necessarily the only
> thing we'll have to re-apply after a reset (especially on MLC NANDs), so
> having place where we can put all operations that should be done after
> a reset is a good thing.

Ouch, there are indeed some things wrong in this patch. We iterate over
all chips and set the timing mode for each:

+		if (modes != ONFI_TIMING_MODE_UNKNOWN) {
+			/*
+			 * FIXME: should we really set the timing mode on all
+			 * dies?
+			 */
+			for (i = 0; i < chip->numchips; i++) {
+				chip->select_chip(mtd, i);
+				ret = chip->onfi_set_features(mtd, chip,
+						ONFI_FEATURE_ADDR_TIMING_MODE,
+						tmode_param);
+			}
+			chip->select_chip(mtd, -1);
+		}
+

Afterwards the code in nand_scan_ident() resets all chips while checking
for a chip array, reverting the effect of the above code. Looking closer
at it the above code has no effect anyway since it's executed when
chip->numchips is not yet initialized and still 0.

I think providing a nand_reset() function is a good idea. I'll implement
one and see what I end up with.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
