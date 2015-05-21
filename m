From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 May 2015 00:58:35 -0500
Subject: [PATCH V5 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150521054602.GE22904@linux>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
 <555D6CC8.9050201@ti.com> <20150521054602.GE22904@linux>
Message-ID: <555D740B.6000001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2015 12:46 AM, Viresh Kumar wrote:
> On 21-05-15, 00:27, Nishanth Menon wrote:
>>> +This describes the OPPs belonging to a device. This node can have following
>>> +properties:
>>> +
>>> +Required properties:
>>> +- compatible: Allow OPPs to express their compatibility. It should be:
>>> +  "operating-points-v2".
>>> +
>>> +- OPP nodes: One or more OPP nodes describing voltage-current-frequency
>>> +  combinations. Their name isn't significant but their phandle can be used to
>>> +  reference an OPP.
>>
>> What if this was generated data (say using an overlay)?
> 
> Sorry I am not aware of this, can you explain a bit how this is done ?
> Are you talking about something like fdtput here ?

Honestly, have'nt thought out all the details in yet :)... just
thinking.. since overlays can come in later in the system, we could boot
up a very bare minimum kernel, have device tree populated runtime (say
based on data incoming from a power management microcontroller based
description of the capabilities.. I know PSCI or some other form will
eventually deal with it.. just wondering about scaling options)... basic
node description made in original dtb, and rest of the data populated
dynamically(by some magic mechanism yet to be defined) prior to consumer
of that data crunching away.. mostly to deal with paper spins that many
of us in SoC vendor world work with..


> 
>> does it have to
>> be "required" or just "optional" :)
> 
> This has to be required (by the parser, kernel in our case).
> 
>>> +Required properties:
>>> +- opp-hz: Frequency in Hz
>>
>> I am just being nit picky -> should we keep Heinrich Hertz respected[2]
>> and name it opp-Hz ? No strong opinions either way.
> 
> Documentation/devicetree/booting-without-of.txt:
> 

hehe.. thanks on the reminder to RTFM.
[...]

> 
>>
>> different angle: How about just target-freq-Hz? just drop the "opp"
>> prefix for properties of an OPP node? No strong feelings here. (some
>> folks did have variations of a few Hz based on clock tree - example with
>> a crystal frequency of 19.2MHz you'd probably get 1001MHz exact, with a
>> 26MHz crystal, you'd get 1000MHz -> ofcourse round-rate is supposed to
>> help with that... but anyways.. why not say we are trying to indicate
>> target frequency? I do recollect during initial days of OPP
>> (pre-dt-adoption days) folks did complain about this - we kinda worked
>> around this with round-rated handling - but we might as well anticipate it.
> 
> Rob suggested opp- prefix and it looks good to me, lets see what
> others have to say :)

OK.

>> I agree with Mike[1] here -> why not move clocks and supply to cpu0_opp?
>> "
>> It seems wrong to me that the clock and supply data is owned by the cpu
>> node, and not the opp descriptor. Everything about the opp transition
>> should belong to a provider node. Then the cpu simply needs to consume
>> that via a phandle.
>> "
>>
>> I am not sure if we discussed that point further OR if we kinda got
>> hooked on to the "should it be in kernel" point of debate in V4.
> 
> I did send a reply to that, but no one replied after that. Probably
> you want to reply on that ?

I assume you meant [1] which in turn pointed to [2]. Thanks, will do so.


[1] http://marc.info/?l=linux-pm&m=143150734506159&w=2
[2]
https://lists.linaro.org/pipermail/linaro-kernel/2014-December/019505.html

-- 
Regards,
Nishanth Menon
