From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 28 Sep 2015 19:51:19 +0300
Subject: [PATCH 2/4] memory: pl172: add ARM PrimeCell PL175 MPMC support
In-Reply-To: <1443459043-24144-1-git-send-email-vz@mleia.com>
References: <1443459043-24144-1-git-send-email-vz@mleia.com>
Message-ID: <1443459081-24199-2-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds support of ARM PrimeCell PL175 MPMC, the controller is
found on NXP LPC32xx SoC.

PL175 MPMC is very similar to PL172 controller, so it is preferred to
add its support into the existing driver.

One of the differences between PL172 and PL175 is that the latter one
supports up to 6 AHB ports, but still only 4 AHB ports can be assigned
to a static memory device, also PL175 does not have write buffer
enable control in static memory configuration register.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/memory/pl172.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/pl172.c b/drivers/memory/pl172.c
index 95a4ad7..cb6ebb8 100644
--- a/drivers/memory/pl172.c
+++ b/drivers/memory/pl172.c
@@ -118,7 +118,8 @@ static int pl172_setup_static(struct amba_device *adev,
 	if (of_property_read_bool(np, "mpmc,extended-wait"))
 		cfg |= MPMC_STATIC_CFG_EW;
 
-	if (of_property_read_bool(np, "mpmc,buffer-enable"))
+	if (amba_part(adev) == 0x172 &&
+	    of_property_read_bool(np, "mpmc,buffer-enable"))
 		cfg |= MPMC_STATIC_CFG_B;
 
 	if (of_property_read_bool(np, "mpmc,write-protect"))
@@ -190,6 +191,7 @@ static int pl172_parse_cs_config(struct amba_device *adev,
 }
 
 static const char * const pl172_revisions[] = {"r1", "r2", "r2p3", "r2p4"};
+static const char * const pl175_revisions[] = {"r1"};
 
 static int pl172_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -202,6 +204,9 @@ static int pl172_probe(struct amba_device *adev, const struct amba_id *id)
 	if (amba_part(adev) == 0x172) {
 		if (amba_rev(adev) < ARRAY_SIZE(pl172_revisions))
 			rev = pl172_revisions[amba_rev(adev)];
+	} else if (amba_part(adev) == 0x175) {
+		if (amba_rev(adev) < ARRAY_SIZE(pl175_revisions))
+			rev = pl175_revisions[amba_rev(adev)];
 	}
 
 	dev_info(dev, "ARM PL%x revision %s\n", amba_part(adev), rev);
@@ -283,6 +288,11 @@ static const struct amba_id pl172_ids[] = {
 		.id	= 0x07041172,
 		.mask	= 0x3f0fffff,
 	},
+	/* PrimeCell MPMC PL175, EMC found on NXP LPC32xx */
+	{
+		.id	= 0x07041175,
+		.mask	= 0x3f0fffff,
+	},
 	{ 0, 0 },
 };
 MODULE_DEVICE_TABLE(amba, pl172_ids);
-- 
2.1.4
