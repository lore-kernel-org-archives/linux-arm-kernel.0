From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 15:56:34 +0100
Subject: [PATCH] HID: hid-gfrm: avoid warning for input_configured API change
Message-ID: <14835877.IL6ArpWV8Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The input_configured callback was recently changed to return
an 'int', but the newly added driver uses the old API:

drivers/hid/hid-gfrm.c:151:22: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]

This changes the driver like the other ones.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 34fc1322e7aa ("HID: hid-gfrm: Google Fiber TV Box remote controls")
Fixes: b2c68a2f1bab ("HID: hid-input: allow input_configured callback return errors")
---
Found on ARM allmodconfig with yesterday's linux-next

diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
index 4d7b7e7f0792..075b1c020846 100644
--- a/drivers/hid/hid-gfrm.c
+++ b/drivers/hid/hid-gfrm.c
@@ -88,7 +88,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return (ret < 0) ? ret : -1;
 }
 
-static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
+static int gfrm_input_configured(struct hid_device *hid, struct hid_input *hidinput)
 {
 	/*
 	 * Enable software autorepeat with:
@@ -96,6 +96,7 @@ static void gfrm_input_configured(struct hid_device *hid, struct hid_input *hidi
 	 * - repeat period: 100 msec
 	 */
 	input_enable_softrepeat(hidinput->input, 400, 100);
+	return 0;
 }
 
 static int gfrm_probe(struct hid_device *hdev, const struct hid_device_id *id)
