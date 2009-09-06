From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 6 Sep 2009 08:19:45 +0200
Subject: zaurus c3000 aka spitz: fix resume (fwd)
Message-ID: <20090906061934.GA1822@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maillist rejected it, reposting...

(Could we get slightly higher limit on #of recipients for lakml?)
								Pavel

----- Forwarded message from Pavel Machek <pavel@ucw.cz> -----

From: Pavel Machek <pavel@ucw.cz>
To: rpurdie at rpsys.net, lenz at cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>, Dirk at Opfer-Online.de,
	arminlitzel at web.de, Cyril Hrubis <metan@ucw.cz>,
	thommycheck at gmail.com,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	dbaryshkov at gmail.com, omegamoon at gmail.com, eric.miao at marvell.com,
	utx at penguin.cz, Russell King <rmk@arm.linux.org.uk>
Subject: zaurus c3000 aka spitz: fix resume


sharpsl_pm.c code tries to read battery state very early during
resume, but those battery meters are connected on SPI and that's only
resumed way later.

Replace the check with simple checking of battery fatal signal, that
actually works at this stage.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

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

----- End forwarded message -----

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
