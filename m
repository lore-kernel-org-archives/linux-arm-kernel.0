From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 8 Apr 2013 13:08:55 +0200
Subject: [RFC 4/5] RTC: rtc-at91sam9: add device-tree support
In-Reply-To: <20130408104823.GF25605@localhost>
References: <20130407150938.GA25605@localhost>
 <1365347572-14972-1-git-send-email-jhovold@gmail.com>
 <1365347572-14972-4-git-send-email-jhovold@gmail.com>
 <20130408073807.GQ20693@game.jcrosoft.org>
 <20130408090023.GC25605@localhost> <51629472.3070404@atmel.com>
 <20130408100301.GS20693@game.jcrosoft.org>
 <20130408104823.GF25605@localhost>
Message-ID: <20130408110855.GW20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:48 Mon 08 Apr     , Johan Hovold wrote:
> On Mon, Apr 08, 2013 at 12:03:01PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 11:57 Mon 08 Apr     , Nicolas Ferre wrote:
> > > On 04/08/2013 11:00 AM, Johan Hovold :
> > > > On Mon, Apr 08, 2013 at 09:38:07AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > >> On 17:12 Sun 07 Apr     , Johan Hovold wrote:
> 
> [...]
> 
> > > >> the RTT is a general purpose timer backuped that we use in linux as a
> > > >> RTC with a gpbr to store the time
> > > >>
> > > >> you need 2 binding on for the RTT one the RTT-rtc
> > > > 
> > > > As in adding some virtual hardware-node which uses the rtt and gpbr as
> > > > resources?
> > > 
> > > So, why not simply having a compatibility string that collects the uses
> > > of this RTT node:
> > > 
> > > compatible = "atmel,at91sam9260-rtt-as-rtc", "atmel,at91sam9260-rtt";
> > > 
> > > And then "decide which device driver to bind to [the RTT] device"...
> > > If the rtt-as-rtc driver is not selected, the device can still be used
> > > as a simple "rtt". The board .dts can overload a compatibility string
> > > according to the use, etc.
> > > 
> > > Then the way do describe which GPBR to use has still to be discussed.
> > > But for the RTT itself, I would keep it simple like that.
> > 
> > no as infact the rtc-at91sam9 should not even exist
> > as this is much more generic
> > 
> > we use a backped register and a timer to emulate a RTC this can be unsed by
> > any one
> > 
> > and I can use any backuped timer
> > 
> > we need to have frameworks
> > where the gpbr are tracked and the rtt
> > 
> > 	for you describe the resources
> > 
> > 	rtt0: rtt at fffffd20 {
> > 		compatible = "atmel,at91sam9260-rtt";
> > 		reg = <0xfffffd20 0x10>;
> > 		interrupts = <1 4 7>;
> > 	};
> > 
> > 	rtc-timer {
> > 		compatible = "linux,rtc-timer";
> > 		timer = <&rtt0>;
> > 		backuped-register = <&gpbr 0>;
> > 	};
> > 
> > this need to SoC implemetation generic
> 
> This would indeed be a neat solution, albeit one that requires a lot
> work to be realised as both a backup-register and backed-up-timer
> framework would need to be implemented.

not that much

for backuped register or rtt a simple list with spinlock will be enougth
and after just handle the phandle

it's not that complex but if we want to describe the hardware correctly this
is needed

And this will not be AT91 specific but SoC generic

Ensure the GPBR are requested once is mandatory for any bug detection
a global ioremap is really dirty and need to be used when only NO other choice

Best Regards,
J.
> 
> Bye,
> -- 
> Nicolas Ferre
> 
> Thanks,
> Johan
