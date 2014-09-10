From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 10 Sep 2014 17:31:14 +0200
Subject: [PATCH 5/5] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <20140910150702.GK2974@localhost>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
 <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140910121424.GG2974@localhost>
 <20140910152019.111c4c01@bbrezillon>
 <20140910150702.GK2974@localhost>
Message-ID: <20140910173114.593dd132@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Sep 2014 17:07:02 +0200
Johan Hovold <johan@kernel.org> wrote:

> On Wed, Sep 10, 2014 at 03:20:19PM +0200, Boris BREZILLON wrote:
> > On Wed, 10 Sep 2014 14:14:24 +0200
> > Johan Hovold <johan@kernel.org> wrote:
> 
> > > This does not describe the hardware, but rather a specific software
> > > configuration.
> > > 
> > > The RTT is first of all not an RTC (although it can be used as one in a
> > > specific software configuration). And the second register resource above
> > > is not an RTT register, but a general-purpose backup register could be
> > > used for other purposes (which register to use is currently configurable
> > > for legacy booting using CONFIG_RTC_DRV_AT91SAM9_GPBR).
> > 
> > We could use a syscon device (which exposes a regmap) for the GPBR
> > block.
> > 
> > rtc at ffffff20 {
> 
> rtt
> 
> > 	compatible = "atmel,at91sam9260-rtt";
> > 	reg = <0xfffffd20 0x10>;
> > 	interrupts = <1 4 7>;
> > 	clocks = <&clk32k>;
> > 	atmel,time-reg = <&gpbr 0x0>;
> > };
> > 
> > gpbr: syscon at fffffd50 {
> > 	compatible = "atmel,at91sam9260-gpbr", "syscon";
> > 	reg = <0xfffffd50 0x10>;
> > 	
> > };
> 
> Yes, this essentially what I suggested in the thread (and my last reply)
> and relying on syscon rather than a custom driver seems like a good
> idea. It would allow early access to the registers too with the recently
> proposed changes. It would not guarantee any kind of exclusivity,
> though, but I guess that's tolerable?

Yep, that's one of the concern I had with the syscon/regmap
approach :-(, but I guess I'll give this solution a try and post a new
version of this series ;-).

Can we just leave the rtt as an rtc problem on the side for now and bind
it to the rtc-at91sam9 driver.

If we ever decide to add a new driver using the RTT for another purpose
we will still be able to reference the RTT block like this (and keep
the existing rtt node definition):


rtt-based-rtc {
	compatible = "atmel,rtt-rtc";
	atmel,rtt = <&rtt>;
	atmel,time-reg = <&gpbr 0x0>;
}

rtt-based-xdev {
	compatible = "atmel,rtt-xdev";
	atmel,rtt = <&rtt>;
	/*...*/
}

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
