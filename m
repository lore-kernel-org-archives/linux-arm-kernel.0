From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 22 Oct 2015 10:01:54 +0900
Subject: [PATCHv2] ARM: dts: use vmmc-supply of emmc/sd for
 exynos5422-odroidxu3
In-Reply-To: <1445345793-5189-1-git-send-email-linux.amoon@gmail.com>
References: <1445345793-5189-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <56283582.5010908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2015 21:56, Anand Moon wrote:
> Changes need for host controller to detect UHS-I highspeed cards.
> Changes in VDDQ_MMC2 voltage range help scale
> the required voltage to detect and load the microSD cards.

Thanks for updating description of commit.

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
> 
> Changes:
> Drop the ranp_delay for LDO9.
> 
> Thanks to : Krzysztof, Doug Anderson, Jaehoon Chung for helping
> me out figure out the mmc core requirement.
> 
> Also drop the previous changes:
> use cd-gpio method to detect sd-card.
> Added UHS-I bus speed support.
> 
> [    4.713553] random: nonblocking pool is initialized
> [    4.718423] 14530000.hdmi supply hdmi-en not found, using dummy regulator
> [    4.726206] exynos-drm exynos-drm: bound 14400000.fimd (ops fimd_component_ops)
> [    4.732555] exynos-drm exynos-drm: bound 14450000.mixer (ops mixer_component_ops)
> [    4.740180] exynos-drm exynos-drm: bound 14530000.hdmi (ops hdmi_component_ops)
> [    4.746936] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    4.753428] [drm] No driver support for vblank timestamp query.
> [    4.940794] Console: switching to colour frame buffer device 274x77
> [    4.995344] exynos-drm exynos-drm: fb0:  frame buffer device
> [    5.024573] [drm] Initialized exynos 1.0.0 20110530 on minor 0
> [    5.031164] exynos-dwc3 usb at 12000000: no suspend clk specified
> [    5.054571] usb 2-1: new full-speed USB device number 2 using exynos-ohci
> [    5.159527] dwmmc_exynos 12220000.mmc: Busy; trying anyway
> [    5.163705] mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 status 0x0)
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 1af5bdc..a4be3e0 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -182,9 +182,10 @@
>  
>  			ldo13_reg: LDO13 {
>  				regulator-name = "vdd_ldo13";
> -				regulator-min-microvolt = <2800000>;
> +				regulator-min-microvolt = <1800000>;

You did not convinced me in previous discussion about the change to
1.8V. I said that:
> On the same diagram few lines below:
> VDDQ_MMC2: 2.8V 250mA

You responded:
> You are correct.

So I am confused. Are you sure that this SD card block can/should
operate on 1.8V? Have you actually tried this?

>  				regulator-max-microvolt = <2800000>;
>  				regulator-always-on;
> +				regulator-ramp-delay = <12000>;

NAK

We've been talking about this. Sooo maaaanyyyy times.

If you are going to send v3 please come up with detailed reasoning,
which will convince my stubborn mind.

Best regards,
Krzysztof

>  			};
>  
>  			ldo15_reg: LDO15 {
> @@ -213,6 +214,7 @@
>  				regulator-min-microvolt = <2800000>;
>  				regulator-max-microvolt = <2800000>;
>  				regulator-always-on;
> +				regulator-ramp-delay = <12000>;
>  			};
>  
>  			ldo24_reg: LDO24 {
> @@ -338,6 +340,7 @@
>  	samsung,dw-mshc-ddr-timing = <0 2>;
>  	samsung,dw-mshc-hs400-timing = <0 2>;
>  	samsung,read-strobe-delay = <90>;
> +	vmmc-supply = <&ldo3_reg>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
>  	bus-width = <8>;
> @@ -355,6 +358,8 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
>  	bus-width = <4>;
> +	vmmc-supply = <&ldo19_reg>;
> +	vqmmc-supply = <&ldo13_reg>;
>  	cap-sd-highspeed;
>  };
>  
> 
