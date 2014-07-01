From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Tue, 1 Jul 2014 15:01:06 +0200
Subject: [PATCH 15/24] ARM64:ILP32: Use the non compat HWCAP for ILP32.
In-Reply-To: <1400914939-9708-16-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
 <1400914939-9708-16-git-send-email-apinski@cavium.com>
Message-ID: <6E65D0A3-E36A-4A34-8CD0-258964FA623A@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2014, at 09:02 , Andrew Pinski <apinski@cavium.com> wrote:

> #ifdef CONFIG_COMPAT
> -#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
> -#define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
> extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
> +#define COMPAT_ELF_HWCAP	\
> +	(is_a32_compat_task()	\
> +	  ? compat_elf_hwcap	\
> +	  : elf_hwcap)
> +
> +#define COMPAT_ELF_HWCAP2	\
> +	(is_a32_compat_task()	\
> +	  ? compat_elf_hwcap2	\
> +	  : 0)
> +
> #endif

You missed the COMPAT_ELF_PLATFORM (in arm64/include/asm/elf.h), which is used to setup AT_PLATFORM in the auxilary vectors. I?d suggest to use a similar naming convention to what will be used in gdb (i.e. appending a ?:ilp32? to the base architecture.

The proposed change would thus be:
---
 arch/arm64/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 3f979b5..6d38edc 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -168,9 +168,9 @@ extern unsigned long arch_randomize_brk(struct mm_struct *mm);
 #ifdef CONFIG_COMPAT
 
 #ifdef __AARCH64EB__
-#define COMPAT_ELF_PLATFORM            ("v8b")
+#define COMPAT_ELF_PLATFORM            (is_ilp32_compat_task() ? "aarch64_be:ilp32" : "v8b")
 #else
-#define COMPAT_ELF_PLATFORM            ("v8l")
+#define COMPAT_ELF_PLATFORM            (is_ilp32_compat_task() ? "aarch64:ilp32" : "v8l")
 #endif
 
 #define COMPAT_ELF_ET_DYN_BASE         (randomize_et_dyn(2 * TASK_SIZE_32 / 3))
-- 
1.9.0


Best,
Philipp.
