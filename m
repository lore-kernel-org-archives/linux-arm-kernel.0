From: arasv@magellan-technology.com (Aras Vaichas)
Date: Tue, 15 Dec 2009 10:43:21 +1100
Subject: [POWER] battery calibration parameters from sysfs
In-Reply-To: <20091214212257.GA9213@elf.ucw.cz>
References: <A6D19A13FE030A409EC4362C172E091F0E0495F6@eseldmw101.eemea.ericsson.se>
	<20091204104930.GA28625@sirena.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E071EB9@eseldmw101.eemea.ericsson.se>
	<20091207114825.GA26965@rakim.wolfsonmicro.main>
	<A6D19A13FE030A409EC4362C172E091F0E0A1FA1@eseldmw101.eemea.ericsson.se>
	<20091207165628.GA24981@rakim.wolfsonmicro.main>
	<20091213132413.GB1437@ucw.cz>
	<20091214121247.GB22388@rakim.wolfsonmicro.main>
	<20091214212257.GA9213@elf.ucw.cz>
Message-ID: <ed62800912141543v2ab7ef63v4b6b2c33018b3296@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/12/15 Pavel Machek <pavel@ucw.cz>:
> Hi!
>
>> > > I'm not sure how familiar you are with the issues surrounding trying to
>> > > do a voltage to charge mapping for a battery but it's much more complex
>> > > than a simple table if you want to get it accurate. ?There's a lot
>> > > of
>>
>> > Well... current zaurus kernels use _huge_ table that maps voltage to
>> > battery %... and that table is linear function :-(.
>>
>> > Do you have some papers on that?
>>
>> Something like "Measure Battery Capacity Precisely in Medical Design"
>> by Bernd Krafthoefer in Power Electronics Technology Jan 2005 might be
>> useful here.
>
> Well, that would really require extensive hardware modifications: it
> needs _way_ more accurate ADCs on battery for a start, and a way to
> generate huge load.

I've worked on several battery powered devices and battery monitoring
is very hard to achieve without a deep understanding of the chemistry,
circuitry and the algorithms. Large current loads can cause the
battery voltage to drop and therefore there can be a significant
voltage drop between measuring the quiescent and the loaded battery
voltages.  I once did try to implement an algorithm which took into
account the different battery voltage during heavy current drain but
it's hard to know how to interpret that data.  One of the RFID systems
I worked on could run the user interface for days on a low battery but
a single RFID read would cause the system to die due to the internal
resistance current drop ...

One of the easiest ways to monitor the battery is with a coulomb
counting method (accumulate current going into and out of the battery)
e.g. "LTC4150 - Coulomb Counter/Battery Gas Gauge"
http://www.linear.com/pc/productDetail.jsp?navId=H0,C1,C1003,C1037,C1134,P2354

As long as you aren't draining very large amounts of current from the
battery, the accumulated current measurement should be almost equal to
the amp-hour rating of the battery.

Unfortunately the simple coulomb counting chips have the disadvantage
that the CPU has to be running to accumulate the pulses. Of course,
the pulses could wake the CPU from a suspend mode, but I'd rather not
do that just to add "one" to a counter ...

Finally we decided on a fully integrated "smart" battery monitor
device like the DS2782
http://www.maxim-ic.com/quick_view2.cfm/qv_pk/4779. This chip has
Linux device driver support, I got the driver from Ryan Mallon at
Bluewater Systems. It was fairly complex to set up and calibrate but
we now use it in a commercial product.

I recommend having a look at the datasheet for the DS2782 to see what
methods they use for determining the remaining charge in a battery and
to get an idea of the complexity of the problem.

Good luck!

Aras Vaichas
