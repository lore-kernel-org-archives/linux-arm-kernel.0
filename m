From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Mar 2015 15:51:53 +0000
Subject: Versatile Express randomly fails to boot - Versatile Express
 to be removed from nightly testing
In-Reply-To: <20150317153657.GY8656@n2100.arm.linux.org.uk>
References: <20150315213330.GB8656@n2100.arm.linux.org.uk>
 <20150316000438.GD8656@n2100.arm.linux.org.uk>
 <20150316004239.GE8656@n2100.arm.linux.org.uk>
 <20150316093553.GF8656@n2100.arm.linux.org.uk>
 <20150316130419.GI8656@n2100.arm.linux.org.uk> <55071742.6000405@arm.com>
 <20150316181634.GK8656@n2100.arm.linux.org.uk> <55072BF5.7030901@arm.com>
 <20150316195255.GM8656@n2100.arm.linux.org.uk> <550818A6.9020205@arm.com>
 <20150317153657.GY8656@n2100.arm.linux.org.uk>
Message-ID: <55084D99.7050004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/03/15 15:36, Russell King - ARM Linux wrote:
> On Tue, Mar 17, 2015 at 12:05:58PM +0000, Sudeep Holla wrote:
>> As I had mentioned yesterday, I did compare the L2C settings between
>> v3.18 and later kernel and found them to be *exactly same*.
>>
>> Since you suspected issues around instruction fetching, I tried playing
>> around the tag and data ram latencies. After some experiments, I found
>> that changing just the tag ram read latency to 2 cycles, the issue we
>> are seeing goes away at-least on my setup. It will be good to see the
>> behaviour on your setup with the patch below.
>>
>> The default value which bootmon is programming happens to be worst
>> case scenario(8 cycles for all). Will recalls that it was changed to
>> minimum value after graphics guys complained about performance.
>>
>> We need to check with h/w guys to get the correct optimal values for
>> these latencies.
>>
>> Regards,
>> Sudeep
>>
>> --->8
>>
>> diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
>> b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
>> index 23662b5a5e9d..030c90c1105d 100644
>> --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
>> +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
>> @@ -172,7 +172,7 @@
>>                  interrupts = <0 43 4>;
>>                  cache-level = <2>;
>>                  arm,data-latency = <1 1 1>;
>> -               arm,tag-latency = <1 1 1>;
>> +               arm,tag-latency = <1 2 1>;
>
> I've tried <1 2 1> and <1 8 1> here, I don't see any difference.  My test
> build fails on the first boot attempt for each.
>

That's bad. I started with 2 cycles for all(rd/wr/setup) latencies(data
and tag ram) and narrowed down to this setting with multiple
experiments. I did try booting 10 times each time at-least.

Since the bootmon sets 8 cycles for all the latencies, does it make
sense to try that setting to check if the issue you are seeing is
related to L2 latencies at all. Meanwhile I will continue my testing.

> I notice you're only changing the write latency here.  Is that correct?
> You mention read latency above.
>

Sorry my bad, you are right, it's write latency, I misread the L2C
binding document.

Regards,
Sudeep
