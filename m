From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 16 Apr 2014 12:18:52 -0400
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <534D0D91.8020406@linaro.org>
References: <534D0D91.8020406@linaro.org>
Message-ID: <534EAD6C.3040502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 06:44 AM, Daniel Thompson wrote:
> Hi Folks
> 
> I've just been rebasing some of my development branches against v3.15rc1
> and observed some boot regressions due to TEXT_OFFSET changing from
> 0x8000 to 0x208000.
> 
> Now the boot regression turned out to be fault in the JTAG boot tools I
> was using (it had internally hardcoded to TEXT_OFFSET to 0x8000 when
> calculating what physical load address to use). I've fixed the JTAG
> loader and my own boards now boots fine.

Your tools are not alone in being affected by this change. QEMU is considering
changing their hard-coded value to 0x8000 [1], which I was eager to see until
being reminded of this (that patch would still be an improvement, but not
enough for users of new multiplatform kernels).

The boot-wrapper [2] (the default bootloader for ARM's proprietary models
which could potentially be used on other systems) is also affected.

> However this did get me looking at what had causes the offset to change.
> I think that as some of the Qualcomm platforms have been converted to
> multi-arch then, for the first time some older code in arch/arm/Kernel
> gets enabled on the multi_v7 kernels:
> 
> --- cut here ---
> textofs-y       := 0x00008000
> textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000
> # We don't want the htc bootloader to corrupt kernel during resume
> textofs-$(CONFIG_PM_H1940)      := 0x00108000
> # SA1111 DMA bug: we don't want the kernel to live in precious DMA-able
> memory
> ifeq ($(CONFIG_ARCH_SA1100),y)
> textofs-$(CONFIG_SA1111) := 0x00208000
> endif
> textofs-$(CONFIG_ARCH_MSM7X30) := 0x00208000
> textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
> textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
> --- cut here ---
> 
> It strikes me as a bit of a "bad smell" that enabling architecture
> options in the multi-arch kernel causes the text offset to jump about
> (not least because more than one platform might seek to change the text
> offset).
> 
> Do the ARCH_QCOM platforms (ARCH_MSM8X60 & ARCH_MSM8960) still require a
> special text offset?

[Stephen Boyd replied yes (3).]

So, what do we do?

My current thinking is that even if we temporarily removed variance (the
jumping about) by maybe building every image with the maximum offset that any
image could have, there would still be variance between images built before
and after that change, and maybe also when some new platform gets added with
an even higher offset. So if there's going to be variance, could we maybe make
it no longer a problem?

It seems to me that if external/uncompressed image loaders could query the
text offset in a straightforward manner, variance between images could be
easily dealt with. Would reading it out of ELF metadata be a reasonable
mechanism? Could the ELF format vmlinux be a suitable general replacement for
the raw Image?

Now at least with my current .config, the vmlinux only has virtual addresses.
Documentation/arm/Booting says the MMU has to be off at boot time so this
still might not be the ideal input for image loaders. Tools could hard-code
the phsyical-to-virtual offset instead of the TEXT_OFFSET. Is that less likely
to vary? Or could we patch up the linker script to set zero-based ELF load
memory addresses (LMAs) [4] so that the physical addresses are almost right,
you just might have to add a system-specific RAM offset, perhaps pulled out of
the device tree? If that won't work, we could generate some kind of
vmlinux-phys with physical addresses. The latter two options might also
simplify external debugging before __turn_mmu_on(). I like the sound of the
LMA approach best, assuming it doesn't break existing stuff (I notice a few AT
directives in vmlinux.lds.S). Some of this might transfer to arm64 as well.
What do you all think?

1. http://lists.nongnu.org/archive/html/qemu-devel/2014-03/msg04715.html
2. http://linux-arm.org/git?p=boot-wrapper.git;a=summary
3. http://archive.arm.linux.org.uk/lurker/message/20140415.175318.5032983c.en.html
4. https://sourceware.org/binutils/docs/ld/Output-Section-LMA.html

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
