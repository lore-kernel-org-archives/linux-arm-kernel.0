From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 24 Apr 2015 11:44:07 +0900
Subject: [RFC 2/4] livepatch: adjust a patched function's address
In-Reply-To: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
References: <1429843449-7388-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1429843449-7388-3-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing livepatch code assumes that a fentry call is inserted before
a function prolog by -mfentry option of gcc. But the location of mcount()
can be identified by using ftrace_lookup_mcount(), and which eventually
allows arch's which don't support -mfentry option, like arm64, to support
livepatch.

This patch modifies core and x86 code before adding livepatch support for
arm64.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/x86/include/asm/livepatch.h |    5 +++++
 include/linux/livepatch.h        |    2 ++
 kernel/livepatch/core.c          |   16 ++++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/livepatch.h b/arch/x86/include/asm/livepatch.h
index a455a53..914954a 100644
--- a/arch/x86/include/asm/livepatch.h
+++ b/arch/x86/include/asm/livepatch.h
@@ -39,6 +39,11 @@ static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
 	regs->ip = ip;
 }
+
+static inline unsigned long klp_arch_lookup_mcount(unsigned long addr)
+{
+	return addr;
+}
 #else
 #error Live patching support is disabled; check CONFIG_LIVEPATCH
 #endif
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 95023fd..fec7800 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -47,6 +47,7 @@ struct klp_func {
 	/* external */
 	const char *old_name;
 	void *new_func;
+	unsigned long new_func_mcount;
 	/*
 	 * The old_addr field is optional and can be used to resolve
 	 * duplicate symbol names in the vmlinux object.  If this
@@ -56,6 +57,7 @@ struct klp_func {
 	 * way to resolve the ambiguity.
 	 */
 	unsigned long old_addr;
+	unsigned long old_addr_mcount;
 
 	/* internal */
 	struct kobject kobj;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 3f9f1d6..3c7c8070 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -245,6 +245,9 @@ static int klp_find_verify_func_addr(struct klp_object *obj,
 		ret = klp_verify_vmlinux_symbol(func->old_name,
 						func->old_addr);
 
+	if (func->old_addr && !ret)
+		func->old_addr_mcount = klp_arch_lookup_mcount(func->old_addr);
+
 	return ret;
 }
 
@@ -330,7 +333,7 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	if (WARN_ON_ONCE(!func))
 		goto unlock;
 
-	klp_arch_set_pc(regs, (unsigned long)func->new_func);
+	klp_arch_set_pc(regs, func->new_func_mcount);
 unlock:
 	rcu_read_unlock();
 }
@@ -358,7 +361,8 @@ static int klp_disable_func(struct klp_func *func)
 			return ret;
 		}
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
+		ret = ftrace_set_filter_ip(&ops->fops,
+			func->old_addr_mcount, 1, 0);
 		if (ret)
 			pr_warn("function unregister succeeded but failed to clear the filter\n");
 
@@ -401,7 +405,8 @@ static int klp_enable_func(struct klp_func *func)
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
+		ret = ftrace_set_filter_ip(&ops->fops,
+			func->old_addr_mcount, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
 			       func->old_name, ret);
@@ -412,7 +417,8 @@ static int klp_enable_func(struct klp_func *func)
 		if (ret) {
 			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
 			       func->old_name, ret);
-			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
+			ftrace_set_filter_ip(&ops->fops,
+				func->old_addr_mcount, 1, 0);
 			goto err;
 		}
 
@@ -742,6 +748,8 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 {
 	INIT_LIST_HEAD(&func->stack_node);
 	func->state = KLP_DISABLED;
+	func->new_func_mcount =
+		klp_arch_lookup_mcount((unsigned long)func->new_func);
 
 	return kobject_init_and_add(&func->kobj, &klp_ktype_func,
 				    obj->kobj, "%s", func->old_name);
-- 
1.7.9.5
