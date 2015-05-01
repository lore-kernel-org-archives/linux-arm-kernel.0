From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 01 May 2015 10:17:35 +0200
Subject: [PATCH 0/4] clk: si5351: Some fixes
In-Reply-To: <20150430223603.GA18006@deathray>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20150430193317.GC22000@deathray> <55429417.4070103@gmail.com>
 <20150430212059.GA14026@deathray> <5542AAE0.5020204@gmail.com>
 <20150430223603.GA18006@deathray>
Message-ID: <5543369F.2070207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.05.2015 00:36, Michael Welling wrote:
> On Fri, May 01, 2015 at 12:21:20AM +0200, Sebastian Hesselbarth wrote:
>> On 30.04.2015 23:20, Michael Welling wrote:
>>> On Thu, Apr 30, 2015 at 10:44:07PM +0200, Sebastian Hesselbarth wrote:
>> [...]
>>>> What I noticed about your clk2 that you always measure as 0 Hz is
>>>> that none of your clocks is prepared/enabled.
>>>>
>>>> Currently, the si5351 driver only ensures the output is enabled
>>>> when si5351_clkout_prepare() is called.
>>>>
>>>> As long as you do not have a clk consumer that properly prepare/enables
>>>> the clock output, it may remain disabled.
>>>>
>>>> We should probably have additional DT properties and corresponding
>>>> pdata to force clkoutN always on.
>>>
>>> Does the silabs,disable-state of 3 (SI5351_DISABLE_NEVER) take care
>>> of this?
>>
>> That would be the HW version of never disabling the clock output.
>> I never really tried the property, does it work as expected?
>
> This did not appear to effect the behavior.

I think it is also a good idea to expose register values to debugfs,
so we can easily check what is really written into internal registers.

>>
>>> Otherwise is there a simple registration that will do this?
>>
>> The SW version of such a property would involve CLK_IGNORE_UNUSED
>> and enabling all requested clock outputs on probe().
>>
>> If above HW property already works, I think it should be enough.
>>
>> [...]
>>>>> It should be noted that if I program the device's register map in the
>>>>> bootloader the device keeps the correct frequency outputs.
>>>>
>>>> "keeps"? You mean "generates", don't you?
>>>>
>>>
>>> Yes the clocks are generated and do not get effected by the driver.
>>
>> IIRC, clk API does check if requested rate and current rate match
>> already. If they do, it does not request the same rate again.
>
> So I found that the audio codec that I am driving with clk2 could
> register the clock and allowed the clock to be enabled and disabled
> by playing audio.
>
> This is when I noticed some strange behavior. The first time I attempt
> to play audio the clock does not turn on blocking the audio from playing.
> After I interrupt and the clock is disabled for the first time, the
> successive clock enables work as expected.

Does "does not turn on" mean you cannot measure any clock on the
output or is it just a guess because audio does not play?

It could be that we just need to add some delay when we enable a clock
output. Datasheet just says 10us max from OEB pin pulled low to valid
clock output - not exactly what we are looking for but it could be a
good start.

> Something tells me that a fault off some kind is occurring on initial
> configuration.

What I noticed when adding the pll reset and checking DEVICE_STATUS is
that SYS_INIT is still set. According to the datasheet, the meaning of
the bit is that si5351 is still copying NVM content to its internal
registers and therefore, we shouldn't try to access them.

What really irritates me about it is that it is seconds after power-up
and copying the contents shouldn't really take _that_ long. However,
the datasheet does not mention anything about how long it may take.

Sebastian
