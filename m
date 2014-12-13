From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 13 Dec 2014 18:35:24 +0100
Subject: __hci_cmd_sync() not suitable for nokia h4p
In-Reply-To: <20141212121453.GA31659@amd>
References: <20141209190210.GA15641@amd>
 <304050AD-DB11-4A2B-A1F7-8B1BBB5F04F0@holtmann.org>
 <20141209201328.GA18003@amd>
 <7EFD3C33-E503-4FB6-BCCF-52836080ABD6@holtmann.org>
 <20141210131519.GA14748@amd>
 <EE1A4B9D-30D5-4BD9-9A43-532619494A0C@holtmann.org>
 <20141211221306.GA2905@amd> <20141212011504.GA16599@earth.universe>
 <20141212121453.GA31659@amd>
Message-ID: <20141213173523.GA17570@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 12, 2014 at 01:14:53PM +0100, Pavel Machek wrote:
> > > I have created provisional device tree binding, and the driver still
> > > works.
> > 
> > I don't have time to look at the code now, but I have some comments
> > regarding the binding.
> 
> > >  
> > >  &uart2 {
> > > +        compatible = "brcm,uart,bcm2048";
> > 
> > This does not look correct. The uart should not be overwritten. The
> > current h4p driver indeed implements a driver for the serial port,
> > but that's a) linux specific and does not belong in the DT and b)
> > should probably be changed in the mainline kernel.
> 
> Yes, bettter solution is needed here. But see the code, I don't see
> how b) would be implemented.

I think it's probably a good idea to start from scratch. The h4p
driver in its current state does not fit to the current kernel's
style at all.

My suggestion would be to have a driver, which implements a hci_dev.
The driver would mostly look like the standard uart hci_dev driver,
but additionally handles the wakeup and reset gpios. Power
Management for the uart device is done via runtime pm, which is
supported by OMAP's uart driver.

Then there should be a second driver, which implements the h4
protocol extensions from Nokia as hci_uart_proto. It could be put
into something like drivers/bluetooth/hci_h4p.c and have support for
the additional packet types (namely H4_EVT_PKT, H4_NEG_PKT,
H4_ALIVE_PKT and H4_RADIO_PKT).

> > >  	interrupts-extended = <&intc 73 &omap3_pmx_core OMAP3_UART2_RX>;
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&uart2_pins>;
> > > +	device {
> > > +		  compatible = "brcm,bcm2048";
> > > +		  uart = <&uart2>;
> > 
> > You don't need a phandle to the parent device.
> 
> Ok.
> 
> > > +		  reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
> > > +		  host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
> > 
> > The host-wakeup should be mapped as irq, gpio2irq conversion
> > will happen ;)
> 
> Why? It is accessed as gpio, too.

Ok. I only did a quick look and saw, that the gpio was converted to
irq.

> > > +		  chip-type = <3>;
> > 
> > This should be set in the driver based on the compatible
> > value and not via DT data.
> 
> Ok
> 
> > > +		  clocks = <&uart2_fck>, <&uart2_ick>;
> > > +		  clock-names = "fck", "ick";
> > 
> > These clocks you defined belong to the uart device and not to the
> > uart slave (bluetooth) device.
> 
> Ok. Why are they only needed in the bluetooth case?

A quick guess (without a deeper look at the code) is, that the ttys
use hwmod provided clock information (which is available from the
kernel). btw, h4p not using hwmod would be another problem, if it is
ok to reimplement a full serial driver.

I guess the clock data should be added to the uart devices in DT,
though. This is btw. true for almost all omap internal devices
described in DT, since the clock data has only been available in DT
for 1 or 2 kernel releases.

> > > +		  bt-sysclk = <2>;
> > 
> > I think this should be mapped cleanly in DT by adding a new clock
> > to the DTS file:
> > 
> > vctcxo_clock: clock  {
> >     compatible = "fixed-clock";
> >     #clock-cells = <0>;
> >     clock-frequency = <38400000>;
> > };
> 
> No. It seems that this selects baud rate during the chip init. I guess
> I can just remove that one.

you can see, that its a descriptor for the speed of the bcm2048's
system clock.

(from h4p driver)
bt-sysclk = 1 => sysclk = 12000;
bt-sysclk = 2 => sysclk = 38400;

and incidentally there is a 38.4 MHz clock connected to the bcm2048
and the wl1251 in the N900 :)

> > Then the bluetooth device can reference its clock device:
> > 
> > clocks = <&vctcxo_clock>;
> > 
> > The same clock reference should be added to the wl1251 DT node :)
> 
> Feel free to do that, but I don't see how this one helps...?

The clock is not enabled via the CPU, instead wl1251 and bcm2048
enable it themselfes, so it's not strictly needed. But it means,
that

a) DT represents the hardware correctly
b) one can acquire the sysclk speed from the referenced clock
   [ using devm_clk_get() and clk_get_rate() ]

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141213/72f92c44/attachment.sig>
