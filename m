From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 26 Jul 2018 11:32:47 +0200
Subject: [linux-sunxi] Re: [PATCH v2 06/18] arm64: dts: allwinner: a64:
 Orange Pi Win: Add UARTs
In-Reply-To: <71e5f296-a8f6-062c-6e55-86c8b07ed0a6@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-7-andre.przywara@arm.com>
 <20180726073911.ualwgf3t2bboeuy5@flea>
 <E978AF7E-4802-4429-99A2-4724EB68FFA9@aosc.io>
 <71e5f296-a8f6-062c-6e55-86c8b07ed0a6@arm.com>
Message-ID: <20180726093247.3hesukln2n3fhqeg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 09:30:14AM +0100, Andre Przywara wrote:
> Hi,
> 
> On 26/07/18 08:42, Icenowy Zheng wrote:
> > 
> > 
> > ? 2018?7?26? GMT+08:00 ??3:39:11, Maxime Ripard <maxime.ripard@bootlin.com> ??:
> >> On Thu, Jul 26, 2018 at 01:35:20AM +0100, Andre Przywara wrote:
> >>> From: Samuel Holland <samuel@sholland.org>
> >>>
> >>> The Orange Pi Win exposes several UARTs on header pin, and connects
> >> one
> >>> to the on-board WiFi/Bluetooth chip.
> >>> Add the pinmux definitions to the UART nodes, but keep them disabled.
> >>>
> >>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >>> ---
> >>>  .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 33
> >> ++++++++++++++++++++++
> >>>  1 file changed, 33 insertions(+)
> >>>
> >>> diff --git
> >> a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> >>> index 0cadcd59edd9..10f63d0b99cb 100644
> >>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> >>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> >>> @@ -54,6 +54,10 @@
> >>>  	aliases {
> >>>  		ethernet0 = &emac;
> >>>  		serial0 = &uart0;
> >>> +		serial1 = &uart1;
> >>> +		serial2 = &uart2;
> >>> +		serial3 = &uart3;
> >>> +		serial4 = &uart4;
> >>>  	};
> >>>  
> >>>  	chosen {
> >>> @@ -237,12 +241,41 @@
> >>>  	vcc-hdmi-supply = <&reg_dldo1>;
> >>>  };
> >>>  
> >>> +/* On debug connector */
> >>>  &uart0 {
> >>>  	pinctrl-names = "default";
> >>>  	pinctrl-0 = <&uart0_pins_a>;
> >>>  	status = "okay";
> >>>  };
> >>>  
> >>> +/* Wi-Fi/BT */
> >>> +&uart1 {
> >>> +	pinctrl-names = "default";
> >>> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> >>> +	status = "okay";
> >>> +};
> >>
> >> What BT chip is there? Does it have serdev support? If so, that should
> >> be enabled here.
> > 
> > RTL8723BS, no serdev.

https://www.spinics.net/lists/linux-bluetooth/msg76376.html

Not very far off though.

> Yes. A while ago I managed to enable Bluetooth (on the Pine64 with the
> same chip), but that involved a lot of hacking with a special userland
> tool (not hciattach and no serdev).
> 
> What this node means to say is: The UART1 is hardwired to some on-board
> device and those pins are not available for GPIO, for instance.
> 
> At least that was my understanding when it comes to enabling devices in
> the DT. Is that correct?

Well, yes and no. Arguably, any device connected to the other side of
the serial bus should have been there from the beginning. However,
there wasn't any way to do that in Linux before serdev was introduced,
so we weren't doing that. That resulted in hacky userspace tools to
work around that, and other work arounds in the DT to for example
tying BT resources (clock, regulators, resets) to the WiFi chip hoping
that someone would use both all the time.

Now that it's just around the corner, we don't have any excuse to do
these kind of hacks anymore.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180726/1af98e30/attachment.sig>
