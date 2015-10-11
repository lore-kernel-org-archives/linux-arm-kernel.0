From: punnaia@xilinx.com (punnaiah choudary kalluri)
Date: Sun, 11 Oct 2015 16:45:14 +0530
Subject: [RFC PATCH 1/2] usb: doc: Add bindings for ULPI platform driver
In-Reply-To: <20150930161803.GI32625@saruman.tx.rr.com>
References: <1443012841-13673-1-git-send-email-sbhatta@xilinx.com>
 <20150924091034.GB27847@shlinux2>
 <F1B223389110CE49B4CF055ABA2E5D3D78C9BCBF@XAP-PVEXMBX02.xlnx.xilinx.com>
 <CAL_JsqK-aAY+DAwt0YH-mbBo+a9c7WPrBwJJoy3=FkT6ZX2A5w@mail.gmail.com>
 <20150930161803.GI32625@saruman.tx.rr.com>
Message-ID: <CAGnW=Bb0pdv7i1N=WqZoQLDUpuGw=Xq=cM5ir2Ow25pUDYtvEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 9:48 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Sep 24, 2015 at 11:18:01AM -0500, Rob Herring wrote:
>> On Thu, Sep 24, 2015 at 4:26 AM, Subbaraya Sundeep Bhatta
>> <subbaraya.sundeep.bhatta@xilinx.com> wrote:
>> > Hi Peter,
>> >
>> >> -----Original Message-----
>> >> From: Peter Chen [mailto:peter.chen at freescale.com]
>> >> Sent: Thursday, September 24, 2015 2:41 PM
>> >> To: Subbaraya Sundeep Bhatta
>> >> Cc: balbi at ti.com; devicetree at vger.kernel.org; kishon at ti.com;
>> >> gregkh at linuxfoundation.org; linux-usb at vger.kernel.org; linux-
>> >> kernel at vger.kernel.org; Punnaiah Choudary Kalluri; Subbaraya Sundeep Bhatta;
>> >> linux-arm-kernel at lists.infradead.org
>> >> Subject: Re: [RFC PATCH 1/2] usb: doc: Add bindings for ULPI platform driver
>> >>
>> >> On Wed, Sep 23, 2015 at 06:24:01PM +0530, Subbaraya Sundeep Bhatta
>> >> wrote:
>> >> > This patch adds binding doc info for generic ULPI PHYs platform
>> >> > driver.
>> >> >
>> >> > Signed-off-by: Subbaraya Sundeep Bhatta <sbhatta@xilinx.com>
>> >> > ---
>> >> >  .../devicetree/bindings/usb/ulpi-platform-phy.txt  |   34
>> >> ++++++++++++++++++++
>> >> >  1 files changed, 34 insertions(+), 0 deletions(-)  create mode 100644
>> >> > Documentation/devicetree/bindings/usb/ulpi-platform-phy.txt
>> >> >
>> >> > diff --git
>> >> > a/Documentation/devicetree/bindings/usb/ulpi-platform-phy.txt
>> >> > b/Documentation/devicetree/bindings/usb/ulpi-platform-phy.txt
>> >> > new file mode 100644
>> >> > index 0000000..7b8cbb4
>> >> > --- /dev/null
>> >> > +++ b/Documentation/devicetree/bindings/usb/ulpi-platform-phy.txt
>> >> > @@ -0,0 +1,34 @@
>> >> > +Platform driver for generic ULPI PHYs
>> >> > +
>> >> > +Required properties:
>> >> > +- compatible               : Should be "ulpi-phy"
>> >> > +- reg                      : Physical base address and size of the USB
>> >> > +                     controller registers map to which this PHY
>> >> > +                     is connected.
>> >> > +- view-port                : Should contain viewport register offset of the
>> >> > +                     USB controller to which this PHY is connected Optional
>> >> > +properties:
>> >> > +- drv-vbus         : required if turning VBUS on/off has to be driven
>> >> > +                     by writing to PHY. This feature depends on board
>> >> > +                     design.
>> >> > +
>> >> > +Example:
>> >> > +Below example shows the PHY binding for Chipidea USB controller which
>> >> > +has ulpi viewport register at 0x0170
>> >> > +
>> >> > +           usb_phy0: phy0 {
>> >> > +                   compatible = "ulpi-phy";
>> >> > +                   reg = <0xe0002000 0x1000>;
>> >> > +                   view-port = <0x0170>;
>> >> > +                   drv-vbus;
>> >> > +           };
>> >> > +
>> >> > +           usb0: usb at e0002000 {
>> >> > +                        compatible = "chipidea,usb2";
>> >> > +                        interrupt-parent = <&intc>;
>> >> > +                        interrupts = <0 21 4>;
>> >> > +                        reg = <0xe0002000 0x1000>;
>> >>
>> >> Although just call devm_ioremap twice for the same register region does not
>> >> cause any errors, I am not sure if it will has other potential problems. Cc: arm
>> >> list.
>> >
>> > Yes Peter I was also in doubt to call devm_ioremap twice for same register region.
>> > devm_ioremap_resource complained hence modified to devm_ioremap. Thanks for
>> > adding arm-list.
>>
>> Don't put overlapping resources in the DT. Having 2 drivers accessing
>> the same registers is not a clean or safe design.
>
> thanks, saves me the trouble of saying the same thing.
>
> Bottom line, if devm_ioremap_resource() fails, you're wrong. Just fix
> your driver and move on.

Any suggestions on how to move further?
Chipidea controller provides ulpi view port register for accessing the
usb phy registers. Now we want to add new driver for ulpi phy configuration
and that obviously it need of ulpi view port register access. So, sharing the
register space between these two drivers is necessary here.


Regards,
Punnaiah

>
> --
> balbi
