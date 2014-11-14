From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Nov 2014 13:55:31 +0000
Subject: some question about TCR setting
In-Reply-To: <CAOVJa8Fx4yiSU0O7HTaYEKOrRdtWve4JGeN0cWRXDsBMyV_8Mg@mail.gmail.com>
References: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
 <20141114104246.GA25828@leverpostej>
 <CAOVJa8Fx4yiSU0O7HTaYEKOrRdtWve4JGeN0cWRXDsBMyV_8Mg@mail.gmail.com>
Message-ID: <20141114135531.GA27768@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 01:13:12PM +0000, vichy wrote:
> hi Mark:
> > The CPU can't read the attributes from the page tables, because in order
> > to do so it would need to know the attributes to access the page tables
> > with. Additionally, the page tables might not always be mapped into the
> > virtual address space.
> Per your explanation, if the page table base address in TTBR is
> 0x1000000, {SH,ORGN,IRGN}{1,0} tell cpu how to access this part of
> physical address, right?

If that were TTBR0_ELx {SH,ORGN,IRGN}0 would apply, and for TTBR1_ELx
{SH,ORGN,IRGN}1 would apply. 

> if so, I have some questions:
> 1. The processor use {SH,ORGN,IRGN}{1,0} in TCR to access all the
> following page directories?

Yes.

> 2. under what circumstance, the page tables might not always be mapped
> into the virtual address space.

Consider CONFIG_HIGHPTE. The physical address space can be larger than
the virtual address space, in which case not everything can be
permanently mapped.

> 3. if the {SH,ORGN,IRGN}{1,0} of block/page descriptor is conflict
> with that one in TCR. Will that make cache maintenance issue.

If page tables are accessed with different attributes from those used to
walk them (i.e. those programmed into the TCR), the usual coherency
issues would apply.

Mark.
