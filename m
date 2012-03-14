From: marc@cpdesign.com.au (Marc Reilly)
Date: Thu, 15 Mar 2012 07:43:06 +1100
Subject: [PATCH v3 2/6] regmap: Add support for device with 24 data bits.
In-Reply-To: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
Message-ID: <1331757790-10583-3-git-send-email-marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for devices with 24 data bits.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/base/regmap/regmap.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 62ef0df..880e3a0 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -122,6 +122,15 @@ static void regmap_format_16(void *buf, unsigned int val)
 	b[0] = cpu_to_be16(val);
 }
 
+static void regmap_format_24(void *buf, unsigned int val)
+{
+	u8 *b = buf;
+
+	b[0] = val >> 16;
+	b[1] = val >> 8;
+	b[2] = val;
+}
+
 static unsigned int regmap_parse_8(void *buf)
 {
 	u8 *b = buf;
@@ -138,6 +147,16 @@ static unsigned int regmap_parse_16(void *buf)
 	return b[0];
 }
 
+static unsigned int regmap_parse_24(void *buf)
+{
+	u8 *b = buf;
+	unsigned int ret = b[2];
+	ret |= ((unsigned int)b[1]) << 8;
+	ret |= ((unsigned int)b[0]) << 16;
+
+	return ret;
+}
+
 /**
  * regmap_init(): Initialise register map
  *
@@ -240,6 +259,10 @@ struct regmap *regmap_init(struct device *dev,
 		map->format.format_val = regmap_format_16;
 		map->format.parse_val = regmap_parse_16;
 		break;
+	case 24:
+		map->format.format_val = regmap_format_24;
+		map->format.parse_val = regmap_parse_24;
+		break;
 	}
 
 	if (!map->format.format_write &&
-- 
1.7.3.4
