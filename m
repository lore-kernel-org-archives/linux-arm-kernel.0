From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 19 Mar 2013 19:38:28 +0100
Subject: [PATCH v3 6/6] irqchip: s3c24xx: add s3c2450 interrupt definitions
In-Reply-To: <5147CD6B.80107@gmail.com>
References: <201303171404.06146.heiko@sntech.de>
 <201303190034.49875.heiko@sntech.de> <5147CD6B.80107@gmail.com>
Message-ID: <201303191938.29099.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 19. M?rz 2013, 03:28:59 schrieb Rob Herring:
> On 03/18/2013 06:34 PM, Heiko St?bner wrote:
> > Am Montag, 18. M?rz 2013, 23:14:52 schrieb Rob Herring:
> >> On 03/18/2013 11:53 AM, Heiko St?bner wrote:

[...]

> >> My first thought here is this information should not be centralized in
> >> the controller node, but placed with each source node (2D, I2C1, etc).
> > 
> > I'm not sure I can follow currently :-)
> > 
> > I'll try an example:
> > 
> > The s3c serial driver expects the interrupts for uart tx and rx and the
> > dt
> > 
> > entry would look like:
> > 	serial at 50000000 {
> > 	
> > 		compatible = "samsung,s3c2410-uart";
> > 		reg = <0x50000000 0x4000>;
> > 		interrupt-parent = <&subintc>;
> > 		interrupts = <0>, <1>;
> 
> So what does 0 and 1 correspond to? These are the bits in the subintc?

Yep, the bits in the subintc register.


> > 	};
> > 
> > the map for these in the subintc looks like
> > 
> >                s3c24xx,irqlist = <3 28 /* UART0-RX */
> >                
> >                                   3 28 /* UART0-TX */
> >                                   3 28 /* UART0-ERR */
> > 
> > marking them as using the level-handler and being children of the
> > interrupt in bit 28 of the intc handler.
> > 
> > So the irq_entry would check the intc, see the waiting interrupt in bit
> > 28, jump to the demux function which would then handle which ever of
> > rx,tx or err would be waiting, which then get sent to the serial driver.
> > 
> > These mappings between sub- and parent irqs also vary very much between
> > the different s3c24xx variants, as can be seen by the multitude of lists
> > in [0] and the parent interrupts are only used for demuxing purposes.
> > 
> > -----
> > A notable speciality are the AC97 (sound) and watchdog interrupts (bits
> > 27 and 28 of the subregister), as they share a common parent interrupt
> > (bit 9 of the main interrupt register).
> > 
> > So irq_entry checks the main register, sees bit 9 (ac97/watchdog),
> > demuxes it to either coming from the ac97 or watchdog and sends it to
> > the relevant driver.
> > 
> > I don't think this should be exposed to the drivers at all :-) .
> > -------
> > 
> > So I'm not sure, how this would be able to go in the driver nodes.
> 
> The information in an interrupts property is transparent to the driver,
> but can contain extra cells with whatever information you need. The GIC
> binding has SPI or PPI interrupt type information for example.

so you mean something like <bit flags parent-bit>, right?


> > The only thing I could think of, would be to make the handler adjustable
> > via the regular interrupts properties (i.e. as two_cell) which would
> > bring the list down to only list the parent relationships.
> > 
> > Hmm ... and this parent list might be doable via the regular interrupts
> > property, so the subintc would look like:
> > 
> > subintc: subintc = {
> > 
> > 	interrupt-parent = <&intc>;
> > 	interrupts = <28 0>, <28 0>, <28 0>, <23 0>, <23 0>, .....
> > 	/*		     bit0    bit1    bit2    bit3    bit4   ..... */
> > 
> > }
> > 
> > i.e. naming the parent interrupt for each of the interrupt bits of the
> > sub- controller. Would this be the right direction?
> 
> I think you may want to use an interrupt-map property. That should allow
> you to do arbitrary mappings from one interrupt controller's numbering
> to another's numbering. The VExpress and several PPC platforms have
> examples.

Yep, I've read the examples and also a bit more in-depth on devicetree.org and 
it seems, as you suggested, interrupt-maps are the right concept to describe 
such mappings.


In general, what would be the preferred way to solve this?
Like described above, having the parent bit encoded in the interrupt property 
or doing it with a mapping of sorts like we discussed down here?

I don't have a preference for one or the other right now and both look like 
interesting concepts.


Thanks
Heiko
