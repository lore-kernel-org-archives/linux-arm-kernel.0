From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Wed, 29 Apr 2015 11:14:02 +0200
Subject: [RFC] arm: pick the r2 passed DTB over the appended one
In-Reply-To: <alpine.LFD.2.11.1504282315320.1582@knanqh.ubzr>
References: <1429880030-21473-1-git-send-email-valentin.longchamp@keymile.com>
 <alpine.LFD.2.11.1504282315320.1582@knanqh.ubzr>
Message-ID: <5540A0DA.9060409@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2015 05:50 AM, Nicolas Pitre wrote:
> On Fri, 24 Apr 2015, Valentin Longchamp wrote:
> 
>> Thanks to the APPENDED_DTB option, it is possible to append the dtb to
>> the kernel's binary image. This is very convenient to accomodate old
>> bootloaders that do not pass a dtb.
>>
>> We have updated a product with a new version of the bootloader that now
>> passed the dtb properly in r2. However, we still want to support with
>> the same software (i.e. kernel) the old bootloader, where the dtb must
>> be appended, but give the priority to to the one passed in r2.
>>
>> This patch tries cover the above use case. It works for the case a dtb
>> is passed in r2 and one is appended (the one pointed by r2 is picked).
>> However, when there is only an appended dtb and r2 points to an ATAG
>> list, this fails. Somehow, the presumably updated r2 does not point to a
>> valid dtb and it gets zeroed by __vet_atags.
> 
> Do you have CONFIG_ARM_ATAG_DTB_COMPAT set?

Yes, it is set.

> 
> I don't see how this could be related, but you should consider adding 
> commit c2607f74aa to your kernel if not already there.

I have included it in the meantime, thanks. It does not change the below
behavior however.

> 
>> Below is an example of this (end of bootloader, start of kernel):
>>
>> at 02000000 ...
>>   Image Name:   Linux-3.10.60-7.2.2-00002-gc6acc
>>   Image Type:   ARM Linux Kernel Image (uncompressed)
>>   Data Size:    2904550 Bytes = 2.8 MiB
>>   Load Address: 00008000
>>   Entry Point:  00008000
>>   Verifying Checksum ... OK
>>   Loading Kernel Image ... OK
>> OK
>> r2 (0x00000100) points to (size, header): 0x00000005, 0x54410001
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>> e5943000
> 
> Where is this value from? This looks like an ARM opcode ("ldr r3, [r4]").

This value that I print out actually is the content of the memory pointed by the
r2 register, printed from __vet_atags (head-common.S)

It can very well be an ARM opcode from the kernel binary since the r2 register
does not point to a DTB but to some other location.

I now have further debugged this and I now understand why it does not work as I
expect it: I have noticed that (at least with our kernel and our system) this
code gets executed twice. This is has the consequence for the case where the DTB
is appended and atags are passed to r2, my check is valid the first time this
code is run. However, the second time, r8 (pointer to atags/dtb) was updated
with r6 (pointer to _edata/appended dtb), which means that my additional check
will cause the code to jump to dtb_check_done. So the DTB is not copied over
with the rest of the kernel binary, because r6, r10 and sp and not "relocated"
past the dtb !

Now my question is: is this normal that this code is executed twice or is a
problem on our side ? If it is normal, I need to add further checks. If not, I
would rather keep my implementation roughly as it is and rather troubleshoot
this "double execution".

Maybe it is important to tell that we use a uImage for our kernel (U-boot
wrapped zImage).

> 
>> trying to parse the FDT
>>
>> dt_phys (r2) is NULL !
>>
>> Error: unrecognized/unsupported machine ID (r1 = 0x000008cf).
>>
>> Available machine support:
>>
>> ID (hex)	NAME
>> ffffffff	Marvell Kirkwood (Flattened Device Tree)
>>
>> Please check your kernel config and/or bootloader.
>>
>> Is this patch a correct approach to implement the above use case ? If
>> yes, does anyone has an idea why this fails ?
>>
>> Note: this patch is for the 3.10 stable branch.
>>
>> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
>> ---
>>  arch/arm/boot/compressed/head.S | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index 032a8d9..a43c8a0 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -244,7 +244,7 @@ restart:	adr	r0, LC0
>>   * dtb data will get relocated along with the kernel if necessary.
>>   */
>>  
>> -		ldr	lr, [r6, #0]
>> +		ldr	lr, [r6, #0]		@ potential appended dtb ?
>>  #ifndef __ARMEB__
>>  		ldr	r1, =0xedfe0dd0		@ sig is 0xd00dfeed big endian
>>  #else
>> @@ -253,6 +253,10 @@ restart:	adr	r0, LC0
>>  		cmp	lr, r1
>>  		bne	dtb_check_done		@ not found
>>  
>> +		ldr	lr, [r8, #0] 		@ conventionaly passed dtb ?
>> +		cmp	lr, r1
>> +		beq	dtb_check_done		@ yes, do not manage it
>> +
>>  #ifdef CONFIG_ARM_ATAG_DTB_COMPAT
>>  		/*
>>  		 * OK... Let's do some funky business here.
>> -- 
>> 1.8.0.1
>>
>>
