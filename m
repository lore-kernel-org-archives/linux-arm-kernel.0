From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Mon,  9 Jul 2018 16:19:19 +0200
Subject: [PATCH v5 4/6] media: v4l2-fwnode: parse 'data-enable-active' prop
In-Reply-To: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1531145962-1540-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1531145962-1540-5-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parse the newly defined 'data-enable-active' property in parallel endpoint
parsing function.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 4 ++++
 include/media/v4l2-mediabus.h         | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 3f77aa3..6105191 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -154,6 +154,10 @@ static void v4l2_fwnode_endpoint_parse_parallel_bus(
 		flags |= v ? V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH :
 			V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW;

+	if (!fwnode_property_read_u32(fwnode, "data-enable-active", &v))
+		flags |= v ? V4L2_MBUS_DATA_ENABLE_HIGH :
+			V4L2_MBUS_DATA_ENABLE_LOW;
+
 	bus->flags = flags;

 }
diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
index 4d8626c..4bbb5f3 100644
--- a/include/media/v4l2-mediabus.h
+++ b/include/media/v4l2-mediabus.h
@@ -45,6 +45,8 @@
 /* Active state of Sync-on-green (SoG) signal, 0/1 for LOW/HIGH respectively. */
 #define V4L2_MBUS_VIDEO_SOG_ACTIVE_HIGH		BIT(12)
 #define V4L2_MBUS_VIDEO_SOG_ACTIVE_LOW		BIT(13)
+#define V4L2_MBUS_DATA_ENABLE_HIGH		BIT(14)
+#define V4L2_MBUS_DATA_ENABLE_LOW		BIT(15)

 /* Serial flags */
 /* How many lanes the client can use */
--
2.7.4
