From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 10 Sep 2014 15:20:19 +0200
Subject: [PATCH 5/5] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <20140910121424.GG2974@localhost>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
 <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140910121424.GG2974@localhost>
Message-ID: <20140910152019.111c4c01@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Sep 2014 14:14:24 +0200
Johan Hovold <johan@kernel.org> wrote:

> On Wed, Sep 03, 2014 at 10:45:34AM +0200, Boris BREZILLON wrote:
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > ---
> >  .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt   | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> > new file mode 100644
> > index 0000000..9ca455f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt
> > @@ -0,0 +1,20 @@
> > +Atmel AT91SAM9260 Real Time Timer
> > +
> > +Required properties:
> > +- compatible: should be: "atmel,at91sam9260-rtt"
> > +- reg: should contain 2 memory regions
> > +  * the first one encodes the memory region of the RTT controller
> > +  * the second one encodes the GPBR (General Purpose Backup Resgisters)
> > +    memory region used to store the current time
> > +- interrupts: rtc alarm/event interrupt
> > +- clocks: should contain one clock pointing the the slow clk
> > +
> > +Example:
> > +
> > +rtc at fffffe00 {
> > +	compatible = "atmel,at91sam9260-rtt";
> > +	reg = <0xfffffd20 0x10
> > +	       0xfffffd50 0x4>;
> > +	interrupts = <1 4 7>;
> > +	clocks = <&clk32k>;
> > +};
> 
> This does not describe the hardware, but rather a specific software
> configuration.
> 
> The RTT is first of all not an RTC (although it can be used as one in a
> specific software configuration). And the second register resource above
> is not an RTT register, but a general-purpose backup register could be
> used for other purposes (which register to use is currently configurable
> for legacy booting using CONFIG_RTC_DRV_AT91SAM9_GPBR).

We could use a syscon device (which exposes a regmap) for the GPBR
block.

rtc at ffffff20 {
	compatible = "atmel,at91sam9260-rtt";
	reg = <0xfffffd20 0x10>;
	interrupts = <1 4 7>;
	clocks = <&clk32k>;
	atmel,time-reg = <&gpbr 0x0>;
};

gpbr: syscon at fffffd50 {
	compatible = "atmel,at91sam9260-gpbr", "syscon";
	reg = <0xfffffd50 0x10>;
	
};

> 
> This was discussed in the thread where I posted an RFC for this last
> year (which you linked to in your original submission thread), but no
> conclusion was reached:
> 
> 	http://www.spinics.net/lists/arm-kernel/msg236292.html
> 
> Johan



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
