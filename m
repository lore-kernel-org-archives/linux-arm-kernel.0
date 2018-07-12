From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 Jul 2018 11:39:47 -0700
Subject: [PATCH v3 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
In-Reply-To: <20180709212522.187257-2-mka@chromium.org>
References: <20180709212522.187257-1-mka@chromium.org>
 <20180709212522.187257-2-mka@chromium.org>
Message-ID: <CAD=FV=UMpo8AfMkRt1a99VRzsDrESTVAJ5QcyD0tzYVxPfKL-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 9, 2018 at 2:25 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
> configured without an IIO input it always reports 37?C for temperatures
> below the first hardware trip point at 105?C. This hardware trip point
> is configured as critical trip point, to initiate a system shutdown
> before the temperature reaches the next hardware trip point at 125?C,
> where the PMIC performs a partial shutdown.
>
> The temperature of the critical trip point can be increased after
> adding the die temperature ADC as IIO input for spmi-temp-alarm, which
> significantly increases the precision of the temperature measurements.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - moved 'thermal-zones' node to the beginning of the .dtsi
>
> Changes in v2:
> - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
>   to refer to it
> - use 105?C hardware trip point as critical trip point
> - reduced number of trip points to 2
> - lowered temperature of passive trip point
> - updated trip point names and added labels
> - updated commit message
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 7eea94701b23..52c5e797aab2 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -3,6 +3,31 @@
>
>  #include <dt-bindings/spmi/spmi.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +       thermal-zones {
> +               pm8998 {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&pm8998_temp>;
> +
> +                       trips {
> +                               pm8998_alert0: pm8998-alert0 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +                               pm8998_crit: pm8998-crit {
> +                                       temperature = <105000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };

IMHO since the 95000 won't trigger until we get the ADC, it's a bit
too extreme to go straight to shutdown when the PMIC reaches 105.  I
think we should take David Collins's advice and disable the "partial
PMIC shutdown" and then set the two stages to 105 (passive) / 125
(critical).  In theory we could add a 115 (hot) stage in there that
would only get triggered later when the ADC gets hooked up.

Personally I wouldn't land this patch until we do that.

-Doug
