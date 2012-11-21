From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Nov 2012 12:22:51 +0000
Subject: [PATCH V5 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <50ACC198.5030300@free-electrons.com>
References: <1353446150-10088-1-git-send-email-gregory.clement@free-electrons.com>
 <1353446150-10088-6-git-send-email-gregory.clement@free-electrons.com>
 <20121121104132.GD11990@mudshark.cambridge.arm.com>
 <50ACC198.5030300@free-electrons.com>
Message-ID: <20121121122251.GI11990@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 11:57:12AM +0000, Gregory CLEMENT wrote:
> On 11/21/2012 11:41 AM, Will Deacon wrote:
> >> +/*
> >> + * Armada XP specific entry point for secondary CPUs.
> >> + * We add the CPU to the coherency fabric and then jump to secondary
> >> + * startup
> >> + */
> >> +ENTRY(armada_xp_secondary_startup)
> >> +
> >> +	/* Read CPU id */
> >> + 	mrc     p15, 0, r1, c0, c0, 5
> >> +	and     r1, r1, #0xF
> >> +
> >> +	/* Add CPU to coherency fabric */
> >> +	ldr     r0, = ARMADA_XP_CFB_BASE
> >> +	mov	lr, pc
> >> +
> >> +	b	ll_set_cpu_coherent
> >> +	b	secondary_startup
> > 
> > Why didn't you use my adr suggestion here?
> 
> Because when I used BSYM(secondary_startup), I get the following
> message during compilation:
> 
> Error: undefined symbol secondary_startup used as an immediate value

Sorry, my mistake (I was thinking on my feet) since secondary_startup is
declared in a C file, right? How about:

	ldr	lr, =secondary_startup
	b	ll_set_cpu_coherent

> And I didn't want to miss the merge window for something which could be
> fixed during the v3.8-rc1 if needed.

Sure, but it also seems daft to merge something that's nine tenths of the
way there when it's straight-forward to finish it off properly.

Will
