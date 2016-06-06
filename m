From: wmills@ti.com (William Mills)
Date: Mon, 6 Jun 2016 08:31:53 -0400
Subject: [RFC v2 1/4] ARM: mm: add early page table attribute modification
 ability
In-Reply-To: <20160606121812.GK1041@n2100.armlinux.org.uk>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-2-git-send-email-wmills@ti.com>
 <20160606121812.GK1041@n2100.armlinux.org.uk>
Message-ID: <57556D39.7050701@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/06/2016 08:18 AM, Russell King - ARM Linux wrote:
> On Sun, Jun 05, 2016 at 11:20:26PM -0400, Bill Mills wrote:
>> Allow early-init to specify modifications to be made to the boot time page
>> table. Any modifications specified will be done with MMU off at the same
>> time that any Phy<->Virt fixup is done.
> 
> I think this is rather over-engineered - do we need to support multiple
> different fixups to the page tables like this?

Yes I was expecting this comment but thought I would give you the choice. :)

> 
> Given how this has grown, I think it would be better to duplicate the
> existing swapper_pg_dir, modify the new copy, and then have the
> pv-fixup-asm code merely copy the new to the old with the MMU off.
> That way, the only two things that the assembly code has to do is to
> deal with the page table update, and updating the TTBR registers.
> Most of the complexity can then be kept in the C code.
> 

I really like this.  I can just do the outer shared fixup and not worry
about a generalized mechanism.  *If* someone needs to do another fixup
they can just code it in C.

The new patch #1 will just rework the PV_FIXUP for the new asm/C split.

You want the off-line table to copy over the early table in place w/ MMU
off, correct? (Not update the HW to point to a new spot.)

> I think we also need to modify the TTBCR to match the sharability of
> memory - currently, TTB walks will be inner sharable, but my
> understanding is that if we switch memory to be outer sharable, we
> also need to update the TTB walks to match.
> 

Good point, Thanks.  I don't think our internal hack has been doing that.
