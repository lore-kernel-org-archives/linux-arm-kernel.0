From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Fri, 15 Jun 2018 14:28:08 +0200
Subject: [PATCH] ARM: add missing of_node_put()
Message-ID: <1529065688-2692-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 The call to of_find_compatible_node() returns a node pointer with refcount
incremented thus it must be explicitly decremented here after the last
usage. (see drivers/of/base.c:of_find_compatible_node())

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with an experimental coccinelle script

Patch was compile tested with: axm55xx_defconfig
(with some sparse warnings - not related to the proposed change though)

Patch is against 4.17.0 (localversion-next is next-20180614)

 arch/arm/mach-axxia/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
index 502e3df..c706a11 100644
--- a/arch/arm/mach-axxia/platsmp.c
+++ b/arch/arm/mach-axxia/platsmp.c
@@ -40,10 +40,11 @@ static int axxia_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	syscon_np = of_find_compatible_node(NULL, NULL, "lsi,axxia-syscon");
 	if (!syscon_np)
 		return -ENOENT;
 
 	syscon = of_iomap(syscon_np, 0);
+	of_node_put(syscon_np);
 	if (!syscon)
 		return -ENOMEM;
 
 	tmp = readl(syscon + SC_RST_CPU_HOLD);
 	writel(0xab, syscon + SC_CRIT_WRITE_KEY);
-- 
2.1.4
