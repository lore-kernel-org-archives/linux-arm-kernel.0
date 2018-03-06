From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Mar 2018 15:25:45 +0000
Subject: [RFC PATCH v3 3/3] arm64/kernel: enable A53 erratum #8434319
 handling at runtime
In-Reply-To: <CAKv+Gu-aKVp_G5Fnjk9pbERG53pZQVn2LL5Yb_0E0yp3jfRRuQ@mail.gmail.com>
References: <20180214113645.16793-1-ard.biesheuvel@linaro.org>
 <20180214113645.16793-4-ard.biesheuvel@linaro.org>
 <20180305172256.GC12869@arm.com>
 <CAKv+Gu-qZR57jaLUjhJFkP2u=XzEN7ewX+GsrKbPbbONwvxBww@mail.gmail.com>
 <20180305173959.GB13385@arm.com>
 <CAKv+Gu-aKVp_G5Fnjk9pbERG53pZQVn2LL5Yb_0E0yp3jfRRuQ@mail.gmail.com>
Message-ID: <20180306152545.GD18477@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 06:01:30PM +0000, Ard Biesheuvel wrote:
> On 5 March 2018 at 17:40, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Mar 05, 2018 at 05:29:26PM +0000, Ard Biesheuvel wrote:
> >> On 5 March 2018 at 17:22, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Wed, Feb 14, 2018 at 11:36:45AM +0000, Ard Biesheuvel wrote:
> >> >> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> >> >> index 07823595b7f0..c065d5649b1b 100644
> >> >> --- a/arch/arm64/kernel/cpu_errata.c
> >> >> +++ b/arch/arm64/kernel/cpu_errata.c
> >> >> @@ -228,6 +228,23 @@ static int qcom_enable_link_stack_sanitization(void *data)
> >> >>  }
> >> >>  #endif       /* CONFIG_HARDEN_BRANCH_PREDICTOR */
> >> >>
> >> >> +static bool __maybe_unused
> >> >> +needs_erratum_843419_workaround(const struct arm64_cpu_capabilities *entry,
> >> >> +                             int scope)
> >> >> +{
> >> >> +     u32 cpuid = read_cpuid_id();
> >> >> +
> >> >> +     WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
> >> >> +
> >> >> +     if ((cpuid & MIDR_CPU_MODEL_MASK) != MIDR_CORTEX_A53)
> >> >> +             return false;
> >> >> +     else if ((cpuid & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK)) == 0x4)
> >> >> +             /* erratum was fixed in some versions of r0p4 */
> >> >> +             return !(read_cpuid(REVIDR_EL1) & BIT(8));
> >> >
> >> > The rXpY information is in the MIDR, so this is checking for something else
> >> > afaict.
> >> >
> >>
> >> No, it checks the REVIDR of r0p4 parts, of which bit 8 tells us if
> >> this specific erratum has been fixed.
> >
> > /me checks errata notice.
> >
> > Ok, fair enough! Given that it looks like this mechanism is used for other
> > errata too, it would make sense to support it in the arm64_cpu_capabilities
> > structure alongside the midr stuff.
> >
> 
> Are you saying I should abstract REVIDR access for this series? I
> don't mind, but in that case, could you be a bit clearer about what
> you would like to see?

Sorry, yes. I was thinking about having a revidr mask/value pair field in
the arm64_cpu_capabilities structure which, if set to a non-zero value by
the errata entry, is then used as a secondary check if the MIDR match
indicates that the CPU is affected by the erratum. A quick look at some of
our errata notices suggests that this can then be used for some other Cortex
cores as well.

Feel free to do it as a follow-up patch if it's easier.

Will
