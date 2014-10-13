From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 13 Oct 2014 16:47:59 +0800
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140926003750.GA12770@saruman>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <2923729.dtX0WmHSV0@wuerfel> <20140924112902.GA23331@peterchendt>
 <2786668.t3YLqX5enD@wuerfel> <20140925141553.GC28045@saruman>
 <20140925233932.GA3026@peterchendt> <20140926003750.GA12770@saruman>
Message-ID: <20141013084758.GB3314@peterchendt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 07:37:50PM -0500, Felipe Balbi wrote:
> HI,
> 
> On Fri, Sep 26, 2014 at 07:39:34AM +0800, Peter Chen wrote:
> > On Thu, Sep 25, 2014 at 09:15:53AM -0500, Felipe Balbi wrote:
> > > On Wed, Sep 24, 2014 at 02:23:38PM +0200, Arnd Bergmann wrote:
> > > > On Wednesday 24 September 2014 19:29:05 Peter Chen wrote:
> > > > > 
> > > > > So, it is IP CORE LIB (you suggest) vs IP CORE Platform Driver
> > > > > (dwc3, musb, chipidea) you are talking about, right? Except for
> > > > > creating another platform driver as well as related DT node (optional),
> > > > > are there any advantages compared to current IP core driver structure?
> > > > 
> > > > Having a library module usually requires less code, and is more
> > > > consistent with other drivers, which helps new developers understand
> > > > what the driver is doing.
> > > 
> > > I beg to differ. You end-up having to pass function pointers through
> > > platform_data to handle differences which could be handled by the core
> > > IP.
> > > 
> > > > The most important aspect though is the DT binding: once the structure
> > > > with separate kernel drivers leaks out into the DT format, you can't
> > > > easily change the driver any more, e.g. to make a property that was
> > > > introduced for one glue driver more general so it can get handled by
> > > > the common part. Having a single node lets us convert to the library
> > > > model later, so that would be a strong reason to keep the DT binding
> > > > simple, without child nodes.
> > > > 
> > > > Following that logic, it turns into another reason for using the library
> > > > model to start with, because otherwise the child device does not have
> > > > any DT properties itself and has to rely on the parent device properties,
> > > > which somewhat complicates the driver structure.
> > > 
> > > this is bullcrap. Take a look at
> > > Documentation/devicetree/bindings/usb/dwc3.txt:
> > > 
> > > synopsys DWC3 CORE
> > > 
> > > DWC3- USB3 CONTROLLER
> > > 
> > > Required properties:
> > >  - compatible: must be "snps,dwc3"
> > >  - reg : Address and length of the register set for the device
> > >  - interrupts: Interrupts used by the dwc3 controller.
> > > 
> > > Optional properties:
> > >  - usb-phy : array of phandle for the PHY device.  The first element
> > >    in the array is expected to be a handle to the USB2/HS PHY and
> > >    the second element is expected to be a handle to the USB3/SS PHY
> > >  - phys: from the *Generic PHY* bindings
> > >  - phy-names: from the *Generic PHY* bindings
> > >  - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
> > > 
> > > This is usually a subnode to DWC3 glue to which it is connected.
> > > 
> > > dwc3 at 4a030000 {
> > > 	compatible = "snps,dwc3";
> > > 	reg = <0x4a030000 0xcfff>;
> > > 	interrupts = <0 92 4>
> > > 	usb-phy = <&usb2_phy>, <&usb3,phy>;
> > > 	tx-fifo-resize;
> > > };
> > > 
> 
> > Is it possible that the glue layer needs to access core register
> > (eg, portsc.phcd during suspend)? The wrapper IP may wait some signals
> > at core IP to change.
> 
> why would a glue layer need to access registers from the core ? That
> sounds very odd. I haven't seen that and will, definitely, NACK such a
> patch :-)
> 

Just have a case for glue layer needs to know core layer's status.
The controller's wakeup logic is usually at glue layer, but we
may need to enable different wakeup for roles. Eg, if the current
role is host (controller is otg capable), we can't enable id wakeup,
otherwise, the user will complain plug out Micro-AB cable wakes up
system which is not expected.

-- 
Best Regards,
Peter Chen
