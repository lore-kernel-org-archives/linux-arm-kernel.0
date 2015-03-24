From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 24 Mar 2015 09:08:50 -0600
Subject: [PATCH] coresight: adding basic support for Spreadtrum SC9836
In-Reply-To: <1427176113-23411-1-git-send-email-zhang.chunyan@linaro.org>
References: <1427176113-23411-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <CANLsYkw+dzHU5QtqM-Pw8s-C-K4aqd0ATKd_SidwVf6uqyd9cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 March 2015 at 23:48, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> Support only for ETB, FUNNEL, STM are included currently.
> Support for ETM, TPIU and the replicator linked to it are not included in
> this version patch.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  arch/arm64/boot/dts/sprd/sc9836.dtsi | 57 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
> index f92f1b4..2ca80f3 100644
> --- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
> +++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
> @@ -45,6 +45,63 @@
>                 };
>         };
>
> +       etb at 10003000 {
> +               compatible = "arm,coresight-etb10", "arm,primecell";
> +               reg = <0 0x10003000 0 0x1000>;
> +               arm,primecell-periphid = <0x0003b907>;

Specifying the primecell id in the device tree like this is usually to
avoid probing of the memory space by the AMBA mechanic when bus
components are discovered.  As such components are probed and
initialised when their drivers are registered with the diver core
later in the boot process.

Is there a good reason why this is done here?  Especially when the
funnel and STM don't specify their cell IDs in the DT.

> +               coresight-default-sink;

Please remove the above - this feature no longer exists.

> +               clocks = <&clk26mhz>;
> +               clock-names = "apb_pclk";
> +               port {
> +                       etb_in: endpoint {
> +                               slave-mode;
> +                               remote-endpoint = <&funnel_out_port0>;
> +                       };
> +               };
> +       };
> +
> +       funnel at 10001000 {
> +               compatible = "arm,coresight-funnel", "arm,primecell";
> +               reg = <0 0x10001000 0 0x1000>;
> +               clocks = <&clk26mhz>;
> +               clock-names = "apb_pclk";
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       /* funnel output port */
> +                       port at 0 {
> +                               reg = <0>;
> +                               funnel_out_port0: endpoint {
> +                                       remote-endpoint = <&etb_in>;
> +                               };
> +                       };
> +
> +                       /* funnel input port 0~3 is reserved for ETMs */
> +                       port at 1 {
> +                               reg = <4>;
> +                               funnel_in_port4: endpoint {
> +                                       slave-mode;
> +                                       remote-endpoint = <&stm_out>;
> +                               };
> +                       };
> +               };
> +       };
> +
> +       stm at 10006000 {
> +               compatible = "arm,coresight-stm", "arm,primecell";
> +               reg = <0 0x10006000 0 0x1000>,
> +                     <0 0x01000000 0 0x180000>;
> +               reg-names = "stm-base", "stm-stimulus-base";
> +               clocks = <&clk26mhz>;
> +               clock-names = "apb_pclk";
> +               port {
> +                       stm_out: endpoint {
> +                               remote-endpoint = <&funnel_in_port4>;
> +                       };
> +               };
> +       };
> +
>         gic: interrupt-controller at 12001000 {
>                 compatible = "arm,gic-400";
>                 reg = <0 0x12001000 0 0x1000>,
> --
> 1.9.1
>
