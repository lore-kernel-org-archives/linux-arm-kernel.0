From: liviu.dudau@arm.com (Liviu Dudau)
Date: Thu, 10 May 2018 10:49:01 +0100
Subject: [PATCH 3/3] arm64: dts: juno/rtsm: re-structure motherboard
 includes
In-Reply-To: <1525884291-18851-3-git-send-email-sudeep.holla@arm.com>
References: <1525884291-18851-1-git-send-email-sudeep.holla@arm.com>
 <1525884291-18851-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180510094901.GR1027@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:44:51PM +0100, Sudeep Holla wrote:
> It is a bit unorthodox to just include a file in the middle of a another
> DTS file, it breaks the pattern from other device trees and also makes
> it really hard to reference things across the files with phandles.
> 
> Restructure the include for the Juno/RTSM motherboards to happen at the
> top of the file, reference the target nodes directly, and indent the
> motherboard .dtsi files to reflect their actual depth in the hierarchy.
> 
> This is a purely syntactic change that result in the same DTB files from
> the DTS/DTSI files. This is based on similar patch from Linus Walleij
> for ARM Vexpress platforms.

A bit of bikeshedding here: the reason I've used the DT /include/
here was that on decompilation of the DTB the nodes would have been in
the natural order and easier to look for issues. Those were the early
days and I can accept that the general practice has changed and we're
using now the C preprocessor more. I don't have any strong feelings on
how the DT looks nowadays, so:

> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi           | 3 +--
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi    | 4 ++++
>  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts       | 4 ++--
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi | 5 ++++-
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> Hi,
> 
> Posting this patch with -b(aka ignore-spaces option for review purpose.
> 
> Regards,
> Sudeep
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index b74e462c6658..ce56a4acda4f 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "juno-clocks.dtsi"
> +#include "juno-motherboard.dtsi"
>  
>  / {
>  	/*
> @@ -795,8 +796,6 @@
>  				<0 0 10 &gic 0 0 0 167 IRQ_TYPE_LEVEL_HIGH>,
>  				<0 0 11 &gic 0 0 0 168 IRQ_TYPE_LEVEL_HIGH>,
>  				<0 0 12 &gic 0 0 0 169 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		/include/ "juno-motherboard.dtsi"
>  	};
>  
>  	site2: tlx at 60000000 {
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index 70e3409d86a3..1792b074e9a3 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -7,6 +7,8 @@
>   *
>   */
>  
> +/ {
> +	smb at 8000000 {
>  		mb_clk24mhz: clk24mhz {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> @@ -287,3 +289,5 @@
>  				};
>  			};
>  		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> index 06c8117e812a..602f63f72c37 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> @@ -12,6 +12,8 @@
>  
>  /memreserve/ 0x80000000 0x00010000;
>  
> +#include "rtsm_ve-motherboard.dtsi"
> +
>  / {
>  	model = "RTSM_VE_AEMv8A";
>  	compatible = "arm,rtsm_ve,aemv8a", "arm,vexpress";
> @@ -162,7 +164,5 @@
>  				<0 0 40 &gic 0 40 4>,
>  				<0 0 41 &gic 0 41 4>,
>  				<0 0 42 &gic 0 42 4>;
> -
> -		/include/ "rtsm_ve-motherboard.dtsi"
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> index 1134e5d8df18..d2dbc3f39263 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> @@ -7,7 +7,8 @@
>   *
>   * VEMotherBoard.lisa
>   */
> -
> +/ {
> +	smb at 8000000 {
>  		motherboard {
>  			arm,v2m-memory-map = "rs1";
>  			compatible = "arm,vexpress,v2m-p1", "simple-bus";
> @@ -274,3 +275,5 @@
>  				};
>  			};
>  		};
> +	};
> +};
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
