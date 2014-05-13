From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 May 2014 12:10:36 +0200
Subject: [PATCHv2 1/4] of: make of_update_property() usable earlier in the
 boot process
In-Reply-To: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399975839-5311-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399975839-5311-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 75b57ecf9d1d1e17d099ab13b8f48e6e038676be ('of: Make device
nodes kobjects so they show up in sysfs') has turned Device Tree nodes
in kobjects and added a sysfs based representation for Device Tree
nodes. Since the sysfs logic is only available after the execution of
a core_initcall(), the patch took precautions in of_add_property() and
of_remove_property() to not do any sysfs related manipulation early in
the boot process.

However, it forgot to do the same for of_update_property(), which if
used early in the boot process (before core_initcalls have been
called), tries to call sysfs_remove_bin_file(), and crashes:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at /home/thomas/projets/linux-2.6/fs/kernfs/dir.c:1216 kernfs_remove_by_name_ns+0x80/0x88()
kernfs: can not remove '(null)', no directory
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.15.0-rc1-00127-g1d7e7b2-dirty #423
[<c0014910>] (unwind_backtrace) from [<c00110ec>] (show_stack+0x10/0x14)
[<c00110ec>] (show_stack) from [<c04c84b8>] (dump_stack+0x84/0x94)
[<c04c84b8>] (dump_stack) from [<c001d8c0>] (warn_slowpath_common+0x6c/0x88)
[<c001d8c0>] (warn_slowpath_common) from [<c001d90c>] (warn_slowpath_fmt+0x30/0x40)
[<c001d90c>] (warn_slowpath_fmt) from [<c0104468>] (kernfs_remove_by_name_ns+0x80/0x88)
[<c0104468>] (kernfs_remove_by_name_ns) from [<c0394d98>] (of_update_property+0xc0/0xf0)
[<c0394d98>] (of_update_property) from [<c0647248>] (mvebu_timer_and_clk_init+0xfc/0x194)
[<c0647248>] (mvebu_timer_and_clk_init) from [<c0640934>] (start_kernel+0x218/0x350)
[<c0640934>] (start_kernel) from [<00008070>] (0x8070)

To fix this problem, we simply skip the sysfs related calls in
of_update_property(), and rely on of_init() to fix up things when it
will be called, exactly as is done in of_add_property() and
of_remove_property().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes: 75b57ecf9d1d1e17d099ab13b8f48e6e038676be ('of: Make device nodes kobjects so they show up in sysfs')
---
 drivers/of/base.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index f72d19b..e981f09 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1831,11 +1831,16 @@ int of_update_property(struct device_node *np, struct property *newprop)
 	if (rc)
 		return rc;
 
+	/* At early boot, bail out and defer setup to of_init() */
+	if (!of_kset)
+		goto skip_sysfs;
+
 	/* Update the sysfs attribute */
 	if (oldprop)
 		sysfs_remove_bin_file(&np->kobj, &oldprop->attr);
 	__of_add_property_sysfs(np, newprop);
 
+ skip_sysfs:
 	if (!found)
 		return -ENODEV;
 
-- 
1.9.2
