From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 10:49:53 +0000
Subject: [PATCH v5 02/14] ARM: Section based HYP idmap
In-Reply-To: <20130114102721.GB4751@redhat.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183848.46302.77369.stgit@ubuntu>
 <20130114102721.GB4751@redhat.com>
Message-ID: <20130114104952.GA4939@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 10:27:21AM +0000, Gleb Natapov wrote:
> On Tue, Jan 08, 2013 at 01:38:48PM -0500, Christoffer Dall wrote:
> > Add a method (hyp_idmap_setup) to populate a hyp pgd with an
> > identity mapping of the code contained in the .hyp.idmap.text
> > section.
> > 
> > Offer a method to drop this identity mapping through
> > hyp_idmap_teardown.
> > 
> > Make all the above depend on CONFIG_ARM_VIRT_EXT and CONFIG_ARM_LPAE.
> > 
> > Cc: Will Deacon <will.deacon@arm.com>
> > Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
> > ---
> >  arch/arm/include/asm/idmap.h                |    1 +
> >  arch/arm/include/asm/pgtable-3level-hwdef.h |    1 +
> >  arch/arm/kernel/vmlinux.lds.S               |    6 +++
> >  arch/arm/mm/idmap.c                         |   54 ++++++++++++++++++++++-----
> >  4 files changed, 50 insertions(+), 12 deletions(-)

[...]

> > -static void identity_mapping_add(pgd_t *pgd, unsigned long addr, unsigned long end)
> > +static void identity_mapping_add(pgd_t *pgd, const char *text_start,
> > +				 const char *text_end, unsigned long prot)
> >  {
> > -	unsigned long prot, next;
> > +	unsigned long addr, end;
> > +	unsigned long next;
> > +
> > +	addr = virt_to_phys(text_start);
> > +	end = virt_to_phys(text_end);
> How does this work with phys addresses greater than 32bit (with
> LPAE)? This was the same before the patch too, but I am still
> curious. Since __virt_to_phys() returns unsigned long kernel cannot be
> put in high memory, right?

Well, AArch32 (arch/arm/) only supports 32-bit virtual addresses by virtue
of the fact that our registers are only 32 bits wide, so we can't
identity-map physical addresses above the 4GB boundary.

You may want to look at the keystone patches from TI for insight about
kernels at high (>32-bit) addresses, although I've not seen any activity
around that for some time now (which is a pity, because the code-patching
stuff was in a good shape).

Will
