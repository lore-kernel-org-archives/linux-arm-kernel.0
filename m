From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 18 Oct 2016 11:14:26 +0100
Subject: [PATCH] ARM: dts: realview: Extend PBX family memory description
In-Reply-To: <1476778873-12210-1-git-send-email-linus.walleij@linaro.org>
References: <1476778873-12210-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <91f58e5e-666b-f612-dbe2-f27b57d5b4e2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/16 09:21, Linus Walleij wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> All three platforms sharing the later RealView Platform Baseboard memory
> map - PBX-A9, PB-A8 and PB11MPCore, provide 512MB of DDR SDRAM on the
> baseboard, of which the boot alias at 0x0 maps the first 256MB. Expand
> the size of the default memory node to reflect that, and describe the
> full memory regions in each board's DTS, but leave those commented by
> default to avoid breaking existing bootloaders.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: I forgot to send this patch for ARM SoC earlier.
> As it is a small change I suggest you just apply it to the ARM
> SoC tree as I do not foresee any other RealView work in the near
> future. If you think it can go into v4.9 then put it in as a fix,
> else just push it to the next merge window.
> Robin: sorry for screwing up :(

No worries - it's gone back in the cupboard now anyway :)

Robin.

> ---
>  arch/arm/boot/dts/arm-realview-pba8.dts   | 8 ++++++++
>  arch/arm/boot/dts/arm-realview-pbx-a9.dts | 9 +++++++++
>  arch/arm/boot/dts/arm-realview-pbx.dtsi   | 4 ++--
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/arm-realview-pba8.dts b/arch/arm/boot/dts/arm-realview-pba8.dts
> index d3238c252b59..9f6c92b84f9f 100644
> --- a/arch/arm/boot/dts/arm-realview-pba8.dts
> +++ b/arch/arm/boot/dts/arm-realview-pba8.dts
> @@ -40,6 +40,14 @@
>  		};
>  	};
>  
> +	/*
> +	 * Using the full 512MB of RAM will require bootloader
> +	 * changes to not load the kernel to the alias at 0x0.
> +	 */
> +	memory {
> +		/*reg = <0x70000000 0x20000000>; /* 512 MiB baseboard DDR */
> +	};
> +
>  	pmu: pmu at 0 {
>  		compatible = "arm,cortex-a8-pmu";
>  		interrupt-parent = <&intc>;
> diff --git a/arch/arm/boot/dts/arm-realview-pbx-a9.dts b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
> index 90d00b407f85..9fef9188660a 100644
> --- a/arch/arm/boot/dts/arm-realview-pbx-a9.dts
> +++ b/arch/arm/boot/dts/arm-realview-pbx-a9.dts
> @@ -60,6 +60,15 @@
>  		};
>  	};
>  
> +	/*
> +	 * There is 1GB of RAM total, but using all of it will require
> +	 * bootloader changes to not load the kernel to the alias at 0x0.
> +	 */
> +	memory {
> +		/*reg = <0x20000000 0x20000000>, /* 512 MiB daughterboard DDR2 */
> +		/*      <0x70000000 0x20000000>; /* 512 MiB baseboard DDR */
> +	};
> +
>  	L2: l2-cache {
>  		compatible = "arm,pl310-cache";
>  		reg = <0x1f002000 0x1000>;
> diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm-realview-pbx.dtsi
> index aeb49c4bd773..8477f667d27c 100644
> --- a/arch/arm/boot/dts/arm-realview-pbx.dtsi
> +++ b/arch/arm/boot/dts/arm-realview-pbx.dtsi
> @@ -38,8 +38,8 @@
>  	};
>  
>  	memory {
> -		/* 128 MiB memory @ 0x0 */
> -		reg = <0x00000000 0x08000000>;
> +		/* 256 MiB alias of baseboard DDR @ 0x0 */
> +		reg = <0x00000000 0x10000000>;
>  	};
>  
>  	/* The voltage to the MMC card is hardwired at 3.3V */
> 
