From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 27 Aug 2017 21:07:49 +0200
Subject: [RFC 1/3] dt-bindings: rtc: Add Realtek RTD1295
In-Reply-To: <feaa47ff-083a-9ee5-c055-ff1f7efce371@suse.de>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-2-afaerber@suse.de>
 <20170823002911.y35nn7jkt34dvjbc@rob-hp-laptop>
 <629b9ed0-7b2d-7c5c-20b8-17289a76f097@suse.de>
 <20170827134729.GE13622@lunn.ch>
 <feaa47ff-083a-9ee5-c055-ff1f7efce371@suse.de>
Message-ID: <20170827190749.6njixw7cxwbhmclp@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2017 at 19:26:11 +0200, Andreas F?rber wrote:
> Hi Andrew,
> 
> Am 27.08.2017 um 15:47 schrieb Andrew Lunn:
> >> Thanks. Did you read the RFC question in the cover letter as well and
> >> have any comments? Downstream has an rtc-base-year = <2014>; property
> >> that I had left out in this RFC and due to your ack not included in v2.
> >>
> >> Should we default to 2014 in the driver and add an optional base-year
> >> property once we encounter a diverging device, or should we make it
> >> required from the beginning? I did not spot any other rtc binding with
> >> such a property and would appreciate a clarification.
> > 
> > From the perspective of the hardware, does it care what the base is?
> 
> The hardware stores a 15-bit number of days since Jan 1st of that base
> year. It does not store the base year.
> 
> The datasheet does not name such a base year. No manual is available.
> 
> The driver needs to get it from somewhere for calculating day/month/year
> in read_time and days in set_time.
> 
> The read_offset/set_offset API appeared to be something different.
> 

There is no api to change the epoch of an RTC because it is difficult to
do in a race free way. This has to be worked on.

Anyway, you don't really care for now as it goes up to 2093 and
hopefully, you will never have a product with a different epoch.

> > A device using a different base will initially return the wrong
> > time. But once the correct time has been written back, it will be O.K.
> > 

The other issue being that you don't have any way to know whether the
base is correct or not until the date is set.

> > This only becomes an issue if a device is used with different OSs,
> > which have different bases. Swapping back and forth between OSs then
> > becomes an issue.
> 
> These are TV boxes, so yes, I'm dual-booting into Android with a vendor
> 4.1 kernel and would like to keep date compatibility.
> 
> https://en.opensuse.org/HCL:Zidoo_X9S
> https://en.opensuse.org/HCL:ProBox2_Ava
> https://en.opensuse.org/HCL:Lake1
> 
> As stated in the v2 rtc commit message, 2014 is the base year
> encountered on all three devices that I've had access to.
> @Jiang, if you're using a different base year, please speak up!
> 
> > KISS suggests not having a base in DT until it is actually
> > required. Since it is an additional property, it does not break
> > backwards compatibility when added.
> 
> That's what I've attempted here - but for RDA8810PL serial Rob said he
> did not want future changes to my binding, therefore I am asking for his
> confirmation here.

It would be a change that is easy enough to do in a backward compatible
way so that is probably fine.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
