From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 16 Nov 2014 22:10:34 +0100
Subject: [PATCHv2 5/8] arm: mvebu: add common uart0 and spi0 pintcrl
 entries for Armada 370
In-Reply-To: <d550094896837ac921e5d2a69fc5aae9b287a98a.1416158990.git.arno@natisbad.org>
References: <cover.1416158990.git.arno@natisbad.org>
 <d550094896837ac921e5d2a69fc5aae9b287a98a.1416158990.git.arno@natisbad.org>
Message-ID: <20141116211034.GJ15870@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 06:37:33PM +0100, Arnaud Ebalard wrote:
> 
> pinctrl entries for uart0 using MPP0-1 and spi0 using MPP33-36 are
> common configurations. Instead of replicating them in each .dts file,
> put those in armada-370.dtsi file so that they can be referenced.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 6b3c23b1e138..d9f5d59e463e 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -115,6 +115,17 @@
>  				compatible = "marvell,mv88f6710-pinctrl";
>  				reg = <0x18000 0x38>;
>  
> +				uart0_pins: uart0-pins {
> +					marvell,pins = "mpp0", "mpp1";
> +					marvell,function = "uart0";
> +				};

Thanks for these.

We can go one stage further. kirkwood.dts has:

                uart0: serial at 12000 {
                        compatible = "ns16550a";
                        reg = <0x12000 0x100>;
                        reg-shift = <2>;
                        interrupts = <33>;
                        clocks = <&gate_clk 7>;
                        pinctrl-0 = <&pmx_uart0>;
                        pinctrl-names = "default";
                        status = "disabled";
                };

i.e actually references them. This is safe because a board .dts file
can override the pins if needed.

We should do the same here, both for 370 and XP.

   Andrew

> +
> +				spi0_pins: spi0-pins {
> +					marvell,pins = "mpp33", "mpp34",
> +						       "mpp35", "mpp36";
> +					marvell,function = "spi0";
> +				};
> +
>  				sdio_pins1: sdio-pins1 {
>  					marvell,pins = "mpp9",  "mpp11", "mpp12",
>  							"mpp13", "mpp14", "mpp15";
> -- 
> 2.1.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
