From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 16:14:06 +0100
Subject: [PATCH] [media] dvbdev: avoid unused functions
Message-ID: <1622537.sJciORk4kT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dvb_create_tsout_entity and dvb_create_media_entity
functions are only called if CONFIG_MEDIA_CONTROLLER_DVB is
enabled, otherwise we get a compiler warning:

dvb-core/dvbdev.c:219:12: warning: 'dvb_create_tsout_entity' defined but not used [-Wunused-function]
dvb-core/dvbdev.c:264:12: warning: 'dvb_create_media_entity' defined but not used [-Wunused-function]

This moves the #ifdef inside of the two functions to the
outside, to avoid the two warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index b56e00817d3f..860dd7d06b60 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -216,10 +216,10 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
 #endif
 }
 
+#if defined(CONFIG_MEDIA_CONTROLLER_DVB)
 static int dvb_create_tsout_entity(struct dvb_device *dvbdev,
 				    const char *name, int npads)
 {
-#if defined(CONFIG_MEDIA_CONTROLLER_DVB)
 	int i, ret = 0;
 
 	dvbdev->tsout_pads = kcalloc(npads, sizeof(*dvbdev->tsout_pads),
@@ -254,7 +254,6 @@ static int dvb_create_tsout_entity(struct dvb_device *dvbdev,
 		if (ret < 0)
 			return ret;
 	}
-#endif
 	return 0;
 }
 
@@ -264,7 +263,6 @@ static int dvb_create_tsout_entity(struct dvb_device *dvbdev,
 static int dvb_create_media_entity(struct dvb_device *dvbdev,
 				   int type, int demux_sink_pads)
 {
-#if defined(CONFIG_MEDIA_CONTROLLER_DVB)
 	int i, ret, npads;
 
 	switch (type) {
@@ -352,9 +350,9 @@ static int dvb_create_media_entity(struct dvb_device *dvbdev,
 	printk(KERN_DEBUG "%s: media entity '%s' registered.\n",
 		__func__, dvbdev->entity->name);
 
-#endif
 	return 0;
 }
+#endif
 
 static int dvb_register_media_device(struct dvb_device *dvbdev,
 				     int type, int minor,
