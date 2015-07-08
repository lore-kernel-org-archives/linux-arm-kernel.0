From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Wed, 8 Jul 2015 14:27:46 +0300
Subject: [PATCH 3/5] host1x: Handle HOST1X class address registers directly
In-Reply-To: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
References: <1436354868-24309-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1436354868-24309-4-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves handling of address registers in the HOST1X class directly
to the firewall code in host1x's job.c, so that individual clients don't
have to replicate this code. The list of address registers detected also
change from INDCTRL which is not actually an address register to INDOFF
and INDOFF2 which are.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 21 ++++++---------------
 drivers/gpu/drm/tegra/gr3d.c | 20 ++++++--------------
 drivers/gpu/host1x/job.c     | 12 +++++++++++-
 3 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 7e4424f..f048d45 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -88,23 +88,14 @@ static int gr2d_is_addr_reg(struct device *dev, u32 class, u32 offset, u32 val)
 {
 	struct gr2d *gr2d = dev_get_drvdata(dev);
 
-	switch (class) {
-	case HOST1X_CLASS_HOST1X:
-		if (offset == 0x2b)
-			return 1;
+	if (class != HOST1X_CLASS_GR2D && class != HOST1X_CLASS_GR2D_SB)
+		return 0;
 
-		break;
+	if (offset >= GR2D_NUM_REGS)
+		return 0;
 
-	case HOST1X_CLASS_GR2D:
-	case HOST1X_CLASS_GR2D_SB:
-		if (offset >= GR2D_NUM_REGS)
-			break;
-
-		if (test_bit(offset, gr2d->addr_regs))
-			return 1;
-
-		break;
-	}
+	if (test_bit(offset, gr2d->addr_regs))
+		return 1;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 9ceaf35..d0dab15 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -98,22 +98,14 @@ static int gr3d_is_addr_reg(struct device *dev, u32 class, u32 offset, u32 val)
 {
 	struct gr3d *gr3d = dev_get_drvdata(dev);
 
-	switch (class) {
-	case HOST1X_CLASS_HOST1X:
-		if (offset == 0x2b)
-			return 1;
+	if (class != HOST1X_CLASS_GR3D)
+		return 0;
 
-		break;
+	if (offset >= GR3D_NUM_REGS)
+		return 0;
 
-	case HOST1X_CLASS_GR3D:
-		if (offset >= GR3D_NUM_REGS)
-			break;
-
-		if (test_bit(offset, gr3d->addr_regs))
-			return 1;
-
-		break;
-	}
+	if (test_bit(offset, gr3d->addr_regs))
+		return 1;
 
 	return 0;
 }
diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 77d977b..0701008 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -295,10 +295,20 @@ struct host1x_firewall {
 	u32 count;
 };
 
+static int is_addr_reg(struct host1x_firewall *fw, unsigned long offset,
+		       u32 val)
+{
+	if (fw->class == HOST1X_CLASS_HOST1X &&
+		(offset == 0x2c /* INDOFF2 */ || offset == 0x2d /* INDOFF */))
+		return true;
+
+	return fw->job->is_addr_reg(fw->dev, fw->class, offset, val);
+}
+
 static int check_register(struct host1x_firewall *fw,
 			  unsigned long offset, u32 val)
 {
-	if (fw->job->is_addr_reg(fw->dev, fw->class, offset, val)) {
+	if (is_addr_reg(fw, offset, val)) {
 		if (!fw->num_relocs)
 			return -EINVAL;
 
-- 
2.1.4
