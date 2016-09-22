From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 22 Sep 2016 19:46:06 +0200
Subject: [PATCH] ARM: dts: exynos: Add reboot reason support for Trats2
In-Reply-To: <1474562915-4319-1-git-send-email-wolfgit@wiedmeyer.de>
References: <1474562915-4319-1-git-send-email-wolfgit@wiedmeyer.de>
Message-ID: <20160922174606.GA4988@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the patch, it is nice that someone did this! When I saw the
syscon reboot mode driver, I though about such feature but never had
time or will to implement it. Great job!

Few comments below.

On Thu, Sep 22, 2016 at 06:48:35PM +0200, Wolfgang Wiedmeyer wrote:
> This allows to reboot the device into recovery mode and into the download
> mode of the bootloader.

Which bootloader? Probably UBoot... or Samsung stock one? Could you put
that information here?

> 
> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts | 14 ++++++++++++++
>  arch/arm/boot/dts/exynos4x12.dtsi       |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 129e973..a38d1e3 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -1294,3 +1294,17 @@
>  	vtmu-supply = <&ldo10_reg>;
>  	status = "okay";
>  };
> +
> +&pmu {
> +	compatible = "syscon", "simple-mfd";
> +
> +	reboot-mode {
> +		compatible = "syscon-reboot-mode";
> +		offset = <0x80c>;
> +
> +		mode-normal	= <0x12345670>;
> +		mode-bootloader	= <0x12345671>;
> +		mode-download	= <0x12345671>;
> +		mode-recovery	= <0x12345674>;

Hmmm, how did you get these values? Are they already supported?

It would be nice to document them:
1. In Documentation/arm/Samsung/Bootloader-interface.txt
2. In header. I hate such magic numbers... you could add new header next
   to existing rockchip one:
   include/dt-bindings/soc/samsung,boot-mode.h
   (and update maintainers entry :) )


Best regards,
Krzysztof


> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index c452499..b58c14e 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -179,7 +179,7 @@
>  			ranges;
>  			status = "disabled";
>  
> -			pmu at 10020000 {
> +			pmu: pmu at 10020000 {
>  				reg = <0x10020000 0x3000>;
>  			};
>  
> -- 
> Website: https://fossencdi.org
> OpenPGP: 0F30 D1A0 2F73 F70A 6FEE  048E 5816 A24C 1075 7FC4
> Key download: https://wiedmeyer.de/keys/ww.asc
> 
