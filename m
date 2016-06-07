From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 7 Jun 2016 14:22:24 +0100
Subject: [PATCH 2/3] Documentation: add DT bindings for ARM SCPI power
 domains
In-Reply-To: <1465228439-13457-3-git-send-email-sudeep.holla@arm.com>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
 <1465228439-13457-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20160607132223.GG2633@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 04:53:58PM +0100, Sudeep Holla wrote:
> The System Control Processor (SCP) provides peripheral devices with
> power domains that can be enabled and disabled viathe System Control
> and Power Interface (SCPI) Message Protocol. Add bindings to allow
> probing of these device power domians.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> index 313dabdc14f9..7141670d649b 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
> @@ -87,10 +87,33 @@ SCPI provides an API to access the various sensors on the SoC.
>  			 implementation for the IDs to use. For Juno
>  			 R0 and Juno R1 refer to [3].
> 
> +Power domain bindings for the power domains based on SCPI Message Protocol
> +------------------------------------------------------------
> +
> +This binding uses the generic power domain binding[4].
> +
> +PM domain providers
> +===================
> +
> +Required properties:
> + - #power-domain-cells : Should be 1. Contains the device or the power
> +			 domain ID value used by SCPI commands.
> + - num-domains: Total number of power domains provided by SCPI. This is
> +		needed as the SCPI message protocol lacks a mechanism to
> +		query this information runtime.
                                      ^
I guess there should be an 'at' here.

Are domain IDs zero-based and definitely non-sparse?

What exactly does this matter for? Just for validation at parsing time,
or is this strictly required for correctness?

If we send a command with an invalid domain ID, would the FW reliably
report an error that we can recover from?

Otherwise, this looks ok. I'd just like to make sure I've understood
correctly.

Thanks,
Mark.

> +
> +PM domain consumers
> +===================
> +
> +Required properties:
> + - power-domains : A phandle and PM domain specifier as defined by bindings of
> +                   the power controller specified by phandle.
> +
>  [0] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html
>  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>  [2] Documentation/devicetree/bindings/thermal/thermal.txt
>  [3] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922b/apas03s22.html
> +[4] Documentation/devicetree/bindings/power/power_domain.txt
> 
>  Example:
> 
> @@ -144,6 +167,12 @@ scpi_protocol: scpi at 2e000000 {
>  		compatible = "arm,scpi-sensors";
>  		#thermal-sensor-cells = <1>;
>  	};
> +
> +	scpi_devpd: scpi-power-domains {
> +		compatible = "arm,scpi-power-domains";
> +		num-domains = <2>;
> +		#power-domain-cells = <1>;
> +	};
>  };
> 
>  cpu at 0 {
> @@ -156,6 +185,7 @@ hdlcd at 7ff60000 {
>  	...
>  	reg = <0 0x7ff60000 0 0x1000>;
>  	clocks = <&scpi_clk 4>;
> +	power-domains = <&scpi_devpd 1>;
>  };
> 
>  thermal-zones {
> @@ -186,3 +216,7 @@ The thermal-sensors property in the soc_thermal node uses the
>  temperature sensor provided by SCP firmware to setup a thermal
>  zone. The ID "3" is the sensor identifier for the temperature sensor
>  as used by the firmware.
> +
> +The num-domains property in scpi-power-domains domain specifies that
> +SCPI provides 2 power domains. The hdlcd node uses the power domain with
> +domain ID 1.
> --
> 2.7.4
> 
