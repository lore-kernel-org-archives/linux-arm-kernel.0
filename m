From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 29 Aug 2016 21:29:36 +0200
Subject: [PATCH v2 1/2] input: touchscreen: silead_gsl1680: Document
 firmware-name, fix implementation
In-Reply-To: <20160829192937.32129-1-hdegoede@redhat.com>
References: <20160829192937.32129-1-hdegoede@redhat.com>
Message-ID: <20160829192937.32129-2-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver has supported touchscreen-fw-name to specify the firmware to
load since it has been merged, but this was omitted from the dt-binding
documentation.

During review of adding touchscreen-fw-name to the binding documentation
it was brought up that there is a standard property name called
"firmware-name" for this, which should be used.

Since there are no users of touchscreen-fw-name yet, this commit
adds documentation of "firmware-name" to the dt-binding documentation
and switches the driver over to use this.

This commit also makes the driver add a "silead/" prefix to the
firmware name from dt before calling request_firmware. That the
firmware files are stored under /lib/firmware/silead under Linux
is an implementation detail and does not belong in devicetree.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt         | 1 +
 drivers/input/touchscreen/silead.c                                   | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
index ad7f41a..b726823 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
@@ -17,6 +17,7 @@ Required properties:
 - touchscreen-size-y	  : See touchscreen.txt
 
 Optional properties:
+- firmware-name		  : File basename (string) for board specific firmware
 - touchscreen-inverted-x  : See touchscreen.txt
 - touchscreen-inverted-y  : See touchscreen.txt
 - touchscreen-swapped-x-y : See touchscreen.txt
diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 3b80f14..7709f5b 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -393,9 +393,10 @@ static void silead_ts_read_props(struct i2c_client *client)
 		data->max_fingers = 5; /* Most devices handle up-to 5 fingers */
 	}
 
-	error = device_property_read_string(dev, "touchscreen-fw-name", &str);
+	error = device_property_read_string(dev, "firmware-name", &str);
 	if (!error)
-		snprintf(data->fw_name, sizeof(data->fw_name), "%s", str);
+		snprintf(data->fw_name, sizeof(data->fw_name),
+			 "silead/%s", str);
 	else
 		dev_dbg(dev, "Firmware file name read error. Using default.");
 }
-- 
2.9.3
