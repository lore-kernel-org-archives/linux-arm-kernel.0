From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 5 May 2015 12:34:29 +0200
Subject: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
In-Reply-To: <1430817426-5241-2-git-send-email-stripathi@apm.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <1430817426-5241-2-git-send-email-stripathi@apm.com>
Message-ID: <CAPDyKFpfiid4ny0fhw-yNfzCrynZnALNs+i51yeMhPneQ4XFFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 May 2015 at 11:17, Suman Tripathi <stripathi@apm.com> wrote:
> This patch adds the arasan sdhc nodes to reuse the of-arasan
> driver for APM X-Gene SoC.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>

I consider this one acked by Arnd, due to:
http://www.spinics.net/lists/arm-kernel/msg415634.html

Thus applied to my mmc tree.

Thanks!

Kind regards
Uffe

> ---
>  arch/arm64/boot/dts/apm/apm-mustang.dts |  4 +++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi  | 44 +++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
> index 83578e7..4cc5d07 100644
> --- a/arch/arm64/boot/dts/apm/apm-mustang.dts
> +++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
> @@ -52,3 +52,7 @@
>  &xgenet {
>         status = "ok";
>  };
> +
> +&sdhc0 {
> +       status = "ok";
> +};
> diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> index c8d3e0e..240c793 100644
> --- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
> +++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
> @@ -145,6 +145,40 @@
>                                 clock-output-names = "socplldiv2";
>                         };
>
> +                       ahbclk: ahbclk at 1f2ac000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               reg = <0x0 0x1f2ac000 0x0 0x1000
> +                                       0x0 0x17000000 0x0 0x2000>;
> +                               reg-names = "csr-reg", "div-reg";
> +                               csr-offset = <0x0>;
> +                               csr-mask = <0x1>;
> +                               enable-offset = <0x8>;
> +                               enable-mask = <0x1>;
> +                               divider-offset = <0x164>;
> +                               divider-width = <0x5>;
> +                               divider-shift = <0x0>;
> +                               clock-output-names = "ahbclk";
> +                       };
> +
> +                       sdioclk: sdioclk at 1f2ac000 {
> +                               compatible = "apm,xgene-device-clock";
> +                               #clock-cells = <1>;
> +                               clocks = <&socplldiv2 0>;
> +                               reg = <0x0 0x1f2ac000 0x0 0x1000
> +                                       0x0 0x17000000 0x0 0x2000>;
> +                               reg-names = "csr-reg", "div-reg";
> +                               csr-offset = <0x0>;
> +                               csr-mask = <0x2>;
> +                               enable-offset = <0x8>;
> +                               enable-mask = <0x2>;
> +                               divider-offset = <0x178>;
> +                               divider-width = <0x8>;
> +                               divider-shift = <0x0>;
> +                               clock-output-names = "sdioclk";
> +                       };
> +
>                         qmlclk: qmlclk {
>                                 compatible = "apm,xgene-device-clock";
>                                 #clock-cells = <1>;
> @@ -533,6 +567,16 @@
>                         interrupts = <0x0 0x4f 0x4>;
>                 };
>
> +               sdhc0: sdhc at 1c000000 {
> +                       device_type = "sdhc";
> +                       compatible = "arasan,sdhci-4.9a";
> +                       reg = <0x0 0x1c000000 0x0 0x100>;
> +                       interrupts = <0x0 0x49 0x4>;
> +                       dma-coherent;
> +                       clock-names = "clk_xin", "clk_ahb";
> +                       clocks = <&sdioclk 0>, <&ahbclk 0>;
> +               };
> +
>                 phy1: phy at 1f21a000 {
>                         compatible = "apm,xgene-phy";
>                         reg = <0x0 0x1f21a000 0x0 0x100>;
> --
> 1.8.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
