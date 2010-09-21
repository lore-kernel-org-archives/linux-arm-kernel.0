From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Sep 2010 10:34:48 -0600
Subject: [PATCH 06/11] OMAP4: prcm: Add temporarily helper functions for rmw
	and read inside the PRM
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Message-ID: <20100921163447.20258.65346.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

Since OMAP4 is using an absolute address, the current PRM accessors
are not useable.
OMAP4 adaptation for these API are currently ongoing, so define temp
version until the proper ones are defined.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/prcm.c             |   24 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/prcm.h |    2 ++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 96f4616..d4388d3 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -216,6 +216,30 @@ u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
 	return v;
 }
 
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask)
+{
+	u32 v;
+
+	v = __raw_readl(reg);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
+/* Read-modify-write a register in a PRM module. Caller must lock */
+u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg)
+{
+	u32 v;
+
+	v = __raw_readl(reg);
+	v &= ~mask;
+	v |= bits;
+	__raw_writel(v, reg);
+
+	return v;
+}
 /* Read a register in a CM module */
 u32 cm_read_mod_reg(s16 module, u16 idx)
 {
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 9fbd914..ab77442 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -38,6 +38,8 @@ u32 prm_read_mod_reg(s16 module, u16 idx);
 void prm_write_mod_reg(u32 val, s16 module, u16 idx);
 u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+u32 omap4_prm_read_bits_shift(void __iomem *reg, u32 mask);
+u32 omap4_prm_rmw_reg_bits(u32 mask, u32 bits, void __iomem *reg);
 u32 cm_read_mod_reg(s16 module, u16 idx);
 void cm_write_mod_reg(u32 val, s16 module, u16 idx);
 u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
