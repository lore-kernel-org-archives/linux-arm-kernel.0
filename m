From: js07.lee@gmail.com (Jungseung Lee)
Date: Tue,  6 Jan 2015 18:07:36 +0900
Subject: [PATCH] kernel/module.c: Mark module state before set RO and NX
 regions
Message-ID: <1420535256-6091-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some architectures like arm/arm64, set_memory_*() check module address
and state as well. Mark module state before set RO and NX regions for
the routine is passed.

It will fix wrong RO/NX protection for loadable kernel modules on arm/arm64.

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 kernel/module.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 3965511..7e7cc9f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3152,6 +3152,10 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	/* This relies on module_mutex for list integrity. */
 	module_bug_finalize(info->hdr, info->sechdrs, mod);
 
+	/* Mark state as coming so strong_try_module_get() ignores us,
+	 * but kallsyms etc. can see us. */
+	mod->state = MODULE_STATE_COMING;
+
 	/* Set RO and NX regions for core */
 	set_section_ro_nx(mod->module_core,
 				mod->core_text_size,
@@ -3164,9 +3168,6 @@ static int complete_formation(struct module *mod, struct load_info *info)
 				mod->init_ro_size,
 				mod->init_size);
 
-	/* Mark state as coming so strong_try_module_get() ignores us,
-	 * but kallsyms etc. can see us. */
-	mod->state = MODULE_STATE_COMING;
 	mutex_unlock(&module_mutex);
 
 	blocking_notifier_call_chain(&module_notify_list,
-- 
1.9.1
