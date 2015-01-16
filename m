From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 16 Jan 2015 15:07:49 +0000
Subject: [PATCH] soc: tegra: Add Tegra132 SoC to the DT list of Tegra SoCs
In-Reply-To: <alpine.DEB.2.02.1501161137351.9776@utopia.booyaka.com>
References: <alpine.DEB.2.02.1501161137351.9776@utopia.booyaka.com>
Message-ID: <20150116150749.GA32155@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

/me opens a delicious can of Lumbricus terrestris

My comments below aren't so much about this patch alone, but more about
the entire strategy with drivers/soc and the kind of code living there.

On Fri, Jan 16, 2015 at 11:39:13AM +0000, Paul Walmsley wrote:
> 
> Add "nvidia,tegra132" as a compatible string that denotes a Tegra SoC.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> ---
>  drivers/soc/tegra/common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
> index a71cb74..a952986 100644
> --- a/drivers/soc/tegra/common.c
> +++ b/drivers/soc/tegra/common.c
> @@ -15,6 +15,7 @@ static const struct of_device_id tegra_machine_match[] = {
>  	{ .compatible = "nvidia,tegra30", },
>  	{ .compatible = "nvidia,tegra114", },
>  	{ .compatible = "nvidia,tegra124", },
> +	{ .compatible = "nvidia,tegra132", },
>  	{ }
>  };

I'm rather worried by this.

The only user of this table is soc_is_tegra(), which seems to guard
several probe paths in drivers which are DT driven. Given that, I don't
see why this is necessary at all, because the presence of the
appropriate nodes should be sufficient to handle the early return from
an initcall.

More worryingly, if soc_is_tegra() returns true but the node isn't
found, the drivers decide to do things. If tegra_pmc_early_init passes
soc_is_tegra() (because we happened to match "nvidia,tegra132"), but
doesn't find a DTB entry for the pmc, it then pokes an assumed
hard-coded physical address.

Assuming things because of the _lack_ of a node has been a major pain
point on 32-bit as DTBs advanced and code was changed, resulting in boot
breaking or DTB compatibility breaking over time as old and new kernels
made conflicting assumptions.

I don't want to see arm64 kernels making assumptions in that manner (nor
would I like to see it in new code for 32-bit ARM); it always leads to
boot breakage, and it's completely avoidable. The only thing we can know
is what is described in the DTB.

So NAK to this addition while soc_is_tegra is in use in that way, and
NAK to any DTS patches adding any of the strings that would cause
soc_is_tegra to return true on arm64.

There's also the worrying pattern of initcalls that look for particular
compatible strings -- why can't these use the existing DT probing
infrastructure rather than rolling their own? It would be nice to not
accumulate initcalls that only make sense on one platform.

Thanks,
Mark.
