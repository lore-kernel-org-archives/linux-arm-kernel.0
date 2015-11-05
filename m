From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 5 Nov 2015 19:50:52 +0100
Subject: [PATCH 2/2] [media] c8sectpfe: Combine three checks into a single if
 block
In-Reply-To: <563BA3CC.4040709@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <563BA3CC.4040709@users.sourceforge.net>
Message-ID: <563BA50C.4060303@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 5 Nov 2015 19:23:50 +0100

The variable "tsin" was checked three times in a loop iteration of the
c8sectpfe_tuner_unregister_frontend() function.
This implementation detail could be improved by the combination of the
involved statements into a single if block so that this variable will be
checked only once there.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.c
index 07fd6d9..2dfbe8a 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.c
@@ -209,17 +209,18 @@ void c8sectpfe_tuner_unregister_frontend(struct c8sectpfe *c8sectpfe,
 
 		tsin = fei->channel_data[n];
 
-		if (tsin && tsin->frontend) {
-			dvb_unregister_frontend(tsin->frontend);
-			dvb_frontend_detach(tsin->frontend);
-		}
+		if (tsin) {
+			if (tsin->frontend) {
+				dvb_unregister_frontend(tsin->frontend);
+				dvb_frontend_detach(tsin->frontend);
+			}
 
-		if (tsin)
 			i2c_put_adapter(tsin->i2c_adapter);
 
-		if (tsin && tsin->i2c_client) {
-			module_put(tsin->i2c_client->dev.driver->owner);
-			i2c_unregister_device(tsin->i2c_client);
+			if (tsin->i2c_client) {
+				module_put(tsin->i2c_client->dev.driver->owner);
+				i2c_unregister_device(tsin->i2c_client);
+			}
 		}
 	}
 
-- 
2.6.2
