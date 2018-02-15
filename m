From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 15 Feb 2018 13:14:52 +0100
Subject: [RFC PATCH v2 4/6] arm64: dts: exynos: add OF graph between MHL
 and USB connector
In-Reply-To: <20180215103920.32017-5-a.hajda@samsung.com>
References: <CGME20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944@eucas1p2.samsung.com>
 <20180215103920.32017-1-a.hajda@samsung.com>
 <20180215103920.32017-5-a.hajda@samsung.com>
Message-ID: <CAJKOXPdg81LPOFmxtJmL7hMXGgB2USAOhCz2yjU9obX1jWjEWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 11:39 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> OF graph describes MHL data lanes between MHL and respective USB
> connector.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 31 +++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index 7e49fadee412..ef758f7337e9 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -779,9 +779,22 @@
>                 clocks = <&pmu_system_controller 0>;
>                 clock-names = "xtal";
>
> -               port {
> -                       mhl_to_hdmi: endpoint {
> -                               remote-endpoint = <&hdmi_to_mhl>;
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port at 0 {
> +                               reg = <0>;
> +                               mhl_to_hdmi: endpoint {
> +                                       remote-endpoint = <&hdmi_to_mhl>;
> +                               };
> +                       };
> +
> +                       port at 1 {
> +                               reg = <1>;
> +                               mhl_to_musb_con: endpoint {
> +                                       remote-endpoint = <&musb_con_to_mhl>;
> +                               };
>                         };
>                 };
>         };
> @@ -804,6 +817,18 @@
>                                              "usb-b-connector";
>                                 label = "micro-USB";
>                                 type = "micro";
> +
> +                               ports {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       port at 3 {

I think you might need here "reg = <3>". Doesn't it produce a warning now?

BR,
Krzysztof

> +                                               musb_con_to_mhl: endpoint {
> +                                                       remote-endpoint = <&mhl_to_musb_con>;
> +                                               };
> +                                       };
> +                               };
> +                       };
>                         };
>                 };
>
> --
> 2.16.1
>
