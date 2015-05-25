From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 25 May 2015 12:04:09 -0700
Subject: [PATCH 2/3] dts: Adding docs for Xilinx LogiCORE IP mailbox
 driver.
In-Reply-To: <555EC20C.6010703@xilinx.com>
References: <1432251450-26352-1-git-send-email-moritz.fischer@ettus.com>
 <1432251450-26352-3-git-send-email-moritz.fischer@ettus.com>
 <555EC20C.6010703@xilinx.com>
Message-ID: <20150525190409.GS18303@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-05-22 at 07:43AM +0200, Michal Simek wrote:
> On 05/22/2015 01:37 AM, Moritz Fischer wrote:
> > Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> > ---
> >  .../bindings/mailbox/xilinx-mailbox.txt         | 40 ++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> > 
> 
> IRC the rule was to send binding first and then the driver.
> 
> > diff --git a/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> > new file mode 100644
> > index 0000000..e559743
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/xilinx-mailbox.txt
> > @@ -0,0 +1,40 @@
> > +Xilinx Mailbox Driver
> > +=====================
> > +
> > +Required properties:
> > +- compatible :	"xlnx,mailbox-2.1".
> > +- reg : 	physical base address of the mailbox and length of
> > +		memory mapped region.
> > +- #mbox-cells:	Common mailbox binding property to identify the number
> > +		of cells required for the mailbox specifier. Should be 1.
> > +
> > +Optional properties:
> > +- interrupt-parent :	interrupt source phandle.
> > +- interrupts :		interrupt number. The interrupt specifier format
> 
> please be consistent with spacing around :. It doesn't look nice.
> 
> > +			depends on the interrupt controller parent.
> > +
> > +Example:
> > +	mbox: mailbox at 0x40400000 {
> 
> remove 0x prefix here.
> 
> > +		compatible = "xlnx,axi-mailbox-2.1";
> > +		reg = <0x100 0x3c>;
> 
> This is weird - it should start with 40400000.
> Or is your physical address 0x100?
> 
> 
> > +		interrupt-parent = <&intc>;
> > +		interrupts = <5>;
> > +		#mbox-cells = <1>;
> > +	};
> > +
> > +Mailbox client
> > +===============
> > +"mboxes" and the optional "mbox-names" (please see
> > +Documentation/devicetree/bindings/mailbox/mailbox.txt for details). Each value
> > +of the mboxes property should contain a phandle to the mailbox controller
> > +device node and second argument is the channel index. It must be 0 (hardware
> > +support only one channel).The equivalent "mbox-names" property value can be
> 
> .<space>The
> 
> > +used to give a name to the communication channel to be used by the client user.
> > +
> > +Example:
> > +	mclient0: mclient0 at 0x400 {
> 
> ditto.
> 
> > +		compatible = "client-1.0";
> > +		reg = <0x400 0x10>;
> > +		mbox-names = "mbox", "mbox-rx";

This seems to consume two mailboxes but...

> > +		mboxes = <&mbox 0>;

... this seems to describe only one, or am I mistaken?

	S?ren
