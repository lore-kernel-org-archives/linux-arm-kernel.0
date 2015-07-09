From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 9 Jul 2015 10:01:26 +0200
Subject: [PATCH v2 6/9] regulator: pwm-regulator: Re-write bindings
In-Reply-To: <1436281613-899-7-git-send-email-lee.jones@linaro.org>
References: <1436281613-899-1-git-send-email-lee.jones@linaro.org>
 <1436281613-899-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20150709100126.13716904@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue,  7 Jul 2015 16:06:50 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> * Add support for continuous-voltage mode
> * Put more meat on the bones with regards to voltage-table mode
> * Sort out formatting for ease of consumption
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../bindings/regulator/pwm-regulator.txt           | 68 ++++++++++++++++++----
>  1 file changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> index ce91f61..892b366 100644
> --- a/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.txt
> @@ -1,27 +1,71 @@
> -pwm regulator bindings
> +Bindings for the Generic PWM Regulator
> +======================================
> +
> +Currently supports 2 modes of operation:
> +
> +voltage-table:		When in this mode, a voltage table (See below) of
> +			predefined voltage <=> duty-cycle values must be
> +			provided via DT. Limitations are that the regulator can
> +			only operate at the voltages supplied in the table.
> +			Intermediary duty-cycle values which would normally
> +			allow finer grained voltage selection are ignored and
> +			rendered useless.  Although more control is given to
> +			the user if the assumptions made in continuous-voltage
> +			mode do not reign true.
> +
> +continuous-voltage:	This mode uses the regulator's maximum and minimum
> +			supplied voltages specified in the
> +			regulator-{min,max}-microvolt properties to calculate
> +			appropriate duty-cycle values.  This allows for a much
> +			more fine grained solution when compared with
> +			voltage-table mode above.  This solution does make an
> +			assumption that a %50 duty-cycle value will cause the
> +			regulator voltage to run at half way between the
> +			supplied max_uV and min_uV values.

Do we really have to specify a new property to select the mode ?
The existing DT will have to be modified anyway, so maybe we can just
add a new compatible string differentiate those two modes.

Also note that if you're doing linear interpolation between the points
specified in the voltage-table instead of doing it on the min -> max
values, you wouldn't have to modify the binding.

>  
>  Required properties:
> -- compatible: Should be "pwm-regulator"
> -- pwms: OF device-tree PWM specification (see PWM binding pwm.txt)
> -- voltage-table: voltage and duty table, include 2 members in each set of
> -  brackets, first one is voltage(unit: uv), the next is duty(unit: percent)
> +--------------------
> +- compatible:		Should be "pwm-regulator"
> +
> +- pwms:			PWM specification (See: ../pwm/pwm.txt)
> +
> +One of these must be provided:
> +- voltage-table: 	Voltage and Duty-Cycle table consisting of 2 cells
> +			    First cell is voltage in microvolts (uV)
> +			    Second cell is duty-cycle in percent (%)
> +
> +- max-duty-cycle:	Maximum Duty-Cycle value -- this will normally be
> +  			255 (0xff) for an 8 bit PWM device

Why are you introducing another random unit. What is max-duty-cycle
really encoding (I guess it has to do with the precision you're
expecting, but I'm not sure) ?
The PWM framework is using nanoseconds, the existing pwm-regulator
binding is using percents. Shouldn't we reuse one of them (I
guess you changed that because the percent unit was not precise
enough) ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
