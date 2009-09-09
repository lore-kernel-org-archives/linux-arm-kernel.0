From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 9 Sep 2009 09:50:24 +0200
Subject: [patch for 2.6.31] zaurus c3000 aka spitz: fix resume
Message-ID: <20090909075024.GA1400@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Linus!

Spitz resume was broken for year or likely two, and it would be very
nice to fix it for 2.6.31 release. One liner is below, and it really
can not harm. It already is in Eric's fix queue, so pulling that for
.31 should work, too.

Do you think you could take it?
								Pavel

---


sharpsl_pm.c code tries to read battery state very early during
resume, but those battery meters are connected on SPI and that's only
resumed way later.

Replace the check with simple checking of battery fatal signal, that
actually works at this stage.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Stanislav Brabec <utx@penguin.cz>
Acked-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

--- linux-rc/arch/arm.ofic/mach-pxa/sharpsl_pm.c	2009-08-28 00:19:10.000000000 +0200
+++ linux-rc/arch/arm/mach-pxa/sharpsl_pm.c	2009-09-04 11:18:33.000000000 +0200
@@ -678,8 +678,8 @@
 		dev_dbg(sharpsl_pm.dev, "User triggered wakeup in offline charger.\n");
 	}
 
-	if ((!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) || (sharpsl_fatal_check() < 0) )
-	{
+	if ((!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_LOCK)) || 
+	    (!sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_FATAL)))	{
 		dev_err(sharpsl_pm.dev, "Fatal condition. Suspend.\n");
 		corgi_goto_sleep(alarm_time, alarm_enable, state);
 		return 1;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
