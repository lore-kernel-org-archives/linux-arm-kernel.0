From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 May 2015 10:30:42 +0100
Subject: [PATCH v8 4/9] mfd: Add binding document for NVIDIA Tegra XUSB
In-Reply-To: <55546767.90501@nvidia.com>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <1430761002-9327-5-git-send-email-abrestic@chromium.org>
 <20150513143954.GA3394@x1> <55544CC5.9050001@nvidia.com>
 <20150514074058.GA22418@x1> <55546767.90501@nvidia.com>
Message-ID: <20150514093042.GG22418@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 May 2015, Jon Hunter wrote:
> On 14/05/15 08:40, Lee Jones wrote:
> > On Thu, 14 May 2015, Jon Hunter wrote:
> >> On 13/05/15 15:39, Lee Jones wrote:
> >>> On Mon, 04 May 2015, Andrew Bresticker wrote:
> >>>
> >>>> Add a binding document for the XUSB host complex on NVIDIA Tegra124
> >>>> and later SoCs.  The XUSB host complex includes a mailbox for
> >>>> communication with the XUSB micro-controller and an xHCI host-controller.
> >>>>
> >>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> >>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>> Cc: Pawel Moll <pawel.moll@arm.com>
> >>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> >>>> Cc: Kumar Gala <galak@codeaurora.org>
> >>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
> >>>> Cc: Lee Jones <lee.jones@linaro.org>
> >>>> ---
> >>>> Changes from v7:
> >>>>  - Move non-shared resources into child nodes.
> >>>> New for v7.
> >>>> ---
> >>>>  .../bindings/mfd/nvidia,tegra124-xusb.txt          | 37 ++++++++++++++++++++++
> >>>>  1 file changed, 37 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> >>>> new file mode 100644
> >>>> index 0000000..bc50110
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> >>>> @@ -0,0 +1,37 @@
> >>>> +NVIDIA Tegra XUSB host copmlex
> >>>> +==============================
> >>>> +
> >>>> +The XUSB host complex on Tegra124 and later SoCs contains an xHCI host
> >>>> +controller and a mailbox for communication with the XUSB micro-controller.
> >>>> +
> >>>> +Required properties:
> >>>> +--------------------
> >>>> + - compatible: For Tegra124, must contain "nvidia,tegra124-xusb".
> >>>> +   Otherwise, must contain '"nvidia,<chip>-xusb", "nvidia,tegra124-xusb"'
> >>>> +   where <chip> is tegra132.
> >>>> + - reg: Must contain the base and length of the XUSB FPCI registers.
> >>>> + - ranges: Bus address mapping for the XUSB block.  Can be empty since the
> >>>> +   mapping is 1:1.
> >>>> + - #address-cells: Must be 2.
> >>>> + - #size-cells: Must be 2.
> >>>> +
> >>>> +Example:
> >>>> +--------
> >>>> +	usb at 0,70098000 {
> >>>> +		compatible = "nvidia,tegra124-xusb";
> >>>> +		reg = <0x0 0x70098000 0x0 0x1000>;
> >>>> +		ranges;
> >>>> +
> >>>> +		#address-cells = <2>;
> >>>> +		#size-cells = <2>;
> >>>> +
> >>>> +		usb-host at 0,70090000 {
> >>>> +			compatible = "nvidia,tegra124-xhci";
> >>>> +			...
> >>>> +		};
> >>>> +
> >>>> +		mailbox {
> >>>> +			compatible = "nvidia,tegra124-xusb-mbox";
> >>>> +			...
> >>>> +		};
> >>>
> >>> This doesn't appear to be a proper MFD.  I would have the USB and
> >>> Mailbox devices probe seperately and use a phandle to point the USB
> >>> device to its Mailbox.
> >>>
> >>> usb at xyz {
> >>> 	mboxes = <&xusb-mailbox, [chan]>;
> >>> };
> >>>
> >>
> >> I am assuming that Andrew had laid it out like this to reflect the hw
> >> structure. The mailbox and xhci controller are part of the xusb
> >> sub-system and hence appear as child nodes. My understanding is that for
> >> device-tree we want the device-tree structure to reflect the actual hw.
> >> Is this not the case?
> > 
> > Yes, the DT files should reflect h/w.  I have requested to see what
> > the memory map looks like, so I might provide a more appropriate
> > solution to accepting a pretty pointless MFD.
> 
> For the xusb-host has memory from 0x7009000 - 0x7009ffff.
> 
> Within this range, we have this fpci range which is defined as 0x7009800
> - 0x70098fff. This range is being shared between the mailbox and xhci
> drivers. Looking at the drivers, we have ...
> 
> mailbox uses: 0x700980e0 - 0x700980f3 and 0x70098428 - 0x7009842b.
> xhci uses:    0x70098000 - 0x700980cf and 0x70098800 - 0x70098803.
> 
> So it is a bit messy as they overlap. However, we could have ...
> 
> 	xusb_mbox: mailbox {
> 		compatible = "nvidia,tegra124-xusb-mbox";
> 		reg = <0x0 0x700980e0 0x0 0x14>,
> 		      <0x0 0x70098428 0x0 0x4>;
> 		...
> 	};
> 	usb-host at 0,70090000 {
> 		compatible = "nvidia,tegra124-xhci";
> 		reg = <0x0 0x70090000 0x0 0x8000>,		      	
> 		      <0x0 0x70098000 0x0 0x00d0>;
> 		      <0x0 0x70098800 0x0 0x0004>;
> 		      <0x0 0x70099000 0x0 0x1000>;
> 		...
> 	};
> 
> I believe that Thierry and Stephen said that they wished to avoid
> multiple devices sharing the same memory ranges, and so we would need to
> divvy up the memory map as above. However, I am not sure if this is an
> ok thing to do.
> 	
> > Two solutions spring to mind.  You can either call
> > of_platform_populate() from the USB driver, as some already do:
> > 
> >   drivers/usb/dwc3/dwc3-exynos.c:
> >     ret = of_platform_populate(node, NULL, NULL, dev);
> >   drivers/usb/dwc3/dwc3-keystone.c:
> >     error = of_platform_populate(node, NULL, NULL, dev);
> >   drivers/usb/dwc3/dwc3-omap.c:
> >     ret = of_platform_populate(node, NULL, NULL, dev);
> >   drivers/usb/dwc3/dwc3-qcom.c:
> >     ret = of_platform_populate(node, NULL, NULL, qdwc->dev);
> >   drivers/usb/dwc3/dwc3-st.c:
> >     ret = of_platform_populate(node, NULL, NULL, dev);
> >   drivers/usb/musb/musb_am335x.c:
> >     ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> > 
> > Or use the "simple-mfd", which is currently in -next:
> > 
> >   git show next/master:Documentation/devicetree/bindings/mfd/mfd.txt
> 
> That is nice. Sounds like the "simple-bus" style of device but for an

That's precisely what it does.  FYI: You 'can' use "simple-bus" and it
will do the right thing, but as an MFD isn't really a bus, it was
decided to create something a little more fitting.

> mfd. Based upon the above, let me know if you think we could use the
> "simple-mfd"?

I do. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
