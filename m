From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Mon, 3 Dec 2012 19:01:39 +0530
Subject: [PATCH v2 1/2] ARM: Exynos5250: Enabling ehci-s5p driver
In-Reply-To: <1352362764-14595-1-git-send-email-gautam.vivek@samsung.com>
References: <CAFp+6iEwbw5jw_JiUosfZYykFNdbnh+OW6-RrJ7NnYN8csUJmw@mail.gmail.com>
 <1352362764-14595-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <CAFp+6iFWC9gt9CviiEEq=7iw6AcpWiKYnLubN=yTuWcdBcmpQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,


On Thu, Nov 8, 2012 at 1:49 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> Adding EHCI device tree node for Exynos5250 along with
> the device base adress and gpio line for vbus.
>
Any thoughts about this please ?

> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  .../devicetree/bindings/usb/exynos-usb.txt         |   25 ++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 +++
>  arch/arm/boot/dts/exynos5250.dtsi                  |    6 ++++
>  arch/arm/mach-exynos/include/mach/map.h            |    1 +
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +
>  5 files changed, 38 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
>
> diff --git a/Documentation/devicetree/bindings/usb/exynos-usb.txt b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> new file mode 100644
> index 0000000..833f5cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/exynos-usb.txt
> @@ -0,0 +1,25 @@
> +Samsung Exynos SoC USB controller
> +
> +The USB devices interface with USB controllers on Exynos SOCs.
> +The device node has following properties.
> +
> +EHCI
> +Required properties:
> + - compatible: should be "samsung,exynos-ehci" for USB 2.0
> +   EHCI controller in host mode.
> + - reg: physical base address of the controller and length of memory mapped
> +   region.
> + - interrupts: interrupt number to the cpu.
> +
> +Optional properties:
> + - samsung,vbus-gpio:  if present, specifies the GPIO that
> +   needs to be pulled up for the bus to be powered.
> +
> +Example:
> +
> +       usb at 12110000 {
> +               compatible = "samsung,exynos-ehci";
> +               reg = <0x12110000 0x100>;
> +               interrupts = <0 71 0>;
> +               samsung,vbus-gpio = <&gpx2 6 1 3 3>;
> +       };
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 405009c..7c8064f 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -193,4 +193,8 @@
>         hdmi {
>                 hpd-gpio = <&gpx3 7 0xf 1 3>;
>         };
> +
> +       usb at 12110000 {
> +               samsung,vbus-gpio = <&gpx2 6 1 3 3>;
> +       };
>  };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index cf6a02d..2995445 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -238,6 +238,12 @@
>                 #size-cells = <0>;
>         };
>
> +       usb at 12110000 {
> +               compatible = "samsung,exynos-ehci";
> +               reg = <0x12110000 0x100>;
> +               interrupts = <0 71 0>;
> +       };
> +
>         amba {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
> index ef4958b..9a86b99 100644
> --- a/arch/arm/mach-exynos/include/mach/map.h
> +++ b/arch/arm/mach-exynos/include/mach/map.h
> @@ -197,6 +197,7 @@
>  #define EXYNOS4_PA_EHCI                        0x12580000
>  #define EXYNOS4_PA_OHCI                        0x12590000
>  #define EXYNOS4_PA_HSPHY               0x125B0000
> +#define EXYNOS5_PA_EHCI                        0x12110000
>  #define EXYNOS4_PA_MFC                 0x13400000
>
>  #define EXYNOS4_PA_UART                        0x13800000
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
> index ed37273..89fa624 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -86,6 +86,8 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
>                                 "exynos5-hdmi", NULL),
>         OF_DEV_AUXDATA("samsung,exynos5-mixer", 0x14450000,
>                                 "exynos5-mixer", NULL),
> +       OF_DEV_AUXDATA("samsung,exynos-ehci", EXYNOS5_PA_EHCI,
> +                               "s5p-ehci", NULL),
>         {},
>  };
>
> --
> 1.7.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks & Regards
Vivek
