From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Fri,  8 Aug 2014 12:07:52 +0200
Subject: [PATCH 11/14] ARM: brcmstb: delete unneeded test before of_node_put
Message-ID: <1407492475-26283-11-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Simplify the error path to avoid calling of_node_put when it is not needed.

The semantic patch that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@

-if (e)
   of_node_put(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/arm/mach-bcm/platsmp-brcmstb.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
index af780e9..c515ea1 100644
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -227,7 +227,7 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 	if (!syscon_np) {
 		pr_err("can't find phandle %s\n", name);
 		rc = -EINVAL;
-		goto cleanup;
+		goto out;
 	}
 
 	cpubiuctrl_block = of_iomap(syscon_np, 0);
@@ -256,9 +256,8 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 	}
 
 cleanup:
-	if (syscon_np)
-		of_node_put(syscon_np);
-
+	of_node_put(syscon_np);
+out:
 	return rc;
 }
 
@@ -274,7 +273,7 @@ static int __init setup_hifcont_regs(struct device_node *np)
 	if (!syscon_np) {
 		pr_err("can't find phandle %s\n", name);
 		rc = -EINVAL;
-		goto cleanup;
+		goto out;
 	}
 
 	hif_cont_block = of_iomap(syscon_np, 0);
@@ -288,9 +287,8 @@ static int __init setup_hifcont_regs(struct device_node *np)
 	hif_cont_reg = 0;
 
 cleanup:
-	if (syscon_np)
-		of_node_put(syscon_np);
-
+	of_node_put(syscon_np);
+out:
 	return rc;
 }
 
