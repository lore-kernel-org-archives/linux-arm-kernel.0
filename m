From: richard@nod.at (Richard Weinberger)
Date: Sun, 13 Jul 2014 16:58:58 +0200
Subject: [PATCH 2/2] ia64: Remove Linux/x86 domain support
In-Reply-To: <1405263538-27589-1-git-send-email-richard@nod.at>
References: <1405263538-27589-1-git-send-email-richard@nod.at>
Message-ID: <1405263538-27589-3-git-send-email-richard@nod.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ia64 exec domain support seems to be incomplete and unused.
It has no custom handler nor a custom signal map.
All it does is showing up in /proc/execdomains.
Let's rip it out.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/ia64/mm/init.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 25c3502..d4a6b79 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -660,31 +660,6 @@ int arch_remove_memory(u64 start, u64 size)
 #endif
 #endif
 
-/*
- * Even when CONFIG_IA32_SUPPORT is not enabled it is
- * useful to have the Linux/x86 domain registered to
- * avoid an attempted module load when emulators call
- * personality(PER_LINUX32). This saves several milliseconds
- * on each such call.
- */
-static struct exec_domain ia32_exec_domain;
-
-static int __init
-per_linux32_init(void)
-{
-	ia32_exec_domain.name = "Linux/x86";
-	ia32_exec_domain.handler = NULL;
-	ia32_exec_domain.pers_low = PER_LINUX32;
-	ia32_exec_domain.pers_high = PER_LINUX32;
-	ia32_exec_domain.signal_map = default_exec_domain.signal_map;
-	ia32_exec_domain.signal_invmap = default_exec_domain.signal_invmap;
-	register_exec_domain(&ia32_exec_domain);
-
-	return 0;
-}
-
-__initcall(per_linux32_init);
-
 /**
  * show_mem - give short summary of memory stats
  *
-- 
2.0.1
