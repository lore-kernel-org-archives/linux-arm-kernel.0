From: robherring2@gmail.com (Rob Herring)
Date: Wed, 09 Feb 2011 17:00:48 -0600
Subject: [RFC PATCH] ARM: pmu: add OF match support
In-Reply-To: <AANLkTikrBx1Y7MFGCJe=Gx-9fUxhwuYq-BZ4stGBGav6@mail.gmail.com>
References: <1297223617-19173-1-git-send-email-robherring2@gmail.com>
	<AANLkTi=7azYw8+sYrbDsLOfF1aZynBDo+ub37O9j+k49@mail.gmail.com>
	<3399156206431206254@unknownmsgid>
	<AANLkTin5aA0tq-PYBmRKh6tLv6bHRaK5ymjhsj9T4-Ah@mail.gmail.com>
	<-4919269306841091192@unknownmsgid>
	<AANLkTikrBx1Y7MFGCJe=Gx-9fUxhwuYq-BZ4stGBGav6@mail.gmail.com>
Message-ID: <4D531CA0.8050402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2011 01:03 PM, Grant Likely wrote:
> On Wed, Feb 9, 2011 at 11:53 AM, Will Deacon<will.deacon@arm.com>  wrote:
>> Grant,
>>
>>>> Following on from Rob's update, it would be nice if you could specify that
>>>> the PMU is a CPU PMU (as opposed to L2-cache, bus, gpu etc) in the string.
>>>> That way adding different PMUs in the future seems more natural and it accounts
>>>> for your concerns above. Is that ok, or does the compatible string have to
>>>> match that used by the platform bus?
>>>
>>> It does make sense to encode the specific implementation into the
>>> compatible string.  A single device driver can bind against multiple
>>> compatible strings.  ie. the match table could include {.compatible =
>>> "arm,cortex-a9-pmu"},{.compatible = "arm,cortex-a9-l2cache-pmu"}...
>>
>> Ok - that's great! Specifying the CPU is probably a little verbose, but
>> something like "arm,armv7pmu" would be really helpful when it comes to
>> multiple devices.
>>
>>>> As for versioning, the PMU detection is done dynamically at runtime,
>>>> so knowing that we're poking a CPU is enough.
>>>
>>> Fair enough.  It is still good practice in the compatible list to
>>> encode the specific PMU implementation (maybe arm,cortex-a9-pmu?)
>>> instead of trying to define a 'generic' or wildcard compatible value.
>>> Newer implementations can always claim compatibility with an older
>>> implementation so that the kernel doesn't have to be modified to find
>>> the new devices.  "arm,pmu" is probably too generic.
>>
>> "arm,pmu" is definitely too generic. If it's good practice to specify
>> as much as possible, then go for it - I just feel a little uneasy having
>> to add lots of redundant kernel code but it sounds like you'll hopefully
>> prove me wrong on that :)
>
> Shouldn't be any redundant kernel code.  It's just a list of match
> values, and the driver code already knows how to handle it.  The
> advantage of being specific is that if the driver ever does need
> information about the specific implementation (say, because the
> hardware reported value is buggy), then the data is available.

By that argument, we should use "<vendor>,cortex-a9-rXpX-pmu." As a 
particular rev of the A9 PMU or vendor's SOC could be buggy. That would 
quickly grow into a long list. Just with cpu models, we would have:

cortex-a9
cortex-a8
cortex-a15
cortex-a5
arm1136
arm1176
l210
l220
pl310
various xscale flavors
Qualcomm SMP

Keep in mind that the whole point of this platform device is just to 
specify the interrupt connection which is the only part that varies by 
SOC (and is not probe-able).

Rob
