From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Thu, 12 Jul 2018 11:28:23 +0200
Subject: [PATCH 2/3] ARM: hisi: check of_iomap and fix missing of_node_put
In-Reply-To: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
References: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
Message-ID: <1531387704-13265-3-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_find_compatible_node() returns a device node with refcount incremented
and thus needs an explicit of_node_put(). Further relying on an unchecked
of_iomap() which can return NULL is problematic here, after all ctrl_base
is critical enough for hix5hd2_set_cpu() to call BUG() if not available
so a check seems mandated here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
0002 Fixes: commit 06cc5c1d4d73 ("ARM: hisi: enable hix5hd2 SoC")
---
Problem found by an experimental coccinelle script

Patch was compile tested with: hisi_defconfig (implies CONFIG_SMP=y)

Patch is against 4.18-rc3 (localversion-next is next-20180712)

 arch/arm/mach-hisi/hotplug.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 3b0d1c6..40857bf 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -173,11 +173,15 @@ static bool hix5hd2_hotplug_init(void)
 	struct device_node *np;
 
 	np = of_find_compatible_node(NULL, NULL, "hisilicon,cpuctrl");
-	if (np) {
-		ctrl_base = of_iomap(np, 0);
-		return true;
-	}
-	return false;
+	if (!np)
+		return false;
+
+	ctrl_base = of_iomap(np, 0);
+	of_node_put(np);
+	if (!ctrl_base)
+		return false;
+
+	return true;
 }
 
 void hix5hd2_set_cpu(int cpu, bool enable)
-- 
2.1.4
