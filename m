From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 16 Aug 2012 23:43:01 -0400 (EDT)
Subject: [PATCH] ARM: io: avoid writeback addressing modes for __raw_
 accessors
In-Reply-To: <1344956366-32574-1-git-send-email-will.deacon@arm.com>
References: <1344956366-32574-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1208161906390.1541@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Aug 2012, Will Deacon wrote:

> Data aborts taken to hyp mode do not provide a valid instruction
> syndrome field in the HSR if the faulting instruction is a memory
> access using a writeback addressing mode.
> 
> For hypervisors emulating MMIO accesses to virtual peripherals, taking
> such an exception requires disassembling the faulting instruction in
> order to determine the behaviour of the access. Since this requires
> manually walking the two stages of translation, the world must be
> stopped to prevent races against page aging in the guest, where the
> first-stage translation is invalidated after the hypervisor has
> translated to an IPA and the physical page is reused for something else.
> 
> This patch avoids taking this heavy performance penalty when running
> Linux as a guest by ensuring that our I/O accessors do not make use of
> writeback addressing modes.

How often does this happen?  I don't really see writeback as a common 
pattern for IO access.

What does happen quite a lot, though, is pre-indexed addressing.  For 
example, let's take this code which is fairly typical of driver code:

#define HW_REG1		0x10
#define HW_REG2		0x14
#define HW_REG3		0x18
#define HW_REG4		0x30

int hw_init(void __iomem *ioaddr)
{
	writel(0, ioaddr + HW_REG1)
	writel(-1, ioaddr + HW_REG2);
	writel(readl(ioaddr + HW_REG3) | 0xff, ioaddr + HW_REG4);
	return 0;
}

Right now this produces this:

hw_init:
        mov     r3, r0
        mvn     r2, #0
        mov     r0, #0
        str     r0, [r3, #16]
        str     r2, [r3, #20]
        ldr     r2, [r3, #24]
        orr     r2, r2, #255
        str     r2, [r3, #48]
        bx      lr

With your patch applied this becomes:

hw_init:
        add     r2, r0, #16
        mov     r3, #0
        str r3, [r2]
        mvn     r3, #0
        add     r2, r0, #20
        str r3, [r2]
        add     r3, r0, #24
        ldr r3, [r3]
        orr     r3, r3, #255
        add     r0, r0, #48
        str r3, [r0]
        mov     r0, #0
        bx      lr

This basically made every IO access into two instructions instead of 
only one, as well as increasing register pressure.

So, is the performance claim something that you've actually measured 
with a real system, or was it only theoretical?


Nicolas
