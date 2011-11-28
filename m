From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Nov 2011 11:53:24 +0000
Subject: GIC irq_start detection breaks 3.2 boot on platforms without PPIs
In-Reply-To: <20111128113800.GD26946@mudshark.cambridge.arm.com>
References: <20111124163548.GC22031@mudshark.cambridge.arm.com>
 <CAL_Jsq+xZayXkOy2v7y+BittjRfC85mw-bCMrDFwDJOvnMnS8Q@mail.gmail.com>
 <20111125154157.GP12047@mudshark.cambridge.arm.com>
 <20111126220834.GB9581@n2100.arm.linux.org.uk>
 <20111127130016.GB26042@mudshark.cambridge.arm.com>
 <20111128113800.GD26946@mudshark.cambridge.arm.com>
Message-ID: <20111128115324.GH9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 11:38:00AM +0000, Will Deacon wrote:
> On Sun, Nov 27, 2011 at 01:00:16PM +0000, Will Deacon wrote:
> > On Sat, Nov 26, 2011 at 10:08:34PM +0000, Russell King - ARM Linux wrote:
> > > I've merged this into my fixes branch, but when I re-merge this with
> > > Marc's irqchip consolidation, I get conflicts.  I think I've fixed it
> > > correctly, but please check the result, which you'll find in my for-next
> > > branch.
> > 
> > Thanks for merging this. I've just had a quick look and the resolution looks
> > functionally correct to me (I'll try booting your for-next branch tomorrow).
> 
> I've tested on 1176, A8 and A9 platforms and your for-next branch seems to
> be ok. I do get these compilation warnings on the UP CPUs:
> 
> arch/arm/mm/ioremap.c: In function ?unmap_area_sections?:
> arch/arm/mm/ioremap.c:80:3: warning: passing argument 1 of ?pmd_offset? from incompatible pointer type
> /home/will/work/aarch32/linux/linux/arch/arm/include/asm/pgtable.h:181:22: note: expected ?struct pud_t *? but argument is of type ?pmdval_t (*)[2]?
> arch/arm/mm/ioremap.c: In function ?remap_area_sections?:
> arch/arm/mm/ioremap.c:130:3: warning: passing argument 1 of ?pmd_offset? from incompatible pointer type
> /home/will/work/aarch32/linux/linux/arch/arm/include/asm/pgtable.h:181:22: note: expected ?struct pud_t *? but argument is of type ?pmdval_t (*)[2]?
> arch/arm/mm/ioremap.c: In function ?remap_area_supersections?:
> arch/arm/mm/ioremap.c:167:4: warning: passing argument 1 of ?pmd_offset? from incompatible pointer type
> /home/will/work/aarch32/linux/linux/arch/arm/include/asm/pgtable.h:181:22: note: expected ?struct pud_t *? but argument is of type ?pmdval_t (*)[2]?

Welcome to those warnings.

This is something that I've been complaining about for the last year, and
is one of the reasons I've not been all that eager to merge the LPAE
patches until it's properly resolved.

The problem is caused by my "ARM: pgtable: switch to use pgtable-nopud.h"
commit, which fixes up everywhere we access a small page table to use
the standard pgd-pud-pmd-pte stuff.  However, section support makes the
conversion completely awful.

> and if I cat /proc/self/net/dev_mcast, then I get an OOPs:
> 
> [   41.771296] Unable to handle kernel NULL pointer dereference at virtual address 00000010
> [   41.797076] pgd = c797c000
> [   41.806863] [00000010] *pgd=070e7831, *pte=00000000, *ppte=00000000
> [   41.827111] Internal error: Oops: 17 [#1] PREEMPT
> [   41.841221] Modules linked in:
> [   41.850392] CPU: 0    Tainted: G        W     (3.2.0-rc2+ #3)
> [   41.867681] PC is at dev_seq_next+0x14c/0x1dc
> [   41.880763] LR is at seq_read+0x43c/0x494
> [   41.892798] pc : [<c024d564>]    lr : [<c00cee54>]    psr: 60000013
> [   41.892826] sp : c79f3ed4  ip : 00006405  fp : 00008000
> [   41.927254] r10: 00000010  r9 : c79f3f80  r8 : 00000010
> [   41.942927] r7 : 00000000  r6 : 00000001  r5 : c041d100  r4 : 00000001
> [   41.962512] r3 : c024d418  r2 : c79f3f08  r1 : 00000001  r0 : c70e5640
> [   41.982100] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [   42.003512] Control: 00c5387d  Table: 0797c008  DAC: 00000015
> [   42.020750] Process cat (pid: 764, stack limit = 0xc79f22f0)
> [   42.037728] Stack: (0xc79f3ed4 to 0xc79f4000)
> [   42.050805] 3ec0:                                              00000000 00000001 c70e5640
> [   42.075369] 3ee0: c7091b00 00000000 c79f3f80 c79f3f08 c03f07c4 0138a000 c70e5668 00000000
> [   42.099931] 3f00: 00000000 400f1000 00000001 00000000 00000025 c7862000 c00cea18 0138a000
> [   42.124493] 3f20: c79f3f80 c79f2000 c79f2000 00000000 00000000 c00f6c2c 000000c5 c7091b00
> [   42.149059] 3f40: 0138a000 0138a000 c79f3f80 c7091b00 00008000 c00b0be8 00000003 c00a8124
> [   42.173621] 3f60: 00000001 c7091b00 0138a000 00000000 00000000 00008000 00000000 c00b0cf8
> [   42.198181] 3f80: 00000000 00000000 00000025 00000000 00008000 0138a000 00000003 00000003
> [   42.222745] 3fa0: c000e344 c000e1c0 00008000 0138a000 00000003 0138a000 00008000 0138a000
> [   42.247307] 3fc0: 00008000 0138a000 00000003 00000003 0138a000 00000000 400f1000 00000000
> [   42.271869] 3fe0: 7fffe000 be951b50 0000dea0 401f8a7c 60000010 00000003 00000000 00000000
> [   42.296468] [<c024d564>] (dev_seq_next+0x14c/0x1dc) from [<c03f07c4>] (0xc03f07c4)
> [   42.319206] Code: eaffffee e590803c e59f508c e1a0a008 (e5984000) 
> [   42.343526] ---[ end trace 1b75b31a2719ed1f ]---
> 
> but I don't think that's your fault (excuse the pun)!

It is showing another problem - that's an incomplete backtrace,
presumably because c03f07c4 is not within the kernel text.  Either
the stack has been corrupted or some other badness has happened,
or maybe the unwinder isn't working properly.
