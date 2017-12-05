From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 5 Dec 2017 23:17:19 +0100
Subject: [PATCH 12/12] firmware: arm_scpi: improve info message for pre-1.0
 firmware
In-Reply-To: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
Message-ID: <587dc762-ab75-e349-87e7-c3ed0c42cd4a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On legacy pre-1.0 firmware versions so far the following message is
printed which may cause some confusion:
SCP Protocol 0.0 Firmware 0.0.0 version

Therefore replace the message with the following if firmware doesn't
provide usable version information:
SCP Protocol legacy pre-1.0 firmware

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index bc7055a6..6d7a6c0a 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -1005,12 +1005,21 @@ static int scpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev_info(dev, "SCP Protocol %lu.%lu Firmware %lu.%lu.%lu version\n",
-		 FIELD_GET(PROTO_REV_MAJOR_MASK, scpi_info->protocol_version),
-		 FIELD_GET(PROTO_REV_MINOR_MASK, scpi_info->protocol_version),
-		 FIELD_GET(FW_REV_MAJOR_MASK, scpi_info->firmware_version),
-		 FIELD_GET(FW_REV_MINOR_MASK, scpi_info->firmware_version),
-		 FIELD_GET(FW_REV_PATCH_MASK, scpi_info->firmware_version));
+	if (scpi_info->is_legacy && !scpi_info->protocol_version &&
+	    !scpi_info->firmware_version)
+		dev_info(dev, "SCP Protocol legacy pre-1.0 firmware\n");
+	else
+		dev_info(dev, "SCP Protocol %lu.%lu Firmware %lu.%lu.%lu version\n",
+			 FIELD_GET(PROTO_REV_MAJOR_MASK,
+				   scpi_info->protocol_version),
+			 FIELD_GET(PROTO_REV_MINOR_MASK,
+				   scpi_info->protocol_version),
+			 FIELD_GET(FW_REV_MAJOR_MASK,
+				   scpi_info->firmware_version),
+			 FIELD_GET(FW_REV_MINOR_MASK,
+				   scpi_info->firmware_version),
+			 FIELD_GET(FW_REV_PATCH_MASK,
+				   scpi_info->firmware_version));
 	scpi_info->scpi_ops = &scpi_ops;
 
 	ret = devm_device_add_groups(dev, versions_groups);
-- 
2.15.1
