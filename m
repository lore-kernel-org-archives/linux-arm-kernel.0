From: opendmb@gmail.com (Doug Berger)
Date: Tue, 28 Mar 2017 14:34:26 -0700
Subject: [PATCH v2 3/8] bus: brcmstb_gisb: Use register offsets with writes too
In-Reply-To: <20170328213431.10904-1-opendmb@gmail.com>
References: <20170328213431.10904-1-opendmb@gmail.com>
Message-ID: <20170328213431.10904-4-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit corrects the bug introduced in commit f80835875d3d
("bus: brcmstb_gisb: Look up register offsets in a table") such
that gisb_write() translates the register enumeration into an
offset from the base address for writes as well as reads.

Fixes: f80835875d3d ("bus: brcmstb_gisb: Look up register offsets in a table")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 72fe0a5a8bf3..a94598d0945a 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2014 Broadcom Corporation
+ * Copyright (C) 2014-2017 Broadcom
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -127,9 +127,9 @@ static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
 		return;
 
 	if (gdev->big_endian)
-		iowrite32be(val, gdev->base + reg);
+		iowrite32be(val, gdev->base + offset);
 	else
-		iowrite32(val, gdev->base + reg);
+		iowrite32(val, gdev->base + offset);
 }
 
 static ssize_t gisb_arb_get_timeout(struct device *dev,
-- 
2.12.0
