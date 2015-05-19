From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Tue, 19 May 2015 15:43:59 +0300
Subject: [PATCH 11/15] thermal: thermal: Add support for hardware-tracked
 trip points
In-Reply-To: <20150518202848.GT11598@ld-irv-0074>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de>
 <1431507163-19933-12-git-send-email-s.hauer@pengutronix.de>
 <5559ABAA.6040001@kapsi.fi> <20150518120944.GQ6325@pengutronix.de>
 <20150518184433.GS11598@ld-irv-0074> <555A39EA.1060608@kapsi.fi>
 <20150518202848.GT11598@ld-irv-0074>
Message-ID: <555B300F.8030305@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/15 23:28, Brian Norris wrote:
> On Mon, May 18, 2015 at 10:13:46PM +0300, Mikko Perttunen wrote:
>> On 05/18/2015 09:44 PM, Brian Norris wrote:
>>> On Mon, May 18, 2015 at 02:09:44PM +0200, Sascha Hauer wrote:
>>>> On Mon, May 18, 2015 at 12:06:50PM +0300, Mikko Perttunen wrote:
>>>>> One interesting thing I noticed was that at least the bang-bang
>>>>> governor only acts if the temperature is properly smaller than (trip
>>>>> temp - hysteresis). So perhaps we should specify the non-tripping
>>>>> range as [low, high)? Or we could change bang-bang.
>>>>
>>>> I wonder how we can protect against such off-by-one errors anyway.
>>>> Generally a hardware might operate on raw values rather than directly
>>>> in temperature values in ?C. This means a driver for this must have
>>>> celsius_to_raw and raw_to_celsius conversion functions. Now it can
>>>> happen that due to rounding errors celsius_to_raw(Tcrit) returns a raw
>>>> value that when converted back to celsius is different from the
>>>> original value in ?C. This would mean the hardware triggers an interrupt
>>>> for a trip point and the thermal core does not react because get_temp
>>>> actually returns a different temperature than previously programmed as
>>>> interrupt trigger. This way we would lose hot (or cold) events.
>>>
>>> This also highlights another fact: there's a race between interrupt
>>> generation and temperature reading (->get_temp()). I would expect any
>>> hardware interrupt thermal sensor would also have a latched temperature
>>> reading to correspond with it, and there would be no guarantee that this
>>> latched temperature will match the polled reading seen once you reach
>>> thermal_zone_device_update(). So a hardware driver might report a
>>> thermal update, but the temperature reported to the core won't
>>> necessarily match what interrupt was meant for.
>>
>> Does this actually matter? The thermal core will reset trips and
>> apply cooling using the new - most recent - value. Using bang bang
>> as example, if the temperature has risen since the interrupt fired,
>> the cooling device will correctly not be switched off. If the
>> temperature has fallen, it will again be correctly switched off. The
>> only issue is then if the temperature is exactly 'trip temp - trip
>> hyst' which will cause set_trips to load the trip points below, but
>> not cause bang bang to turn off the cooling device, and the next
>> chance it will have will only be at the next below trip point. Well,
>> this is still safe (at least until you replace "cooling device" with
>> "heating device"), so maybe it isn't that big of an issue.
>>
>> Please point out if there's a problem with my line of reasoning.
>
> I'm not sure I followed exactly the reason for the low-temp/hyst corner
> case, but otherwise I guess that makes sense. The only problem IMO, is
> that you're encouraging the generation of spurious notifications; if the
> temperature is constantly changing right around 'trip temp', but it
> never settles above 'trip temp' long enough for the core to re-capture
> the high temperature scenario, you'll just keep making useless calls to
> thermal_zone_device_update(). This kind of defeats the purpose of the
> hysteresis, right?

The corner case with bang bang is as follows:
- Say we have trip points as 50C and 80C, both with 5C hysteresis, and 
these are programmed into hardware. So the actual hardware trip points 
are 45C and 80C.
- Currently the temperature is, say, 60C and the fan is turned on.
- Temperature drops to 45C, the lower trip point is triggered.
- 45C >= 50C - 5C, so the fan is not turned off.

If we said that the hysteresis was 0C, then bang bang is certainly 
correct in that if the trip point was at 50C, it shouldn't turn the fan 
off, since that is greater than or equal to the requested temperature 
for cooling.

The function you describe would certainly be useful for eliminating 
possible superfluous interrupts due to temperature wobble, though I'm 
not sure how much of a problem that even would be.

>
> I'd really rather have a high temperature interrupt generate exactly one
> notification to the core framework, and that the sensor driver can rely
> on that one interrupt being handled as a high temperature situation,
> allowing it to disable the high-temp interrupt.
>
> One of my biggest problems with the thermal subsystem so far is that
> thermal_zone_device_update() doesn't actually seem to have any specific
> semantic meaning. It just means that there was some reason to update
> something. So then, you have to reason about a particular thermal
> governor (bang bang) in order to make something sensible. If I want to
> use a different sort of user-space governor, then I have to reevaluate
> all these same assumptions, and it seems like I end up with a sub-par
> solution.

Yeah, though I'm not sure if you can ever be sure that the governor is 
fine not getting regular temperature updates, so I imagine you might 
always end up needing to pick your governors with that in mind. In 
practice, this might not be so horrible.

>
> As a side note: I have patches to extend some of the uevent information
> passed by the user-space governor too, to accomplish what I'm suggesting
> above. Perhaps that would be a better way to discuss what I'm thinking.
>
>> FWIW - at least Tegra doesn't have a latched register like this.
>> There's just a bit indicating that an interrupt was raised and a
>> temperature register that updates according to the sensor's input
>> clock.
>
> A sensor for Broadcom's BCM7xxx has a latched register. If I get the
> time, I'll post my driver soon.
>
> Brian
>
