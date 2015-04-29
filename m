From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 29 Apr 2015 19:34:29 +0100
Subject: [PATCH V7 4/9] mfd: Add binding document for NVIDIA Tegra XUSB
In-Reply-To: <CAL1qeaFh5go_K0GnGXxU7KqjcgCm2kpUL5mVgGSYosPoXAXgpw@mail.gmail.com>
References: <1430174242-29465-1-git-send-email-abrestic@chromium.org>
 <1430174242-29465-5-git-send-email-abrestic@chromium.org>
 <20150429092545.GR9169@x1>
 <CAL1qeaFh5go_K0GnGXxU7KqjcgCm2kpUL5mVgGSYosPoXAXgpw@mail.gmail.com>
Message-ID: <20150429183429.GB9169@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Apr 2015, Andrew Bresticker wrote:

> Lee,
> 
> On Wed, Apr 29, 2015 at 2:25 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Mon, 27 Apr 2015, Andrew Bresticker wrote:
> >
> >> Add a binding document for the XUSB host complex on NVIDIA Tegra124
> >> and later SoCs.  The XUSB host complex includes a mailbox for
> >> communication with the XUSB micro-controller and an xHCI host-controller.
> >>
> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Pawel Moll <pawel.moll@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> >> Cc: Kumar Gala <galak@codeaurora.org>
> >> Cc: Samuel Ortiz <sameo@linux.intel.com>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> ---
> >> New for v7.
> >> ---
> >>  .../bindings/mfd/nvidia,tegra124-xusb.txt          | 46 ++++++++++++++++++++++
> >>  1 file changed, 46 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> >> new file mode 100644
> >> index 0000000..6a46680
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/nvidia,tegra124-xusb.txt
> >> @@ -0,0 +1,46 @@
> >> +NVIDIA Tegra XUSB host copmlex
> >> +==============================
> >> +
> >> +The XUSB host complex on Tegra124 and later SoCs contains an xHCI host
> >> +controller and a mailbox for communication with the XUSB micro-controller.
> >> +
> >> +Required properties:
> >> +--------------------
> >> + - compatible: For Tegra124, must contain "nvidia,tegra124-xusb".
> >> +   Otherwise, must contain '"nvidia,<chip>-xusb", "nvidia,tegra124-xusb"'
> >> +   where <chip> is tegra132.
> >
> > Okay.  Why?
> 
> Why what?  This is the convention used for Tegra bindings and is also
> documented in Documentation/devicetree/bindings/submitting-patches.txt.
> See nvidia,tegra114-spi.txt and nvidia,tegra20-i2c.txt for other
> examples of this.

It seems strange to me that you'd mention two specific chips in one
compatible string.  What's the purpose of that?

> >> + - reg: Must contain register base and length for each register set listed
> >> +   in reg-names.
> >
> > You've mentioned 2 of the cells, what about the remaining 2?
> 
> The example given was for Tegra124, where there are two address cells
> and two size cells.

I don't get that.  How does that work?

> >> + - reg-names: Must include the following entries:
> >> +   - xhci
> >> +   - fpci
> >> +   - ipfs
> >> + - interrupts: Must contain an interrupt for each entry in interrupt-names.
> >> + - interrupt-names: Must include the following entries:
> >> +   - host
> >> +   - smi
> >> +   - pme
> >> +
> >> +Example:
> >> +--------
> >> +     usb at 0,70090000 {
> >> +             compatible = "nvidia,tegra124-xusb";
> >> +             reg = <0x0 0x70090000 0x0 0x8000>,
> >> +                   <0x0 0x70098000 0x0 0x1000>,
> >> +                   <0x0 0x70099000 0x0 0x1000>;
> >> +             reg-names = "xhci", "fpci", "ipfs";
> >> +             interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
> >> +                          <GIC_SPI 40 IRQ_TYPE_LEVEL_HGIH>,
> >> +                          <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> >> +             interrupt-names = "host", "smi", "pme";
> >
> > Are these resources used by both children?
> 
> Only the FPCI register set is shared.
> 
> > If not, place them into the children and ioremap() them from the
> > associated child drivers.
> 
> Ok.

Great.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
