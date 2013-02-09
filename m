From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  9 Feb 2013 12:05:10 +0400
Subject: [PATCH] ARM: Fix compiler warning when CONFIG_ATAGS is not set
Message-ID: <1360397110-3480-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix following compiler warning:

  CC      arch/arm/kernel/setup.o
  In file included from arch/arm/kernel/setup.c:58:
  arch/arm/kernel/atags.h: In function 'setup_machine_tags':
  arch/arm/kernel/atags.h:18: warning: no return statement in function returning non-void

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/kernel/atags.h | 8 --------
 arch/arm/kernel/setup.c | 8 +++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index 9edc969..9d95c77 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -8,12 +8,4 @@ void convert_to_tag_list(struct tag *tags);
 
 #ifdef CONFIG_ATAGS
 struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr);
-#else
-static inline struct machine_desc *
-setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
-{
-	early_print("no ATAGS support: can't continue\n");
-	while (true);
-	unreachable();
-}
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1cc9e17..1dcb989 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -732,8 +732,14 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_processor();
 	mdesc = setup_machine_fdt(__atags_pointer);
-	if (!mdesc)
+	if (!mdesc) {
+#ifdef CONFIG_ATAGS
 		mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
+#else
+		early_print("no ATAGS support: can't continue\n");
+		while (1);
+#endif
+	}
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
 
-- 
1.7.12.4
