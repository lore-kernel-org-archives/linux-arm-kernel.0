From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 30 Jun 2014 14:29:28 -0700
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
Message-ID: <53B1D6B8.7080806@amacapital.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2014 08:11 PM, Nathan Lynch wrote:
> Place vdso-related user-space code in arch/arm/kernel/vdso/.
> 
> It is almost completely written in C with some assembly helpers to
> load the data page address, sample the counter, and fall back to
> system calls when necessary.
> 
> If CONFIG_ARM_ARCH_TIMER is not enabled, the vdso cannot service
> high-resolution clocks and falls back to syscalls.  Low-resolution
> clocks e.g. CLOCK_REALTIME_COARSE can be serviced regardless.
> 
> Of particular note is that a post-processing step ("vdsomunge") is
> necessary to produce a shared object which is architecturally allowed
> to be used by both soft- and hard-float EABI programs.
> 
> The 2012 edition of the ARM ABI defines Tag_ABI_VFP_args = 3 "Code is
> compatible with both the base and VFP variants; the user did not
> permit non-variadic functions to pass FP parameters/results."
> Unfortunately current toolchains do not support this tag, which is
> ideally what we would use.
> 
> The best available option is to ensure that both EF_ARM_ABI_FLOAT_SOFT
> and EF_ARM_ABI_FLOAT_HARD are unset in the ELF header's e_flags,
> indicating that the shared object is "old" and should be accepted for
> backward compatibility's sake.  While binutils < 2.24 appear to
> produce a vdso.so with both flags clear, 2.24 always sets
> EF_ARM_ABI_FLOAT_SOFT, with no way to inhibit this behavior.  So we
> have to fix things up with a custom post-processing step.
> 
> In fact, the VDSO code in glibc does much less validation (including
> checking these flags) than the code for handling conventional
> file-backed shared libraries, so this is a bit moot unless glibc's
> VDSO code becomes more strict.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>

> diff --git a/arch/arm/kernel/vdso/Makefile b/arch/arm/kernel/vdso/Makefile
> new file mode 100644
> index 000000000000..ceb712a7626c
> --- /dev/null
> +++ b/arch/arm/kernel/vdso/Makefile
> @@ -0,0 +1,59 @@
> +hostprogs-y := vdsomunge
> +
> +obj-vdso := vgettimeofday.o datapage.o
> +
> +# Build rules
> +targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
> +obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
> +
> +ccflags-y := -shared -fPIC -fno-common -fno-builtin -fno-stack-protector
> +ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
> +		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)

Does this need -DDISABLE_BRANCH_PROFILING?

> diff --git a/arch/arm/kernel/vdso/checkundef.sh b/arch/arm/kernel/vdso/checkundef.sh
> new file mode 100755
> index 000000000000..185c30da202b
> --- /dev/null
> +++ b/arch/arm/kernel/vdso/checkundef.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +nm="$1"
> +file="$2"
> +"$nm" -u "$file" | ( ret=0; while read discard symbol
> +do
> +    echo "$file: undefined symbol $symbol"
> +    ret=1
> +done ; exit $ret )
> +exit $?

This is just as buggy as the x86 version.  make;make malfunctions.

Can you rely on a new enough toolchain to use -Wl,--no-undefined?

> diff --git a/arch/arm/kernel/vdso/datapage.S b/arch/arm/kernel/vdso/datapage.S
> new file mode 100644
> index 000000000000..fbf36d75da06
> --- /dev/null
> +++ b/arch/arm/kernel/vdso/datapage.S
> @@ -0,0 +1,15 @@
> +#include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
> +
> +	.align 2
> +.L_vdso_data_ptr:
> +	.long	_start - . - VDSO_DATA_SIZE
> +
> +ENTRY(__get_datapage)
> +	.cfi_startproc
> +	adr	r0, .L_vdso_data_ptr
> +	ldr	r1, [r0]
> +	add	r0, r0, r1
> +	bx	lr
> +	.cfi_endproc
> +ENDPROC(__get_datapage)

Can you translate this into English for the non-ARM-speakers here?

> +
> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +#define HOST_ORDER ELFDATA2LSB
> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +#define HOST_ORDER ELFDATA2MSB
> +#endif
> +
> +static const char *outfile;
> +
> +static void cleanup(void)
> +{
> +	if (error_message_count > 0 && outfile != NULL)
> +		unlink(outfile);
> +}
> +
> +static Elf32_Word read_elf_word(Elf32_Word word, bool swap)
> +{
> +	return swap ? bswap_32(word) : word;
> +}
> +
> +static Elf32_Half read_elf_half(Elf32_Half half, bool swap)
> +{
> +	return swap ? bswap_16(half) : half;
> +}
> +
> +static void write_elf_word(Elf32_Word val, Elf32_Word *dst, bool swap)
> +{
> +	*dst = swap ? bswap_32(val) : val;
> +}

The macros in arch/x86/vdso/vdso2c.c are IMO much nicer.

--Andy
