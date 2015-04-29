From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Wed, 29 Apr 2015 17:49:14 +0200
Subject: [RFC] arm: pick the r2 passed DTB over the appended one
In-Reply-To: <alpine.LFD.2.11.1504290929090.1582@knanqh.ubzr>
References: <1429880030-21473-1-git-send-email-valentin.longchamp@keymile.com>
 <alpine.LFD.2.11.1504282315320.1582@knanqh.ubzr>
 <5540A0DA.9060409@keymile.com>
 <alpine.LFD.2.11.1504290929090.1582@knanqh.ubzr>
Message-ID: <5540FD7A.8040002@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2015 03:58 PM, Nicolas Pitre wrote:
> On Wed, 29 Apr 2015, Valentin Longchamp wrote:
> 
>> On 04/29/2015 05:50 AM, Nicolas Pitre wrote:
>>> On Fri, 24 Apr 2015, Valentin Longchamp wrote:
>>>
>>>> Uncompressing Linux... done, booting the kernel.
>>>> e5943000
>>>
>>> Where is this value from? This looks like an ARM opcode ("ldr r3, [r4]").
>>
>> This value that I print out actually is the content of the memory pointed by the
>> r2 register, printed from __vet_atags (head-common.S)
>>
>> It can very well be an ARM opcode from the kernel binary since the r2 register
>> does not point to a DTB but to some other location.
> 
> What is the value of r2 at that point?

The value of r2 at that point ends up to be the value of r8 (please see below).

> 
>> I now have further debugged this and I now understand why it does not work as I
>> expect it: I have noticed that (at least with our kernel and our system) this
>> code gets executed twice. This is has the consequence for the case where the DTB
>> is appended and atags are passed to r2, my check is valid the first time this
>> code is run. However, the second time, r8 (pointer to atags/dtb) was updated
>> with r6 (pointer to _edata/appended dtb), which means that my additional check
>> will cause the code to jump to dtb_check_done. So the DTB is not copied over
>> with the rest of the kernel binary, because r6, r10 and sp and not "relocated"
>> past the dtb !
>>
>> Now my question is: is this normal that this code is executed twice or is a
>> problem on our side ? If it is normal, I need to add further checks. If not, I
>> would rather keep my implementation roughly as it is and rather troubleshoot
>> this "double execution".
> 
> The double execution is "normal".  The code checks if itself and the 
> compressed payload is in the way of the decompressed kernel. If it is 
> then it relocates itself to avoid being overwritten. Once relocated, 
> execution starts over again to keep things simple.
> 
> When a DTB is appended to zImage, then it has to be relocated alongside 
> the compressed payload for the same reasons. For this, we need to 
> determine the actual size of the DTB. That's where r6 is adjusted to 
> pretend the DTB is part of the actual zImage.
> 
> Yet if CONFIG_ARM_ATAG_DTB_COMPAT is set, this has to be performed 
> before the relocation as it may well change the size of the DTB.
> 
> Now, to fix your test, you'd simply have to augment it with:
> 
> +		cmp	r6, r8		@ is r8 pointing to the appended DTB?
> +		beq	1f
> 		ldr	lr, [r8, #0]	@ conventionaly passed dtb ?
> 		cmp	lr, r1
> 		beq	dtb_check_done	@ yes, do not manage it
> +1:
> 

I had thought the same and implemented a similar test as you propose (patch
attached, with some more debug code - please excuse my poor assembler). However
it does not work ! The reason for it is that on the second run, r6 contains
another value. As the output below seems to show, this 2nd run r6 value seems to
point to a DTB since the first jump to dtb_check_done is not performed. However,
since r8 now points to the "initial" appended DTB, the 2nd test jumps to
dtb_check_done. Please see the output below.

> ## Current stack ends at 0x1fba0b68 ## Booting kernel from Legacy Image at 02000000 ...
>    Image Name:   Linux-3.10.60-7.2.2-00005-g56840
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2905014 Bytes = 2.8 MiB
>    Load Address: 00008000
>    Entry Point:  00008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
> ## Transferring control to Linux (at address 00008000) ...
> r2 (0x00000100) points to (size, header): 0x00000005, 0x54410001
> 
> Starting kernel ...
> 
> a
> b
> 002CAE58
> 00000100
> c
> d
> a
> b
> 008AF9F8
> 002CAE58
> c
> 
> Uncompressing Linux... done, booting the kernel.
>
>  trying to parse the FDT
> 
>  dt_phys (r2) is NULL !
> 
> Error: unrecognized/unsupported machine ID (r1 = 0x000008cf).
> 
> Available machine support:
> 
> ID (hex)	NAME
> ffffffff	Marvell Kirkwood (Flattened Device Tree)
> 
> Please check your kernel config and/or bootloader.
> 
> 

Why does r6 on the second run contain another value than r8 and points to an
address that seem to be (another ?) DTB ?

Valentin

---
 arch/arm/boot/compressed/head.S | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index e9e312c..2677ccc 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -19,6 +19,7 @@
  * 100% relocatable.  Any attempt to do so will result in a crash.
  * Please select one of the following when turning on debugging.
  */
+#define DEBUG
 #ifdef DEBUG

 #if defined(CONFIG_DEBUG_ICEDCC)
@@ -244,7 +245,12 @@ restart:   adr     r0, LC0
  * dtb data will get relocated along with the kernel if necessary.
  */

-               ldr     lr, [r6, #0]            @ potential appended dtb ?
+
+               stmfd   sp!, {r0-r1, lr}
+               kputc   #'a'
+               kputc   #'\n'
+               stmfd   sp!, {r0-r1, lr}
+               ldr     lr, [r6, #0]            @ potential appended dtb ?
 #ifndef __ARMEB__
                ldr     r1, =0xedfe0dd0         @ sig is 0xd00dfeed big endian
 #else
@@ -253,10 +259,35 @@ restart:  adr     r0, LC0
                cmp     lr, r1
                bne     dtb_check_done          @ not found

-               ldr     lr, [r8, #0]            @ conventionaly passed dtb ?
+               stmfd   sp!, {r0-r1, lr}
+               kputc   #'b'
+               kputc   #'\n'
+               kphex   r6, 8
+               kputc   #'\n'
+               kphex   r8, 8
+               kputc   #'\n'
+               stmfd   sp!, {r0-r1, lr}
+               cmp     r6, r8                  @ r8 already pointing to app
+               beq     skip_2nd_check          @ yes, leave 2nd check
+
+               stmfd   sp!, {r0-r1, lr}
+               kputc   #'c'
+               kputc   #'\n'
+               stmfd   sp!, {r0-r1, lr}
+               ldr     lr, [r8, #0]            @ conventionaly passed dtb ?
+#ifndef __ARMEB__
+               ldr     r1, =0xedfe0dd0         @ sig is 0xd00dfeed big endian
+#else
+               ldr     r1, =0xd00dfeed
+#endif
                cmp     lr, r1
-               beq     dtb_check_done          @ yes, do not manage it
+               beq     dtb_check_done          @ yes, use it instead of appended

+skip_2nd_check:
+               stmfd   sp!, {r0-r1, lr}
+               kputc   #'d'
+               kputc   #'\n'
+               stmfd   sp!, {r0-r1, lr}
 #ifdef CONFIG_ARM_ATAG_DTB_COMPAT
                /*
                 * OK... Let's do some funky business here.
-- 
1.8.0.1
