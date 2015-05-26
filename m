From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 May 2015 13:41:56 -0600
Subject: [PATCH 02/21] ARM: tegra: Add gpio-ranges property
In-Reply-To: <1432565608-26036-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5564CC84.1030700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2015 08:53 AM, Tomeu Vizoso wrote:
> Specify how the GPIOs map to the pins in T124, so the dependency is
> explicit.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>   arch/arm/boot/dts/tegra124.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
> index 13cc7ca..5d1d35f 100644
> --- a/arch/arm/boot/dts/tegra124.dtsi
> +++ b/arch/arm/boot/dts/tegra124.dtsi
> @@ -254,6 +254,7 @@
>   		gpio-controller;
>   		#interrupt-cells = <2>;
>   		interrupt-controller;
> +		gpio-ranges = <&pinmux 0 0 250>;

We should be consistent between SoCs. Why not make the same change for 
all Tegra SoCs?

I think this change will cause the GPIO subsystem to call into the 
pinctrl subsystem and create/add/register a new GPIO<->pinctrl range 
structure. The pinctrl driver already does this, so I think we'll end up 
with two duplicate entries in the pinctrl device's gpio_ranges list. 
This probably won't cause a problem, but I wanted to make sure you'd 
thought about it to make sure.

Right now, I think we get lucky and pinctrl ends up probing first (or at 
least very early) anyway. Somewhat related to this series, I wonder if 
we shouldn't add pinctrl client properties to every node in the Tegra DT 
that describes a controller that makes use of external pins that are 
affected by the pinmux. Such a change would guarantee this desired 
probing order. In order to preserve the "program the entire pinmux at 
once" semantics, these new pinctrl client properties would all need to 
reference empty states, yet would still need to exist to represent the 
dependency.
