From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 21:31:28 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Convert TS219 to pinctrl.
In-Reply-To: <1351090434-30499-2-git-send-email-andrew@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-2-git-send-email-andrew@lunn.ch>
Message-ID: <20121024213128.2d4c07dc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Wed, 24 Oct 2012 16:53:46 +0200, Andrew Lunn wrote:

> +			pinctrl-0 = < &pmx_uart0 &pmx_uart1 &pmx_spi
> +				      &pmx_twsi0 &pmx_sata0 &pmx_sata1
> +				      &pmx_ram_size &pmx_reset_button
> +				      &pmx_USB_copy_button &pmx_board_id>;

It would be really better to have those under each device, rather than
globally declared here. For some devices such as UARTs, it is not yet
possible with the 8250 driver to associate pinctrl pins (but I'm
planning to work on that soon). However for the other drivers (SPI,
TWSI, SATA, button), it should be possible.

> +			pinctrl-names = "default";
> +
> +			pmx_uart0: pmx-uart0 {
> +				marvell,pins = "mpp10", "mpp11";
> +				marvell,function = "uart0";
> +			};
> +			pmx_uart1: pmx-uart1 {
> +				marvell,pins = "mpp13", "mpp14";
> +				marvell,function = "uart1";
> +			};
> +			pmx_spi: pmx-spi {
> +				marvell,pins = "mpp0", "mpp1", "mpp2", "mpp3";
> +				marvell,function = "spi";
> +			};
> +			pmx_twsi0: pmx-twsi0 {
> +				marvell,pins = "mpp8", "mpp9";
> +				marvell,function = "twsi0";
> +			};
> +			pmx_sata0: pmx-sata0 {
> +				marvell,pins = "mpp5", "mpp21", "mpp23";
> +				marvell,function = "sata0";
> +			};
> +			pmx_sata1: pmx-sata1 {
> +				marvell,pins = "mpp4", "mpp20", "mpp22";
> +				marvell,function = "sata1";
> +			};

All those definitions are not board specific, they are common to the
SoC. So they should be in the corresponding .dtsi file.

Basically:

 * The SoC .dtsi file should define all the pinmux groups that are
   described in the datasheet and are used by boards. I.e, there may be
   conflicting groups defined, where one group configures pin X with
   function Y, while another group configures pin X with function Z.

 * The board .dts file should define the pinmux groups that are really
   board-specific (buttons, LEDs, etc.), and then for each device,
   point to the correct pinmux group (either defined in the .dtsi file
   or in the board file).

See for example imx28.dtsi, and then the boards such as
imx28-cfa10036.dts, imx28-evk.dts, imx28-m28evk.dts, imx28-tx28.dts.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
