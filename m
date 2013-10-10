From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Oct 2013 11:23:23 +0100
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <20131010102205.GD29191@S2101-09.ap.freescale.net>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
 <20131010072624.GA29191@S2101-09.ap.freescale.net>
 <20131010100840.GP25034@n2100.arm.linux.org.uk>
 <20131010102205.GD29191@S2101-09.ap.freescale.net>
Message-ID: <20131010102322.GQ25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 06:22:07PM +0800, Shawn Guo wrote:
> What about the solution suggested by Stephen, moving
> MX6QDL_PAD_SD1_DAT3__SD1_DATA3 out from pinctrl_usdhc1_1 and having
> additional nodes/phandle for DAT3 with different settings?
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 59154dc..fd52f4e 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -1157,7 +1157,6 @@
>                                                         MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
>                                                         MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
>                                                         MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
> -                                                       MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
>                                                         MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17059
>                                                         MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17059
>                                                         MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17059
> @@ -1165,6 +1164,18 @@
>                                                 >;
>                                         };
> 
> +                                       pinctrl_usdhc1_1_dat3: usdhc1dat3-1 {
> +                                               fsl,pins = <
> +                                                       MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
> +                                               >;
> +                                       };
> +
> +                                       pinctrl_usdhc1_1_dat3cd: usdhc1dat3cd-1 {
> +                                               fsl,pins = <
> +                                                       MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059
> +                                               >;
> +                                       };
> 
> Then pinctrl-0 = <&pinctrl_usdhc1_1 &pinctrl_usdhc1_1_dat3> for existing
> boards, and <&pinctrl_usdhc1_1 &pinctrl_usdhc1_1_dat3cd> for boards that
> want to use DAT3 for card detection.

Yes, that avoids the issue entirely, and is a much better solution IMHO.
