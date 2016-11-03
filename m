From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  2 Nov 2016 22:52:07 -0600
Subject: [PATCH v5 4/8] firmware: arm_scpi: allow firmware with
 get_capabilities not implemented
In-Reply-To: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1478148731-11712-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

On Amlogic SCPI legacy implementation, the GET_CAPABILITIES command is
not supported, failover by using 0.0.0 version.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
[sudeep.holla at arm.com: changed the subject]
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 2982bc7b8c33..902233642bd3 100644
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
