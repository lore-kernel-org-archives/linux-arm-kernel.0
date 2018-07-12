From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Thu, 12 Jul 2018 11:28:22 +0200
Subject: [PATCH 1/3] ARM: hisi: fix error handling and missing of_node_put
In-Reply-To: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
References: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
Message-ID: <1531387704-13265-2-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_iomap() can return NULL which seems critical here and thus should be
explicitly flagged so that the cause of system halting can be understood.
As of_find_compatible_node() is returning a device node with refcount
incremented it must be explicitly decremented here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 7fda91e73155 ("ARM: hisi: enable smp for HiP01")
---

Problem located by experimental coccinelle script

Patch was compile tested with: hisi_defconfig (implies CONFIG_SMP=y)

There are two change related checkpatch warnings about
"WARNING: Avoid crashing the kernel - try using WARN_ON"
but here the BUG_ON() seems adequate.

Patch is against 4.18-rc3 (localversion-next is next-20180712)

 arch/arm/mach-hisi/hotplug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index a129aae..3b0d1c6 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -219,10 +219,10 @@ void hip01_set_cpu(int cpu, bool enable)
 
 	if (!ctrl_base) {
 		np = of_find_compatible_node(NULL, NULL, "hisilicon,hip01-sysctrl");
-		if (np)
-			ctrl_base = of_iomap(np, 0);
-		else
-			BUG();
+		BUG_ON(!np);
+		ctrl_base = of_iomap(np, 0);
+		of_node_put(np);
+		BUG_ON(!ctrl_base);
 	}
 
 	if (enable) {
-- 
2.1.4
