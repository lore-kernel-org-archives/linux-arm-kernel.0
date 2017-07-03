From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 3 Jul 2017 10:17:22 +0100
Subject: Clocks used by another OS/CPU (was: Re: [RFC PATCH] clk: renesas:
 cpg-mssr: Add interface for critical core clocks)
In-Reply-To: <20170701181408.yuocymwtj5dgt74d@pengutronix.de>
References: <CAMuHMdW9+CNTTOVO4SRRUxuz3ajLbY2j1uG8b_RpHX52NPwXrQ@mail.gmail.com>
 <CAL_JsqKGrZeR7z80beY_XEjqd5fEQQwPxusJ1FADoALgNE3fEg@mail.gmail.com>
 <20170630202453.eh6vaehkap3as4np@pengutronix.de>
 <8d86a9aa-1928-6b52-1487-d5fb9dae17f4@gmail.com>
 <20170701181408.yuocymwtj5dgt74d@pengutronix.de>
Message-ID: <8d255a76-babe-312d-15b3-3474969f2410@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/07/17 19:14, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Sat, Jul 01, 2017 at 07:02:48AM +0200, Dirk Behme wrote:

[...]

>>
>>
>> The other problem is security related. If, at all, you have to do it the
>> other way around, then:
>>
>> Make Linux a consumer of the other CPU's (trusted/trustzone/whatever
>> secured) OS clock driver.

Yes, that's better and is getting common on newer platforms. They have
separate M-class(or even low A-class e.g. A5/A7) processors to handle
all the system management.

The new ARM SCMI specification[0][1] is designed to standardize the
interface. It covers the clocks in clock protocol.

> 
> That doesn't matter much. Either way the first CPU has to provide the
> master side of this device (as it needs clks for booting up) and the 2nd
> gets this virtual clk device that forwards clk requests to the first
> CPU.
> 
> On my machine (Udoo Neo, A9 + M4) the A9 is the primary CPU that is
> started by the bootrom. If I want the M4 being the primary device I'd
> need support in the bootloader to wait long enough (i.e. until the M4 is
> up) before letting the A9 jump into Linux.

I think that is platform specific. On few platforms I have seen
recently, it's M4 or whatever core that handles system power management
boots first and is responsible to even boot secondaries.

> Managable I'd say. This way would even make sense if the M4 runs a
> rt critical OS that shouldn't be forced to wait on the non-rt A9 to> enable a clk.
> 

Exactly.

-- 
Regards,
Sudeep


[0] http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/index.html
[1] https://marc.info/?l=devicetree&m=149849482623492&w=2
