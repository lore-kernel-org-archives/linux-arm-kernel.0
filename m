From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Sep 2015 12:00:05 +0200
Subject: [PATCH 2/3] ALSA: hda - Advertise MODALIAS in uevent
In-Reply-To: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
References: <1442484006-9614-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1442484006-9614-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

By setting the MODALIAS variable in uevents, userspace helpers will be
enabled to load modules via the module alias associated with a device.

This information is required to automatically load HDA codec drivers
instead of having to explicitly request the various modules in the HDA
core code.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 sound/hda/hda_bus_type.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
index 89c2711baaaf..5adf24c9f9cc 100644
--- a/sound/hda/hda_bus_type.c
+++ b/sound/hda/hda_bus_type.c
@@ -63,9 +63,21 @@ static int hda_bus_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
+static int hda_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct hdac_device *hdev = dev_to_hdac_dev(dev);
+
+	if (add_uevent_var(env, "MODALIAS=snd-hda-codec-id:%08x",
+			   hdev->vendor_id))
+		return -ENOMEM;
+
+	return 0;
+}
+
 struct bus_type snd_hda_bus_type = {
 	.name = "hdaudio",
 	.match = hda_bus_match,
+	.uevent = hda_uevent,
 };
 EXPORT_SYMBOL_GPL(snd_hda_bus_type);
 
-- 
2.5.0
