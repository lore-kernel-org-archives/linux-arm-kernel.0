From: robh@kernel.org (Rob Herring)
Date: Thu, 30 Jun 2016 08:54:32 -0500
Subject: [PATCH 3/3] dt-bindings: Document the STM32 USB OTG DWC2 core
 binding
In-Reply-To: <CAF3+Tqe_83zuaxWfp2sv6pZ70XzkbfZ4V4w+n8wCFAApvRirdg@mail.gmail.com>
References: <1466562349-5043-1-git-send-email-bruherrera@gmail.com>
 <1466562349-5043-3-git-send-email-bruherrera@gmail.com>
 <20160624154118.GA4598@rob-hp-laptop>
 <CAF3+Tqe05kXExob_62w80BBbXz6p01-WwXM1+R6ecp0JtsgviA@mail.gmail.com>
 <20160628205441.GA3737@rob-hp-laptop>
 <CAF3+Tqe_83zuaxWfp2sv6pZ70XzkbfZ4V4w+n8wCFAApvRirdg@mail.gmail.com>
Message-ID: <20160630135432.GA13875@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 03:56:23PM -0300, Bruno Herrera wrote:
> On Tue, Jun 28, 2016 at 5:54 PM, Rob Herring <robh@kernel.org> wrote:
> > On Fri, Jun 24, 2016 at 03:51:18PM -0300, Bruno Herrera wrote:
> >> On Fri, Jun 24, 2016 at 12:41 PM, Rob Herring <robh@kernel.org> wrote:
> >> > On Tue, Jun 21, 2016 at 11:25:49PM -0300, Bruno Herrera wrote:
> >> >> Signed-off-by: Bruno Herrera <bruherrera@gmail.com>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
> >> >>  1 file changed, 1 insertion(+)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> >> >> index 20a68bf..79e5370 100644
> >> >> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> >> >> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> >> >> @@ -11,6 +11,7 @@ Required properties:
> >> >>    - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
> >> >>    - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;
> >> >>    - snps,dwc2: A generic DWC2 USB controller with default parameters.
> >> >> +  - st,stm32-fsotg: The DWC2 USB controller instance in STM32F4 SoCs in FS mode;
> >> >
> >> > This should go above snps,dwc2.
> >> >
> >> Ok, tks!
> >>
> >> > What determines FS mode vs. HS?
> >> >
> >> Its more HW design decision.
> >> STM32F429/439/469 has two OTG controllers, one that is FS (internal
> >> phy) and other that is HS (but can also work in FS mode with
> >> internal/external phy)
> >> This bind work with both cores FS and HS working with the internal PHY.
> >>
> >> I tested the following configurations:
> >> 1 - STM32F429I-DISCOv1 board (OTG HS working in FS mode internal PHY)
> >> 2 - STM32F469I-DISCO board (OTG FS)
> >>
> >> I did not tested OTG HS core working in FS mode with external PHY (I2C).
> >
> > You shouldn't be setting the compatible string based on which mode you
> > want. So for the HS block, you need a different compatible string than
> > the FS block and set the speed in another way (not sure if we have a
> > standard way). Or perhaps the phy should determine the speed.
> 
> I understand but I dont see how to fix it properly unless we add a
> some specific STM32 properties in the DT or in the dwc2_core_params.
> In fact there are two cores, and they are different in terms of
> functionality (despite of the type of the PHY).
> One core is for FS and other is for HS, so they could/should have
> different compatible strings because they have different
> configurations and are different piece of IP/Hardware(The buffer size
> are different, the number of end points and so one, DMA)

Then it is perfectly fine to have 2 compatible strings: one for the FS 
block and one for the HS block.

> 
> But the problem is that the HS core can also support the the FS mode
> and in this case is misleading to have a HS core with an FS compatible
> string.

But as you said, there are other differences in the 2 blocks, so just 
changing to the FS compatible string would not work.

You could just have a high-speed-disable property or something, but look 
thru existing bindings and see if one exists already. If not, propose a 
common one.

> Something like that (real case for STM32F429I-DISCO):
> 
> &usbotg_hs {
> compatible = "st,stm32-fsotg", "snps,dwc2";
> dr_mode = "host";
> pinctrl-0 = <&usbotg_fs_pins_b>;
> pinctrl-names = "default";
> status = "okay";
> };
> 
> Even if the decision is phy based it would lead to a STM32 specific
> logic and we would need to figure out how to represent the internal
> PHY.

Most SoCs end up describing the phys at least for USB 2 and 3 as they 
vary a lot eventhough everyone licenses one of the few IP blocks.

Rob
