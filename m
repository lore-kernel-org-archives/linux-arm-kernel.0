From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Dec 2010 23:35:58 +0000
Subject: [RFC 2/2] Selective MMU identity mapping for kexec
In-Reply-To: <1292434762.2926.7.camel@e102144-lin.cambridge.arm.com>
References: <1288636375-22805-1-git-send-email-per.xx.fransson@stericsson.com>
	<1288636375-22805-3-git-send-email-per.xx.fransson@stericsson.com>
	<1292434762.2926.7.camel@e102144-lin.cambridge.arm.com>
Message-ID: <20101215233558.GK9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 05:39:22PM +0000, Will Deacon wrote:
> Hi Per,
> 
> It's nice to see somebody looking at this!
> 
> On Mon, 2010-11-01 at 19:32 +0100, Per Fransson wrote:
> > Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> > ---
> >  arch/arm/kernel/machine_kexec.c   |   27 +++++++++++++++++++++-
> >  arch/arm/kernel/relocate_kernel.S |   23 +++++++++++++++++++
> >  arch/arm/mm/mmu.c                 |   44 +++++++++++++++++++++++++++++++++++++
> >  arch/arm/mm/proc-v7.S             |    1 +
> >  4 files changed, 94 insertions(+), 1 deletions(-)
> 
> Some parts of this patchset will be useful for implementing CPU hotplug
> on the ARM RealView boards. The idea is to throw cores back to the
> bootloader when they are offlined, so we need to be able to disable the
> MMU safely before we jump.

Beware - you can't replace random pre-existing table entries on a running
SMP system without creating hazards.

> > +	cpu_reset_phys = virt_to_phys(cpu_reset);
> > +	identity_map(cpu_reset_phys, &kexec_mmu_ents[0].store,
> > +		     &kexec_mmu_ents[0].ptr);
> > +	identity_map(((char *)cpu_reset_phys)+PGDIR_SIZE,
> > +		     &kexec_mmu_ents[1].store, &kexec_mmu_ents[1].ptr);
> 
> I think this could become common code as calling cpu_reset will require
> the identity map to be in place now that you have added MMU disable code
> there.

We have an identity mapping function set in the kernel (which has been
recently moved into its own file in my devel branch.)  It would need to
be extended to return the old pmd and pmd pointer to undo.
