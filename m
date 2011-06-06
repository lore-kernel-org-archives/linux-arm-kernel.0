From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 6 Jun 2011 16:49:59 +0200 (CEST)
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <4DECCADE.6080100@selfish.org>
References: <4DECCADE.6080100@selfish.org>
Message-ID: <alpine.LFD.2.02.1106061518480.13964@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Jun 2011, Holger Freyther wrote:

> Hi,
> 
> my not mainlined with custom drivers board support seems to suffer from an
> issue introduced by moving the irq.c to the generic GPIO interrupt code
> (aac4dd1dab8acfc244d697473d2a5f4424a5746c, reverting it makes the oops go
> away). I think this is caused by either interrupt #46 or #47 on this system
> which is on the second 'bank'.
> 
> At first I thought that the usage of IRQ_ENT_REG1_OFFSET and IRQ_REG1_OFFSET
> was simply omitted but there is the for loop that counts j by four (offset
> between REG0 and REG1).
> 
> 
> Is this issue known to anyone? I feel try to understand this a bit more as
> well and try to come up with a patch.
> 
> Unable to handle kernel paging request at virtual address 5ffffc1b
> [5ffffc1b] *pgd=00000000
> Internal error: Oops: 801 [#1] PREEMPT
> Modules linked in: ...
> CPU: 0    Tainted: G         C   (3.0.0-rc2-00006-gff5f4d6-dirty #68)
> PC is at irq_gc_mask_clr_bit+0x38/0x40
> LR is at gpio_irq_handler+0x44/0xdc
> pc : [<c0d6f3a4>]    lr : [<c0d29a74>]    psr: 60000093
> sp : c10abe68  ip : 00000001  fp : c10abe74
> r10: 00000000  r9 : c10b69d0  r8 : 00000001
> r7 : fec67010  r6 : 0000ffff  r5 : 00000038  r4 : 00000038
> r3 : 0000001c  r2 : 00000400  r1 : 5ffffbff  r0 : c70050f0

5ffffbff + 1c = 5ffffc1b. Looking at the disassembly:

0000014c <irq_gc_mask_clr_bit>:
 14c:   e5903014        ldr     r3, [r0, #20]
 150:   e590c000        ldr     ip, [r0]
 154:   e5932004        ldr     r2, [r3, #4]
 158:   e593100c        ldr     r1, [r3, #12]
 15c:   e062200c        rsb     r2, r2, ip
 160:   e3a0c001        mov     ip, #1
 164:   e1c1221c        bic     r2, r1, ip, lsl r2
 168:   e583200c        str     r2, [r3, #12]
 16c:   e590000c        ldr     r0, [r0, #12]
 170:   e5931000        ldr     r1, [r3]
 174:   e5903064        ldr     r3, [r0, #100]  ; 0x64
 178:   e7812003        str     r2, [r1, r3]
 17c:   e12fff1e        bx      lr

So it's the "str r2, [r1, r3]" and obviously r1 is pointing into
nirwana. r3 makes me wonder as well. We write 0x18 into ct->regs.mask
because we add 0x04 to the base pointer. So where comes the 0x1c from?

R1 and R3 are read from the generic chip data structure and I'm pretty
sure that you are chasing some weird data corruption and that
reverting that patch makes it invisible for whatever reason.

Thanks,

	tglx
