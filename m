From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 22:04:29 +0200
Subject: [PATCH 9/9] ARM: Kirkwood: Convert IX2-200 to pinctrl.
In-Reply-To: <1351090434-30499-10-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-10-git-send-email-andrew@lunn.ch>
Message-ID: <20121024220429.50e2b0b8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Wed, 24 Oct 2012 16:53:54 +0200, Andrew Lunn wrote:
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |   90 +++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   24 -------
>  2 files changed, 90 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> index 865aeec..d8fa8e8 100644
> --- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> +++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> @@ -16,6 +16,96 @@
>  	};
>  
>  	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			compatible = "marvell,88f6281-pinctrl";
> +			reg = <0x10000 0x20>;

This definition (compatible + reg) should go in kirkwood.dtsi. The
pinctrl unit should be declared at the SoC level. Ditto for all other
patches.

> +			pinctrl-0 = < &pmx_button_reset &pmx_button_power
> +				      &pmx_led_backup &pmx_led_power
> +				      &pmx_button_otb &pmx_led_rebuild
> +				      &pmx_led_health
> +				      &pmx_led_sata_brt_ctrl_1
> +				      &pmx_led_sata_brt_ctrl_2
> +				      &pmx_led_backup_brt_ctrl_1
> +				      &pmx_led_backup_brt_ctrl_2
> +				      &pmx_led_power_brt_ctrl_1
> +				      &pmx_led_power_brt_ctrl_2
> +				      &pmx_led_health_brt_ctrl_1
> +				      &pmx_led_health_brt_ctrl_2
> +				      &pmx_led_rebuild_brt_ctrl_1
> +				      &pmx_led_rebuild_brt_ctrl_2 >;
> +			pinctrl-names = "default";
> +
> +			pmx_button_reset: pmx-button-reset {
> +				marvell,pins = "mpp12";
> +				marvell,function = "gpio";
> +			};
> +			pmx_button_power: pmx-button-power {
> +				marvell,pins = "mpp14";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_backup: pmx-led-backup {
> +				marvell,pins = "mpp15";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_power: pmx-led-power {
> +				marvell,pins = "mpp16";
> +				marvell,function = "gpio";
> +			};
> +			pmx_button_otb: pmx-button-otb {
> +				marvell,pins = "mpp35";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_rebuild: pmx-led-rebuild {
> +				marvell,pins = "mpp36";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_health: pmx-led_health {
> +				marvell,pins = "mpp37";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_sata_brt_ctrl_1: pmx-led-sata-brt-ctrl-1 {
> +				marvell,pins = "mpp38";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_sata_brt_ctrl_2: pmx-led-sata-brt-ctrl-2 {
> +				marvell,pins = "mpp39";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_backup_brt_ctrl_1: pmx-led-backup-brt-ctrl-1 {
> +				marvell,pins = "mpp40";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_backup_brt_ctrl_2: pmx-led-backup-brt-ctrl-2 {
> +				marvell,pins = "mpp41";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_power_brt_ctrl_1: pmx-led-power-brt-ctrl-1 {
> +				marvell,pins = "mpp42";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_power_brt_ctrl_2: pmx-led-power-brt-ctrl-2 {
> +				marvell,pins = "mpp43";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_health_brt_ctrl_1: pmx-led-health-brt-ctrl-1 {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_health_brt_ctrl_2: pmx-led-health-brt-ctrl-2 {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_rebuild_brt_ctrl_1: pmx-led-rebuild-brt-ctrl-1 {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_rebuild_brt_ctrl_2: pmx-led-rebuild-brt-ctrl-2 {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};

This is not a strong comment, but I am not sure it is really useful to
define one pinmux configuration for each pin. You can do something like:

	pmx_buttons: pmx-buttons {
		marvell,pins = "mpp45", "mpp46", "mpp47", "mpp48";
		marvell,function = "gpio";
	};

I think all the pins used for buttons or for LEDs kind of make sense to
be muxed together. And then, when you declare the LEDs in the DT, you
can do:

                leds {
                        compatible = "gpio-leds";
                        pinctrl-names = "default";
                        pinctrl-0 = <&led_pins>;

                        red_led {
                                   label = "red_led";
                                   gpios = <&gpio1 17 1>;
                                   default-state = "off";
                        };

                        yellow_led {
                                   label = "yellow_led";
                                   gpios = <&gpio1 19 1>;
                                   default-state = "off";
                        };

                        green_led {
                                   label = "green_led";
                                   gpios = <&gpio1 21 1>;
                                   default-state = "off";
                                   linux,default-trigger = "heartbeat";
                        };
                };

Where "led_pins" is a pinmux configuration that includes three pins.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
