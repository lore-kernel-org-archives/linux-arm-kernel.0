From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:10:19 +0100
Subject: [PATCH 1/6] ARM: vexpress: determine active tile site before reading
	tile ID
In-Reply-To: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
References: <1312823424-9654-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823424-9654-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Versatile Express platform features two tile sites and communicates
the active tile site via the SYS_MISC register on the motherboard.

This patch updates the tile detection code to read the ID for the
currently active tile during boot.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-vexpress/include/mach/motherboard.h |    5 +++++
 arch/arm/mach-vexpress/v2m.c                      |    6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/include/mach/motherboard.h b/arch/arm/mach-vexpress/include/mach/motherboard.h
index 0a3a375..163a22c 100644
--- a/arch/arm/mach-vexpress/include/mach/motherboard.h
+++ b/arch/arm/mach-vexpress/include/mach/motherboard.h
@@ -119,6 +119,11 @@ int v2m_cfg_write(u32 devfn, u32 data);
 int v2m_cfg_read(u32 devfn, u32 *data);
 
 /*
+ * Miscellaneous
+ */
+#define SYS_MISC_MASTERSITE	(1 << 14)
+
+/*
  * Core tile IDs
  */
 #define V2M_CT_ID_CA9		0x0c000191
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 9e6b93b..dbb182c 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -389,10 +389,12 @@ static struct ct_desc *ct_descs[] __initdata = {
 static void __init v2m_populate_ct_desc(void)
 {
 	int i;
-	u32 current_tile_id;
+	u32 procid_reg, current_tile_id;
 
 	ct_desc = NULL;
-	current_tile_id = readl(MMIO_P2V(V2M_SYS_PROCID0)) & V2M_CT_ID_MASK;
+	procid_reg = readl(MMIO_P2V(V2M_SYS_MISC)) & SYS_MISC_MASTERSITE ?
+			V2M_SYS_PROCID1 : V2M_SYS_PROCID0;
+	current_tile_id = readl(MMIO_P2V(procid_reg)) & V2M_CT_ID_MASK;
 
 	for (i = 0; i < ARRAY_SIZE(ct_descs) && !ct_desc; ++i)
 		if (ct_descs[i]->id == current_tile_id)
-- 
1.7.0.4
