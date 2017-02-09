From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 9 Feb 2017 14:29:28 +0000
Subject: [PATCH 1/2] clk: scpi: RfC - Allow to ignore invalid SCPI DVFS
 clock rates
In-Reply-To: <e72f02ea-04f0-50c8-21c8-34667f7aeb92@baylibre.com>
References: <3b60654a-88b6-6262-396e-a058ade1c586@gmail.com>
 <d7b8f9db-7512-646c-bb96-ef74e7266661@gmail.com>
 <209248b8-2a1c-e00f-d8a8-b82759772b5d@arm.com> <m28tpgihzw.fsf@baylibre.com>
 <efe61325-eacd-2d4d-3ac0-71d54ef9d2bb@arm.com>
 <f0c0ed0a-82d5-4814-3420-bae9aa65193b@poczta.onet.pl>
 <6c360b3c-629c-03ea-3332-545da38ba283@arm.com>
 <f7e65721-bf09-54ed-a5d3-c918b0ca4505@poczta.onet.pl>
 <e72f02ea-04f0-50c8-21c8-34667f7aeb92@baylibre.com>
Message-ID: <a9fb8f7c-bee4-af4a-e246-a2449d1b8fa1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/02/17 13:31, Neil Armstrong wrote:
> On 02/09/2017 01:51 PM, Micha? Zegan wrote:
>>
>>
>> W dniu 09.02.2017 o 13:25, Sudeep Holla pisze:
>>>
>>>
>>> On 09/02/17 12:19, Micha? Zegan wrote:
>>>>
>>>>
>>>> W dniu 09.02.2017 o 11:52, Sudeep Holla pisze:
>>>>>
>>>>>
>>>>> On 08/02/17 19:45, Kevin Hilman wrote:
>>>>>> Sudeep Holla <sudeep.holla@arm.com> writes:
>>>>>>
>>>>>>> On 04/02/17 21:03, Heiner Kallweit wrote:
>>>>>>>> Introduce an optional property "clock-max-frequency" for SCPI DVFS
>>>>>>>> clocks. All frequencies for the respective clock exceeding this
>>>>>>>> threshold will be ignored.
>>>>>>>>
>>>>>>>> This is useful on systems where the firmware offers too optimistic
>>>>>>>> clock rates causing instabilities and crashes.
>>>>>>>>
>>>>>>>
>>>>>>> It clearly means the firmware/hardware(IOW platform) was not tested
>>>>>>> correctly before firmware advertised the OPPs. It needs to fixed in the
>>>>>>> firmware. The approach should be advertise the known minimal set working
>>>>>>> rather than the set for which hardware was designed.
>>>>>>>
>>>>>>> That's the whole reason while these are kept in firmware so the OS need
>>>>>>> not worry about such details.
>>>>>>>
>>>>>>> So NACK, go fix the firmware 
>>>>>>
>>>>>> Sorry, but "go fix the firmware" is not an option for most users of
>>>>>> these boards.
>>>>>>
>>>>>
>>>>> I knew this was coming :). I just wanted to shout at vendors who are not
>>>>> validating their firmware. Sometimes I feel it's better have platform
>>>>> driver and drive everything from Linux and don't use buggy firmware at
>>>>> all instead of adding tons of workaround. It defeats the whole purpose
>>>>> of having the firmware.
>>>>>
>>>> Well, at least in the case of odroid c2 from hardkernel, I believe those
>>>> unstable frequencies are supported intentionally. The wiki of the board
>>>> lists them explicitly, and says when they are stable.
>>>> So if that was intentional, then a frequency capping set by default
>>>> would be needed, it can be lifted by a specific user if he wants. Unless
>>>> hk should disable that "feature" instead.
>>>
>>> If those frequency are known to cause any stability issues, they should
>>> be considered as *not supported*. If it's just thermal constraints then
>>> yes the user/developer should be allowed to use them as they can take
>>> care of thermal management so that the platform remains stable for usage.
>>>
>> The unstability does not occur when you do not use all cores at once, so hmm
> 
> Hi Sudeep,
> 
> On Hardkernel ODroid C2 based on Amlogic S905, due to a bad hardware design the platform
> crashes when using >1536MHz frequencies while activating all cores.
> 
> But Hardkernel kept the frequencies to be able to use them when having a single core enabled
> using their off-tree highly modified linux kernel.
> 

Some kind of turbo mode which needs complete software attention to deal
with the hardware+firmware(platform) mess. Generally such frequencies
are exposed as just one OPP above the nominal range. If selected, the
firmware can choose is the maximum freq an individual processor may
reach, assuming ideal conditions, not be sustainable for long durations,
and may only be achievable if other processors are in a specific
idle/power state.

The point is it needs to be well hidden in the platform. Exposing such
specific and leaving it to the user to deal with seems stupid. They may
just fry the chip trying to experiment something :)

> So we need to handle these kind of cases where the vendor leaves them for strong reasons
> but mainlinux linux is not (yet) a strong reason to change the firmware.
> 

OK

> I'm sure we can find a smart solution to handle these use cases without adding too much
> ugly code.
> 

Agreed, I was thinking if adding some thermal driver and capping
frequency is a feasible option. Adding max-frequency to DT means one
needs to change the DT to run that custom Hardkernel ? That's doesn't
sound good, but I am sure many argue otherwise ;)

-- 
Regards,
Sudeep
