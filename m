From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 13 Jun 2014 15:51:39 +0200
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140613133437.1a85f287@free-electrons.com>
References: <20140526162643.GB3693@n2100.arm.linux.org.uk>
 <20140527111542.6a49833f@free-electrons.com>
 <20140527094749.GE3693@n2100.arm.linux.org.uk>
 <20140527135216.7eaf3b3f@free-electrons.com>
 <20140527121806.GF3693@n2100.arm.linux.org.uk>
 <20140527143745.386c77d9@free-electrons.com>
 <20140528112450.GH3693@n2100.arm.linux.org.uk>
 <20140530100819.1208149f@free-electrons.com>
 <20140530092044.GO3693@n2100.arm.linux.org.uk>
 <20140613121121.7e7dc8e6@free-electrons.com>
 <20140613102019.GQ23430@n2100.arm.linux.org.uk>
 <20140613133437.1a85f287@free-electrons.com>
Message-ID: <20140613155139.05e2393c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, 13 Jun 2014 13:34:37 +0200, Thomas Petazzoni wrote:

> > The patches I sent during this thread are now merged into mainline.  The
> > setting of the shared bit, and the memory cache policy are now both
> > derived from the proc_info structures, specifically the __cpu_mm_mmu_flags
> > member.
> 
> Right. So for Armada 370/XP, I'll update the proc_info structure. We
> still have to find the right solution/compromise for the Armada 375/38x
> though.

So, I had a look at that, and there are still I believe a few issues to
solve:

 * Your change that takes the PMD flags set by the assembly code as the
   reference can easily be used by specifying mm_mmuflags =
   PMD_SECT_WBWA for Armada 370 and PMD_SECT_WBWA|PMD_SECT_S for Armada
   XP to get write-allocate on Armada 370 and write-allocate +
   shareable on Armada XP.

   However, this adjusts only the PMD flags, and does not adjust
   the TTB flags: they are still governed only by the ALT_UP/ALT_SMP
   logic:

#define TTB_FLAGS_UP	TTB_IRGN_WB|TTB_RGN_OC_WB
#define TTB_FLAGS_SMP	TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
[...]
	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)

   Do you have a suggestion on how to handle this?

 * Regarding setting the SMP bit and TLB broadcast bit for Cortex-A9,
   I've moved the __v7_ca9mp_setup code outside of the common Cortex-A
   code so that it does set both bits as soon as it's a SMP-capable
   Cortex-A9. Something like (untested):

/*
 * Cortex-A9 is handled as a special case, as we want the SMP bit to
 * be set regardless of whether CONFIG_SMP is enabled or not: as soon
 * as the processor is SMP capable, we want to enable the SMP bit so
 * that Cortex-A9 processors that support hardware I/O coherency will
 * operate properly.
 */
__v7_ca9mp_setup:
	mcr	p15, 0, r0, c0, c0, 5		@ read MPIDR
	and	r0, r0, #0xc0000000		@ multiprocessing extensions and
	teq	r0, #0x80000000			@ not part of a uniprocessor system?
	bne	__v7_setup

	mrc	p15, 0, r0, c1, c0, 1
	tst	r0, #(1 << 6)
	orreq	r0, r0, #((1 << 6) | (1 << 10))
	mcreq	p15, 0, r0, c1, c0, 1
	b	__v7_setup

   Would this be acceptable?

 * Regarding setting the write allocate and shareable attribute in the
   PMD bits for SMP-capable Cortex-A9, I was hoping to be able to do
   that from the __v7_ca9mp_setup function above, but in fact this
   per-processor 'initfunc' is called *after* the page tables are
   created. So I'm not sure where to put the logic that detects we have
   an SMP-capable Cortex-A9 and tweak the PMD flags accordingly. Any
   suggestion?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
