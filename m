From: mturquette@linaro.org (Mike Turquette)
Date: Sat, 16 Nov 2013 18:44:13 -0800
Subject: [PATCH v11 2/2] ARM: dts: enable clock binding on Hi3620
In-Reply-To: <1384306274-27315-3-git-send-email-haojian.zhuang@gmail.com>
References: <1384306274-27315-1-git-send-email-haojian.zhuang@gmail.com>
 <1384306274-27315-3-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20131117024413.19193.15469@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Haojian Zhuang (2013-11-12 17:31:14)
> Enable clock binding for Hi3620 common clock driver.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  arch/arm/boot/dts/hi3620.dtsi | 79 ++++++++++++++++++++++++-------------------
>  arch/arm/boot/dts/hi4511.dts  |  3 +-
>  2 files changed, 46 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
> index e311937..ab1116d 100644
> --- a/arch/arm/boot/dts/hi3620.dtsi
> +++ b/arch/arm/boot/dts/hi3620.dtsi
> @@ -11,7 +11,8 @@
>   * publishhed by the Free Software Foundation.
>   */
>  
> -/include/ "skeleton.dtsi"
> +#include "skeleton.dtsi"
> +#include <dt-bindings/clock/hi3620-clock.h>
>  
>  / {
>         aliases {
> @@ -63,6 +64,7 @@
>         };
>  
>         amba {
> +
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 compatible = "arm,amba-bus";
> @@ -88,13 +90,20 @@
>  
>                 sysctrl: system-controller at 802000 {
>                         compatible = "hisilicon,sysctrl";
> -                       reg = <0x802000 0x1000>;
>                         #address-cells = <1>;
> -                       #size-cells = <0>;
> +                       #size-cells = <1>;
> +                       ranges = <0 0x802000 0x1000>;
> +                       reg = <0x802000 0x1000>;
>  
>                         smp-offset = <0x31c>;
>                         resume-offset = <0x308>;
>                         reboot-offset = <0x4>;
> +
> +                       clock: clock at 0 {
> +                               compatible = "hisilicon,hi3620-clock";
> +                               reg = <0 0x10000>;
> +                               #clock-cells = <1>;
> +                       };
>                 };
>  
>                 dual_timer0: dual_timer at 800000 {
> @@ -102,7 +111,7 @@
>                         reg = <0x800000 0x1000>;
>                         /* timer00 & timer01 */
>                         interrupts = <0 0 4>, <0 1 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_TIMER0_MUX>, <&clock HI3620_TIMER1_MUX>;
>                         clock-names = "apb_pclk";

Two clocks are specified in "clocks" but only a single name in
clock-names. Is this intentional?

Thanks,
Mike

>                         status = "disabled";
>                 };
> @@ -112,7 +121,7 @@
>                         reg = <0x801000 0x1000>;
>                         /* timer10 & timer11 */
>                         interrupts = <0 2 4>, <0 3 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_TIMER2_MUX>, <&clock HI3620_TIMER3_MUX>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -122,7 +131,7 @@
>                         reg = <0xa01000 0x1000>;
>                         /* timer20 & timer21 */
>                         interrupts = <0 4 4>, <0 5 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_TIMER4_MUX>, <&clock HI3620_TIMER5_MUX>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -132,7 +141,7 @@
>                         reg = <0xa02000 0x1000>;
>                         /* timer30 & timer31 */
>                         interrupts = <0 6 4>, <0 7 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_TIMER6_MUX>, <&clock HI3620_TIMER7_MUX>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -142,7 +151,7 @@
>                         reg = <0xa03000 0x1000>;
>                         /* timer40 & timer41 */
>                         interrupts = <0 96 4>, <0 97 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_TIMER8_MUX>, <&clock HI3620_TIMER9_MUX>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -157,7 +166,7 @@
>                         compatible = "arm,pl011", "arm,primecell";
>                         reg = <0xb00000 0x1000>;
>                         interrupts = <0 20 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_UARTCLK0>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -166,7 +175,7 @@
>                         compatible = "arm,pl011", "arm,primecell";
>                         reg = <0xb01000 0x1000>;
>                         interrupts = <0 21 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_UARTCLK1>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -175,7 +184,7 @@
>                         compatible = "arm,pl011", "arm,primecell";
>                         reg = <0xb02000 0x1000>;
>                         interrupts = <0 22 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_UARTCLK2>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -184,7 +193,7 @@
>                         compatible = "arm,pl011", "arm,primecell";
>                         reg = <0xb03000 0x1000>;
>                         interrupts = <0 23 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_UARTCLK3>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -193,7 +202,7 @@
>                         compatible = "arm,pl011", "arm,primecell";
>                         reg = <0xb04000 0x1000>;
>                         interrupts = <0 24 4>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_UARTCLK4>;
>                         clock-names = "apb_pclk";
>                         status = "disabled";
>                 };
> @@ -208,7 +217,7 @@
>                                         &pmx0 5 0 1 &pmx0 6 1 1 &pmx0 7 2 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK0>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -223,7 +232,7 @@
>                                         &pmx0 6 5 1 &pmx0 7 6 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK1>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -238,7 +247,7 @@
>                                         &pmx0 6 3 1 &pmx0 7 3 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK2>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -253,7 +262,7 @@
>                                         &pmx0 6 11 1 &pmx0 7 11 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK3>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -268,7 +277,7 @@
>                                         &pmx0 6 13 1 &pmx0 7 13 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK4>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -283,7 +292,7 @@
>                                         &pmx0 6 16 1 &pmx0 7 16 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK5>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -298,7 +307,7 @@
>                                         &pmx0 6 18 1 &pmx0 7 19 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK6>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -313,7 +322,7 @@
>                                         &pmx0 6 25 1 &pmx0 7 26 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK7>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -328,7 +337,7 @@
>                                         &pmx0 6 33 1 &pmx0 7 34 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK8>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -343,7 +352,7 @@
>                                         &pmx0 6 41 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK9>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -357,7 +366,7 @@
>                                         &pmx0 5 45 1 &pmx0 6 46 1 &pmx0 7 46 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK10>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -372,7 +381,7 @@
>                                         &pmx0 6 49 1 &pmx0 7 49 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK11>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -387,7 +396,7 @@
>                                         &pmx0 6 51 1 &pmx0 7 52 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK12>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -402,7 +411,7 @@
>                                         &pmx0 6 55 1 &pmx0 7 56 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK13>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -417,7 +426,7 @@
>                                         &pmx0 6 60 1 &pmx0 7 61 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK14>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -432,7 +441,7 @@
>                                         &pmx0 6 64 1 &pmx0 7 65 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK15>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -447,7 +456,7 @@
>                                         &pmx0 6 72 1 &pmx0 7 73 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK16>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -462,7 +471,7 @@
>                                         &pmx0 6 80 1 &pmx0 7 81 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK17>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -477,7 +486,7 @@
>                                         &pmx0 6 86 1 &pmx0 7 87 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK18>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -491,7 +500,7 @@
>                                         &pmx0 3 88 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK19>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -505,7 +514,7 @@
>                                         &pmx0 3 90 1 &pmx0 4 91 1 &pmx0 5 92 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK20>;
>                         clock-names = "apb_pclk";
>                 };
>  
> @@ -518,7 +527,7 @@
>                         gpio-ranges = < &pmx0 3 94 1 &pmx0 7 96 1>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> -                       clocks = <&pclk>;
> +                       clocks = <&clock HI3620_GPIOCLK21>;
>                         clock-names = "apb_pclk";
>                 };
>  
> diff --git a/arch/arm/boot/dts/hi4511.dts b/arch/arm/boot/dts/hi4511.dts
> index 96e69ab..fe62392 100644
> --- a/arch/arm/boot/dts/hi4511.dts
> +++ b/arch/arm/boot/dts/hi4511.dts
> @@ -8,7 +8,8 @@
>   */
>  
>  /dts-v1/;
> -/include/ "hi3620.dtsi"
> +
> +#include "hi3620.dtsi"
>  
>  / {
>         model = "Hisilicon Hi4511 Development Board";
> -- 
> 1.8.3.2
