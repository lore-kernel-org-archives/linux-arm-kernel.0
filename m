From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 18:29:44 +0100
Subject: [PATCH 5/6] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <1409048930-21598-6-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-6-git-send-email-punit.agrawal@arm.com>
Message-ID: <20140827172944.GH13850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:28:49AM +0100, Punit Agrawal wrote:
> The SWP instruction was deprecated in the ARMv6 architecture,
> superseded by the LDREX/STREX family of instructions for
> load-linked/store-conditional operations. The ARMv7 multiprocessing
> extensions mandate that SWP/SWPB instructions are treated as undefined
> from reset, with the ability to enable them through the System Control
> Register SW bit. With ARMv8, the option to enable these instructions
> through System Control Register was dropped as well.
> 
> This patch ports the alternative solution to emulate the SWP and SWPB
> instructions using LDXR/STXR sequences from the arm port to
> arm64. Additionaly, the patch also proivdes support to log the

s/proivdes/provides/

> emulation statistics via debugfs.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> ---
>  arch/arm64/Kconfig              |   41 +++++++
>  arch/arm64/include/asm/insn.h   |    9 ++
>  arch/arm64/kernel/Makefile      |    1 +
>  arch/arm64/kernel/insn.c        |   11 ++
>  arch/arm64/kernel/v7_obsolete.c |  241 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 303 insertions(+)
>  create mode 100644 arch/arm64/kernel/v7_obsolete.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c52894e..ba780b1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -142,6 +142,47 @@ config ARCH_XGENE
>  	help
>  	  This enables support for AppliedMicro X-Gene SOC Family
>  
> +comment "Processor Features"
> +
> +config V7_OBSOLETE

We could place this under a sub-menu (I haven't checked how it would
look like).

> +	bool "Emulate obsolete ARMv7 instructions"
> +	depends on COMPAT
> +	help
> +	  AArch32 legacy software support may require certain
> +	  instructions that have been deprecated or obsoleted in the
> +	  architecture.
> +
> +	  Enable this config to enable selective emulation of these
> +	  features.
> +
> +	  If unsure, say N

I think we need to get some terminology right:

deprecated:	no longer recommended, usually with a configuration
		option to be enabled/disabled
obsolete:	no longer present

So what we are adding here is deprecated ARMv7 features that have been
obsolete in ARMv8. You could as well say "Emulate deprecated/obsolete
ARMv8 A32 instructions". "Deprecated ARMv7..." could work but we may
want to add options for features that haven't been deprecated in ARMv7,
just ARMv8 A32.

You could also change the config option (and file/function names) for
consistency to something like a32_obsolete (for config option, maybe
CONFIG_ARM64_A32_OBSOLETE, it gets even more confusing ;)).

> +config SWP_EMULATION
> +	bool "Emulate SWP/SWPB instructions"
> +	help
> +	  ARMv8 obsoletes the use of SWP/SWPB instructions such that

"... the use of A32 SWP/SWPB" to be clearer.

> +	  they are always undefined. Say Y here to enable software
> +	  emulation of these instructions for userspace (not kernel)
> +	  using LDXR/STXR.

No need to say "not kernel" since the kernel uses the A64 ISA.

> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index dc1f73b..2861cc6 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -105,6 +105,15 @@ bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>  int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> +
> +#ifdef CONFIG_V7_OBSOLETE
> +#define RN_OFFSET	16
> +#define RT_OFFSET	12
> +#define RT2_OFFSET	 0
> +
> +u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
> +#endif /* CONFIG_V7_OBSOLETE */
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif	/* __ASM_INSN_H */

[...]

> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -302,3 +302,14 @@ u32 __kprobes aarch64_insn_gen_nop(void)
>  {
>  	return aarch64_insn_gen_hint(AARCH64_INSN_HINT_NOP);
>  }
> +
> +#ifdef CONFIG_V7_OBSOLETE
> +/*
> + * Macros/defines for extracting register numbers from instruction.
> + */
> +u32 aarch32_insn_extract_reg_num(u32 insn, int offset)
> +{
> +	return (insn & (0xf << offset)) >> offset;
> +}
> +
> +#endif /* CONFIG_V7_OBSOLETE */

I don't think we need to bother with an #ifdef here and in the header.
The code is small enough to affect the compilation time and the linker
should get rid of it if not used.

-- 
Catalin
