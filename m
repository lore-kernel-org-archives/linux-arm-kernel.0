From: nm@ti.com (Nishanth Menon)
Date: Fri, 1 Apr 2016 17:53:07 -0500
Subject: [PATCH 3/3] ARM: OMAP: Catch callers of revision information prior to
 it being populated
In-Reply-To: <1459551187-5992-1-git-send-email-nm@ti.com>
References: <1459551187-5992-1-git-send-email-nm@ti.com>
Message-ID: <1459551187-5992-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_rev is used to detect various SoC types, however any misuse of
the usage by invoking it earlier than it being populated will result
in invalid results. Lets flag them as early as possible to prevent
unintended side effects taking place. We get 0 if it is uninitialized
and -1 when detection is done using device tree (as the case was for
DRA7 as the case was prior to commit 06c2d368fc36 ("ARM: OMAP: DRA7:
Make use of omap_revision information for soc_is* calls")

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap1/id.c | 1 +
 arch/arm/mach-omap2/id.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 52de382fc804..bfabc065d331 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -65,6 +65,7 @@ static struct omap_id omap_ids[] __initdata = {
 
 unsigned int omap_rev(void)
 {
+	WARN_ON_ONCE(!omap_revision || omap_revision == -1);
 	return omap_revision;
 }
 EXPORT_SYMBOL(omap_rev);
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index d85c24918c17..75fb6c006e86 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -46,6 +46,7 @@ u32 omap_features;
 
 unsigned int omap_rev(void)
 {
+	WARN_ON_ONCE(!omap_revision || omap_revision == -1);
 	return omap_revision;
 }
 EXPORT_SYMBOL(omap_rev);
-- 
2.8.0
