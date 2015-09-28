From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 28 Sep 2015 19:51:20 +0300
Subject: [PATCH 3/4] memory: pl172: add ARM PrimeCell PL176 MPMC support
In-Reply-To: <1443459043-24144-1-git-send-email-vz@mleia.com>
References: <1443459043-24144-1-git-send-email-vz@mleia.com>
Message-ID: <1443459081-24199-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds support of ARM PrimeCell PL176 MPMC.

Static memory configuration of PL175 MPMC is very similar to one found
on PL172 and PL175 controllers, so it is preferred to add its support
into the existing driver. The difference is that PL176 supports up to
10 slave ports (but only 4 of them may be connected to static memory
devices), AHB master bus width cab be 64-bit wide, also NAND devices
can be interfaced.

Similar to PL175 contoller, PL176 has no write buffer enable control
in static memory configuration register, the rest of static memory
configuration bits (with exception of NAND) is the same.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/memory/pl172.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/memory/pl172.c b/drivers/memory/pl172.c
index cb6ebb8..ff57195 100644
--- a/drivers/memory/pl172.c
+++ b/drivers/memory/pl172.c
@@ -192,6 +192,7 @@ static int pl172_parse_cs_config(struct amba_device *adev,
 
 static const char * const pl172_revisions[] = {"r1", "r2", "r2p3", "r2p4"};
 static const char * const pl175_revisions[] = {"r1"};
+static const char * const pl176_revisions[] = {"r0"};
 
 static int pl172_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -207,6 +208,9 @@ static int pl172_probe(struct amba_device *adev, const struct amba_id *id)
 	} else if (amba_part(adev) == 0x175) {
 		if (amba_rev(adev) < ARRAY_SIZE(pl175_revisions))
 			rev = pl175_revisions[amba_rev(adev)];
+	} else if (amba_part(adev) == 0x176) {
+		if (amba_rev(adev) < ARRAY_SIZE(pl176_revisions))
+			rev = pl176_revisions[amba_rev(adev)];
 	}
 
 	dev_info(dev, "ARM PL%x revision %s\n", amba_part(adev), rev);
@@ -293,6 +297,11 @@ static const struct amba_id pl172_ids[] = {
 		.id	= 0x07041175,
 		.mask	= 0x3f0fffff,
 	},
+	/* PrimeCell MPMC PL176 */
+	{
+		.id	= 0x89041176,
+		.mask	= 0xff0fffff,
+	},
 	{ 0, 0 },
 };
 MODULE_DEVICE_TABLE(amba, pl172_ids);
-- 
2.1.4
