From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri, 01 Feb 2013 16:43:31 +0000
Subject: [RFC PATCH] arm: decompressor: initialize PIC offset base register
 for uClinux tools
In-Reply-To: <alpine.LFD.2.02.1301291453530.6300@xanadu.home>
References: <1359480546-7033-1-git-send-email-jonathan.austin@arm.com>
 <alpine.LFD.2.02.1301291453530.6300@xanadu.home>
Message-ID: <510BF0B3.3030608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas, thanks for the comments,

On 29/01/13 20:13, Nicolas Pitre wrote:
> On Tue, 29 Jan 2013, Jonathan Austin wrote:
> 
>> Before jumping to (position independent) C-code from the decompressor's
>> assembler world we set-up the C environment. This setup currently does not
>> set r9, which for arm-none-uclinux-uclibceabi should be the PIC offset base
>> register (IE should point to the beginning of the GOT).
>>
>> Currently, therefore, in order to build working kernels that use the
>> decompressor it is necessary to use an arm-linux-gnueabi toolchain, or
>> similar. uClinux toolchains cause a Prefetch Abort to occur at the beginning
>> of the decompress_kernel function.
>>
>> This patch allows uClinux toolchains to build bootable zImages by setting r9
>> to the beginning of the GOT when __uClinux__ is defined, allowing the
>> decompressor's C functions to work correctly.
>>
>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>> ---
>>
>> One other possibility would be to specify -mno-single-pic-base when building
>> the decompressor. This works around the problem, but forces the compiler to
>> generate less optimal code.
> 
> How "less optimal"?  How much bigger/slower is it?
> If not significant enough then going with -mno-single-pic-base might be
> fine.

Code that needs to access anything global will need to derive the location
of the GOT for itself, but there's a possible upside there that there's an
extra free register (r9 can be used as a general purpose register...)

The patch would look like:
-----8<-------
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 5cad8a6..afed28e 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -120,7 +120,7 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
 endif
 -ccflags-y := -fpic -fno-builtin -I$(obj)
+ccflags-y := -fpic -mno-single-pic-base -fno-builtin -I$(obj)
 asflags-y := -Wa,-march=all -DZIMAGE
  # Supply kernel BSS size to the decompressor via a linker symbol.
------>8---------


I did a fairly crude benchmark - count how many instructions we need in
order to finish decompressing the kernel...

Setup r9 correctly:       129,976,282
Use -mno-single-pic-base: 124,826,778

(this was done using an R-class model and a magic semi-hosting call to pause
the model at the end of the decompress_kernel function)

So, it seems like the extra register means there's actually a 4% *win* 
in instruction terms from using -mno-single-pic-base

That said, I've still made some comments/amendments below...

> 
>>   arch/arm/boot/compressed/head.S |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index fe4d9c3..4491e75 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -410,6 +410,10 @@ wont_overwrite:
>>    *   sp  = stack pointer
>>    */
>>   		orrs	r1, r0, r5
>> +#ifdef __uClinux__
>> +		mov	r9, r11			@ PIC offset base register
>> +		addne	r9, r9, r0		@ Also needs relocating
>> +#endif
>>   		beq	not_relocated
> 
> Please don't insert your code between the orrs and the beq as those two
> go logically together.

I'd initially done this in order to change only one site - as we need to
set r9 and then add the offset I was using the condition code to test r0...

However, this was silly - I think I can just do it in one instruction:

add   r9, r11, r0

In the case that we're not relocated, r0 should be 0 anyway...

> 
> In fact, the best location for this would probably be between the
> wont_overwrite label and the comment that immediately follows it. And
> then, those comments that follow until the branch into C code should be
> updated accordingly.


Okay, assuming I've understood you correctly, you're suggesting something
like this:

-----8<-------

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fe4d9c3..d81efbd 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -396,6 +396,9 @@ dtb_check_done:
                mov     pc, r0
  wont_overwrite:
+#ifdef __uClinux__
+               add     r9, r11, r0             @ uClinux PIC offset base register
+#endif
 /*
  * If delta is zero, we are running@the address we were linked at.
  *   r0  = delta
@@ -405,6 +408,7 @@ wont_overwrite:
  *   r5  = appended dtb size (0 if not present)
  *   r7  = architecture ID
  *   r8  = atags pointer
+ *   r9  = GOT start (for uClinux ABI), relocated
  *   r11 = GOT start
  *   r12 = GOT end
  *   sp  = stack pointer
@@ -470,6 +474,7 @@ not_relocated:      mov     r0, #0
  *   r4  = kernel execution address
  *   r7  = architecture ID
  *   r8  = atags pointer
+ *   r9  = GOT start (for uClinux ABI)
  */
                mov     r0, r4
                mov     r1, sp                  @ malloc space above stack
------->8-----------


The question that now occurs is whether we should just set r9 whether or not
we're using a uClinux toolchain - I don't think it is going to hurt as the
arm-linux-gnueabi world can happily clobber it with no bad consequences...

But after all this, it seems that just using -mno-single-pic base as in the patch
above is best...

Thoughts?

Jonny
