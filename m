From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Apr 2013 14:21:07 +0100
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
Message-ID: <20130408132107.GF17476@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 01:34:28PM +0100, Vladimir Danushevsky wrote:
> From: Vladimir Danushevsky <vladidan@oracle.com>
> 
> Hi All,

Hello,

> One of the indirect LPAE features in a single-copy atomicity of LDRD/STRD instructions. This information is useful for some dynamic code generating applications (e.g. JIT compilers) to produce a more efficient access mechanism to atomic/volatile operands. 
> 
> The feature is part of the design scheme therefore it's not related to the platform configuration i.e. whether CONFIG_ARM_LPAE is enabled or not.
> 
> The patch exposes that information through hwcap entry of an Auxiliary Vector.

Hmm, your commit text and patch format are both completely mangled.
Furthermore, you've taken your patch against a -stable kernel, rather than
the latest mainline release, so it doesn't apply anymore anyway.

However, I see what you're trying to do, and I've recently made use of this
in our atomic64 implementation so that we avoid the exclusive instructions
for atomic64_{read,set}.

> --- linux-3.8.4_vanilla/arch/arm/kernel/setup.c 2013-03-20 16:11:19.000000000 -0400
> 
> +++ linux-3.8.4/arch/arm/kernel/setup.c 2013-04-03 15:42:31.580525201 -0400
> 
> @@ -487,6 +487,10 @@ static void __init setup_processor(void)
> 
>         elf_hwcap &= ~HWCAP_THUMB;
> 
>  #endif
> 
> 
> +        /* check LPAE presence */ 
> 
> +        if (((read_cpuid_ext(CPUID_EXT_MMFR3) >> 28) & 0xf) > 0)
> 
> +          elf_hwcap |= HWCAP_ATOMICD;

This is broken -- you're checking for supersection support (why?) rather
than checking the vmsa field in MMFR0.

How about something like the patch below instead?

Will

--->8

diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
index 3688fd1..ecf0c6f 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -25,6 +25,7 @@
 #define HWCAP_IDIVT    (1 << 18)
 #define HWCAP_VFPD32   (1 << 19)       /* set if VFP has 32 regs (not 16) */
 #define HWCAP_IDIV     (HWCAP_IDIVA | HWCAP_IDIVT)
+#define HWCAP_ATOMICD  (1 << 20)
 
 
 #endif /* _UAPI__ASMARM_HWCAP_H */
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d343a6c..cae7b9e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -355,7 +355,7 @@ void __init early_print(const char *str, ...)
 
 static void __init cpuid_init_hwcaps(void)
 {
-       unsigned int divide_instrs;
+       unsigned int divide_instrs, vmsa;
 
        if (cpu_architecture() < CPU_ARCH_ARMv7)
                return;
@@ -368,6 +368,11 @@ static void __init cpuid_init_hwcaps(void)
        case 1:
                elf_hwcap |= HWCAP_IDIVT;
        }
+
+       /* LPAE implies atomic ldrd/strd instructions */
+       vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
+       if (vmsa >= 5)
+               elf_hwcap |= HWCAP_ATOMICD;
 }
 
 static void __init feat_v6_fixup(void)
@@ -864,6 +869,7 @@ static const char *hwcap_str[] = {
        "vfpv4",
        "idiva",
        "idivt",
+       "atomicd",
        NULL
 };
 
