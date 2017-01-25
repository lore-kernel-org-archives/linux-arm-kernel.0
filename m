From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 25 Jan 2017 10:59:12 +0000
Subject: [STLinux Kernel] [PATCH 8/8] ARM: dts: STiH407-family: Enable HW
 flow-control
In-Reply-To: <20170124134310.27512-9-lee.jones@linaro.org>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-9-lee.jones@linaro.org>
Message-ID: <20170125105912.GA5680@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, 24 Jan 2017, Lee Jones wrote:

> Hardware flow-control capability must be specified at a platform
> level in order to inform the ASC driver that the platform is capable
> (i.e. are the lines wired up, etc).  STiH4{07,10} devices are indeed
> capable, so let's provide the property.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 9789978..7ada8ea 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -226,7 +226,7 @@
>  			pinctrl-0 = <&pinctrl_serial0_flowctrl>;
>  			pinctrl-1 = <&pinctrl_serial0>;
>  			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
> -
> +			st,hw-flow-control;

There is a generic serial binding for this already. As this ST property
hasn't been used upstream, it seems like it would be worth dropping it
and switching to the generic uart-has-rtscts one.

See Documentation/devicetree/bindings/serial/serial.txt

  - uart-has-rtscts: The presence of this property indicates that the
    UART has dedicated lines for RTS/CTS hardware flow control, and that
    they are available for use (wired and enabled by pinmux configuration).
    This depends on both the UART hardware and the board wiring.
    Note that this property is mutually-exclusive with "cts-gpios" and
    "rts-gpios" above.

Also you should put this in the board dtsi, as it is board dependent property.
By putting it here you are enabling hw-flow-control for all stih407-family
based boards.

regards,

Peter.
