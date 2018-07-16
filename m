From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 16 Jul 2018 14:47:12 +0930
Subject: [PATCH 1/7] arm: dts: aspeed: Add aspeed G4 USB pinmux
In-Reply-To: <20180629035106.27181-2-benh@kernel.crashing.org>
References: <20180629035106.27181-1-benh@kernel.crashing.org>
 <20180629035106.27181-2-benh@kernel.crashing.org>
Message-ID: <1531718232.1112143.1441811576.1A98A0F8@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2018, at 13:21, Benjamin Herrenschmidt wrote:
> Set the default pinmux for EHCI so boards don't have to do
> it an document why it is not set for UHCI.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 75df1573380e..1d7ffa9fdb11 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -113,6 +113,8 @@
>  			reg = <0x1e6a1000 0x100>;
>  			interrupts = <5>;
>  			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2h_default>;
>  			status = "disabled";
>  		};
>  
> @@ -123,6 +125,10 @@
>  			#ports = <3>;
>  			clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
>  			status = "disabled";
> +			/*
> +			 * No default pinmux, it will follow EHCI, use an explicit pinmux
> +			 * override if you don't enable EHCI
> +			 */

This is only part of the story on the AST2400 which has 3 USB ports:

* Port 1 is fixed-function UHCI
* Port 2 can be muxed to the UHCI (host) or HID (device) controllers
* Port 3 can be muxed to the EHCI or vHub controllers

I assume if we plug a USB 1.1 device into port 3 it gets rate matched and dealt with (therefore UHCI follows EHCI as suggested in your comment). But given port 2, which *may* route to UHCI *specifically* (not EHCI), UHCI *doesn't* always follow EHCI.

However, port 2 has its other function, HID, and HID is only available on port 2. So, if we had a HID devicetree node, we would put the pinmux for port 2 in there and leave it to the board to configure the HID controller as enabled or not. However, given this conflict, the UHCI node still shouldn't have any pinmux properties as your comment suggests, as it's up to the board whether HID or UHCI mode should be selected for port 2, but we'll need to enable the UHCI controller for port 1 (or 3) and we don't want to force the mux state of port 2 (or 3).

So whilst partially correct, the comment is a bit misleading in that it suggests muxing EHCI is enough in general, which isn't really true. Maybe say instead that due to flexible configuration, UHCI pinmux should be overridden in the platform dts explicitly?

Cheers,

Andrew

>  		};
>  
>  		apb {
> -- 
> 2.17.1
> 
