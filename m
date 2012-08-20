From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Aug 2012 13:41:10 +0100
Subject: [PATCH] ARM: io: avoid writeback addressing modes for __raw_
 accessors
In-Reply-To: <alpine.LFD.2.02.1208161906390.1541@xanadu.home>
References: <1344956366-32574-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.02.1208161906390.1541@xanadu.home>
Message-ID: <20120820124109.GK25864@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

[apologies in advance for the long reply]

On Fri, Aug 17, 2012 at 04:43:01AM +0100, Nicolas Pitre wrote:
> On Tue, 14 Aug 2012, Will Deacon wrote:
> 
> > Data aborts taken to hyp mode do not provide a valid instruction
> > syndrome field in the HSR if the faulting instruction is a memory
> > access using a writeback addressing mode.
> > 
> > For hypervisors emulating MMIO accesses to virtual peripherals, taking
> > such an exception requires disassembling the faulting instruction in
> > order to determine the behaviour of the access. Since this requires
> > manually walking the two stages of translation, the world must be
> > stopped to prevent races against page aging in the guest, where the
> > first-stage translation is invalidated after the hypervisor has
> > translated to an IPA and the physical page is reused for something else.
> > 
> > This patch avoids taking this heavy performance penalty when running
> > Linux as a guest by ensuring that our I/O accessors do not make use of
> > writeback addressing modes.
> 
> How often does this happen?  I don't really see writeback as a common 
> pattern for IO access.

Building a Thumb-2 kernel with GCC:

gcc version 4.6.3 20120201 (prerelease) (crosstool-NG
linaro-1.13.1-2012.02-20120222 - Linaro GCC 2012.02)

Translates the following code from amba_device_add:

		for (pid = 0, i = 0; i < 4; i++)
			pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
				(i * 8);
		for (cid = 0, i = 0; i < 4; i++)
			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
				(i * 8);

into:

c0177bec:       f853 2b04       ldr.w   r2, [r3], #4	<---
c0177bf0:       f3bf 8f4f       dsb     sy
c0177bf4:       b2d2            uxtb    r2, r2
c0177bf6:       40a2            lsls    r2, r4
c0177bf8:       3408            adds    r4, #8
c0177bfa:       2c20            cmp     r4, #32
c0177bfc:       ea45 0502       orr.w   r5, r5, r2
c0177c00:       d1f4            bne.n   c0177bec <amba_device_add+0x94>
c0177c02:       f1a8 0810       sub.w   r8, r8, #16
c0177c06:       2300            movs    r3, #0
c0177c08:       44c8            add     r8, r9
c0177c0a:       461c            mov     r4, r3
c0177c0c:       f858 2b04       ldr.w   r2, [r8], #4	<---
c0177c10:       f3bf 8f4f       dsb     sy
c0177c14:       b2d2            uxtb    r2, r2
c0177c16:       409a            lsls    r2, r3
c0177c18:       3308            adds    r3, #8
c0177c1a:       2b20            cmp     r3, #32
c0177c1c:       ea44 0402       orr.w   r4, r4, r2
c0177c20:       d1f4            bne.n   c0177c0c <amba_device_add+0xb4>

so this is happening with recent toolchains and current kernel sources.

> What does happen quite a lot, though, is pre-indexed addressing.  For 
> example, let's take this code which is fairly typical of driver code:
> 
> #define HW_REG1		0x10
> #define HW_REG2		0x14
> #define HW_REG3		0x18
> #define HW_REG4		0x30
> 
> int hw_init(void __iomem *ioaddr)
> {
> 	writel(0, ioaddr + HW_REG1)
> 	writel(-1, ioaddr + HW_REG2);
> 	writel(readl(ioaddr + HW_REG3) | 0xff, ioaddr + HW_REG4);
> 	return 0;
> }
> 
> Right now this produces this:
> 
> hw_init:
>         mov     r3, r0
>         mvn     r2, #0
>         mov     r0, #0
>         str     r0, [r3, #16]
>         str     r2, [r3, #20]
>         ldr     r2, [r3, #24]
>         orr     r2, r2, #255
>         str     r2, [r3, #48]
>         bx      lr

Well, that's not quite true for CONFIG_ARM_DMA_MEM_BUFFERABLE=y. The dsb and
compiler barrier ends up creating this monster for that code:

00000280 <hw_init>:
 280:   4603            mov     r3, r0
 282:   f3bf 8f4f       dsb     sy
 286:   2000            movs    r0, #0
 288:   6118            str     r0, [r3, #16]
 28a:   f3bf 8f4f       dsb     sy
 28e:   f04f 32ff       mov.w   r2, #4294967295
 292:   615a            str     r2, [r3, #20]
 294:   f3bf 8f4f       dsb     sy
 298:   699a            ldr     r2, [r3, #24]
 29a:   f3bf 8f4f       dsb     sy
 29e:   f042 02ff       orr.w   r2, r2, #255    ; 0xff
 2a2:   631a            str     r2, [r3, #48]   ; 0x30
 2a4:   4770            bx      lr
 2a6:   bf00            nop

whilst the addressing modes are still nice, the dsb is going to be the
performance limitation here. That said, we could try the "Qo" constraints,
which I seem to remember don't generate writebacks. I'll have a play.

> So, is the performance claim something that you've actually measured 
> with a real system, or was it only theoretical?

The difference is down to the work done by the hypvervisor: an MMIO access
will trap to hyp mode, where the HSR describes the instruction (access size,
load/store, Rt, signed etc). For the case of a writeback instruction, this
information is not provided by the hardware. Instead, the hypervisor has to
disassemble the faulting instruction and work out what it's doing at which
address prior to emulation.

Even if that cost was acceptable, the problem then gets worse. Imagine that
a guest MMIO access faults into the hypervisor, where the emulation code
tries to decode the instruction because the fault information is incomplete.
To do this, it must obtain the *physical* address of the faulting text page
so that it can load the instruction. This happens via the ATS12NSOP{R,W}
registers, which return a PA for the faulting VA (i.e. both stages of
translation).

Now, let's say the hypervisor has got hold of a PA but hasn't yet loaded the
instruction. Meanwhile, another virtual CPU running the same guest decides
(due to page aging or whatnot) to reclaim the text page containing the
faulting instruction. It writes a faulting pte and does a TLB invalidation,
however this is too late for the hypervisor, who has already translated its
address. Furthermore, let's say that the guest then reuses the same physical
page for something like a network buffer. The hypervisor goes ahead and grabs
what it thinks is the faulting instruction from memory but in fact gets a
load of random network data!

To deal with this, the hypervisor will likely have to stop the virtual world
when emulating any MMIO accesses that report incomplete fault information to
avoid racing with a TLB invalidation from another virtual CPU. That will
certainly be more expensive than an additional instruction on each access.
To answer your question: I haven't measured it (largely because KVM can't
pull apart Thumb-2 instructions yet).

I believe that the KVM guys were planning to print a diagnostic prior to
emulation/world-stop if the fault information is incomplete, complaining that
the guest is using writeback addressing modes for I/O.

Cheers,

Will
