From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Apr 2014 12:24:26 +0200
Subject: [PATCH RFC v4 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <20140402053715.GV17250@pengutronix.de>
References: <1396284116-19178-1-git-send-email-s.nawrocki@samsung.com>
 <1396284116-19178-3-git-send-email-s.nawrocki@samsung.com>
 <20140331200620.GA13881@kroah.com> <533ABCEC.8040701@codethink.co.uk>
 <533ACBD0.8030209@samsung.com> <20140401163744.GE3842@kroah.com>
 <20140402053715.GV17250@pengutronix.de>
Message-ID: <533BE55A.80408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/14 07:37, Sascha Hauer wrote:
> On Tue, Apr 01, 2014 at 09:37:44AM -0700, Greg KH wrote:
>> On Tue, Apr 01, 2014 at 04:23:12PM +0200, Sylwester Nawrocki wrote:
>>> On 01/04/14 15:19, Ben Dooks wrote:
>>>> On 31/03/14 21:06, Greg KH wrote:
>>>>>> On Mon, Mar 31, 2014 at 06:41:56PM +0200, Sylwester Nawrocki wrote:
>>> [...]
>>>>>> I don't understand why you need the driver core to initialize this one
>>>>>> type of thing?  That should be in a driver, or in a class, or at worse
>>>>>> case, the platform code.
>>>>>>
>>>>>> What makes clocks so "unique" here?
>>>
>>> The reason I put it in the driver core was mainly to avoid having many
>>> drivers doing same call to this initialization function.
>>> I was considering moving it to the bus code, still there are several
>>> buses for which it would need to be repeated.
>>
>> "several" is how many?  2?  3?  10?
>>
>> Please fix it "correctly" and don't put it in the driver core just
>> because it seems easier that way.
>>
>>> Maybe really_probe() is not a best place to put this, nonetheless
>>> the requirements I could list were:
>>>
>>>  1. not involving individual drivers,
>>
>> Why not?
>>
>>>  2. have such an initialization call done for all devices, irrespective
>>>     of Linux bus or class type,
>>
>> Why?  Do _all_ devices that Linux supports have this issue to be
>> resolved?
>>
>>>  3. Handle errors properly, e.g. defer driver probing if a clock for
>>>    a device is not yet available.
>>
>> Then do it in the bus that controls that device, as it knows to defer
>> probing at that point in time.
> 
> The issue this patch tries to solve is not about single devices, but
> about the way these devices are connected with each other.
> 
> Clocks for different (sometimes completely unrelated) devices influence
> each other. You can't control the clock from one device without
> influencing other devices. Knowledge about these constraints can't be
> encoded in the drivers, because the constraints differ per SoC,
> sometimes even per board. Many SoCs share the same devices, but the
> clock topology they are surrounded with is always different. With this I
> don't mean the direct clock inputs, these are well abstracted with the
> current clk_* API.  What I mean is situations like: "On this board use
> the clock controller to output this particular clock on that pin,
> because it happens to be the master clock of some audio codec connected
> externally; also make the same clock input to the internal Audio system
> to make sure both are in sync". These situations can be completely
> different on the next board or on the next SoC which has the same
> devices, but a different clock routing.
> 
> That said, I also think the driver core doesn't have to be bothered with
> the clock setup. Putting the clock setup into the devicenode providing
> the clocks (and thus parsing it from the clock controller driver) should
> be sufficient.

It would work but I don't really like such a DT binding. Rather than
only having a long list of clocks in one node I would prefer to also
have a possibility to list clock data specific to a device in its
corresponding DT node. Similarly as it's done, e.g. with interrupts.

-- 
Thanks,
Sylwester
