From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Jun 2014 14:21:39 -0600
Subject: [PATCH 2/2] ARM: tegra: Initialize flow controller from DT
In-Reply-To: <1402487891-6493-2-git-send-email-thierry.reding@gmail.com>
References: <1402487891-6493-1-git-send-email-thierry.reding@gmail.com>
 <1402487891-6493-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <539A0BD3.6060002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2014 05:58 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use a matching device tree node to initialize the flow controller driver
> instead of hard-coding the I/O address. This is necessary to get rid of
> the iomap.h include, which in turn make it easier to share this code
> with 64-bit Tegra SoCs.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Note that this doesn't provide a fallback option for compatibility with
> old device trees. Any kind of fallback would require either the iomap.h
> file to remain included or copying out some parts verbatim, which to a
> large degree defies the whole purpose of this patch. The ultimate goal
> is to move this code into drivers/soc/tegra in order to allow sharing
> between 32- and 64-bit Tegra SoCs.
> 
> If we absolutely must have backwards compatibility with device trees
> that don't have the flow controller node and still want to share this
> code with ARM64, I don't see any other way than moving iomap.h to
> drivers/soc/tegra along with all the other code.

We do need a fallback. I think it would be as simple as the following:

  	np = of_find_matching_node(NULL, matches);
- 	BUG_ON(!np);
+ 	if (!np) {
+ 		base_addr = 0x60007000;
+ 		iomap(base_addr) // roughly this anyway

In other words, hard-code the fallback right where it's used. No need to
keep iomap.h around etc.

> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c

> @@ -80,6 +81,7 @@ static void __init tegra_init_early(void)
>  	tegra_cpu_reset_handler_init();
>  	tegra_powergate_init();
>  	tegra_hotplug_init();
> +	tegra_flowctrl_init();
>  }

It might make sense to call the function as early as possible; don't
some of CPU reset, powergate, hotplug depend on the flow controller? Not
that they can likely trigger this early, but it'd still be good if the
init order roughly logically followed any runtime dependencies.
