From: robh@kernel.org (Rob Herring)
Date: Thu, 1 Dec 2016 09:54:10 -0600
Subject: [PATCH 0/5] Meson GXL and GXM USB support
In-Reply-To: <CAFBinCC8c2sXgo80LMMg=jqZ2hr8eLM_2g03H1J99m4xxFGYFA@mail.gmail.com>
References: <20161126145635.24488-1-martin.blumenstingl@googlemail.com>
 <CAFBinCAA_JEtr_0Ze0thoRaEKMnWQMKcPxJ8y88zkWAAhuxsMw@mail.gmail.com>
 <20161130222228.zu6ampaajg3gkdz4@rob-hp-laptop>
 <CAFBinCC8c2sXgo80LMMg=jqZ2hr8eLM_2g03H1J99m4xxFGYFA@mail.gmail.com>
Message-ID: <20161201155410.5ik4kg3clrh27s2k@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2016 at 11:49:03PM +0100, Martin Blumenstingl wrote:
> On Wed, Nov 30, 2016 at 11:22 PM, Rob Herring <robh@kernel.org> wrote:
> > On Sun, Nov 27, 2016 at 11:42:02PM +0100, Martin Blumenstingl wrote:
> >> Hello Kishon,
> >>
> >> On Sat, Nov 26, 2016 at 3:56 PM, Martin Blumenstingl
> >> <martin.blumenstingl@googlemail.com> wrote:
> >> > USB support on GXL and GXM differs a lot from Meson8b and GXBB:
> >> > The most obvious change is that GXL and GXM now have one dwc3
> >> > controller and one dwc2 controller (instead of two dwc2 controllers).
> >> > With that there are also new USB PHYs.
> >> >
> >> > Due to lack of hardware I was only able to test this on a board with
> >> > GXM, but as far as I understand the hardware my preparations should be
> >> > correct (so it should also work on GXL).
> >> >
> >> > dwc2 will probably stay unused on most GXM devices since it's limited
> >> > to device mode via some dwc2 hardware configuration register.
> >> >
> >> > dwc3 is probably used on all devices, even if there is more than just
> >> > one USB port. dwc3 has a built-in USB2 hub - on GXL this hub has two
> >> > ports enabled, while on GXM there are three ports enabled (see below
> >
> > This hub is an actual USB hub? If so, then you should probably model the
> > USB bus topology (which we have a binding definition for).
> (the following explanation is based on a) what I found is going on in
> the hardware registers b) reading the vendor drivers - unfortunately
> there are no datasheets available which could give more details).
> lsusb on my GXM gives:
> ...
>  Hub Port Status:
>    Port 1: 0000.0100 power
>    Port 2: 0000.0100 power
>    Port 3: 0000.0100 power
> 
> The layout looks like this:
> dwc3 provides a USB hub with 2 (on GXL) or 3 (on GXM) USB ports.
> Each of the port is driven by a PHY (port 1 = abp at 0x78000, port2 =
> abp at 0x78020, etc...).
> 
> On GXM USB2 PHY port 3 = abp at 0x78040 is connected to the third dwc3 hub port.
> On GXL PHY port 3 = abp at 0x78040 is connected to the dwc2 (I could not
> prove this yet as I don't have access to any GXL hardware).
> 
> So the answer is: we don't have an actual USB hub here (as this hub is
> provided by dwc3), but rather a set of PHYs which is assigned to
> dwc3's hub (if we don't configure *all* PHYs then none of the USB
> ports provided by the dwc3 hub works).
> 
> Could you please point me to the USB bus topology binding (is it the
> one described in usb-device.txt)?

Yes.

> 
> >> > for lsusb output). There are no USB3 ports enabled in the dwc3 hardware
> >> > configuration, meaning that the SoC is limited to high-speed mode.
> >> > On my GXM device the dwc3 hardware configuration forces it into "host
> >> > only" mode.
> >> >
> >> > The SoCs contain two PHY blocks: one USB3 PHY and up to four USB2 PHYs
> >> > (on GXM there are only three enabled, but the registers should support
> >> > up to four).
> >> > The USB3 PHY also handles the OTG interrupts, but since dwc3's hardware
> >> > configuration enforces "host only" mode I was not able to test this. It
> >> > simply takes care of an interrupt and then notifies all related PHYs
> >> > about the new mode.
> >> > The USB2 PHY block is a bit different: I created one PHY driver which
> >> > spans all "PHY ports" because the handling is a bit tricky. It turns
> >> > out that for each available USB port in dwc3's hub the corresponding
> >> > PHY must be enabled (even if there is no physical port - in my case
> >> > port 3 is not connected to anything, but disabling the PHY breaks
> >> > ports 1 and 2 as well).
> >> > I decided not not pass the USB2 PHYs directly to dwc3 due to three
> >> > reasons: 1. the USB3 PHY (which holds a reference to all relevant
> >> > USB2 PHY ports) controls the mode of the USB2 PHY ports (since both
> >> > are used with the same controller and thus it makes sense to keep the
> >> > mode consistent across all ports) 2. the dwc3 driver does not support
> >> > passing multiple USB2 PHYs (only one USB2 and one USB3 PHY can be
> >> > passed to it) 3. it is similar to how the vendor reference driver
> >> > manages the PHYs. Please note that this coupling is not a fixed, this
> >> > is all configurable via devicetree (so if the third USB2 PHY has to
> >> > be passed two the dwc2 controller then this is still possible by
> >> > just moving on PHY reference in the .dts).
> >> after not staring at my own code for 24 hours I realized this:
> >> (I went through quite a few iterations before getting these drivers to work)
> >> I'm basically re-modelling an "USB PHY hub" with my USB3 PHY driver
> >> (there's one "upstream" PHY interface which is passed to dwc3 and
> >> multiple downstream PHYs, each for one port on dwc3's internal hub).
> >> With this approach I could split each of the the USB2s into separate
> >> nodes again (instead of one devicetree node with #phy-cells = <1>) as
> >> the USB3 PHY is taking care of that special "we have to enable all
> >> ports or no port will be usable".
> >>
> >> We could go even one step further: why implement this in the Meson GXL
> >> specific PHY driver - why not implement a generic "phy-hub" driver
> >> (which would be valid whenever the PHY controller has to manage
> >> multiple PHYs at once, but wants to keep them all in a consistent
> >> state).
> >> The devicetree could look like this:
> >>     usb2_phy_hub: phy at 0 {
> >>         compatible = "phy-hub";
> >>         phys = <&other_phy1>, <&other_phy 2>;
> >>     };
> >>
> >> &dwc3 {
> >>      phys = <&usb2_phy_hub>, <&usb3_phy0>;
> >>      phy-names = "usb2-phy", "usb3-phy";
> >> };
> >
> > I'm okay with a hub if it is modeled as a USB hub. Here though, it
> > looks like you are just trying to group things which doesn't need to be
> > in DT.
> I hope my answer above makes things more clear

Yes, I thought there was some heirarchy here, but it seems not.

So you should just list the 3 phys at the controller. The controller 
has 3 ports and you have a phy for each port. The fact that they all 
need to be on/initialized is a quirk and shouldn't mean that you create 
some heirarchy in DT.

> >> The generic phy-hub driver would then implement all phy_ops callbacks
> >> and pass then to each of it's downstream PHYs.
> >
> > You can have generic drivers without a generic binding.
> So you'd rather implement a generic driver which would provide
> functions like of_create_grouped_phy(struct device_node *np) which
> would implement the grouping logic as described (but has no binding
> itself, but rather relies on the actual platform driver taking care of
> creating that binding and re-using generic code)?

Right.

Rob
