From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jan 2018 17:51:00 +0000
Subject: [v2,03/11] arm64: Take into account ID_AA64PFR0_EL1.CSV3
In-Reply-To: <20180108174016.GB180149@jc-sabre>
References: <1515157961-20963-4-git-send-email-will.deacon@arm.com>
 <20180108072253.GA178830@jc-sabre>
 <9bc1f137-d78c-e46e-e1bc-f49160d5f289@arm.com>
 <20180108174016.GB180149@jc-sabre>
Message-ID: <20180108175100.GW25869@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 09:40:17AM -0800, Jayachandran C wrote:
> On Mon, Jan 08, 2018 at 09:20:09AM +0000, Marc Zyngier wrote:
> > On 08/01/18 07:24, Jayachandran C wrote:
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 19ed09b..202b037 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -862,6 +862,13 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> > >                 return __kpti_forced > 0;
> > >         }
> > >  
> > > +       /* Don't force KPTI for CPUs that are not vulnerable */
> > > +       switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
> > > +               case MIDR_CAVIUM_THUNDERX2:
> > > +               case MIDR_BRCM_VULCAN:
> > > +                       return false;
> > > +       }
> > > +
> > >         /* Useful for KASLR robustness */
> > >         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > >                 return true;
> > > 
> > 
> > KPTI is also an improvement for KASLR. Why would you deprive a user of
> > the choice to further secure their system?
> 
> The user has a choice with kpti= at the kernel command line, so we are
> not depriving the user of a choice. KASLR is expected to be enabled by
> distributions, and KPTI will be enabled by default as well.
> 
> On systems that are not vulnerable to variant 3, this is an unnecessary
> overhead.

KASLR can be bypassed on CPUs that are not vulnerable to variant 3 simply
by timing how long accesses to kernel addresses from EL0 take -- please read
the original KAISER paper for details about that attack on x86. kpti
mitigates that. If you don't care about KASLR, don't enable it (arguably
it's useless without kpti).

Will
