From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Jan 2018 10:00:34 +0000
Subject: [v2,03/11] arm64: Take into account ID_AA64PFR0_EL1.CSV3
In-Reply-To: <20180109040626.GB4924@jc-sabre>
References: <1515157961-20963-4-git-send-email-will.deacon@arm.com>
 <20180108072253.GA178830@jc-sabre>
 <9bc1f137-d78c-e46e-e1bc-f49160d5f289@arm.com>
 <20180108174016.GB180149@jc-sabre> <20180108175100.GW25869@arm.com>
 <20180109040626.GB4924@jc-sabre>
Message-ID: <20180109100034.GD4297@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 08:06:27PM -0800, Jayachandran C wrote:
> On Mon, Jan 08, 2018 at 05:51:00PM +0000, Will Deacon wrote:
> > On Mon, Jan 08, 2018 at 09:40:17AM -0800, Jayachandran C wrote:
> > > On Mon, Jan 08, 2018 at 09:20:09AM +0000, Marc Zyngier wrote:
> > > > On 08/01/18 07:24, Jayachandran C wrote:
> > > > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > > > index 19ed09b..202b037 100644
> > > > > --- a/arch/arm64/kernel/cpufeature.c
> > > > > +++ b/arch/arm64/kernel/cpufeature.c
> > > > > @@ -862,6 +862,13 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> > > > >                 return __kpti_forced > 0;
> > > > >         }
> > > > >  
> > > > > +       /* Don't force KPTI for CPUs that are not vulnerable */
> > > > > +       switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
> > > > > +               case MIDR_CAVIUM_THUNDERX2:
> > > > > +               case MIDR_BRCM_VULCAN:
> > > > > +                       return false;
> > > > > +       }
> > > > > +
> > > > >         /* Useful for KASLR robustness */
> > > > >         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > > > >                 return true;
> > > > > 
> > > > 
> > > > KPTI is also an improvement for KASLR. Why would you deprive a user of
> > > > the choice to further secure their system?
> > > 
> > > The user has a choice with kpti= at the kernel command line, so we are
> > > not depriving the user of a choice. KASLR is expected to be enabled by
> > > distributions, and KPTI will be enabled by default as well.
> > > 
> > > On systems that are not vulnerable to variant 3, this is an unnecessary
> > > overhead.
> > 
> > KASLR can be bypassed on CPUs that are not vulnerable to variant 3 simply
> > by timing how long accesses to kernel addresses from EL0 take -- please read
> > the original KAISER paper for details about that attack on x86. kpti
> > mitigates that. If you don't care about KASLR, don't enable it (arguably
> > it's useless without kpti).
> 
> The code above assumes that all ARM CPUs (now and future) will be vulnerable
> to timing attacks that can bypass KASLR. I don't think that is a correct
> assumption to make.

Well, the code is assuming that the difference between a TLB hit and a miss
can be measured and that permission faulting entries can be cached in the
TLB. I think that's a safe assumption for the moment. You can also disable
kaslr on the command line and at compile-time if you don't want to use it,
and the same thing applies to kpti. I really see this more as user
preference, rather than something that should be keyed off the MIDR and we
already provide those controls via the command line.

To be clear: I'll take the MIDR whitelisting, but only after the KASLR check
above.

> If ThunderX2 is shown to be vulnerable to any timing based attack we can
> certainly move the MIDR check after the check for the CONFIG_RANDOMIZE_BASE.
> But I don't think that is the case now, if you have any PoC code to check
> this I can run on the processor and make the change.

I haven't tried, but if you have a TLB worth its salt, I suspect you can
defeat kaslr by timing prefetches or faulting loads to kernel addresses.

> It is pretty clear that we need a whitelist check either before or after the
> CONFIG_RANDOMIZE_BASE check.

Please send a patch implementing this after the check.

> The kaiser paper seems to say that ARM TTBR0/1 made it more immune, and the
> prefetch paper(if I understand correctly) showed that prefetch on some ARM
> cores can be used for timing attack. This is probably and area where you will
> have better information, so any specific pointers would be appreciated - 
> especially ones showing that all ARM CPUs are susceptible.

Pretty much all the stuff specific to ARM (and there's not much) in the
paper is incorrect, but the basic premise of the timnig attacks is sound.

Will
