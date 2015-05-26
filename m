From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 26 May 2015 10:37:34 +0100
Subject: [PATCH 1/2 v2] ARM64: juno: add GPIO keys
In-Reply-To: <1432629650-19559-1-git-send-email-linus.walleij@linaro.org>
References: <1432629650-19559-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150526093734.GB2175@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 09:40:50AM +0100, Linus Walleij wrote:
> The Juno board has two keys connected to a PL061 GPIO block,
> in accordance to DDI0524B "ARM Versatile Express Juno Development
> Platform" revision 1.0, table 2-4 "GPIO (0) and GPIO (1) used
> for additional user key entry". By trial-and-error I found that
> these are connected to the two keys named "power" and "home"
> on the motherboard.
> 
> Register the GPIO block and these two keys in the device tree
> using the PL061 GPIO driver and the generic gpio keys.
> 
> - Map POWER, HOME, VOL+ and VOL- to the obvious input events.
> - Map RLOCK to KEY_SCREENLOCK/KEY_COFFEE unless someone can
>   explain better what this is for.
> - Map the NMI button to KEY_SYSREQ as this is used like so
>   in the SYSREQ debugging hack.

Hi Linus,

I'm going to do a test on my board once I find a bit of spare time
as I have some in-house reports that the handling of the GPIO
buttons is not reliable and on some boards it led to board reset.
Firmware might have been updated since (last year) so it would be
useful if you can tell me the version(s) of firmware that you are
using.

Best regards,
Liviu

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Register the GPIO block at 0x1d0000 as gpio0, as it turns out
>   there is an unused GPIO block at 0x1e0000 as well.
> - Label using capital letters.
> - Map all 6 keys. Only the two highest GPIO lines are unused.
> - Daniel: please look at this: the Juno has an NMI button, not
>   on the primary IRQ controller (GIC) but on a cascaded GPIO
>   controller. I have waited for this to happen, what are your
>   thoughts about the possibilities to handle this with the
>   priority-escalation trick you were devising for GIC's with
>   FIQ stolen by TrustZone? As the Juno is a typical server
>   design I suspect this is what we have to deal with for the
>   "server-with-an-NMI-pushbutton" use case.
> ---
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 61 +++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index 351c95bda89e..fde0cfad09de 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -54,6 +54,55 @@
>  				regulator-always-on;
>  			};
>  
> +			gpio_keys {
> +				compatible = "gpio-keys";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				button at 1 {
> +					debounce_interval = <50>;
> +					wakeup = <1>;
> +					linux,code = <116>;
> +					label = "POWER";
> +					gpios = <&iofpga_gpio0 0 0x4>;
> +				};
> +				button at 2 {
> +					debounce_interval = <50>;
> +					wakeup = <1>;
> +					linux,code = <102>;
> +					label = "HOME";
> +					gpios = <&iofpga_gpio0 1 0x4>;
> +				};
> +				button at 3 {
> +					debounce_interval = <50>;
> +					wakeup = <1>;
> +					linux,code = <152>;
> +					label = "RLOCK";
> +					gpios = <&iofpga_gpio0 2 0x4>;
> +				};
> +				button at 4 {
> +					debounce_interval = <50>;
> +					wakeup = <1>;
> +					linux,code = <115>;
> +					label = "VOL+";
> +					gpios = <&iofpga_gpio0 3 0x4>;
> +				};
> +				button at 5 {
> +					debounce_interval = <50>;
> +					wakeup = <1>;
> +					linux,code = <114>;
> +					label = "VOL-";
> +					gpios = <&iofpga_gpio0 4 0x4>;
> +				};
> +				button at 6 {
> +					debounce_interval = <50>;
> +					wakeup = <1>;
> +					linux,code = <99>;
> +					label = "NMI";
> +					gpios = <&iofpga_gpio0 5 0x4>;
> +				};
> +			};
> +
>  			ethernet at 2,00000000 {
>  				compatible = "smsc,lan9118", "smsc,lan9115";
>  				reg = <2 0x00000000 0x10000>;
> @@ -148,5 +197,17 @@
>  					clocks = <&soc_smc50mhz>;
>  					clock-names = "apb_pclk";
>  				};
> +
> +				iofpga_gpio0: gpio at 1d0000 {
> +					compatible = "arm,pl061", "arm,primecell";
> +					reg = <0x1d0000 0x1000>;
> +					interrupts = <6>;
> +					clocks = <&soc_smc50mhz>;
> +					clock-names = "apb_pclk";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +				};
>  			};
>  		};
> -- 
> 1.9.3
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
