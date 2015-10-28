From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Oct 2015 11:29:34 +0000
Subject: [PATCH] ARM64: juno: disable NOR flash node by default
In-Reply-To: <1446025195-9264-1-git-send-email-linus.walleij@linaro.org>
References: <1446025195-9264-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151028112933.GB24930@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 10:39:55AM +0100, Linus Walleij wrote:
> After discussing on the mailing list it turns out that
> accessing the flash memory from the kernel can disrupt CPU
> sleep states and CPU hotplugging, so let's disable this
> DT node by default. Setups that want to access the flash
> can modify this entry to enable the flash again.
> 
> Quoting Sudeep Holla: "the firmware assumes the flash is
> always in read mode while Linux leaves NOR flash in
> "read id" mode after initialization."
> 
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <leif.lindholm@arm.com>
> Cc: Ryan Harkin <ryan.harkin@linaro.org>
> Fixes: 5078f77e1443 "ARM64: juno: add NOR flash to device tree"
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> ARM SoC folks: please apply this as a fix for the upcoming v4.4
> merge window, directly to the branch where the original commit
> resides (appears to be directly on the for-next branch or
> something).
> ---
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index c7c99a42e2e9..8c029ee2a5b5 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -109,6 +109,13 @@
>  				linux,part-probe = "afs";
>  				reg = <0 0x00000000 0x04000000>;
>  				bank-width = <4>;
> +				/*
> +				 * Unfortunately, accessing the flash disturbs
> +				 * the CPU idle states (suspend) and CPU
> +				 * hotplug of the platform. For this reason,
> +				 * flash hardware access is disabled by default.
> +				 */
> +				status = "disabled";
>  			};
>  
>  			ethernet at 2,00000000 {
> -- 
> 2.4.3
> 
