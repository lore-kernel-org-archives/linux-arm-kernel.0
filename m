From: will.deacon@arm.com (Will Deacon)
Date: Tue,  6 Mar 2012 16:54:02 +0000
Subject: [PATCH 2/6] kexec: crash: don't save swapper_pg_dir for !CONFIG_MMU
 configurations
In-Reply-To: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
References: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
Message-ID: <1331052846-19144-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nommu platforms don't have very interesting swapper_pg_dir pointers and
usually just #define them to NULL, meaning that we can't include them in
the vmcoreinfo on the kexec crash path.

This patch only saves the swapper_pg_dir if we have an MMU.

Reviewed-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/kexec.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 7b08867..cb5d13c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1462,7 +1462,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 
 	VMCOREINFO_SYMBOL(init_uts_ns);
 	VMCOREINFO_SYMBOL(node_online_map);
+#ifdef CONFIG_MMU
 	VMCOREINFO_SYMBOL(swapper_pg_dir);
+#endif
 	VMCOREINFO_SYMBOL(_stext);
 	VMCOREINFO_SYMBOL(vmlist);
 
-- 
1.7.4.1
