From: will.deacon@arm.com (Will Deacon)
Date: Tue, 27 Nov 2018 19:31:23 +0000
Subject: [PATCH 1/7] arm64: capabilities: Merge entries for
 ARM64_WORKAROUND_CLEAN_CACHE
In-Reply-To: <20181126150956.GA24096@en101>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
 <1541418917-14219-2-git-send-email-suzuki.poulose@arm.com>
 <20181126140603.GA29684@arm.com> <20181126150956.GA24096@en101>
Message-ID: <20181127193123.GH5641@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2018 at 03:09:56PM +0000, Suzuki K Poulose wrote:
> On Mon, Nov 26, 2018 at 02:06:04PM +0000, Will Deacon wrote:
> > On Mon, Nov 05, 2018 at 11:55:11AM +0000, Suzuki K Poulose wrote:
> > > We have two entries for ARM64_WORKAROUND_CLEAN_CACHE capability :
> > > 
> > > 1) ARM Errata 826319, 827319, 824069, 819472 on A53 r0p[012]
> > > 2) ARM Errata 819472 on A53 r0p[01]
> > > 
> > > Both have the same work around. Merge these entries to avoid
> > > duplicate entries for a single capability.
> > > 
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Andre Przywara <andre.przywara@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >  arch/arm64/kernel/cpu_errata.c | 19 +++++++------------
> > >  1 file changed, 7 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > > index a509e351..c825bc0 100644
> > > --- a/arch/arm64/kernel/cpu_errata.c
> > > +++ b/arch/arm64/kernel/cpu_errata.c
> > > @@ -573,24 +573,19 @@ static const struct midr_range arm64_harden_el2_vectors[] = {
> > >  const struct arm64_cpu_capabilities arm64_errata[] = {
> > >  #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
> > >  	defined(CONFIG_ARM64_ERRATUM_827319) || \
> > > -	defined(CONFIG_ARM64_ERRATUM_824069)
> > > +	defined(CONFIG_ARM64_ERRATUM_824069) || \
> > > +	defined(CONFIG_ARM64_ERRATUM_819472)
> > >  	{
> > > -	/* Cortex-A53 r0p[012] */
> > > -		.desc = "ARM errata 826319, 827319, 824069",
> > > +	/*
> > > +	 * Cortex-A53 r0p[012]: ARM errata 826319, 827319, 824069
> > > +	 * Cortex-A53 r0p[01] : ARM errata 819472
> > > +	 */
> > > +		.desc = "ARM errata 826319, 827319, 824069, 819472",
> > >  		.capability = ARM64_WORKAROUND_CLEAN_CACHE,
> > >  		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A53, 0, 0, 2),
> > >  		.cpu_enable = cpu_enable_cache_maint_trap,
> > 
> > Isn't this a semantic change wrt the Kconfig options? After this change,
> > if I /only/ set CONFIG_ARM64_ERRATUM_819472=y, then I still get the
> > workaround applied for CPUs > r0[p01] which isn't what I asked for.
> 
> You're right. I could change this to :

Indeed, and you'll probably need something similar for the other entries
that you're merging.

Will
