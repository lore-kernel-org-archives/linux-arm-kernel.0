From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 16 Apr 2014 17:08:35 -0400
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
Message-ID: <534EF153.5050603@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Thanks for your response.

On 04/16/2014 03:14 PM, Nicolas Pitre wrote:
> On Wed, 16 Apr 2014, Christopher Covington wrote:
> 
>> On 04/15/2014 06:44 AM, Daniel Thompson wrote:
>>> Hi Folks
>>>
>>> I've just been rebasing some of my development branches against v3.15rc1
>>> and observed some boot regressions due to TEXT_OFFSET changing from
>>> 0x8000 to 0x208000.
>>>
>>> Now the boot regression turned out to be fault in the JTAG boot tools I
>>> was using (it had internally hardcoded to TEXT_OFFSET to 0x8000 when
>>> calculating what physical load address to use). I've fixed the JTAG
>>> loader and my own boards now boots fine.
>>
>> Your tools are not alone in being affected by this change. QEMU is considering
>> changing their hard-coded value to 0x8000 [1], which I was eager to see until
>> being reminded of this (that patch would still be an improvement, but not
>> enough for users of new multiplatform kernels).
>>
>> The boot-wrapper [2] (the default bootloader for ARM's proprietary models
>> which could potentially be used on other systems) is also affected.
> 
> Why would QEMU and the ARM boot-wrap-per care about the kernel 
> TEXT_OFFSET value?

The simulators I'm familiar with all have the equivalent of a built-in JTAG
debugger, capable of peeking at and poking memory, servicing Angel semihosting
calls, and so on. Knowledge of the TEXT_OFFSET is required for loading
non-self-uncompressing images for the same reasons as when using JTAG on real
hardware, as I understand it.

> I may understand the desire to boot a plain uncompressed Image over JTAG 
> and in this case you are amongst a very small group of people doing so 
> and therefore should be knowing what you're doing.  In other words this 
> is a minor inconvenient to a few people.

I didn't mean to imply that there is a large user base for this style of
loading, just that an approach that works across multiple tools would be nice
if change is warranted.

> But both QEMU and the boot-wrapper should deal with zImage. That's the 
> only image format with documented load offset is guaranteed not to 
> change i.e. it can be loaded at about any offset as zImage knows how to 
> relocate itself as needed.  There is nowhere a guarantee that 
> TEXT_OFFSET can't change.

QEMU definitely does support zImage and I believe it's promoted as the main
boot method. I would expect the bootwrapper to work with zImages, as its (in
the non-semihosting case) basically just packing the kernel, device tree and
initramfs up into an ELF file that's loaded into memory by a simulator's
built-in JTAG-like loader.

> And if you think booting zImage on ARM models is too slow, then simply 
> try out CONFIG_KERNEL_LZO.

Thanks for the tip.

>> My current thinking is that even if we temporarily removed variance (the
>> jumping about) by maybe building every image with the maximum offset that any
>> image could have, there would still be variance between images built before
>> and after that change, and maybe also when some new platform gets added with
>> an even higher offset. So if there's going to be variance, could we maybe make
>> it no longer a problem?
> 
> There is already no problem with zImage.
> 
>> It seems to me that if external/uncompressed image loaders could query the
>> text offset in a straightforward manner, variance between images could be
>> easily dealt with. Would reading it out of ELF metadata be a reasonable
>> mechanism? Could the ELF format vmlinux be a suitable general replacement for
>> the raw Image?
> 
> The ELF image only has virtual addresses in it.  And the virtual address 
> of the kernel may be changed independently of TEXT_OFFSET with 
> CONFIG_VMSPLIT_*.

Do you know why this is the case? The ELF format is capable of storing
physical addresses as mentioned below.

>> Now at least with my current .config, the vmlinux only has virtual addresses.
>> Documentation/arm/Booting says the MMU has to be off at boot time so this
>> still might not be the ideal input for image loaders. Tools could hard-code
>> the phsyical-to-virtual offset instead of the TEXT_OFFSET. Is that less likely
>> to vary?
> 
> Physical offset does vary from one platform to another, so this 
> particular physical-to-virtual offset is actually determined at run time 
> and the kernel runtime patched during early boot -- see __fixup_pv_table 
> in arch/arm/kernel/head.S.

What I meant to ask about was variance from one kernel version and build to
the next, given a single platform. Platform-to-platform variation can probably
be abstracted where needed by the scripts controlling the external load. In
any case, CONFIG_VMSPLIT_* that you mentioned above would be an example where
it would vary in an inconvenient manner, so this approach wouldn't be an
improvement.

>> Or could we patch up the linker script to set zero-based ELF load
>> memory addresses (LMAs) [4] so that the physical addresses are almost right,
>> you just might have to add a system-specific RAM offset, perhaps pulled out of

I don't think I made this very clear, but adding the offset would happen at
load/run-time, controlled by JTAG scripts or simulator equivalent.

>> the device tree? If that won't work, we could generate some kind of
>> vmlinux-phys with physical addresses. The latter two options might also
>> simplify external debugging before __turn_mmu_on(). I like the sound of the
>> LMA approach best, assuming it doesn't break existing stuff (I notice a few AT
>> directives in vmlinux.lds.S). Some of this might transfer to arm64 as well.
>> What do you all think?
>
> If you really really want to get at the TEXT_OFFSET value in the 
> uncompressed image, the simplest way would be:
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index f8c08839ed..de84d0635a 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -78,6 +78,11 @@
>  
>  	__HEAD
>  ENTRY(stext)
> +
> +	b	1f
> +	.word	TEXT_OFFSET		@ located at a 4-byte offset in Image
> +1:
> +
>   ARM_BE8(setend	be )			@ ensure we are in BE8 mode
>  
>   THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
> 
> This way the first word for Image would always be 0xea000000 and the 
> second one would be TEXT_OFFSET.  No other kernel Image binaries ever 
> had 0xea000000 as their first word so that also let you validate whether 
> or not the TEXT_OFFSET value is there.

Thank you for the suggestion. This approach also came to mind, but it would
require new documentation and tooling in the JTAG scripts or simulator
equivalent. That's another aspect of the ELF-based approaches that I
like--hopefully existing documentation and tool support could be reused.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
