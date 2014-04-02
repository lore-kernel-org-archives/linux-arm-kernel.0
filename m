From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Apr 2014 12:18:37 +0200
Subject: [PATCH RFC v4 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <20140401163744.GE3842@kroah.com>
References: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
 <1396284116-19178-3-git-send-email-s.nawrocki@samsung.com>
 <20140331200620.GA13881@kroah.com> <533ABCEC.8040701@codethink.co.uk>
 <533ACBD0.8030209@samsung.com> <20140401163744.GE3842@kroah.com>
Message-ID: <533BE3FD.8070902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/14 18:37, Greg KH wrote:
> On Tue, Apr 01, 2014 at 04:23:12PM +0200, Sylwester Nawrocki wrote:
>> On 01/04/14 15:19, Ben Dooks wrote:
>>> On 31/03/14 21:06, Greg KH wrote:
>>>>> On Mon, Mar 31, 2014 at 06:41:56PM +0200, Sylwester Nawrocki wrote:
>> [...]
>>>>> I don't understand why you need the driver core to initialize this one
>>>>> type of thing?  That should be in a driver, or in a class, or at worse
>>>>> case, the platform code.
>>>>>
>>>>> What makes clocks so "unique" here?
>>
>> The reason I put it in the driver core was mainly to avoid having many
>> drivers doing same call to this initialization function.
>> I was considering moving it to the bus code, still there are several
>> buses for which it would need to be repeated.
> 
> "several" is how many?  2?  3?  10?

It would be mostly the platform and amba bus, but this clock defaults
could be useful also for i2c, spi. In general it's about not probable
devices which may be specified in devicetree.

> Please fix it "correctly" and don't put it in the driver core just
> because it seems easier that way.
> 
>> Maybe really_probe() is not a best place to put this, nonetheless
>> the requirements I could list were:
>>
>>  1. not involving individual drivers,
> 
> Why not?

I'd say because this thing can be often considered a platform detail
which would be better opaque to drivers. It's at the border of a device
and its integration within a platform.

>>  2. have such an initialization call done for all devices, irrespective
>>     of Linux bus or class type,
> 
> Why?  Do _all_ devices that Linux supports have this issue to be
> resolved?

Sorry, certainly not all devices. I think it's only related to the
non-probable devices which can be specified in DT.

>>  3. Handle errors properly, e.g. defer driver probing if a clock for
>>    a device is not yet available.
> 
> Then do it in the bus that controls that device, as it knows to defer
> probing at that point in time.

All right, that would also work. I suspect doing it for platform and
amba bus might be sufficient in the beginning.

>> One advantage I could see from making the call from within a device
>> driver is that a device could keep using the common DT bindings and
>> replace the common initialization function with a private one, if
>> there is a need for some quirks handled for a device. With approach
>> as in this patch it's difficult to override the default behaviour.
>> However then there is a question whether we strive for the clocks
>> management to be possibly kept away from device drivers.
>>
>>> I suppose the issue here is that a lot of drivers currently use
>>> clocks and a number of systems have badly setup default clock trees
>>> at start time.
>>>
>>> Mark Brown and others have argued that the management of clocks which
>>> is common to all devices should not live in the driver.
>>
>> True, motivation behind this patch series was also replacing custom
>> code in multiple drivers doing similar clock rate or parent setting
>> by a common code, using standardized DT binding.
> 
> Then put it in the bus that controls these broken devices / platforms.

OK, I'm going to put it in the bus code.

-- 
Thanks,
Sylwester
