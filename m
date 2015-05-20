From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 May 2015 16:52:29 +0200
Subject: [PATCH v8 4/9] mfd: Add binding document for NVIDIA Tegra XUSB
In-Reply-To: <20150520063551.GD3627@x1>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-5-git-send-email-abrestic@chromium.org>
 <20150513143954.GA3394@x1> <55544CC5.9050001@nvidia.com>
 <20150514074058.GA22418@x1>
 <CAL1qeaEqNejuGkN-ke11mtWnaaRo+XieCBkQ6+NQ-Afym6uxVA@mail.gmail.com>
 <CAL1qeaHy0h7bXhuLHh4AG2Zfu48JYeawgVo4dp_k4oX8YFw6tA@mail.gmail.com>
 <20150520063551.GD3627@x1>
Message-ID: <20150520145227.GA3787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 07:35:51AM +0100, Lee Jones wrote:
> On Tue, 19 May 2015, Andrew Bresticker wrote:
> 
> > Lee,
> > 
> > On Thu, May 14, 2015 at 10:38 AM, Andrew Bresticker
> > <abrestic@chromium.org> wrote:
> > > On Thu, May 14, 2015 at 12:40 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > >> On Thu, 14 May 2015, Jon Hunter wrote:
> > >>
> > >>> Hi Lee,
> > >>>
> > >>> On 13/05/15 15:39, Lee Jones wrote:
> > >>> > On Mon, 04 May 2015, Andrew Bresticker wrote:
> > >>> >
> > >>> >> Add a binding document for the XUSB host complex on NVIDIA Tegra124
> > >>> >> and later SoCs.  The XUSB host complex includes a mailbox for
> > >>> >> communication with the XUSB micro-controller and an xHCI host-controller.
> > >>> >>
> > >>> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> > >>> >> Cc: Rob Herring <robh+dt@kernel.org>
> > >>> >> Cc: Pawel Moll <pawel.moll@arm.com>
> > >>> >> Cc: Mark Rutland <mark.rutland@arm.com>
> > >>> >> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > >>> >> Cc: Kumar Gala <galak@codeaurora.org>
> > >>> >> Cc: Samuel Ortiz <sameo@linux.intel.com>
> > >>> >> Cc: Lee Jones <lee.jones@linaro.org>
> > >>> >> ---
> > >>> >> Changes from v7:
> > >>> >>  - Move non-shared resources into child nodes.
> > >>> >> New for v7.
> > >>> >> ---
> > >>> >>  .../bindings/mfd/nvidia,tegra124-xusb.txt          | 37 ++++++++++++++++++++++
> > >>> >>  1 file changed, 37 insertions(+)
> > >>> >>  create mode 100644 Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> > >>> >>
> > >>> >> diff --git a/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> > >>> >> new file mode 100644
> > >>> >> index 0000000..bc50110
> > >>> >> --- /dev/null
> > >>> >> +++ b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> > >>> >> @@ -0,0 +1,37 @@
> > >>> >> +NVIDIA Tegra XUSB host copmlex
> > >>> >> +==============================
> > >>> >> +
> > >>> >> +The XUSB host complex on Tegra124 and later SoCs contains an xHCI host
> > >>> >> +controller and a mailbox for communication with the XUSB micro-controller.
> > >>> >> +
> > >>> >> +Required properties:
> > >>> >> +--------------------
> > >>> >> + - compatible: For Tegra124, must contain "nvidia,tegra124-xusb".
> > >>> >> +   Otherwise, must contain '"nvidia,<chip>-xusb", "nvidia,tegra124-xusb"'
> > >>> >> +   where <chip> is tegra132.
> > >>> >> + - reg: Must contain the base and length of the XUSB FPCI registers.
> > >>> >> + - ranges: Bus address mapping for the XUSB block.  Can be empty since the
> > >>> >> +   mapping is 1:1.
> > >>> >> + - #address-cells: Must be 2.
> > >>> >> + - #size-cells: Must be 2.
> > >>> >> +
> > >>> >> +Example:
> > >>> >> +--------
> > >>> >> +  usb at 0,70098000 {
> > >>> >> +          compatible = "nvidia,tegra124-xusb";
> > >>> >> +          reg = <0x0 0x70098000 0x0 0x1000>;
> > >>> >> +          ranges;
> > >>> >> +
> > >>> >> +          #address-cells = <2>;
> > >>> >> +          #size-cells = <2>;
> > >>> >> +
> > >>> >> +          usb-host at 0,70090000 {
> > >>> >> +                  compatible = "nvidia,tegra124-xhci";
> > >>> >> +                  ...
> > >>> >> +          };
> > >>> >> +
> > >>> >> +          mailbox {
> > >>> >> +                  compatible = "nvidia,tegra124-xusb-mbox";
> > >>> >> +                  ...
> > >>> >> +          };
> > >>> >
> > >>> > This doesn't appear to be a proper MFD.  I would have the USB and
> > >>> > Mailbox devices probe seperately and use a phandle to point the USB
> > >>> > device to its Mailbox.
> > >>> >
> > >>> > usb at xyz {
> > >>> >     mboxes = <&xusb-mailbox, [chan]>;
> > >>> > };
> > >>> >
> > >>>
> > >>> I am assuming that Andrew had laid it out like this to reflect the hw
> > >>> structure. The mailbox and xhci controller are part of the xusb
> > >>> sub-system and hence appear as child nodes. My understanding is that for
> > >>> device-tree we want the device-tree structure to reflect the actual hw.
> > >>> Is this not the case?
> > >>
> > >> Yes, the DT files should reflect h/w.  I have requested to see what
> > >> the memory map looks like, so I might provide a more appropriate
> > >> solution to accepting a pretty pointless MFD.
> > >
> > > FWIW, the address map for XUSB looks like this:
> > >
> > > XUSB_HOST: 0x70090000 - 0x7009a000
> > >     xHCI registers: 0x70090000 - 0x70098000
> > >     FPCI configuration registers: 0x70098000 - 0x70099000
> > >     IPFS configuration registers: 0x70099000 - 0x7009a000
> > >
> > >> Two solutions spring to mind.  You can either call
> > >> of_platform_populate() from the USB driver, as some already do:
> > >>
> > >>   drivers/usb/dwc3/dwc3-exynos.c:
> > >>     ret = of_platform_populate(node, NULL, NULL, dev);
> > >>   drivers/usb/dwc3/dwc3-keystone.c:
> > >>     error = of_platform_populate(node, NULL, NULL, dev);
> > >>   drivers/usb/dwc3/dwc3-omap.c:
> > >>     ret = of_platform_populate(node, NULL, NULL, dev);
> > >>   drivers/usb/dwc3/dwc3-qcom.c:
> > >>     ret = of_platform_populate(node, NULL, NULL, qdwc->dev);
> > >>   drivers/usb/dwc3/dwc3-st.c:
> > >>     ret = of_platform_populate(node, NULL, NULL, dev);
> > >>   drivers/usb/musb/musb_am335x.c:
> > >>     ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> > >
> > > This still requires a small, separate driver to setup the regmap and
> > > do of_platform_populate().  The only difference is it lives in
> > > drivers/usb/ instead of drivers/mfd/.
> > >
> > >> Or use the "simple-mfd", which is currently in -next:
> > >>
> > >>   git show next/master:Documentation/devicetree/bindings/mfd/mfd.txt
> > >
> > > I'm not too opposed to this, but Thierry was when I brought this up
> > > before.  The issue here is that if we ever have to do something
> > > besides setting up a regmap in the MFD, we'd have to change the
> > > binding and break DT backwards-compatibility.
> > 
> > Any thoughts on this?  A minimal MFD seems to be the best way to
> > future-proof this binding/driver should it need to be extended in the
> > future.  If this is a firm NAK from you however, I'll need to let
> > Jassi now so that he can un-queue the mailbox patches for 4.2....
> 
> I was waiting to hear Thierry's thoughts.  However, I am unconvinced
> that you need an MFD driver for this and refuse to take a shell (read
> "pointless") one on an "if we ever ..." clause.
> 
> Will you break backwards capability though?  I'm not sure you will.
> Old DTBs will still use 'simple-mfd' and probe the devices in the
> normal way.  *If* you introduce an MFD driver at a later date then the
> old DTB will miss out the *new* functionality, which is expected and
> accepted.

I'm a little confused by the simple-mfd approach. The only code I see in
linux-next for this is a single line that adds the "simple-mfd" string
to the OF device ID table in drivers/of/platform.c. As far as I can tell
this will merely cause child devices to be created. There won't be a
shared regmap and resources won't be set up properly either. Having a
proper MFD driver seems to be the only way to achieve what we need.

The reason why every other simple-mfd users seems to get away with this
is because they also match on syscon and that sets up a regmap of its
own and the child device drivers use the syscon API to get at it. So I
don't see how we can make use of simple-mfd to achieve what we need,
unless we essentially copy what syscon does (but do proper resource
management while at it).

There is also the matter of clocks, resets, power supplies, etc. which
simple-mfd can't take into account in its current form. From a hardware
point of view, (some of) the clocks and resets are shared by the XHCI
and the mailbox blocks, so the device tree node would have to take that
into account. And a driver would also have to know which clocks, resets
and power supplies to probe and the order in which they need to be
enabled. simple-mfd doesn't provide any of that currently, so we'd
likely need to hack around that in all sorts of weird ways in the child
drivers. It makes much more sense for a top-level MFD driver to set up
the shared hardware resources and then instantiate the child devices and
let the drivers for those only care about the child-specific resources.

A catch-all driver will inevitably lead to implementing a midlayer with
potentially all sorts of quirks to make it work with the various devices
out there.

A much better implementation, in my opinion, would be to make simple-mfd
a subclassable object and then have drivers use a helper library to call
code that is common for simple-mfd kinds of devices. Something like this
for example:

	struct tegra_xusb {
		...
		struct mfd_simple mfd;
		...
	};

	static int tegra_xusb_probe(struct platform_device *pdev)
	{
		struct tegra_xusb *xusb;
		...
		err = mfd_simple_register(&xusb->mfd);
		...
	}

Now all these drivers reuse all the code provided by the mfd_simple
helper, which will instantiate the children, but it is also very easy to
tie in the platform-specific glue (clocks, resets, regulators, ...) via
the device-specific drivers.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/3807ec83/attachment.sig>
