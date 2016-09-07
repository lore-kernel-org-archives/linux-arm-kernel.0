From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  7 Sep 2016 17:34:32 +0200
Subject: [PATCH v3 3/8] scpi: Do not fail if get_capabilities is not
 implemented
In-Reply-To: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
References: <1473262477-18045-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1473262477-18045-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Amlogic SCPI legacy implementation, the GET_CAPABILITIES is not
supported, failover by using 0.0.0 version.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 9ba1020..6a16100 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -891,6 +891,10 @@ static int scpi_init_versions(struct scpi_drvinfo *info)
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
