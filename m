From: samuel@sholland.org (Samuel Holland)
Date: Wed, 4 Jul 2018 10:23:18 -0500
Subject: [linux-sunxi] Re: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <861scjyrio.wl-marc.zyngier@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
 <5283f98e-6443-db7a-fe51-6379ed19002c@arm.com>
 <24b78819-5e3f-431f-3987-f7409742ef07@linaro.org>
 <1d75c538-9166-5eec-a08c-b168f9770bd1@arm.com>
 <alpine.DEB.2.21.1807041151530.1816@nanos.tec.linutronix.de>
 <1a36f63c-0259-bdcd-bb96-d5230c2564ea@arm.com>
 <alpine.DEB.2.21.1807041628440.1752@nanos.tec.linutronix.de>
 <55fc9e48-6329-df75-3a12-60cc42d91a31@arm.com>
 <861scjyrio.wl-marc.zyngier@arm.com>
Message-ID: <0cfd26d9-e1a5-3755-09b2-044eff37ff99@sholland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/18 10:01, Marc Zyngier wrote:
> On Wed, 04 Jul 2018 15:44:36, Andre Przywara <andre.przywara@arm.com> wrote:
>> On 04/07/18 15:31, Thomas Gleixner wrote:
>>> On Wed, 4 Jul 2018, Andre Przywara wrote:
>>>> On 04/07/18 11:00, Thomas Gleixner wrote:
>>>>> On Wed, 4 Jul 2018, Marc Zyngier wrote:
>>>>>> On 04/07/18 09:23, Daniel Lezcano wrote:
>>>>>>> 
>>>>>>> If the patches fix a bug which already exist, it makes sense to 
>>>>>>> propagated the fix back to the stable versions.
>>>>>> 
>>>>>> That's your call, but I'm not supportive of that decision, 
>>>>>> specially as we have information from the person developing the 
>>>>>> workaround that this doesn't fully address the issue.
>>>>> 
>>>>> The patches should not be applied at all. Simply because they don't 
>>>>> fix the issue completely.
>>>>> 
>>>>> From a quick glance at various links and information about this,
>>>>> this very much smells like the FSL_ERRATUM_A008585. Has that been
>>>>> tried? It looks way more robust than the magic 11 bit crystal ball
>>>>> logic.
>>>> 
>>>> The Freescale erratum is similar, but not identical [1]. It seems like 
>>>> the A64 is less variable, so we can use a cheaper workaround, which 
>>>> gets away with normally just one sysreg read. But then again the newer 
>>>> error reports may actually suggest otherwise ...
>>>> 
>>>> And as it currently stands, the Freescale erratum has the drawback of 
>>>> relying on the CPU running much faster than the timer. The A64 can run
>>>>  at 24 MHz (for power savings, or possibly during DVFS transitions), 
>>>> which is the timer frequency. So subsequent counter reads will never 
>>>> return the same value and the workaround times out.
>>> 
>>> If that's the case then you need to find a different functional timer for
>>> time keeping. Having an erratic behaving timer for time keeping is not an
>>> option at all.
>> 
>> That's not an option on arm64. There are other usable time sources in the 
>> SoC, but the arch timer is somewhat mandatory for all practical purposes
>> on arm64. We rely on it in some many places that it's not feasible to run 
>> without it. That's why we call it "architected" timer after all ;-) But I 
>> am quite confident that we can find a correct workaround. Maybe it's
>> really the TVAL (the downcounter) write which is the culprit here, since
>> the hardware actually writes "now() + TVAL" into the CVAL (upcounter)
>> register. This internal counter access may be flawed as well.
> 
> You got it backward: CVAL is not a counter at all. It is a Comparator. And 
> TVAL has an implicit read from the counter, as it is defined as "CVAL - CNT" 
> (i.e. the number of ticks until the timer expires).
> 
> So it might be worth trying to handle TVAL entirely in SW.
> 
> But this relies on being able to read the timer and get a number of correct 
> values out of it. One possibility would be to sacrifice precision and always 
> ignore some of the bottom bits, but this is always going to suck terribly.
> 
> The alternative is burn that thing, and pretend it never existed.

>From the testing I have done, this patch series fully stabilizes reading CNTPCT
and CNTVCT. So with the workaround, the timer *can* accurately count time. So
merging this would be an improvement on the current situation.

The system clock jumps might be explained by interaction with CVAL/TVAL, and
that's the part I haven't investigated yet. As I mentioned before, and Andre
just mentioned again, the BSP provided by the vendor has another workaround for
writing the TVAL register. Hopefully, that's the missing piece which will fix
the clock jumps.

Thanks,
Samuel
