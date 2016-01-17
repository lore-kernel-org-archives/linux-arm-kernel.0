From: eyalr@ti.com (Reizer, Eyal)
Date: Sun, 17 Jan 2016 07:57:01 +0000
Subject: [PATCH 1/3] ti-st: use device handles and add device tree binding
In-Reply-To: <20151229183534.GM12450@rob-hp-laptop>
References: <1450870253-8694-1-git-send-email-eyalr@ti.com>
 <8665E2433BC68541A24DFFCA87B70F5B23759A5B@DFRE01.ent.ti.com>
 <20151229183534.GM12450@rob-hp-laptop>
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B2376B680@DFRE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the delayed response.

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, December 29, 2015 8:36 PM
> To: Reizer, Eyal
> Cc: devicetree at vger.kernel.org; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; tony at atomide.com;
> linux at arm.linux.org.uk
> Subject: Re: [PATCH 1/3] ti-st: use device handles and add device tree binding
> 
> On Wed, Dec 23, 2015 at 11:38:29AM +0000, Reizer, Eyal wrote:
> > - Add support for getting the platform data which includes the uart
> >   used and gpio pin used for enable from device tree.
> >
> > - Fix the implementation for using device handle for the uart and
> >   gpiod for the enable pin, instead of device name (as string) used
> >   for the uart and pio number which are both bad practice.
> >
> > Signed-off-by: Eyal Reizer <eyalr@ti.com>
> > ---
> >  Documentation/devicetree/bindings/misc/ti-st.txt |   42 ++++++
> >  arch/arm/mach-omap2/pdata-quirks.c               |   16 ++-
> >  drivers/misc/ti-st/st_kim.c                      |  159 ++++++++++++++++------
> >  drivers/misc/ti-st/st_ll.c                       |   16 ++-
> >  include/linux/ti_wilink_st.h                     |   13 +-
> 
> I'd suggest you look at commit c0bd1b9e58959c5 (Revert "ti-st: add device
> tree support") first.
> 
> >  5 files changed, 190 insertions(+), 56 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/misc/ti-st.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/ti-st.txt
> > b/Documentation/devicetree/bindings/misc/ti-st.txt
> > new file mode 100644
> > index 0000000..4490da6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/ti-st.txt
> > @@ -0,0 +1,42 @@
> > +TI Wilink 6/7/8 (wl12xx/wl18xx) Shared transport driver
> 
> Bindings shouldn't be describing drivers...
> 

OK, understood

> > +
> > +TI?s Wireless Connectivity chips support Bluetooth (BT), WiFi, and
> > +GPS technology cores in a single die.
> > +
> > +Such a multi-core combo chip will be interfaced to the application
> > +processor using a single physical port (like UART).
> > +
> > +Shared Transport (ST) software enables BT and GPS protocols or
> > +software components to interact with their respective cores over single
> physical port.
> > +ST uses logical channels, over physical transport, to communicate
> > +with individual cores.
> > +
> > +Logical channels 1, 2, 3, and 4 are used for BT packets, channel 8
> > +for FM, channel 9 for GPS and channels 30, 31, 32, and 33 are used
> > +for Chip Power Management (PM).
> 
> All this is irrelevant for a binding.
> 

OK, understood

> > +
> > +This node provides properties for passing parameters to the ti shared
> > +transport driver.
> > +
> > +Required properties:
> > + - compatible: should be the following:
> > +    * "kim" - ti-st parameters
> 
> Who is kim? Certainly not a description of a h/w block.

Not sure about the origin of this name but according to the following link:
http://processors.wiki.ti.com/index.php/Shared_Transport_Driver
KIM is "Kernel Initialization Manager" that enables communication with BT and GPS cores.

> 
> > +
> > +Optional properties:
> > + - nshutdown-gpios : specifies attributes for gpio ping used for enabling
> > +	the bluetooth,gps and FM sub systems
> > + - serial-device : the phandle for the phisical uart used for interacting
> > + 	with the wilink device
> 
> There have been multiple discussions on serial slave devices recently.
> I'm not going to accept any device binding without a common uart slave
> device binding first.
> 

Perhaps I am reading it wrong but I think this is a different discussion.
The shared transport driver is already in the kernel for pretty long time. 
AFAIK the original author is not around to maintain it.
Currently it is useless  as no bindings exist for it and all customers I have seen using ti_st that upgrade 
to newer kernels have broken support and have to manually patch the kernel for adding bindings for it.

Having a new uart slave device that may provide similar functionality is a different discussion as it would 
require a total different implementation.
But what do we do now with the implementation that is already there. 
Don't we want it to work and at least have working bindings for it?

> > + - flow_cntrl : Indicates if uart flow control is used
> > + - flow_cntrl : uart baud rate in BPS
> 
> Typo here, but these should be part of a common serial slave binding.
> 
> Don't use '_' in property names.
> 

Will fix this

> > +
> > +Example:
> > +
> > +kim {
> > +	compatible = "kim";
> > +	nshutdown-gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> > +	serial-device = <&uart1>;
> > +	flow_cntrl = <1>;
> > +	flow_cntrl = <3000000>;
> > +};
> > +

Best Regards,
Eyal
