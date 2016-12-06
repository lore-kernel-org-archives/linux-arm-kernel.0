From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue,  6 Dec 2016 16:03:50 +0000
Subject: [RFC PATCH v3 08/11] arm64: compat: 32-bit vDSO setup
In-Reply-To: <20161206160353.14581-1-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
Message-ID: <20161206160353.14581-9-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the compat vDSO is enabled, install it in compat processes. In this
case, the compat vDSO replaces the sigreturn page (it provides its own
sigreturn trampolines).

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Christopher Covington <cov@codeaurora.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/kernel/vdso.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 4d3048619be8..473492f3ab2a 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -141,6 +141,20 @@ static int vdso_setup(struct mm_struct *mm,
 }
 
 #ifdef CONFIG_COMPAT
+#ifdef CONFIG_VDSO32
+
+static struct vdso_mappings vdso32_mappings __ro_after_init;
+
+static int __init vdso32_init(void)
+{
+	extern char vdso32_start, vdso32_end;
+
+	return vdso_mappings_init("vdso32", &vdso32_start, &vdso32_end,
+				  &vdso32_mappings);
+}
+arch_initcall(vdso32_init);
+
+#else /* CONFIG_VDSO32 */
 
 /* sigreturn trampolines page */
 static struct page *sigreturn_page __ro_after_init;
@@ -196,6 +210,8 @@ static int sigreturn_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+#endif /* CONFIG_VDSO32 */
+
 #ifdef CONFIG_KUSER_HELPERS
 
 /* kuser helpers page */
@@ -249,7 +265,11 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
+#ifdef CONFIG_VDSO32
+	ret = vdso_setup(mm, &vdso32_mappings);
+#else
 	ret = sigreturn_setup(mm);
+#endif
 	if (ret)
 		goto out;
 
-- 
2.10.2
