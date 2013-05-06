From: neilb@suse.de (NeilBrown)
Date: Mon, 6 May 2013 12:40:11 +1000
Subject: Latest build results - errors/warnings - lots of them
In-Reply-To: <20130502153834.GR28721@atomide.com>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <20130502082218.GA21614@n2100.arm.linux.org.uk>
 <20130502153834.GR28721@atomide.com>
Message-ID: <20130506124011.7e4c2806@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 May 2013 08:38:34 -0700 Tony Lindgren <tony@atomide.com> wrote:

> > drivers/power/twl4030_charger.c: In function 'twl4030_charger_enable_usb':
> > drivers/power/twl4030_charger.c:192:20: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result
> 
> Neil, care to provide a fix for this? It's from your commit ab37813
> (twl4030_charger: Allow charger to control the regulator that feeds it).
> 
>
This the sort of thing that might be appropriate?

NeilBrown


From: NeilBrown <neilb@suse.de>
Date: Mon, 6 May 2013 12:35:59 +1000
Subject: [PATCH] twl4030_charger: don't ignore regulator_enable()

regulator_enable() doesn't like being ignored.  If it does fail there
is nothing we can do except not set usb_enabled (which is necessary
else a subsequent regulator_disable() will be unbalanced).

We cannot usefully return an error here as errors from
twl4030_charger_enable_usb() are ignored.

Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index bed4581..8b0ec70 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -189,8 +189,8 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 
 		/* Need to keep regulator on */
 		if (!bci->usb_enabled) {
-			regulator_enable(bci->usb_reg);
-			bci->usb_enabled = 1;
+			if (regulator_enable(bci->usb_reg) == 0)
+				bci->usb_enabled = 1;
 		}
 
 		/* forcing the field BCIAUTOUSB (BOOT_BCI[1]) to 1 */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130506/119fb117/attachment.sig>
