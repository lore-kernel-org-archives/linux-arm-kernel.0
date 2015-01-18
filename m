From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 18 Jan 2015 21:24:47 +0100
Subject: [PATCHv2] ti-soc-thermal: request temperature periodically if hw
 can't do that itself
In-Reply-To: <20150103114632.GA21883@amd>
References: <20150103114632.GA21883@amd>
Message-ID: <20150118202447.GA29014@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


When periodic mode is not enabled, it is neccessary to force reads.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 634b6ce..2fde78c 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -43,6 +43,8 @@
 
 #include "ti-bandgap.h"
 
+static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
+
 /***   Helper functions to access registers and their bitfields   ***/
 
 /**
@@ -852,14 +831,21 @@ int ti_bandgap_read_temperature(struct ti_bandgap *bgp, int id,
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

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
