From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 31 Aug 2018 18:01:23 +0300
Subject: [PATCH] ARM: omap2+: hwmod_core: improve the support for clkctrl
 clocks
Message-ID: <1535727683-23930-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for split memory ranges for clkctrl providers.
This is necessary to support the coming clockdomain based split of
clkctrl provider ranges, instead of the current CM instance based one.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
Note: This patch can be applied independently, the only hard dependency
with the clkctrl data split is with the DT changes, those must follow
everything else.

 arch/arm/mach-omap2/omap_hwmod.c | 72 ++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 2ceffd8..23819bb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -188,16 +188,16 @@
 
 /**
  * struct clkctrl_provider - clkctrl provider mapping data
- * @addr: base address for the provider
- * @size: size of the provider address space
- * @offset: offset of the provider from PRCM instance base
+ * @num_addrs: number of base address ranges for the provider
+ * @addr: base address(es) for the provider
+ * @size: size(s) of the provider address space(s)
  * @node: device node associated with the provider
  * @link: list link
  */
 struct clkctrl_provider {
-	u32			addr;
-	u32			size;
-	u16			offset;
+	int			num_addrs;
+	u32			*addr;
+	u32			*size;
 	struct device_node	*node;
 	struct list_head	link;
 };
@@ -724,23 +724,34 @@ static int __init _setup_clkctrl_provider(struct device_node *np)
 	const __be32 *addrp;
 	struct clkctrl_provider *provider;
 	u64 size;
+	int i;
 
 	provider = memblock_virt_alloc(sizeof(*provider), 0);
 	if (!provider)
 		return -ENOMEM;
 
-	addrp = of_get_address(np, 0, &size, NULL);
-	provider->addr = (u32)of_translate_address(np, addrp);
-	addrp = of_get_address(np->parent, 0, NULL, NULL);
-	provider->offset = provider->addr -
-			   (u32)of_translate_address(np->parent, addrp);
-	provider->addr &= ~0xff;
-	provider->size = size | 0xff;
 	provider->node = np;
 
-	pr_debug("%s: %s: %x...%x [+%x]\n", __func__, np->parent->name,
-		 provider->addr, provider->addr + provider->size,
-		 provider->offset);
+	provider->num_addrs =
+		of_property_count_elems_of_size(np, "reg", sizeof(u32)) / 2;
+
+	provider->addr =
+		memblock_virt_alloc(sizeof(void *) * provider->num_addrs, 0);
+	if (!provider->addr)
+		return -ENOMEM;
+
+	provider->size =
+		memblock_virt_alloc(sizeof(u32) * provider->num_addrs, 0);
+	if (!provider->size)
+		return -ENOMEM;
+
+	for (i = 0; i < provider->num_addrs; i++) {
+		addrp = of_get_address(np, i, &size, NULL);
+		provider->addr[i] = (u32)of_translate_address(np, addrp);
+		provider->size[i] = size;
+		pr_debug("%s: %pOF: %x...%x\n", __func__, np, provider->addr[i],
+			 provider->addr[i] + provider->size[i]);
+	}
 
 	list_add(&provider->link, &clkctrl_providers);
 
@@ -787,23 +798,26 @@ static struct clk *_lookup_clkctrl_clk(struct omap_hwmod *oh)
 	pr_debug("%s: %s: addr=%x\n", __func__, oh->name, addr);
 
 	list_for_each_entry(provider, &clkctrl_providers, link) {
-		if (provider->addr <= addr &&
-		    provider->addr + provider->size >= addr) {
-			struct of_phandle_args clkspec;
+		int i;
 
-			clkspec.np = provider->node;
-			clkspec.args_count = 2;
-			clkspec.args[0] = addr - provider->addr -
-					  provider->offset;
-			clkspec.args[1] = 0;
+		for (i = 0; i < provider->num_addrs; i++) {
+			if (provider->addr[i] <= addr &&
+			    provider->addr[i] + provider->size[i] > addr) {
+				struct of_phandle_args clkspec;
 
-			clk = of_clk_get_from_provider(&clkspec);
+				clkspec.np = provider->node;
+				clkspec.args_count = 2;
+				clkspec.args[0] = addr - provider->addr[0];
+				clkspec.args[1] = 0;
 
-			pr_debug("%s: %s got %p (offset=%x, provider=%s)\n",
-				 __func__, oh->name, clk, clkspec.args[0],
-				 provider->node->parent->name);
+				clk = of_clk_get_from_provider(&clkspec);
 
-			return clk;
+				pr_debug("%s: %s got %p (offset=%x, provider=%pOF)\n",
+					 __func__, oh->name, clk,
+					 clkspec.args[0], provider->node);
+
+				return clk;
+			}
 		}
 	}
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
