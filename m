From: salyzyn@android.com (Mark Salyzyn)
Date: Mon,  1 Oct 2018 10:58:36 -0700
Subject: RESEND [PATCH v3 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
Message-ID: <20181001175845.168430-17-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

Make it possible to disable the kuser helpers by adding a KUSER_HELPERS
config option (enabled by default). When disabled, all kuser
helpers-related code is removed from the kernel and no mapping is done
at the fixed high address (0xffff0000); any attempt to use a kuser
helper from a 32-bit process will result in a segfault.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: android-kernel at android.com

v2:
- split off assembler changes to a new previous patch in series to reduce churn
- modify slightly the feature documentation to reduce its reach
- modify slightly the feature documentation to rationalize the yes default.
- There are more ifdefs as a result of the rebase.

v3:
- rebase
---
 arch/arm64/Kconfig         | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile |  4 ++--
 arch/arm64/kernel/vdso.c   | 10 ++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..6e61f01108cb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1301,6 +1301,36 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config KUSER_HELPERS
+	bool "Enable the kuser helpers page in 32-bit processes"
+	depends on COMPAT
+	default y
+	help
+	  Warning: disabling this option may break 32-bit applications.
+
+	  Provide kuser helpers in a special purpose fixed-address page. The
+	  kernel provides helper code to userspace in read-only form at a fixed
+	  location to allow userspace to be independent of the CPU type fitted
+	  to the system. This permits 32-bit binaries to be run on ARMv6 through
+	  to ARMv8 without modification.
+
+	  See Documentation/arm/kernel_user_helpers.txt for details.
+
+	  However, the fixed-address nature of these helpers can be used by ROP
+	  (return-orientated programming) authors when creating exploits.
+
+	  If all of the 32-bit binaries and libraries that run on your platform
+	  are built specifically for your platform, and make no use of these
+	  helpers, then you can turn this option off to hinder such exploits.
+	  However, in that case, if a binary or library relying on those helpers
+	  is run, it will receive a SIGSEGV signal, which will terminate the
+	  program. Typically, binaries compiled for ARMv7 or later do not use
+	  the kuser helpers.
+
+	  Say N here only if you are absolutely certain that you do not need
+	  these helpers; otherwise, the safe option is to say Y (the default
+	  for now)
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index b89a79424912..1c2bd2210f58 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,10 +27,10 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o 	\
+arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o	\
 					   sys_compat.o
 arm64-obj-$(CONFIG_COMPAT)		+= sigreturn32.o
-arm64-obj-$(CONFIG_COMPAT)		+= kuser32.o
+arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 5398f6454ce1..76a94bed4bd5 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -62,18 +62,22 @@ static const struct vm_special_mapping compat_vdso_spec[] = {
 		.name	= "[sigpage]",
 		.pages	= &vectors_page[0],
 	},
+#ifdef CONFIG_KUSER_HELPERS
 	{
 		.name	= "[kuserhelpers]",
 		.pages	= &vectors_page[1],
 	},
+#endif
 };
 static struct page *vectors_page[ARRAY_SIZE(compat_vdso_spec)] __ro_after_init;
 
 static int __init alloc_vectors_page(void)
 {
+#ifdef CONFIG_KUSER_HELPERS
 	extern char __kuser_helper_start[], __kuser_helper_end[];
 	size_t kuser_sz = __kuser_helper_end - __kuser_helper_start;
 	unsigned long kuser_vpage;
+#endif
 
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
 	size_t sigret_sz =
@@ -84,22 +88,26 @@ static int __init alloc_vectors_page(void)
 	if (!sigret_vpage)
 		return -ENOMEM;
 
+#ifdef CONFIG_KUSER_HELPERS
 	kuser_vpage = get_zeroed_page(GFP_ATOMIC);
 	if (!kuser_vpage) {
 		free_page(sigret_vpage);
 		return -ENOMEM;
 	}
+#endif
 
 	/* sigreturn code */
 	memcpy((void *)sigret_vpage, __aarch32_sigret_code_start, sigret_sz);
 	flush_icache_range(sigret_vpage, sigret_vpage + PAGE_SIZE);
 	vectors_page[0] = virt_to_page(sigret_vpage);
 
+#ifdef CONFIG_KUSER_HELPERS
 	/* kuser helpers */
 	memcpy((void *)kuser_vpage + 0x1000 - kuser_sz, __kuser_helper_start,
 		kuser_sz);
 	flush_icache_range(kuser_vpage, kuser_vpage + PAGE_SIZE);
 	vectors_page[1] = virt_to_page(kuser_vpage);
+#endif
 
 	return 0;
 }
@@ -128,11 +136,13 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	current->mm->context.vdso = (void *)addr;
 
+#ifdef CONFIG_KUSER_HELPERS
 	/* Map the kuser helpers at the ABI-defined high address. */
 	ret = _install_special_mapping(mm, AARCH32_KUSER_HELPERS_BASE,
 				       PAGE_SIZE,
 				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
 				       &compat_vdso_spec[1]);
+#endif
 out:
 	up_write(&mm->mmap_sem);
 
-- 
2.19.0.605.g01d371f741-goog
