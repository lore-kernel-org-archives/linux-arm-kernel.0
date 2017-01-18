From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Wed, 18 Jan 2017 22:58:47 +0900
Subject: [PATCH v3 1/2] arm64: dts: exynos: Add USB 3.0 controller node
 for Exynos7
In-Reply-To: <1484721173-30474-2-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170118063008epcas5p26a5a1fd73d843b2b08eae0fdb03b775c@epcas5p2.samsung.com>
 <1484721173-30474-1-git-send-email-pankaj.dubey@samsung.com>
 <1484721173-30474-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAGOxZ52ypgGdvYYP24Y37NzfmGqDNwBW+NsrKDAeNN6=OnafbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Wed, Jan 18, 2017 at 3:32 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> From: Vivek Gautam <gautamvivek1987@gmail.com>
>
> Add USB 3.0 DRD controller device node, with its clock
> and phy information to enable the same on Exynos7.
>
> Signed-off-by: Vivek Gautam <gautamvivek1987@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---

Looks good.
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index 80aa60e..9a3fbed 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -603,6 +603,40 @@
>                                 #include "exynos7-trip-points.dtsi"
>                         };
>                 };
> +
> +               usbdrd_phy: phy at 15500000 {
> +                       compatible = "samsung,exynos7-usbdrd-phy";
> +                       reg = <0x15500000 0x100>;
> +                       clocks = <&clock_fsys0 ACLK_USBDRD300>,
> +                              <&clock_fsys0 OSCCLK_PHY_CLKOUT_USB30_PHY>,
> +                              <&clock_fsys0 PHYCLK_USBDRD300_UDRD30_PIPE_PCLK_USER>,
> +                              <&clock_fsys0 PHYCLK_USBDRD300_UDRD30_PHYCLK_USER>,
> +                              <&clock_fsys0 SCLK_USBDRD300_REFCLK>;
> +                       clock-names = "phy", "ref", "phy_pipe",
> +                               "phy_utmi", "itp";
> +                       samsung,pmu-syscon = <&pmu_system_controller>;
> +                       #phy-cells = <1>;
> +               };
> +
> +               usbdrd3 {
> +                       compatible = "samsung,exynos7-dwusb3";
> +                       clocks = <&clock_fsys0 ACLK_USBDRD300>,
> +                              <&clock_fsys0 SCLK_USBDRD300_SUSPENDCLK>,
> +                              <&clock_fsys0 ACLK_AXIUS_USBDRD30X_FSYS0X>;
> +                       clock-names = "usbdrd30", "usbdrd30_susp_clk",
> +                               "usbdrd30_axius_clk";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       dwc3 at 15400000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0x15400000 0x10000>;
> +                               interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +                               phys = <&usbdrd_phy 0>, <&usbdrd_phy 1>;
> +                               phy-names = "usb2-phy", "usb3-phy";
> +                       };
> +               };
>         };
>  };
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Regards,
Alim
