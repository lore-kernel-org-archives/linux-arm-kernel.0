From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Jan 2018 11:55:15 +0000
Subject: [PATCH v3 2/2] arm64: Turn on KPTI only on CPUs that need it
In-Reply-To: <CAKv+Gu_kOYYx3Qa8OsfsxJDLMSrWVNrt7kmtJOue9sVaTdGqXg@mail.gmail.com>
References: <20180118135354.GB20783@arm.com>
 <1516364568-95577-1-git-send-email-jnair@caviumnetworks.com>
 <1516364568-95577-2-git-send-email-jnair@caviumnetworks.com>
 <20180122114155.GC15456@arm.com>
 <CAKv+Gu_kOYYx3Qa8OsfsxJDLMSrWVNrt7kmtJOue9sVaTdGqXg@mail.gmail.com>
Message-ID: <20180122115515.GF15456@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 11:51:34AM +0000, Ard Biesheuvel wrote:
> On 22 January 2018 at 11:41, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jan 19, 2018 at 04:22:48AM -0800, Jayachandran C wrote:
> >> Whitelist Broadcom Vulcan/Cavium ThunderX2 processors in
> >> unmap_kernel_at_el0(). These CPUs are not vulnerable to
> >> CVE-2017-5754 and do not need KPTI when KASLR is off.
> >>
> >> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> >> ---
> >>  arch/arm64/kernel/cpufeature.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >> index 647d44b..fb698ca 100644
> >> --- a/arch/arm64/kernel/cpufeature.c
> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> @@ -866,6 +866,13 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> >>       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> >>               return true;
> >>
> >> +     /* Don't force KPTI for CPUs that are not vulnerable */
> >> +     switch (read_cpuid_id() & MIDR_CPU_MODEL_MASK) {
> >> +     case MIDR_CAVIUM_THUNDERX2:
> >> +     case MIDR_BRCM_VULCAN:
> >> +             return false;
> >> +     }
> >> +
> >>       /* Defer to CPU feature registers */
> >>       return !cpuid_feature_extract_unsigned_field(pfr0,
> >>                                                    ID_AA64PFR0_CSV3_SHIFT);
> >
> > We'll need to re-jig this to work properly with big/little because this is
> > only called once, but that's ok for now:
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > Suzuki has a series reworking much of the cpufeatures code so that we can
> > do this properly for 4.17.
> >
> 
> If we start adding opt outs here, we should at least include A53, and
> probably replace
> 
> >>       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> >>               return true;
> 
> with
> 
> >>       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0)
> >>               return true;
> 
> so that adding 'nokaslr' to the command line also disables KPTI.

Yup, I was going to do this once we have the new cpufeatures code from
Suzuki and can safely whitelist cores that can appear in big/little
configurations.

Will
