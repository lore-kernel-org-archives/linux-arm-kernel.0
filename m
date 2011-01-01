From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Jan 2011 12:05:52 +0000
Subject: [PATCH] mmci: call flush_dcache_page() outside of atomic kmap
In-Reply-To: <1293878168-12741-1-git-send-email-rabin@rab.in>
References: <1293878168-12741-1-git-send-email-rabin@rab.in>
Message-ID: <20110101120539.GA25924@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 01, 2011 at 04:06:08PM +0530, Rabin Vincent wrote:
> While booting a QEMU Versatile/PB system with the root file system on
> SD, the following WARN_ON hits:
> 
> ------------[ cut here ]------------
> WARNING: at /home/rabin/kernel/arm/lib/scatterlist.c:426 sg_miter_stop+0x64/0x9c()
> Modules linked in:
> [<c0031da4>] (unwind_backtrace+0x0/0xe4) from [<c003d5c0>] (warn_slowpath_common+0x4c/0x64)
> [<c003d5c0>] (warn_slowpath_common+0x4c/0x64) from [<c003d5f0>] (warn_slowpath_null+0x18/0x1c)
> [<c003d5f0>] (warn_slowpath_null+0x18/0x1c) from [<c0148338>] (sg_miter_stop+0x64/0x9c)
> [<c0148338>] (sg_miter_stop+0x64/0x9c) from [<c01a892c>] (mmci_pio_irq+0x1fc/0x270)
> [<c01a892c>] (mmci_pio_irq+0x1fc/0x270) from [<c0065928>] (handle_IRQ_event+0x24/0xf0)
> [<c0065928>] (handle_IRQ_event+0x24/0xf0) from [<c0067930>] (handle_level_irq+0xa4/0x114)
> [<c0067930>] (handle_level_irq+0xa4/0x114) from [<c0036258>] (sic_handle_irq+0x50/0x60)
> [<c0036258>] (sic_handle_irq+0x50/0x60) from [<c0022070>] (asm_do_IRQ+0x70/0x94)
> [<c0022070>] (asm_do_IRQ+0x70/0x94) from [<c002c0b4>] (__irq_svc+0x34/0xa0)
> 
> It's the WARN_ON(!irqs_disabled()) in sg_miter_stop():
> 
>                 if (miter->__flags & SG_MITER_ATOMIC) {
>                         WARN_ON(!irqs_disabled());
>                         kunmap_atomic(miter->addr, KM_BIO_SRC_IRQ);
>                 }
> 
> This is because if the cache is VIVT, flush_dcache_page() calls
> __flush_dcache_aliases() when a user space mapping exists.  That
> function uses flush_dcache_mmap_unlock() which is spin_unlock_irq(),
> which enables interrupts.   Fix this by calling flush_dcache_page() only
> after the sg_miter is stopped.

I think there's some questions that need to be answered here first:

1. Why does this not trigger on real PB926 hardware?
2. Why the hell is a page being submitted which is mapped into userspace
   yet has not already been populated with data from the card?

(2) is a serious error, what it means is that userspace can access the
data which was _previously_ in the page before the page has been read
with the required data.

In any case, this patch is unacceptable - trying to fix it by saving the
IRQ-disabled state around each scatterlist iterator function in case it
returns with IRQs enabled is just not on.  It's a bodge at best, and at
worst it's opening up windows for a pile of races.
