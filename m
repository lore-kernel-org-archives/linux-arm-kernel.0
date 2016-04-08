From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 8 Apr 2016 14:20:34 +0000
Subject: [PATCH] ARM: dts: r8a7791: Don't disable referenced optional
 clocks
In-Reply-To: <5706B191.3060903@cogentembedded.com>
References: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <57059874.1070309@cogentembedded.com>
 <1460012450.13819.38.camel@collabora.co.uk>
 <5706B191.3060903@cogentembedded.com>
Message-ID: <HK2PR0601MB13938CB5B56DDCF340FBAC37F5910@HK2PR0601MB1393.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07 April 2016 20:14, Sergei Shtylyov wrote:
> On 04/07/2016 10:00 AM, Sjoerd Simons wrote:
> 
> > Hey Sergei,
> >
> > Thanks for your review.
> 
>     You're welcome. :-)
> 
> > On Thu, 2016-04-07 at 02:15 +0300, Sergei Shtylyov wrote:
> >> On 04/06/2016 03:52 PM, Sjoerd Simons wrote:
> >>
> >>>
> >>> clk_get on a disabled clock node will return EPROBE_DEFER, which
> >>> can
> >>> cause drivers to be deferred forever if such clocks are referenced
> >>> in
> >>> their clocks property.
> >>>
> >>> Update the various disabled external clock nodes to default to a
> >>> frequency of 0, but don't disable them to prevent this.
> >>>
> >>> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> >>>
> >>> ---
> >>>
> >>>    arch/arm/boot/dts/r8a7791-koelsch.dts | 1 +
> >>>    arch/arm/boot/dts/r8a7791-porter.dts  | 1 +
> >>>    arch/arm/boot/dts/r8a7791.dtsi        | 5 +----
> >>>    3 files changed, 3 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> >>> b/arch/arm/boot/dts/r8a7791-koelsch.dts
> >>> index 1adf877..da59c28 100644
> >>> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> >>> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> >>> @@ -660,6 +660,7 @@
> >>>    };
> >>>
> >>>    &pcie_bus_clk {
> >>> +	clock-frequency = <100000000>;
> 
> >>      Hmmm, looking at the Koelsch schematics, I don't see this clock.
> >> :-/
> >
> > I don't have the schematics so i was simply keeping the current state.
> 
>     I understand. I was just surprised by what checking the code against the
> schematics revealed.
> 
> > I've added Phil Edworthy to the list as he was the one originally
> 
>     I should've CC'ed Phil myself...
>
> > enable the bus clk for Koelsh according to git. Hopefully he can
> > clarify :)
> 
>     Let's hope he'd reply...
> 
> >>>    	status = "okay";
> >>>    };
> >>>
> >>> diff --git a/arch/arm/boot/dts/r8a7791-porter.dts
> >>> b/arch/arm/boot/dts/r8a7791-porter.dts
> >>> index 9554d13..19b257e 100644
> >>> --- a/arch/arm/boot/dts/r8a7791-porter.dts
> >>> +++ b/arch/arm/boot/dts/r8a7791-porter.dts
> >>> @@ -413,6 +413,7 @@
> >>>    };
> >>>
> >>>    &pcie_bus_clk {
> >>> +	clock-frequency = <100000000>;
> >>>    	status = "okay";
> >>>    };
> >>>
> >>      Again, looking at the Porter schematics, I don't see this clock
> >> either. :-/
> >
> > You were the one enabling this clock for Porter ;) I don't have PCIE
> 
>     Yes, of course. I don't remember the gory details already -- I might have
> blindly copied what was in the Koelsch's .dts.
> 
> > hardware to test with on my porter board, might be worth if you could
> > disable this clock and see if PCI-E still fucntions as expected (maybe
> > in practise it just happens to prefer the internal clock?) ?
> 
>     I know the PCIe driver does require this clock in order to function -- it
> would be the same eternal -EPROBE_DEFER condition you'd already described;
> see drivers/pci/host/pcie-rcar.c yourself...
> 
> >>> diff --git a/arch/arm/boot/dts/r8a7791.dtsi
> >>> b/arch/arm/boot/dts/r8a7791.dtsi
> >>> index 8693888..676df63 100644
> >>> --- a/arch/arm/boot/dts/r8a7791.dtsi
> >>> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> >>> @@ -1104,8 +1104,7 @@
> >>>    		pcie_bus_clk: pcie_bus {
> >>>    			compatible = "fixed-clock";
> >>>    			#clock-cells = <0>;
> >>> -			clock-frequency = <100000000>;
> >>> -			status = "disabled";
> >>> +			clock-frequency = <0>;
> >>      If the clock has a good default frequency, I don't think you need
> >> to
> >> remove it. Otherwise you missed USB_EXTAL which is 48 MHz (and can be
> >> overridden).
> >
> > I did that as it was by default disabled, so if i do enable it but
> > don't drop the default frequency to 0 board swithout that clock will
> > suddenly have it added to their dtb.
> 
>     Zero frequency is hardly any better then the default...
> 
> > For the usb external clock I didn't touch it as it was already enabled
> > by default with a proper frequency, so it wouldn't hit the issue i was
> > trying to fix here. But i agree, both looking at other Renesas dtsis
> > and how all other external clocks are done in this dtsi, this node is
> > odd.
> 
>     It's not that odd given that the R-Car gen2 manual specifically says it
> should be 48 MHz.
>     Looking into the manual again, the PCIe bus clock must be the onne
> presented on the CICREF[PN]1_SATA/PCIe input signals and it indeed should be
> 100 MHz... So Phil was correct.

PCIe always requires a 100MHz reference clock. On Koelsch, this clock is
generated by U6 and always on. Some boards may need additional hardware
to be setup in order to output the clock, hence the DT node for the clock.

I hope that clarifies the situation!
Phil
