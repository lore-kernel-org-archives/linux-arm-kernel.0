From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 1 Jul 2014 08:28:30 -0500
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <53B1D6B8.7080806@amacapital.net>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <53B1D6B8.7080806@amacapital.net>
Message-ID: <53B2B77E.7040904@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2014 04:29 PM, Andy Lutomirski wrote:
> On 06/22/2014 08:11 PM, Nathan Lynch wrote:
>> +
>> +# Build rules
>> +targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
>> +obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>> +
>> +ccflags-y := -shared -fPIC -fno-common -fno-builtin -fno-stack-protector
>> +ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
>> +		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> 
> Does this need -DDISABLE_BRANCH_PROFILING?

Yes, thanks.


>> diff --git a/arch/arm/kernel/vdso/checkundef.sh b/arch/arm/kernel/vdso/checkundef.sh
>> new file mode 100755
>> index 000000000000..185c30da202b
>> --- /dev/null
>> +++ b/arch/arm/kernel/vdso/checkundef.sh
>> @@ -0,0 +1,9 @@
>> +#!/bin/sh
>> +nm="$1"
>> +file="$2"
>> +"$nm" -u "$file" | ( ret=0; while read discard symbol
>> +do
>> +    echo "$file: undefined symbol $symbol"
>> +    ret=1
>> +done ; exit $ret )
>> +exit $?
> 
> This is just as buggy as the x86 version.  make;make malfunctions.
> 
> Can you rely on a new enough toolchain to use -Wl,--no-undefined?

Looks like relying on --no-undefined should be okay.


>> diff --git a/arch/arm/kernel/vdso/datapage.S b/arch/arm/kernel/vdso/datapage.S
>> new file mode 100644
>> index 000000000000..fbf36d75da06
>> --- /dev/null
>> +++ b/arch/arm/kernel/vdso/datapage.S
>> @@ -0,0 +1,15 @@
>> +#include <linux/linkage.h>
>> +#include <asm/asm-offsets.h>
>> +
>> +	.align 2
>> +.L_vdso_data_ptr:
>> +	.long	_start - . - VDSO_DATA_SIZE
>> +
>> +ENTRY(__get_datapage)
>> +	.cfi_startproc
>> +	adr	r0, .L_vdso_data_ptr
>> +	ldr	r1, [r0]
>> +	add	r0, r0, r1
>> +	bx	lr
>> +	.cfi_endproc
>> +ENDPROC(__get_datapage)
> 
> Can you translate this into English for the non-ARM-speakers here?

It's a PC-relative load of the data page.  If someone knows how to make
this happen in the C portion of the vdso, it would might get us a little
speedup.


>> +#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
>> +#define HOST_ORDER ELFDATA2LSB
>> +#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>> +#define HOST_ORDER ELFDATA2MSB
>> +#endif
>> +
>> +static const char *outfile;
>> +
>> +static void cleanup(void)
>> +{
>> +	if (error_message_count > 0 && outfile != NULL)
>> +		unlink(outfile);
>> +}
>> +
>> +static Elf32_Word read_elf_word(Elf32_Word word, bool swap)
>> +{
>> +	return swap ? bswap_32(word) : word;
>> +}
>> +
>> +static Elf32_Half read_elf_half(Elf32_Half half, bool swap)
>> +{
>> +	return swap ? bswap_16(half) : half;
>> +}
>> +
>> +static void write_elf_word(Elf32_Word val, Elf32_Word *dst, bool swap)
>> +{
>> +	*dst = swap ? bswap_32(val) : val;
>> +}
> 
> The macros in arch/x86/vdso/vdso2c.c are IMO much nicer.

Respectfully, I think I'd disagree, but more importantly, vdso2c.c seems
to assume a little-endian target.
