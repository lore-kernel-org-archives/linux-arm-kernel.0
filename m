From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Jan 2015 12:46:32 +0100
Subject: [PATCH] ti-soc-thermal: implement eocz bit to make driver useful on
 omap3
Message-ID: <20150103114632.GA21883@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For omap3, proper implementation of eocz bit is needed. It was
actually a TODO in the driver.

When periodic mode is not enabled, it is neccessary to force reads.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 634b6ce..ee63d08 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -43,6 +43,8 @@
 
 #include "ti-bandgap.h"
 
+static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
+
 /***   Helper functions to access registers and their bitfields   ***/
 
 /**
@@ -852,14 +831,20 @@ int ti_bandgap_read_temperature(struct ti_bandgap *bgp, int id,
 	if (ret)
 		return ret;
 
+	if (!TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
+		ret = ti_bandgap_force_single_read(bgp, id);
+		if (ret)
+			return ret;
+	}
+
 	spin_lock(&bgp->lock);
 	temp = ti_bandgap_read_temp(bgp, id);
 	spin_unlock(&bgp->lock);
 
-	ret |= ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
+	ret = ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
 	if (ret)
 		return -EIO;
 
 	*temperature = temp;
 
 	return 0;
@@ -917,7 +903,8 @@ void *ti_bandgap_get_sensor_data(struct ti_bandgap *bgp, int id)
 static int
 ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 {
-	u32 temp = 0, counter = 1000;
+	u32 counter = 1000;
+	struct temp_sensor_registers *tsr;
 
 	/* Select single conversion mode */
 	if (TI_BANDGAP_HAS(bgp, MODE_CONFIG))
@@ -925,16 +912,27 @@ ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id)
 
 	/* Start of Conversion = 1 */
 	RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 1);
-	/* Wait until DTEMP is updated */
-	temp = ti_bandgap_read_temp(bgp, id);
 
-	while ((temp == 0) && --counter)
-		temp = ti_bandgap_read_temp(bgp, id);
-	/* REVISIT: Check correct condition for end of conversion */
+	/* Wait for EOCZ going up */
+	tsr = bgp->conf->sensors[id].registers;
+
+	while (--counter) {
+		if (ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
+		    tsr->bgap_eocz_mask)
+			break;
+	}
 
 	/* Start of Conversion = 0 */
 	RMW_BITS(bgp, id, temp_sensor_ctrl, bgap_soc_mask, 0);
 
+	/* Wait for EOCZ going down */
+	counter = 1000;
+	while (--counter) {
+		if (!(ti_bandgap_readl(bgp, tsr->temp_sensor_ctrl) &
+		      tsr->bgap_eocz_mask))
+			break;
+	}
+
 	return 0;
 }
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
