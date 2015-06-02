From: bp@alien8.de (Borislav Petkov)
Date: Tue, 2 Jun 2015 21:10:51 +0200
Subject: [PATCH] edac: xgene: fix cpuid abuse
In-Reply-To: <1433196575-9455-1-git-send-email-lho@apm.com>
References: <1433196575-9455-1-git-send-email-lho@apm.com>
Message-ID: <20150602191051.GE19887@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 04:09:35PM -0600, Loc Ho wrote:
> The new x-gene EDAC driver incorrectly tried to figure out the version of
> one of its IP blocks by looking at the version of the CPU core, which is
> only vagely related.
> 
> This removes the incorrect code and instead uses the version of the IP
> block in the compatible string where it belongs.
> 
> Found using build testing on x86, which does not provide the arm64
> cpuid interface.
> 
> This version is based on Arnd original version.

... and I applied it and restored Arnd's authorship as this is his
patch.

I have added you to the Signed-off-by chain and documented the changes
you did, as such handling should be documented properly in the history
and the path of this patch upstream, see below.

It passes all *config builds on x86 so I'd guess we're ok. Will appear
in linux-next tomorrow, let's see what breaks now. :-)

---
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 1 Jun 2015 16:09:35 -0600
Subject: [PATCH] EDAC, xgene: Fix cpuid abuse

The new x-gene EDAC driver incorrectly tried to figure out the version
of one of its IP blocks by looking at the version of the CPU core, which
is only vagely related.

This removes the incorrect code and instead uses the version of the IP
block in the compatible string where it belongs.

Found using build testing on x86, which does not provide the arm64
cpuid interface.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ Changed subnode to "apm,xgene-edac-pmd-v2", adjusted check. ]
Signed-off-by: Loc Ho <lho@apm.com>
Cc: devicetree at vger.kernel.org
Cc: dougthompson at xmission.com
Cc: ijc+devicetree at hellion.org.uk
Cc: jcm at redhat.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: mark.rutland at arm.com
Cc: mchehab at osg.samsung.com
Cc: patches at apm.com
Cc: robh+dt at kernel.org
Link: http://lkml.kernel.org/r/3195065.IK73o60xya at wuerfel
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 .../devicetree/bindings/edac/apm-xgene-edac.txt    |  3 +-
 drivers/edac/xgene_edac.c                          | 55 ++++------------------
 2 files changed, 10 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
index 480911c38ff9..78edb80002c8 100644
--- a/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
+++ b/Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
@@ -25,7 +25,8 @@ Required properties for memory controller subnode:
 - memory-controller	: Instance number of the memory controller.
 
 Required properties for PMD subnode:
-- compatible		: Shall be "apm,xgene-edac-pmd".
+- compatible		: Shall be "apm,xgene-edac-pmd" or
+                          "apm,xgene-edac-pmd-v2".
 - reg			: First resource shall be the PMD resource.
 - pmd-controller	: Instance number of the PMD controller.
 
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index b5158572f6ab..14636e4b6a08 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -523,6 +523,7 @@ struct xgene_edac_pmd_ctx {
 	struct edac_device_ctl_info *edac_dev;
 	void __iomem		*pmd_csr;
 	u32			pmd;
+	int			version;
 };
 
 static void xgene_edac_pmd_l1_check(struct edac_device_ctl_info *edac_dev,
@@ -784,50 +785,6 @@ static void xgene_edac_pmd_cpu_hw_cfg(struct edac_device_ctl_info *edac_dev,
 	writel(0x00000101, pg_f + MEMERR_CPU_MMUECR_PAGE_OFFSET);
 }
 
-static bool xgene_edac_pmd_l2c_version1(void)
-{
-	/* Check all chips with PMD L2C version 1 HW */
-	#define REVIDR_MINOR_REV(revidr)	((revidr) & 0x00000007)
-
-	switch (MIDR_VARIANT(read_cpuid_id())) {
-	case 0:
-		switch (MIDR_REVISION(read_cpuid_id())) {
-		case 0:
-
-			switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
-			case 1:
-			case 2:
-				return true;
-			};
-			break;
-		case 1:
-			if (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1)) == 1)
-				return true;
-			break;
-		}
-		break;
-	case 1:
-		switch (MIDR_REVISION(read_cpuid_id())) {
-		case 0:
-			switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
-			case 1:
-				return true;
-			};
-			break;
-		case 1:
-			switch (REVIDR_MINOR_REV(read_cpuid(REVIDR_EL1))) {
-			case 1:
-			case 0:
-				return true;
-			};
-			break;
-		}
-		break;
-	}
-
-	return false;
-}
-
 static void xgene_edac_pmd_hw_cfg(struct edac_device_ctl_info *edac_dev)
 {
 	struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
@@ -837,7 +794,7 @@ static void xgene_edac_pmd_hw_cfg(struct edac_device_ctl_info *edac_dev)
 	/* Enable PMD memory error - MEMERR_L2C_L2ECR and L2C_L2RTOCR */
 	writel(0x00000703, pg_e + MEMERR_L2C_L2ECR_PAGE_OFFSET);
 	/* Configure L2C HW request time out feature if supported */
-	if (!xgene_edac_pmd_l2c_version1())
+	if (ctx->version > 1)
 		writel(0x00000119, pg_d + CPUX_L2C_L2RTOCR_PAGE_OFFSET);
 }
 
@@ -956,7 +913,8 @@ static int xgene_edac_pmd_available(u32 efuse, int pmd)
 	return (efuse & (1 << pmd)) ? 0 : 1;
 }
 
-static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np)
+static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np,
+			      int version)
 {
 	struct edac_device_ctl_info *edac_dev;
 	struct xgene_edac_pmd_ctx *ctx;
@@ -998,6 +956,7 @@ static int xgene_edac_pmd_add(struct xgene_edac *edac, struct device_node *np)
 	ctx->edac = edac;
 	ctx->edac_dev = edac_dev;
 	ctx->ddev = *edac->dev;
+	ctx->version = version;
 	edac_dev->dev = &ctx->ddev;
 	edac_dev->ctl_name = ctx->name;
 	edac_dev->dev_name = ctx->name;
@@ -1169,7 +1128,9 @@ static int xgene_edac_probe(struct platform_device *pdev)
 		if (of_device_is_compatible(child, "apm,xgene-edac-mc"))
 			xgene_edac_mc_add(edac, child);
 		if (of_device_is_compatible(child, "apm,xgene-edac-pmd"))
-			xgene_edac_pmd_add(edac, child);
+			xgene_edac_pmd_add(edac, child, 1);
+		if (of_device_is_compatible(child, "apm,xgene-edac-pmd-v2"))
+			xgene_edac_pmd_add(edac, child, 2);
 	}
 
 	return 0;
-- 
2.3.5

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
