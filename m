From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Oct 2015 16:18:58 +0100
Subject: [PATCH v2 1/2] ARM: Availability of psci_smp_available depends
 on CONFIG_SMP
In-Reply-To: <20151006081122.GA21527@ulmo.nvidia.com>
References: <cover.1442990383.git.jan.kiszka@siemens.com>
 <8b94f7869972d64f442f97208707a5856cbc8b14.1442990383.git.jan.kiszka@siemens.com>
 <20151006081122.GA21527@ulmo.nvidia.com>
Message-ID: <20151006151857.GA2416@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 10:11:24AM +0200, Thierry Reding wrote:
> On Wed, Sep 23, 2015 at 08:39:43AM +0200, Jan Kiszka wrote:
> > Ensure that we can use psci_smp_available without checking for
> > CONFIG_SMP first.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >  arch/arm/include/asm/psci.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> > index 68ee3ce..ff956f4 100644
> > --- a/arch/arm/include/asm/psci.h
> > +++ b/arch/arm/include/asm/psci.h
> > @@ -16,7 +16,7 @@
> >  
> >  extern struct smp_operations psci_smp_ops;
> >  
> > -#ifdef CONFIG_ARM_PSCI
> > +#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_SMP)
> >  bool psci_smp_available(void);
> >  #else
> >  static inline bool psci_smp_available(void) { return false; }
> 
> Hi Will,

Hi Thierry,

> you had questions about this when this was first submitted back in
> May[0], but discussion stalled. Can you take another look, please?
> 
> I think irrespective of what the series is trying to do this is a
> correct fix. The arch/arm/kernel/psci_smp.c file is only compiled if
> both ARM_PSCI and SMP are selected. Builds break if we don't mirror
> that conditional in the header because for ARM_PSCI && !SMP no dummy
> will be defined, but the implementation for the prototype won't be
> available either, leading to a linker error.

Sure, I'm fine with this patch in isolation, I just didn't (don't) fully
grok what the series is trying to achieve.

Will
