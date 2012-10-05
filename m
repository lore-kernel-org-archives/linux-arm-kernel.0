From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Oct 2012 16:55:21 +0200
Subject: [PATCH 07/16] cgroup: fix warning when building without any subsys
In-Reply-To: <1349448930-23976-1-git-send-email-arnd@arndb.de>
References: <1349448930-23976-1-git-send-email-arnd@arndb.de>
Message-ID: <1349448930-23976-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a configuration where the base cgroup support is enabled but
every single cgroup subsys is turned off, CGROUP_BUILTIN_SUBSYS_COUNT
is zero, which causes the sanity check code in cgroup_load_subsys
to trigger:

       BUG_ON(ss->subsys_id >= CGROUP_BUILTIN_SUBSYS_COUNT);
       BUG_ON(subsys[ss->subsys_id] != ss);

Gcc first confirms that subsys_id cannot be 0 or larger and consequently
warns in the second line.

kernel/cgroup.c: In function 'cgroup_load_subsys':
kernel/cgroup.c:4326:38: warning: array subscript is below array bounds [-Warray-bounds]

Since the subsys_id can never be less than zero, we can just change the
type to an unsigned int, which makes the warning go away.

Found by building ARM cns3420vb_defconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Ben Blum <bblum@andrew.cmu.edu>
---
 include/linux/cgroup.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c90eaa8..26b99df 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -475,7 +475,7 @@ struct cgroup_subsys {
 	void (*post_clone)(struct cgroup *cgrp);
 	void (*bind)(struct cgroup *root);
 
-	int subsys_id;
+	unsigned int subsys_id;
 	int active;
 	int disabled;
 	int early_init;
-- 
1.7.10
