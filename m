From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 19 Oct 2016 14:51:09 +0200
Subject: [PATCH v5 2/5] scpi: Do not fail if get_capabilities is not
 implemented
In-Reply-To: <1476881472-13055-1-git-send-email-narmstrong@baylibre.com>
References: <1476881472-13055-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1476881472-13055-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Amlogic SCPI legacy implementation, the GET_CAPABILITIES is not
supported, failover by using 0.0.0 version.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 2982bc7..9022336 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -783,6 +783,10 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
 		info->protocol_version = le32_to_cpu(caps.protocol_version);
 		info->firmware_version = le32_to_cpu(caps.platform_version);
 	}
+	/* Ignore error if not implemented */
+	if (scpi_info->is_legacy && ret == -EOPNOTSUPP)
+		return 0;
+
 	return ret;
 }
 
-- 
1.9.1
