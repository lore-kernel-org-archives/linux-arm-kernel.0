From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 May 2012 11:23:27 +0100
Subject: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
 address space.
In-Reply-To: <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508124116.GE17798@arm.com>
 <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
 <20120508215554.GA18980@n2100.arm.linux.org.uk>
 <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
Message-ID: <20120509102327.GF11099@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 09:50:28AM +0100, Shilimkar, Santosh wrote:
> On Wed, May 9, 2012 at 3:25 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, May 08, 2012 at 07:31:57PM +0530, Shilimkar, Santosh wrote:
> >> Ok. Assuming you mean " it's _not_ cleaner to have two domains where
> >> manager overrides XN attributes" Note that DRAM can be in the middle of
> >> 4GB address space, so we need to take care of bottom and top address
> >> space.
> >>
> >> Update patch end of the email. Is that fine with you ?
> >
> > This is certainly not cleaner because this will break non-ARMv7.
> 
> The only change done common code is  clearing 'XN' bit for DRAM
> region in page table entries. The other change of setting the DACR
> register is done in ARMv7 specific code.
> 
> So it should work as long as XN bit supported or that
> bit position is not used. I checked ARMv6(OMAP2) and that seems
> to be fine.
> 
> Can you please help me to understand which ARM version will
> be broken because of this change and how ? I only have access
> to ARMv6 and ARMv7 specs.

It's probably ARMv5 and earlier that didn't have an XN bit (introduced
with ARMv6).

I have an old ARM ARM on my desk and it looks like bit 4 is XN on ARMv6+
and Implementation Defined on ARMv5 and earlier.  It looks like we set
it all the time in the current decompressor.

Looking at the arch/arm/mm/mmu.c file, there is this PMD_BIT4 which is
always set on ARMv5 and earlier except Xscale and XSC3 (see the comment
in build_mem_type_table).

-- 
Catalin
