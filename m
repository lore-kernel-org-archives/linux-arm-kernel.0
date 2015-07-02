From: msalter@redhat.com (Mark Salter)
Date: Thu, 02 Jul 2015 13:40:22 -0400
Subject: [PATCH] ARM64 / SMP: Switch pr_err() to pr_debug() for disabled
 GICC entry
In-Reply-To: <20150702162940.GF1354@e104818-lin.cambridge.arm.com>
References: <1435757843-13236-1-git-send-email-hanjun.guo@linaro.org>
 <20150702162940.GF1354@e104818-lin.cambridge.arm.com>
Message-ID: <1435858822.24502.10.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-07-02 at 17:29 +0100, Catalin Marinas wrote:

> On Wed, Jul 01, 2015 at 09:37:23PM +0800, Hanjun Guo wrote:

> > It is normal that firmware presents GICC entry or entries (processors)
> > with disabled flag in ACPI MADT, taking a system of 16 cpus for example,
> > ACPI firmware may present 8 enabled first with another 8 cpus disabled
> > in MADT, the disabled cpus can be hot-added later.
> > 
> > Firmware may also present more cpus than the hardware actually has, but
> > disabled the unused ones, and easily enable it when the hardware has such
> > cpus to make the firmware code scalable.
> > 
> > So that's not an error for disabled cpus in MADT, we can switch
> > pr_err() to pr_debug() instead.
> > 
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  arch/arm64/kernel/smp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 4b2121b..5caf04a 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -402,7 +402,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
> >  	}
> >  
> >  	if (!(processor->flags & ACPI_MADT_ENABLED)) {
> > -		pr_err("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
> > +		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
> 
> That's a pretty harmless change. But looking at the use-case, would we
> expect the disabled entries to have a valid hwid? I guess such hwid is
> not known, especially if we can hot-plug some CPU at a later time. If
> that's the case, can we also move this check before the hwid one?
> 

Heh, I should have read ahead. I just made the same point in a
mail I just sent.
