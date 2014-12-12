From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 12 Dec 2014 13:14:53 +0100
Subject: __hci_cmd_sync() not suitable for nokia h4p
In-Reply-To: <20141212011504.GA16599@earth.universe>
References: <20141209190210.GA15641@amd>
 <304050AD-DB11-4A2B-A1F7-8B1BBB5F04F0@holtmann.org>
 <20141209201328.GA18003@amd>
 <7EFD3C33-E503-4FB6-BCCF-52836080ABD6@holtmann.org>
 <20141210131519.GA14748@amd>
 <EE1A4B9D-30D5-4BD9-9A43-532619494A0C@holtmann.org>
 <20141211221306.GA2905@amd> <20141212011504.GA16599@earth.universe>
Message-ID: <20141212121453.GA31659@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!


> > I have created provisional device tree binding, and the driver still
> > works.
> 
> I don't have time to look at the code now, but I have some comments
> regarding the binding.

> >  
> >  &uart2 {
> > +        compatible = "brcm,uart,bcm2048";
> 
> This does not look correct. The uart should not be overwritten. The
> current h4p driver indeed implements a driver for the serial port,
> but that's a) linux specific and does not belong in the DT and b)
> should probably be changed in the mainline kernel.

Yes, bettter solution is needed here. But see the code, I don't see
how b) would be implemented.

> >  	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&uart2_pins>;
> > +	device {
> > +		  compatible = "brcm,bcm2048";
> > +		  uart = <&uart2>;
> 
> You don't need a phandle to the parent device.

Ok.

> > +		  reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
> > +		  host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
> 
> The host-wakeup should be mapped as irq, gpio2irq conversion
> will happen ;)

Why? It is accessed as gpio, too.

> > +		  chip-type = <3>;
> 
> This should be set in the driver based on the compatible
> value and not via DT data.

Ok

> > +		  clocks = <&uart2_fck>, <&uart2_ick>;
> > +		  clock-names = "fck", "ick";
> 
> These clocks you defined belong to the uart device and not to the
> uart slave (bluetooth) device.

Ok. Why are they only needed in the bluetooth case?

> > +		  bt-sysclk = <2>;
> 
> I think this should be mapped cleanly in DT by adding a new clock
> to the DTS file:
> 
> vctcxo_clock: clock  {
>     compatible = "fixed-clock";
>     #clock-cells = <0>;
>     clock-frequency = <38400000>;
> };

No. It seems that this selects baud rate during the chip init. I guess
I can just remove that one.

> Then the bluetooth device can reference its clock device:
> 
> clocks = <&vctcxo_clock>;
> 
> The same clock reference should be added to the wl1251 DT node :)

Feel free to do that, but I don't see how this one helps...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
