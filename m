From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Thu, 12 Jul 2018 11:28:24 +0200
Subject: [PATCH 3/3] ARM: hisi: handle of_iomap and fix missing of_node_put
In-Reply-To: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
References: <1531387704-13265-1-git-send-email-hofrat@osadl.org>
Message-ID: <1531387704-13265-4-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Relying on an unchecked of_iomap() which can return NULL is problematic
here, an explicit check seems mandatory. Also the call to
of_find_compatible_node() returns a device node with refcount incremented
therefor an explicit of_node_put() is needed here. 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit 22bae4290457 ("ARM: hi3xxx: add hotplug support")
---

Problem found by an experimental coccinelle script

The way  id  is used is a bit redundant with the function return - not
really clear if this "double indication" is intentional or just happened ?
Also note that hi3xxx_hotplug_init probably should be bool as that is how
it is being used - the error return is not actually interpreted beyond
detection of failure in its only call site hi3xxx_set_cpu().

Patch was compile tested with: hisi_defconfig (implies CONFIG_SMP=y)

Patch is against 4.18-rc3 (localversion-next is next-20180712)

 arch/arm/mach-hisi/hotplug.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index 40857bf..4036ffe 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -148,13 +148,20 @@ static int hi3xxx_hotplug_init(void)
 	struct device_node *node;
 
 	node = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
-	if (node) {
-		ctrl_base = of_iomap(node, 0);
-		id = HI3620_CTRL;
-		return 0;
+	if (!node) {
+		id = ERROR_CTRL;
+		return -ENOENT;
 	}
-	id = ERROR_CTRL;
-	return -ENOENT;
+
+	ctrl_base = of_iomap(node, 0);
+	of_node_put(node);
+	if (!ctrl_base) {
+		id = ERROR_CTRL;
+		return -ENOMEM;
+	}
+
+	id = HI3620_CTRL;
+	return 0;
 }
 
 void hi3xxx_set_cpu(int cpu, bool enable)
-- 
2.1.4
