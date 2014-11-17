From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 17 Nov 2014 01:55:32 +0100
Subject: [PATCHv2 5/8] arm: mvebu: add common uart0 and spi0 pintcrl
 entries for Armada 370
In-Reply-To: <874mtyok43.fsf@natisbad.org>
References: <cover.1416158990.git.arno@natisbad.org>
 <d550094896837ac921e5d2a69fc5aae9b287a98a.1416158990.git.arno@natisbad.org>
 <20141116211034.GJ15870@lunn.ch> <874mtyok43.fsf@natisbad.org>
Message-ID: <20141117005532.GK15870@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 11:29:00PM +0100, Arnaud Ebalard wrote:
> Hi,
> 
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> > On Sun, Nov 16, 2014 at 06:37:33PM +0100, Arnaud Ebalard wrote:
> >> 
> >> pinctrl entries for uart0 using MPP0-1 and spi0 using MPP33-36 are
> >> common configurations. Instead of replicating them in each .dts file,
> >> put those in armada-370.dtsi file so that they can be referenced.
> >> 
> >> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> >> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> >> ---
> >>  arch/arm/boot/dts/armada-370.dtsi | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >> 
> >> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> >> index 6b3c23b1e138..d9f5d59e463e 100644
> >> --- a/arch/arm/boot/dts/armada-370.dtsi
> >> +++ b/arch/arm/boot/dts/armada-370.dtsi
> >> @@ -115,6 +115,17 @@
> >>  				compatible = "marvell,mv88f6710-pinctrl";
> >>  				reg = <0x18000 0x38>;
> >>  
> >> +				uart0_pins: uart0-pins {
> >> +					marvell,pins = "mpp0", "mpp1";
> >> +					marvell,function = "uart0";
> >> +				};
> >
> > Thanks for these.
> >
> > We can go one stage further. kirkwood.dts has:
> >
> >                 uart0: serial at 12000 {
> >                         compatible = "ns16550a";
> >                         reg = <0x12000 0x100>;
> >                         reg-shift = <2>;
> >                         interrupts = <33>;
> >                         clocks = <&gate_clk 7>;
> >                         pinctrl-0 = <&pmx_uart0>;
> >                         pinctrl-names = "default";
> >                         status = "disabled";
> >                 };
> >
> > i.e actually references them. This is safe because a board .dts file
> > can override the pins if needed.
> >
> > We should do the same here, both for 370 and XP.
> 
> Just to be sure I understand: for uart0 and uart1, I think this can only
> be done for Armada 370 (on XP, uart0/1 rx/tx are not mpp).

I must admit, i did not look at the datasheet for XP. So you can
ignore XP.

 
> This only a matter of adding the following in armada-370.dtsi for uart0: 
> 
>  		 /*
> 		  * Default UART pinctrl setting without RTS/CTS, can
> 		  * be overwritten on board level.
>                   */
>                  uart0: serial at 12000 {
>                          pinctrl-0 = <&uart0_pins>;
>                          pinctrl-names = "default";
>                  };

Looks good.
 
> For uart1, it's not obvious because there are 6 different MPP which can
> be configured to act as uart1 TXD.

That is too many configurations. So lets leave it per board.

> Now, regarding armada XP, uart2 and uart3 txd/rxd MPP are 42/43 and
> 44/45. Best we can do is put the same as above in each specific
> armada-xp-mv78XXX.dtsi file, where pinctrl node is, after adding
> uart2-pins and uart3-pins. Unless I am missing something, this cannot
> be done in armada-xp.dtsi.

Actually, i think it can. But i could be wrong.

armada-370-xp.dtsi declares uart0 and uart1.  armada-xp.dtsi then
defined another two uart's, uart2 and uart3. You should be able to
define the pinctrl nodes for the serial ports there, even if the main
pinctrl node is in the SoC specific .dtsi file.

	Andrew
