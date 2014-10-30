From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Oct 2014 18:24:35 +0100
Subject: [PATCH RESEND V4 5/9] of: Add NVIDIA Tegra xHCI controller binding
In-Reply-To: <CAL1qeaG701hKtcUL5a67b=X38hbcYunUOUBziZMpxemvhhAayA@mail.gmail.com>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-6-git-send-email-abrestic@chromium.org>
 <20141029094338.GA28356@ulmo.nvidia.com>
 <CAL1qeaEf0mTQfMgnY8jHGDBvbQ7ivtzAQRWaE9K24TJ86hWYMg@mail.gmail.com>
 <20141030135500.GC19802@ulmo.nvidia.com>
 <CAL1qeaG701hKtcUL5a67b=X38hbcYunUOUBziZMpxemvhhAayA@mail.gmail.com>
Message-ID: <20141030172432.GA8944@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 10:19:21AM -0700, Andrew Bresticker wrote:
> On Thu, Oct 30, 2014 at 6:55 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Wed, Oct 29, 2014 at 09:37:14AM -0700, Andrew Bresticker wrote:
> >> On Wed, Oct 29, 2014 at 2:43 AM, Thierry Reding
> >> <thierry.reding@gmail.com> wrote:
> >> > On Tue, Oct 28, 2014 at 03:27:50PM -0700, Andrew Bresticker wrote:
> >> > [...]
> >> >> diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
> >> > [...]
> >> >> +Optional properties:
> >> >> +-------------------
> >> >> +- vbus-{0,1,2}-supply: VBUS regulator for the corresponding UTMI pad.
> >> >> +- vddio-hsic-supply: VDDIO regulator for the HSIC pads.
> >> >> +- nvidia,usb3-port-{0,1}-lane: PCIe/SATA lane to which the corresponding USB3
> >> >> +  port is mapped.  See <dt-bindings/pinctrl/pinctrl-tegra-xusb.h> for the list
> >> >> +  of valid values.
> >> >
> >> > I dislike how we now need to provide a list of all pins in the header
> >> > file, where previously we used strings for this. This could become very
> >> > ugly if the set of pins changes in future generations of this IP block.
> >> >
> >> > Could we instead derive this from the pinmux nodes? For example you have
> >> > this in the example below:
> >> >
> >> >         usb3p0 {
> >> >                 nvidia,lanes = "pcie-0";
> >> >                 ...
> >> >         };
> >> >
> >> > Perhaps what we need is to either key off the node name or add another
> >> > property, such as:
> >> >
> >> >         nvidia,usb3-port = <0>;
> >> >
> >> > This would match the nvidia,usb2-port property that you've added below.
> >>
> >> That is actually how I described the USB3 port to SS lane mapping
> >> originally, but in review of an earlier version of this series,
> >> Stephen suggested that I make it a separate, not pinconfig property
> >> since it wasn't a value written directly to the hardware.  I'm fine
> >> with changing it back as the pinconfig property makes more sense to me
> >> as well.
> >
> > Hmm... I had considered it a mux option of the specific lane. If the
> > function is usb3, it'd still need to be muxed to one of the ports. So
> > it's additional information associated with the usb3 function.
> >
> > I did look through the driver changes and can't really make out which
> > part of the code actually performs this assignment. Can you point me to
> > it?
> 
> There's not really an assignment.  The property is used to map between
> a lane (e.g. PCIe-0 or SATA) and the USB3.0 port it's mapped to.  For
> an example of where it's used, take a look at usb3_phy_power_on().
> There are certain per-lane registers which need to be programmed in
> addition to the per-USB3.0 port pad registers.  This mapping is used
> to determine which lane needs to be programmed.

Are you saying the mapping of lane to USB port is fixed? That is, PCIe-0
lane is always used for USB port X and SATA always for USB port Y?

If so I'd argue that we don't need this property in DT at all.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/52e09898/attachment.sig>
