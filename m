From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 16 Apr 2014 15:14:19 -0400 (EDT)
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <534EAD6C.3040502@codeaurora.org>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
Message-ID: <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014, Christopher Covington wrote:

> On 04/15/2014 06:44 AM, Daniel Thompson wrote:
> > Hi Folks
> > 
> > I've just been rebasing some of my development branches against v3.15rc1
> > and observed some boot regressions due to TEXT_OFFSET changing from
> > 0x8000 to 0x208000.
> > 
> > Now the boot regression turned out to be fault in the JTAG boot tools I
> > was using (it had internally hardcoded to TEXT_OFFSET to 0x8000 when
> > calculating what physical load address to use). I've fixed the JTAG
> > loader and my own boards now boots fine.
> 
> Your tools are not alone in being affected by this change. QEMU is considering
> changing their hard-coded value to 0x8000 [1], which I was eager to see until
> being reminded of this (that patch would still be an improvement, but not
> enough for users of new multiplatform kernels).
> 
> The boot-wrapper [2] (the default bootloader for ARM's proprietary models
> which could potentially be used on other systems) is also affected.

Why would QEMU and the ARM boot-wrap-per care about the kernel 
TEXT_OFFSET value?

I may understand the desire to boot a plain uncompressed Image over JTAG 
and in this case you are amongst a very small group of people doing so 
and therefore should be knowing what you're doing.  In other words this 
is a minor inconvenient to a few people.

But both QEMU and the boot-wrapper should deal with zImage. That's the 
only image format with documented load offset is guaranteed not to 
change i.e. it can be loaded at about any offset as zImage knows how to 
relocate itself as needed.  There is nowhere a guarantee that 
TEXT_OFFSET can't change.

And if you think booting zImage on ARM models is too slow, then simply 
try out CONFIG_KERNEL_LZO.

> My current thinking is that even if we temporarily removed variance (the
> jumping about) by maybe building every image with the maximum offset that any
> image could have, there would still be variance between images built before
> and after that change, and maybe also when some new platform gets added with
> an even higher offset. So if there's going to be variance, could we maybe make
> it no longer a problem?

There is already no problem with zImage.

> It seems to me that if external/uncompressed image loaders could query the
> text offset in a straightforward manner, variance between images could be
> easily dealt with. Would reading it out of ELF metadata be a reasonable
> mechanism? Could the ELF format vmlinux be a suitable general replacement for
> the raw Image?

The ELF image only has virtual addresses in it.  And the virtual address 
of the kernel may be changed independently of TEXT_OFFSET with 
CONFIG_VMSPLIT_*.

> Now at least with my current .config, the vmlinux only has virtual addresses.
> Documentation/arm/Booting says the MMU has to be off at boot time so this
> still might not be the ideal input for image loaders. Tools could hard-code
> the phsyical-to-virtual offset instead of the TEXT_OFFSET. Is that less likely
> to vary?

Physical offset does vary from one platform to another, so this 
particular physical-to-virtual offset is actually determined at run time 
and the kernel runtime patched during early boot -- see __fixup_pv_table 
in arch/arm/kernel/head.S.

> Or could we patch up the linker script to set zero-based ELF load
> memory addresses (LMAs) [4] so that the physical addresses are almost right,
> you just might have to add a system-specific RAM offset, perhaps pulled out of
> the device tree? If that won't work, we could generate some kind of
> vmlinux-phys with physical addresses. The latter two options might also
> simplify external debugging before __turn_mmu_on(). I like the sound of the
> LMA approach best, assuming it doesn't break existing stuff (I notice a few AT
> directives in vmlinux.lds.S). Some of this might transfer to arm64 as well.
> What do you all think?

If you really really want to get at the TEXT_OFFSET value in the 
uncompressed image, the simplest way would be:

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f8c08839ed..de84d0635a 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -78,6 +78,11 @@
 
 	__HEAD
 ENTRY(stext)
+
+	b	1f
+	.word	TEXT_OFFSET		@ located at a 4-byte offset in Image
+1:
+
  ARM_BE8(setend	be )			@ ensure we are in BE8 mode
 
  THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.

This way the first word for Image would always be 0xea000000 and the 
second one would be TEXT_OFFSET.  No other kernel Image binaries ever 
had 0xea000000 as their first word so that also let you validate whether 
or not the TEXT_OFFSET value is there.


Nicolas
