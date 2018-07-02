From: dianders@chromium.org (Doug Anderson)
Date: Mon, 2 Jul 2018 12:53:44 -0700
Subject: [PATCH v2 2/2] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
In-Reply-To: <20180702181005.18247-2-mka@chromium.org>
References: <20180702181005.18247-1-mka@chromium.org>
 <20180702181005.18247-2-mka@chromium.org>
Message-ID: <CAD=FV=WH8q-3Rt89Get0N357+hWmKiEsruaKtWzo_JoE6gd_3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 2, 2018 at 11:10 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> The thermal zone uses spmi-temp-alarm as sensor. If the sensor is
> configured without an IIO input it always reports 37?C for temperatures
> below the first hardware trip point at 105?C. This hardware trip point
> is configured as critical trip point, to initiate a system shutdown
> before the temperature reaches the next hardware trip point at 125?C,
> where the PMIC performs a partial shutdown.
>
> The temperature of the critical trip point can be raised after adding
> the die temperature ADC as IIO input for spmi-temp-alarm, which
> significantly increases the precision of the temperature measurements.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
>   to refer to it
> - use 105?C hardware trip point as critical trip point

I'm not sure this was right.  I guess you're trying to avoid
Temperature Stage 2?  From Davi'd email in response to v1:

> The PMIC TEMP_ALARM hardware peripheral will perform an automatic partial
> PMIC shutdown upon hitting over-temperature stage 2 (125 C).  This turns
> off peripherals within the PMIC that are expected to draw significant
> current.  The set of peripherals included varies between PMICs.  This
> partial shutdown will occur simultaneously with the triggering of an
> interrupt to the APPS processor that informs the qcom-spmi-temp-alarm
> driver that an over-temperature threshold has been crossed.

I think it's actually OK to use Temperature Stage 2 as the "critical"
point, which is why it still interrupts the CPU.  At "critical" the
system will shut down, right?  ...so presumably it's OK if the drivers
can't recover from having the power yanked out from underneath them as
long as they don't hang/crash the system in this case.  If I had to
guess the whole point of this stage is to give the system shutdown a
better chance of succeeding without getting to stage 3.


I do agree, however, that removing the "145" from the device tree was
the right thing to do since software will never see that.  The system
will just shut down.


> - reduced number of trip points to 2
> - lowered temperature of passive trip point

This won't actually do anything until the ADC gets hooked up, right?

I guess I would have expected:
- 105: passive
- 125: critical

...and then we could add (if we wanted) a "hot" between passive and
critical once we have the ADC hooked up?



> - updated trip point names and added labels
> - updated commit message
>
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 2f4989e7ef68..e7caa334e6c7 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -3,6 +3,7 @@
>
>  #include <dt-bindings/spmi/spmi.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  &spmi_bus {
>         pm8998_lsid0: pmic at 0 {
> @@ -60,3 +61,27 @@
>                 #size-cells = <0>;
>         };
>  };
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
> +                       };
> +               };
> +       };
> +};

A nit, but I think convention is to actually put additions straight to
the root node before reference to phandles, so I would have put this
above the "&spmi_bus" part.
