From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 20 Feb 2017 11:50:14 -0700
Subject: [PATCH] arm64: dts: juno: update definition for programmable
 replicator.
In-Reply-To: <1487358790-2618-1-git-send-email-mike.leach@linaro.org>
References: <1487358790-2618-1-git-send-email-mike.leach@linaro.org>
Message-ID: <CANLsYkz7cLiyR2i-B6x9kK5gmWCLz_4WF-Q4hwi-w=NHMojW2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2017 at 12:13, Mike Leach <mike.leach@linaro.org> wrote:
> Juno platforms have a programmable replicator splitting the trace output to
> TPIU and ETR. Currently this is not being programmed as it is being treated
> as a none-programmable replicator - which is the default operational mode
> for these devices. The TPIU in the system is enabled by default, and this
> combination is causing back-pressure in the trace system resulting in
> overflows at the source.
>
> Replaces the existing definition with one that defines the programmable
> replicator, using the "qcom,coresight-replicator1x" driver that provides
> the correct functionality for CoreSight programmable replicators.
>
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 9d799d9..6546e23 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -372,12 +372,14 @@
>                 };
>         };
>
> -       coresight-replicator {
> -               /*
> -                * Non-configurable replicators don't show up on the
> -                * AMBA bus.  As such no need to add "arm,primecell".
> -                */
> -               compatible = "arm,coresight-replicator";
> +       coresight-replicator at 20120000 {
> +

There is an extra line that is not needed here.  And we can probably
change "coresight-replicator" to "replicator" now that it can be
discovered on the AMBA bus.

Other than that:

Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +               compatible = "qcom,coresight-replicator1x", "arm,primecell";
> +               reg = <0 0x20120000 0 0x1000>;
> +
> +               clocks = <&soc_smc50mhz>;
> +               clock-names = "apb_pclk";
> +               power-domains = <&scpi_devpd 0>;
>
>                 ports {
>                         #address-cells = <1>;
> --
> 2.7.4
>
