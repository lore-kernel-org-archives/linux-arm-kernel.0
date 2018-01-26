From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jan 2018 14:05:46 +0000
Subject: [PATCH 4/7] arm64: kpti: Add ->enable callback to remap swapper
 using nG mappings
In-Reply-To: <2d89624a-ccc2-78a0-deaf-e0494636659a@arm.com>
References: <1516968197-23206-1-git-send-email-will.deacon@arm.com>
 <1516968197-23206-5-git-send-email-will.deacon@arm.com>
 <2d89624a-ccc2-78a0-deaf-e0494636659a@arm.com>
Message-ID: <20180126140546.GA25364@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Fri, Jan 26, 2018 at 01:40:50PM +0000, Marc Zyngier wrote:
> On 26/01/18 12:03, Will Deacon wrote:
> > +/*
> > + * void __kpti_install_ng_mappings(int cpu, int num_cpus, phys_addr_t swapper)
> > + *
> > + * Called exactly once from stop_machine context by each CPU found during boot.
> > + */
> > +__idmap_kpti_flag:
> > +	.long	1
> 
> I'm a bit concerned that we're placing the counter in a section that is
> not writeable (at least in theory). We can either have the idmap
> writeable entirely, or have a idmap data section (which means extending
> it to be more than a single page).

The idmap is mapped using the same attributes as the initial swapper
mappings (SWAPPER_MM_MMUFLAGS) but, unlike swapper, it is not subsequently
remapped and therefore remains writeable.

I could update the .pushsection flags to reflect this with "awx"?

Also, whilst looking around in head.S, I noticed phys_to_pte. I'll move
that into assembler.h and switch the argument order as a separate patch.

> Not sure if that's a concern, but I thought I'd raise it. The core works
> pretty well as is, so  it cannot be completely wrong... ;-)

Is that a Tested-by? ;)

> > +ENTRY(idmap_kpti_install_ng_mappings)
> > +	cpu		.req	w0
> > +	num_cpus	.req	w1
> > +	swapper_pa	.req	x2
> > +	swapper_ttb	.req	x3
> > +	flag_ptr	.req	x4
> > +	cur_pgdp	.req	x5
> > +	end_pgdp	.req	x6
> > +	pgd		.req	x7
> > +	cur_pudp	.req	x8
> > +	end_pudp	.req	x9
> > +	pud		.req	x10
> > +	cur_pmdp	.req	x11
> > +	end_pmdp	.req	x12
> > +	pmd		.req	x13
> > +	cur_ptep	.req	x14
> > +	end_ptep	.req	x15
> > +	pte		.req	x16
> > +
> > +	mrs	swapper_ttb, ttbr1_el1
> > +	adr	flag_ptr, __idmap_kpti_flag
> > +
> > +	cbnz	cpu, __idmap_kpti_secondary
> > +
> > +	/* We're the boot CPU. Wait for the others to catch up */
> > +	sevl
> > +1:	wfe
> > +	ldaxr	w18, [flag_ptr]
> > +	eor	w18, w18, num_cpus
> > +	cbnz	w18, 1b
> > +
> > +	/* We need to walk swapper, so turn off the MMU. */
> > +	pre_disable_mmu_workaround
> > +	mrs	x18, sctlr_el1
> > +	bic	x18, x18, #1
> 
> nit: You should be able to use SCTLR_ELx_M, as we already include
> sysreg.h (indirectly).

Aha, I looked for that and failed to find it. Thanks.

Will
