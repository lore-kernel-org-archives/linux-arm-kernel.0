From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 19 Oct 2009 23:37:52 +0200
Subject: spitz backlight: fix brightness limiting
Message-ID: <20091019213751.GC1482@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On spitz (& similar) machines, if battery is running low, backlight
needs to be limited to lower step. Unfortunately, current code uses &=
for limiting, turning backlight off completely for some backlight
settings. Fix that.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- linux-rc/drivers/video/backlight/corgi_lcd.c	2009-10-18 18:11:36.000000000 +0200
+++ linux-rc/drivers/video/backlight/corgi_lcd.c	2009-10-16 02:10:13.000000000 +0200
@@ -433,8 +434,9 @@
 
 	if (corgibl_flags & CORGIBL_SUSPENDED)
 		intensity = 0;
-	if (corgibl_flags & CORGIBL_BATTLOW)
-		intensity &= lcd->limit_mask;
+
+	if ((corgibl_flags & CORGIBL_BATTLOW) && intensity > lcd->limit_mask)
+		intensity = lcd->limit_mask;
 
 	return corgi_bl_set_intensity(lcd, intensity);
 }


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
