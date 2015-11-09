From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 09 Nov 2015 22:48:32 +0100
Subject: [PATCH v2 0/8] phy: rockchip-usb: correct pll handling and
 usb-uart
In-Reply-To: <CAD=FV=UytwJ9jthOZZEzw6ZwTFwyuTz5-B7xkuN_OgMbHKbWRA@mail.gmail.com>
References: <1446998681-26436-1-git-send-email-heiko@sntech.de>
 <3369052.6pxaYT98AY@phil>
 <CAD=FV=UytwJ9jthOZZEzw6ZwTFwyuTz5-B7xkuN_OgMbHKbWRA@mail.gmail.com>
Message-ID: <4138105.lq8ZJ1GKoN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 9. November 2015, 13:32:28 schrieb Doug Anderson:
> Heiko,
> 
> On Mon, Nov 9, 2015 at 1:27 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> >> If you happened to be in the mood for cleaning up this PHY and wanted
> >> to fix up one more thing that I noticed...
> >>
> >> ...you could actually increase the range of registers managed by the
> >> PHYs.  For instance, in rk3288, the "host1" port isn't just managed by
> >> 1 register, but by 4 (GRF_UOC2_CON0 - GRF_UOC2_CON3).  I think there
> >> are 5 for the OTG port.
> >>
> >> Obviously not required for this series and there's no (current) reason
> >> to do anything with the rest of those registers, but it might be
> >> interesting for the future...
> >
> > I'm not sure what change you're proposing :-) .
> 
> I was proposing changing the PHY to look like:
> 
> usbphy: phy {
>   compatible = "rockchip,rk3288-usb-phy";
>   rockchip,grf = <&grf>;
>   #address-cells = <1>;
>   #size-cells = <1>;
>   status = "disabled";
> 
>   usbphy0: usb-phy0 {
>     #phy-cells = <0>;
>     reg = <0x320 0x14>;
>     clocks = <&cru SCLK_OTGPHY0>;
>     clock-names = "phyclk";
>   };
>   ...
> };
> 
> ...in other words change the "size-cells" for the main PHY to 1 and
> add a length to the registers.
> 
> 
> > I currently see the reg-property both in the dts and in the code as
> > "offset" - the start-register, because it points to uoc_con0 for each phy.
> > So if needed I was just planning on doing reg+x , as they're coming from
> > the GRF anyway.
> 
> Yeah, that would work.  I was just trying to make it more obvious in
> the DTS that there was actually a range of registers managed here...

ok, that would make sense to make that a bit more visible, and it
would even require functional changes ;-)


> > One interesting point would be to move that under the GRF node, similar
> > to what we're doing with the power-domains under the PMU.
> >
> > In retrospect I think exposing the phys individually was not the best
> > decision - especially as when you dive deeper, they are not that similar
> > anymore and individual functions change. But we'll have to live with that.
> 
> Now it's my turn: I'm not sure I understand...  ;)

as the driver currently stands (without my changes) every phy is seen as
the same function block - it looks like phy0...phy2 have the same
functionality and the driver cannot distinguish between them. The
similarity is true for SIDDQ and some other generic bits (even across
different Rockchip SoCs), but for more special functionality bits move
their location between phys. This is even more visisble if you compare
rk3066/rk3188/rk3288 phys.

What I mean, and would like to have for the new phy-IP for rk3368 etc
would be to have one node, then do the reference via an index like 
<&usbphy 1> and hide the internals in the driver instead of having
that in the dts.

That's why it's nice to be able to reidentify the phy in the driver again
via the register/structs introduced, because now you can again know that
phyX is actually the OTG phy etc.


Heiko
