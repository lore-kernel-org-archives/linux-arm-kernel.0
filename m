From: johan@kernel.org (Johan Hovold)
Date: Wed, 10 Sep 2014 17:07:02 +0200
Subject: [PATCH 5/5] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <20140910152019.111c4c01@bbrezillon>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
 <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140910121424.GG2974@localhost>
 <20140910152019.111c4c01@bbrezillon>
Message-ID: <20140910150702.GK2974@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 03:20:19PM +0200, Boris BREZILLON wrote:
> On Wed, 10 Sep 2014 14:14:24 +0200
> Johan Hovold <johan@kernel.org> wrote:

> > This does not describe the hardware, but rather a specific software
> > configuration.
> > 
> > The RTT is first of all not an RTC (although it can be used as one in a
> > specific software configuration). And the second register resource above
> > is not an RTT register, but a general-purpose backup register could be
> > used for other purposes (which register to use is currently configurable
> > for legacy booting using CONFIG_RTC_DRV_AT91SAM9_GPBR).
> 
> We could use a syscon device (which exposes a regmap) for the GPBR
> block.
> 
> rtc at ffffff20 {

rtt

> 	compatible = "atmel,at91sam9260-rtt";
> 	reg = <0xfffffd20 0x10>;
> 	interrupts = <1 4 7>;
> 	clocks = <&clk32k>;
> 	atmel,time-reg = <&gpbr 0x0>;
> };
> 
> gpbr: syscon at fffffd50 {
> 	compatible = "atmel,at91sam9260-gpbr", "syscon";
> 	reg = <0xfffffd50 0x10>;
> 	
> };

Yes, this essentially what I suggested in the thread (and my last reply)
and relying on syscon rather than a custom driver seems like a good
idea. It would allow early access to the registers too with the recently
proposed changes. It would not guarantee any kind of exclusivity,
though, but I guess that's tolerable?

Johan
