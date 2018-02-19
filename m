From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Feb 2018 09:54:08 +0100
Subject: [PATCH v3 7/7] ARM: sun8i: smp: Remove the disabling of CPU0
In-Reply-To: <20180219081837.15482-8-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-8-mylene.josserand@bootlin.com>
Message-ID: <20180219085408.5to43p7jbtijx4q3@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 09:18:37AM +0100, Myl?ne Josserand wrote:
> On sun8i-a63t, hotplug CPU for CPU0 is currently not working.
> Remove the possibility to disable CPU0 only for sun8i-a83t.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  arch/arm/mach-sunxi/mc_smp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index fec592bf68b4..69d5ae5b3d72 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -661,8 +661,12 @@ static int sunxi_mc_smp_cpu_kill(unsigned int l_cpu)
>  	return !ret;
>  }
>  
> -static bool sunxi_mc_smp_cpu_can_disable(unsigned int __unused)
> +static bool sunxi_mc_smp_cpu_can_disable(unsigned int cpu)
>  {
> +	/* CPU0 hotplug handled only for sun9i */
> +	if (of_machine_is_compatible("allwinner,sun8i-a83t"))
> +		if (cpu == 0)
> +			return false;

This also means that you have a window in your patch sequence where
you can disable the CPU0 on the A83t. This patch should be earlier.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180219/8c0a8fe0/attachment-0001.sig>
