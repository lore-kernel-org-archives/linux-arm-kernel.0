From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Apr 2015 10:29:36 +0100
Subject: [PATCH] arm64: fix midr range for Cortex-A57 erratum 832075
In-Reply-To: <20150401092229.GC1552@arm.com>
References: <1427833848-12188-1-git-send-email-byan@nvidia.com>
 <alpine.DEB.2.02.1503312113340.24011@utopia.booyaka.com>
 <20150401092229.GC1552@arm.com>
Message-ID: <20150401092936.GD1552@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 10:22:29AM +0100, Will Deacon wrote:
> On Tue, Mar 31, 2015 at 10:17:21PM +0100, Paul Walmsley wrote:
> > On Tue, 31 Mar 2015, Bo Yan wrote:
> > > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > > index fa62637e63a8..7838f1578019 100644
> > > --- a/arch/arm64/kernel/cpu_errata.c
> > > +++ b/arch/arm64/kernel/cpu_errata.c
> > > @@ -88,7 +88,7 @@ struct arm64_cpu_capabilities arm64_errata[] = {
> > >  	/* Cortex-A57 r0p0 - r1p2 */
> > >  		.desc = "ARM erratum 832075",
> > >  		.capability = ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE,
> > > -		MIDR_RANGE(MIDR_CORTEX_A57, 0x00, 0x12),
> > > +		MIDR_RANGE(MIDR_CORTEX_A57, 0x00, 0x100002),
> > >  	},
> > >  #endif
> > >  	{
> > > -- 
> > > 2.1.4
> > 
> > Reviewed-by: Paul Walmsley <paul@pwsan.com>
> > 
> > Reviewed against DDI0488G section 4.3.1 "Main ID Register, EL1".  Looks 
> > like a cut-and-paste error from the A53 workarounds.
> 
> Thanks guys, I agree that this is a bug. I'll apply this, but using an
> explicit shift to set the variant (tweaked version below).
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index a66f4fa4d541..c998345a052f 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -70,7 +70,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>         /* Cortex-A57 r0p0 - r1p2 */
>                 .desc = "ARM erratum 832075",
>                 .capability = ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE,
> -               MIDR_RANGE(MIDR_CORTEX_A57, 0x00, 0x12),
> +               MIDR_RANGE(MIDR_CORTEX_A57, 0x00, (1 << MIDR_VARIANT_SHIFT) | 2,

With the missing close bracket, of course :)

I'll push out once I've done some testing.

Will
