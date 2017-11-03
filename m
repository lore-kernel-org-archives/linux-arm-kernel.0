From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 3 Nov 2017 16:26:37 +0200
Subject: [PATCH 3/7] ARM: OMAP2+: hwmod: fix clkctrl address translation logic
In-Reply-To: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
References: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
Message-ID: <1509719201-32700-4-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?There are cases where clkctrl clock offsets do not match the corresponding
clockdomain, and this case the existing mapping functionality will fail.
Fix this by adding the whole address range for a clkctrl provider and
matching the actual clkctrl registers against these ranges.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 72 +++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2dbd632..bb7c745 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -185,15 +185,15 @@
 /**
  * struct clkctrl_provider - clkctrl provider mapping data
  * @addr: base address for the provider
- * @offset: base offset for the provider
- * @clkdm: base clockdomain for provider
+ * @size: size of the provider address space
+ * @offset: offset of the provider from PRCM instance base
  * @node: device node associated with the provider
  * @link: list link
  */
 struct clkctrl_provider {
 	u32			addr;
+	u32			size;
 	u16			offset;
-	struct clockdomain	*clkdm;
 	struct device_node	*node;
 	struct list_head	link;
 };
@@ -223,8 +223,7 @@ struct omap_hwmod_soc_ops {
 	void (*update_context_lost)(struct omap_hwmod *oh);
 	int (*get_context_lost)(struct omap_hwmod *oh);
 	int (*disable_direct_prcm)(struct omap_hwmod *oh);
-	u32 (*xlate_clkctrl)(struct omap_hwmod *oh,
-			     struct clkctrl_provider *provider);
+	u32 (*xlate_clkctrl)(struct omap_hwmod *oh);
 };
 
 /* soc_ops: adapts the omap_hwmod code to the currently-booted SoC */
@@ -716,45 +715,28 @@ static int _del_initiator_dep(struct omap_hwmod *oh, struct omap_hwmod *init_oh)
 	{ }
 };
 
-static int _match_clkdm(struct clockdomain *clkdm, void *user)
-{
-	struct clkctrl_provider *provider = user;
-
-	if (clkdm_xlate_address(clkdm) == provider->addr) {
-		pr_debug("%s: Matched clkdm %s for addr %x (%s)\n", __func__,
-			 clkdm->name, provider->addr,
-			 provider->node->parent->name);
-		provider->clkdm = clkdm;
-
-		return -1;
-	}
-
-	return 0;
-}
-
 static int _setup_clkctrl_provider(struct device_node *np)
 {
 	const __be32 *addrp;
 	struct clkctrl_provider *provider;
+	u64 size;
 
 	provider = memblock_virt_alloc(sizeof(*provider), 0);
 	if (!provider)
 		return -ENOMEM;
 
-	addrp = of_get_address(np, 0, NULL, NULL);
+	addrp = of_get_address(np, 0, &size, NULL);
 	provider->addr = (u32)of_translate_address(np, addrp);
-	provider->offset = provider->addr & 0xff;
+	addrp = of_get_address(np->parent, 0, NULL, NULL);
+	provider->offset = provider->addr -
+			   (u32)of_translate_address(np->parent, addrp);
 	provider->addr &= ~0xff;
+	provider->size = size | 0xff;
 	provider->node = np;
 
-	clkdm_for_each(_match_clkdm, provider);
-
-	if (!provider->clkdm) {
-		pr_err("%s: nothing matched for node %s (%x)\n",
-		       __func__, np->parent->name, provider->addr);
-		memblock_free_early(__pa(provider), sizeof(*provider));
-		return -EINVAL;
-	}
+	pr_debug("%s: %s: %x...%x [+%x]\n", __func__, np->parent->name,
+		 provider->addr, provider->addr + provider->size,
+		 provider->offset);
 
 	list_add(&provider->link, &clkctrl_providers);
 
@@ -775,32 +757,48 @@ static int _init_clkctrl_providers(void)
 	return ret;
 }
 
-static u32 _omap4_xlate_clkctrl(struct omap_hwmod *oh,
-				struct clkctrl_provider *provider)
+static u32 _omap4_xlate_clkctrl(struct omap_hwmod *oh)
 {
-	return oh->prcm.omap4.clkctrl_offs -
-	       provider->offset - provider->clkdm->clkdm_offs;
+	if (!oh->prcm.omap4.modulemode)
+		return 0;
+
+	return omap_cm_xlate_clkctrl(oh->clkdm->prcm_partition,
+				     oh->clkdm->cm_inst,
+				     oh->prcm.omap4.clkctrl_offs);
 }
 
 static struct clk *_lookup_clkctrl_clk(struct omap_hwmod *oh)
 {
 	struct clkctrl_provider *provider;
 	struct clk *clk;
+	u32 addr;
 
 	if (!soc_ops.xlate_clkctrl)
 		return NULL;
 
+	addr = soc_ops.xlate_clkctrl(oh);
+	if (!addr)
+		return NULL;
+
+	pr_debug("%s: %s: addr=%x\n", __func__, oh->name, addr);
+
 	list_for_each_entry(provider, &clkctrl_providers, link) {
-		if (provider->clkdm == oh->clkdm) {
+		if (provider->addr <= addr &&
+		    provider->addr + provider->size >= addr) {
 			struct of_phandle_args clkspec;
 
 			clkspec.np = provider->node;
 			clkspec.args_count = 2;
-			clkspec.args[0] = soc_ops.xlate_clkctrl(oh, provider);
+			clkspec.args[0] = addr - provider->addr -
+					  provider->offset;
 			clkspec.args[1] = 0;
 
 			clk = of_clk_get_from_provider(&clkspec);
 
+			pr_debug("%s: %s got %p (offset=%x, provider=%s)\n",
+				 __func__, oh->name, clk, clkspec.args[0],
+				 provider->node->parent->name);
+
 			return clk;
 		}
 	}
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
