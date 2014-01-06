From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jan 2014 11:04:34 +0100
Subject: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
In-Reply-To: <20140103182349.GA13489@core.coreip.homeip.net>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140103173605.GN3144@lukather>
 <20140103182349.GA13489@core.coreip.homeip.net>
Message-ID: <7852278.jiSUdg0kdd@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 3. Januar 2014, 10:23:50 schrieb Dmitry Torokhov:
> On Fri, Jan 03, 2014 at 06:36:05PM +0100, Maxime Ripard wrote:
> > On Thu, Jan 02, 2014 at 11:36:33PM +0100, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 01/02/2014 09:20 PM, Maxime Ripard wrote:
> > > >On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> > > >>>Also, instead of inventing yet another vendor-specific property, why
> > > >>>not re-use> > >>>
> > > >>>a button binding similar to gpio-keys like:
> > > >>>        lradc: lradc at 01c22800 {
> > > >>>        
> > > >>>                compatible = "allwinner,sun4i-lradc-keys";
> > > >>>                reg = <0x01c22800 0x100>;
> > > >>>                interrupts = <31>;
> > > >>>                allwinner,chan0-step = <200>;
> > > >>>		
> > > >>>		#address-cells = <1>;
> > > >>>		#size-cells = <0>;
> > > >>>		
> > > >>>		button at 0 {
> > > >>>		
> > > >>>			reg = <0>; /* your channel index from above */
> > > >>>			linux,code = <115>; /* already used as dt-property */
> > > >>>		
> > > >>>		};
> > > >>>		
> > > >>>		button at 1 {
> > > >>>		
> > > >>>			reg = <1>;
> > > >>>			linux,code = <114>;
> > > >>>		
> > > >>>		};
> > > >>
> > > >>Ugh no. Having a vendor specific property which is KISS certainly
> > > >>beats this, both wrt ease of writing dts files as well as wrt the
> > > >>dts parsing code in the driver.
> > > >
> > > >I'd agree with Heiko here. This is pretty much the same construct
> > > >that's already in use in other input drivers, like gpio-keys.
> > > 
> > > In the gpio case there is a 1 on 1 relation between a single hw
> > > entity (the gpio-pin) and a single keycode. Here there is 1 hw entity
> > > which maps to an array of key-codes, certainly using an array rather
> > > then a much more complicated construct is the correct data-structure
> > > to represent this.
> > 
> > You can build an array in your driver out of this very easily, it's 10
> > lines in your probe. And you gain from this something that is more
> > generic, can be shared by other similar drivers and is consistent with
> > what is already in use.
> 
> How will it be shared? Surely not code-wise, but basically in spirit
> only. It seems to me that the originally proposed binding is simple and
> concise and works well for the driver.

I don't think "binding [...] works well for the driver" is the correct 
direction. From my understanding the binding should describe the hardware in 
an os-agnostic way (so "linux,foo" properties should stay the exception) and 
not the data structures used in the driver. The driver itself then implements 
the binding to convert the binding-data into a structure it wants to use.

The sharing would, as you suggested, be in spirit and in the use of already 
established dt-properties without introducing more non-standard ones.


Heiko
