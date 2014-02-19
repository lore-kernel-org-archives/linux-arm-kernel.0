From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Feb 2014 17:46:34 +0100
Subject: [PATCH v4 13/13] ARM: mvebu: register the cpuidle driver for
 the Armada XP SoCs
In-Reply-To: <1392312816-17657-14-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
 <1392312816-17657-14-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140219174634.17123478@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 13 Feb 2014 18:33:36 +0100, Gregory CLEMENT wrote:
> The cpuidle is a platform driver so we have to register the device
> during the initialization of the boards.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index f6c9d1d85c14..81b42980311c 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -30,6 +30,11 @@
>  #include "common.h"
>  #include "coherency.h"
>  #include "mvebu-soc-id.h"
> +#include "pmsu.h"
> +
> +static struct platform_device armada_xp_cpuidle_device = {
> +	.name = "cpuidle-armada-370-xp",
> +};
>  
>  static void __init armada_370_xp_map_io(void)
>  {
> @@ -80,6 +85,13 @@ static void __init armada_370_xp_dt_init(void)
>  	if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
>  		i2c_quirk();
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	if (of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu")
> +		&& of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric")
> +		&& of_machine_is_compatible("marvell,armadaxp")) {
> +		armada_370_xp_pmsu_enable_l2_powerdown_onidle();
> +		armada_370_xp_cpu_pm_init();
> +		platform_device_register(&armada_xp_cpuidle_device);
> +	}

What about putting this in pmsu.c, in an arch_initcall() (or some other
initcall level) ? The cpuidle feature is really tied to the PMSU, so I
believe it makes sense to have the cpuidle-armada-370-xp
platform_device declared and registered in pmsu.c. As an added bonus,
you don't need to expose
armada_370_xp_pmsu_enable_l2_powerdown_onidle() and
armada_370_xp_cpu_pm_init() in a header: they can remain static
functions private to pmsu.c.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
