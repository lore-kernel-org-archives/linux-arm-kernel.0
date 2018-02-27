From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 27 Feb 2018 15:24:34 -0600
Subject: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
In-Reply-To: <20180221085541.14556-5-a.hajda@samsung.com>
References: <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
 <20180221085541.14556-1-a.hajda@samsung.com>
 <20180221085541.14556-5-a.hajda@samsung.com>
Message-ID: <CAL_JsqKGVwvqu36D57WbB7bPMt2tOZmvq+ukFuNHbhgiWYuw-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 2:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> OF graph describes MHL data lanes between MHL and respective USB
> connector.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> v4:
> - added missing reg property in connector's port node (Krzysztof)
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index f604f6b1a9c2..2ed506df94d0 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -817,9 +817,22 @@
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

These ports are mutually exclusive, right? If so, it should be 1 port
with 2 endpoints. Ports should represent independent data flows.
Something muxed or replicated (1 to many connection) should be be
endpoints.

Rob
