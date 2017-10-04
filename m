From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Wed, 4 Oct 2017 20:56:44 +0200
Subject: [PATCH 1/3] firmware: arm_scpi: improve struct dvfs_info to make code
 better readable
Message-ID: <16d1cd8c-e124-cc94-ca29-d7cb04ff26d9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Making the header subfields members of struct dvfs_info allows to make
the code better readable and avoids some macro magic.

In addition remove a useless statement using info->latency.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/firmware/arm_scpi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index f713a64c..412f1c4c 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -72,8 +72,6 @@
 
 #define MAX_DVFS_DOMAINS	8
 #define MAX_DVFS_OPPS		16
-#define DVFS_LATENCY(hdr)	(le32_to_cpu(hdr) >> 16)
-#define DVFS_OPP_COUNT(hdr)	((le32_to_cpu(hdr) >> 8) & 0xff)
 
 #define PROTOCOL_REV_MINOR_BITS	16
 #define PROTOCOL_REV_MINOR_MASK	((1U << PROTOCOL_REV_MINOR_BITS) - 1)
@@ -328,7 +326,9 @@ struct legacy_clk_set_value {
 } __packed;
 
 struct dvfs_info {
-	__le32 header;
+	u8 domain;
+	u8 opp_count;
+	__le16 latency;
 	struct {
 		__le32 freq;
 		__le32 m_volt;
@@ -667,8 +667,8 @@ static int scpi_dvfs_populate_info(struct device *dev, u8 domain)
 	if (!info)
 		return -ENOMEM;
 
-	info->count = DVFS_OPP_COUNT(buf.header);
-	info->latency = DVFS_LATENCY(buf.header) * 1000; /* uS to nS */
+	info->count = buf.opp_count;
+	info->latency = le16_to_cpu(buf.latency) * 1000; /* uS to nS */
 
 	info->opps = devm_kcalloc(dev, info->count, sizeof(*opp), GFP_KERNEL);
 	if (!info->opps)
@@ -721,9 +721,6 @@ static int scpi_dvfs_get_transition_latency(struct device *dev)
 	if (IS_ERR(info))
 		return PTR_ERR(info);
 
-	if (!info->latency)
-		return 0;
-
 	return info->latency;
 }
 
-- 
2.14.2
