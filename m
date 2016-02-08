From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 8 Feb 2016 18:01:26 +0100
Subject: [PATCH 1/3] ARM: move .vectors and .stubs sections back into the
 kernel VMA
In-Reply-To: <20160208163935.GN10826@n2100.arm.linux.org.uk>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160203000351.GX10826@n2100.arm.linux.org.uk>
 <CAKv+Gu_kYWczCazqgRC3y-n7s3WRTDhJXLO1RM1FE-6h1BhSUw@mail.gmail.com>
 <20160203091331.GB10826@n2100.arm.linux.org.uk>
 <CAKv+Gu8jbfs6HuzoFTQV2z-0LLiEZ9p0ZHO6eF3itE8p1LMwBA@mail.gmail.com>
 <20160208163935.GN10826@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu-9=h98nwpwcXMfHBzJ8PEF=k9KG1O_HyV=bdA_PkxTfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 February 2016 at 17:39, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 03, 2016 at 10:16:46AM +0100, Ard Biesheuvel wrote:
>> There are 34 section headers, starting at offset 0x10a6e60:
>>
>> Section Headers:
>>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>>   [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
>>   [16] .vectors          PROGBITS        00000000 a40000 000020 00  AX  0   0  2
>>   [17] .stubs            PROGBITS        00001000 a41000 0002c0 00  AX  0   0 32
>>   [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
> ...
>> Section Headers:
>>   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
>>   [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
>>   [16] .stubs            PROGBITS        c0c35000 a35000 0002c0 00  AX  0   0 32
>>   [17] .vectors          PROGBITS        c0c34000 a44000 000020 00  AX  0   0  2
>>   [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32
>
> Sorry, but I'm going to re-iterate my objection, and I believe that
> because you're looking at readelf's output, you're making assumptions
> when interpreting its output.
>
> These figures do not truely describe how the file is laid out.  The
> tool to use for this is objdump -h.  Let's compare:
>
> $ readelf -S vmlinux
> Section Headers:
>   [Nr] Name        Type         Addr     Off    Size   ES Flg Lk Inf Al
>   [13] .notes      NOTE         c093afd0 93afd0 000024 00  AX  0   0  4
>   [14] .vectors    PROGBITS     00000000 940000 000020 00  AX  0   0  4
>   [15] .stubs      PROGBITS     00001000 941000 0002c0 00  AX  0   0 32
>   [16] .init.text  PROGBITS     c093b2e0 94b2e0 04862c 00  AX  0   0 32
>
> $ objdump -h vmlinux
> Sections:
> Idx Name          Size      VMA       LMA       File off  Algn
>  12 .notes        00000024  c093afd0  c093afd0  0093afd0  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>  13 .vectors      00000020  00000000  c093b000  00940000  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>  14 .stubs        000002c0  00001000  c093b020  00941000  2**5
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>  15 .init.text    0004862c  c093b2e0  c093b2e0  0094b2e0  2**5
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>
> Note that objdump -h has one additional piece of information here: the
> LMA - load memory address.  This tells us where the file contents
> (offset into the ELF file at "File off") are to be loaded into memory,
> as opposed to the VMA which describes where (at run time) the object is
> to be found.
>
> With this new information, we can see that .vectors is loaded to
> 0xc093b000, and occupies only 32 bytes in the binary memory image, even
> though it occupies 4k in the ELF file.)  .stubs is loaded at 0xc093b020,
> and occupies 0x2c0 bytes.  Furthermore, we can see .init.text is located
> at 0xc093b2e0.
>
> So, there is no memory wastage here - .vectors, .stubs and the init text
> are all packed tightly together.  That's something which the readelf -S
> output doesn't show us.
>
> Please, replace the readelf -S output with objdump -h output so that we
> can see what's /really/ going on here.
>

OK, fair enough.

Before:

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
 14 .notes        00000024  c0c90030  c0c90030  00a90030  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 15 .vectors      00000020  00000000  c0c91000  00aa0000  2**1
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 16 .stubs        000002c0  00001000  c0c91020  00aa1000  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 17 .init.text    0006b250  c0c912e0  c0c912e0  00aa12e0  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE

and after

 14 .notes        00000024  c0c90030  c0c90030  00a90030  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 15 .stubs        000002c0  c0c91000  c0c91000  00a91000  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 16 .vectors      00000020  c0c90000  c0c912c0  00aa0000  2**1
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 17 .init.text    0006b250  c0c912e0  c0c912e0  00aa12e0  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, CODE

So, apart from the fact that .vectors and .stubs are reordered,
nothing changes, and the LMA footprint is identical.

> In any case, I still don't like your patch.  At least having these at 0
> and 0x1000 means that (for some CPUs) they are located at the real VMA
> address that they may appear at, though for modern CPUs, locating them
> at 0xffff0000 and 0xffff1000 VMA would be more reasonable.  This has the
> advantage that (jtag) debuggers are able to correctly parse the vmlinux
> file and insert breakpoints into the vectors.
>

0xffff0000 and 0xffff1000 work for me. I am trying to get rid of this
dodgy workaround in scripts/link-vmlinux.sh(85):

if [ -n "${CONFIG_ARM}" ] && [ -z "${CONFIG_XIP_KERNEL}" ] && [ -n
"${CONFIG_PAGE_OFFSET}" ]; then
    kallsymopt="${kallsymopt} --page-offset=$CONFIG_PAGE_OFFSET"
fi

which is there because perf does not like seeing the zero based kernel
symbol addresses, and only fixes the XIP_KERNEL=n case anyway.

Alternatively, this issue can be solved by making all stubs symbols
strictly local (or absolute), i.e., something like below. Would that
be preferable to you? It also fixes the perf issue for both
XIP_KERNEL=y and =n, but keeps .vectors and .stubs where they are.

-- 
Ard.


---------8<------------
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 788e40c1254f..c5c50c70c080 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -1027,7 +1027,7 @@ __kuser_helper_end:
  .macro vector_stub, name, mode, correction=0
  .align 5

-vector_\name:
+.Lvector_\name:
  .if \correction
  sub lr, lr, #\correction
  .endif
@@ -1056,7 +1056,7 @@ vector_\name:
  mov r0, sp
  ARM( ldr lr, [pc, lr, lsl #2] )
  movs pc, lr @ branch to handler in SVC mode
-ENDPROC(vector_\name)
+ENDPROC(.Lvector_\name)

  .align 2
  @ handler addresses follow this label
@@ -1064,14 +1064,15 @@ ENDPROC(vector_\name)
  .endm

  .section .stubs, "ax", %progbits
+.Lstubs_start:
  @ This must be the first word
  .word vector_swi

-vector_rst:
+.Lvector_rst:
  ARM( swi SYS_ERROR0 )
  THUMB( svc #0 )
  THUMB( nop )
- b vector_und
+ b .Lvector_und

 /*
  * Interrupt dispatcher
@@ -1173,8 +1174,8 @@ vector_rst:
  * (they're not supposed to happen, and won't happen in 32-bit data mode).
  */

-vector_addrexcptn:
- b vector_addrexcptn
+.Lvector_addrexcptn:
+ b .Lvector_addrexcptn

 /*=============================================================================
  * FIQ "NMI" handler
@@ -1202,18 +1203,18 @@ vector_addrexcptn:
  .long __fiq_svc @  f

  .globl vector_fiq_offset
- .equ vector_fiq_offset, vector_fiq
+ .equ vector_fiq_offset, .Lvector_fiq - .Lstubs_start + 0x1000

  .section .vectors, "ax", %progbits
 .L__vectors_start:
- W(b) vector_rst
- W(b) vector_und
+ W(b) .Lvector_rst
+ W(b) .Lvector_und
  W(ldr) pc, .L__vectors_start + 0x1000
- W(b) vector_pabt
- W(b) vector_dabt
- W(b) vector_addrexcptn
- W(b) vector_irq
- W(b) vector_fiq
+ W(b) .Lvector_pabt
+ W(b) .Lvector_dabt
+ W(b) .Lvector_addrexcptn
+ W(b) .Lvector_irq
+ W(b) .Lvector_fiq

  .data
