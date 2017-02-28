From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 28 Feb 2017 18:17:30 +0000
Subject: [linux-sunxi] [PATCH 1/5] pinctrl: sunxi: refactor pinctrl choice
 selecting for ARM64
In-Reply-To: <20170228172444.59655-1-icenowy@aosc.xyz>
References: <20170228172444.59655-1-icenowy@aosc.xyz>
Message-ID: <488811a1-b64f-c435-e919-7f83dc107697@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

(first thing: could you create your series with --cover-letter and fill
this in? There you could explain what this series is about and also
state things like dependencies from other patches and the commit that
you based that on.)

On 28/02/17 17:24, Icenowy Zheng wrote:
> ARM64 Allwinner SoCs used to have every pinctrl driver selected in
> ARCH_SUNXI. Change this to make their default value to (ARM64 &&
> ARCH_SUNXI).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Overall this is a nice solution. Thanks for posting this.

> ---
>  drivers/pinctrl/sunxi/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index 816015cf7053..92325736d953 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -48,8 +48,9 @@ config PINCTRL_SUN8I_H3
>  	select PINCTRL_SUNXI
>  
>  config PINCTRL_SUN8I_H3_R
> -	def_bool MACH_SUN8I
> -	select PINCTRL_SUNXI_COMMON
> +	def_bool MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> +	depends on RESET_CONTROLLER

So this looks a bit odd. I take it this is for the extra reset register
in the PRCM block.
1) I don't think this belongs into this patch. If this has been
forgotten in the past, please make an extra patch for this. It's cheap
to do so ;-)
2) Is this really a "depends on"? Shouldn't this be a select? With
sunxi_ng clocks we don't need the reset controller for the normal
peripherals anymore, so this option might not be selected by default in
the future. And having this "depends on" leads to the PINCTRL_ option
being hidden if RESET_CONTROLLER isn't selected.
I think this bites us already in arm64, where ARCH_HAS_RESET_CONTROLLER
is not enabled for ARCH_SUNXI.


But as the rest of the patch is fine, if you remove this line:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> +	select PINCTRL_SUNXI
>  
>  config PINCTRL_SUN8I_V3S
>  	def_bool MACH_SUN8I
> @@ -65,11 +66,11 @@ config PINCTRL_SUN9I_A80_R
>  	select PINCTRL_SUNXI
>  
>  config PINCTRL_SUN50I_A64
> -	bool
> +	def_bool ARM64 && ARCH_SUNXI
>  	select PINCTRL_SUNXI
>  
>  config PINCTRL_SUN50I_H5
> -	bool
> +	def_bool ARM64 && ARCH_SUNXI
>  	select PINCTRL_SUNXI
>  
>  endif
> 
