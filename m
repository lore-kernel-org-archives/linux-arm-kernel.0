From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 4 Jul 2014 10:39:34 +0800
Subject: [PATCH 0/4] Migrate PXA27x platforms to clock framework
In-Reply-To: <87lhsanl7q.fsf@free.fr>
References: <1404066744-13416-1-git-send-email-robert.jarzmik@free.fr>
 <7034630.fvV46PN35C@wuerfel> <877g3yp7ie.fsf@free.fr>
 <CAN1soZyu192Y7z-HJHo+3_bddFcf=H0udgJSWez1=Lmrb5wVfg@mail.gmail.com>
 <87lhsanl7q.fsf@free.fr>
Message-ID: <CAN1soZwtuyWQhuLO4pK6aB51ibGjAHZN3+VDyAFMfU3gBfxdxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 6:14 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Haojian Zhuang <haojian.zhuang@gmail.com> writes:
>
>>> Haojian, are you ok with that ? And BTW, does a combined kernel for PXA
>>> platforms even exists (mixing pxa3xx and pxa2xx for example) ?
>>>
>>
>> It's acceptable to me that different silicons are queued in different stages.
>> I only request that it won't break the compiler building & bootup.
> OK.
>
>>
>> But I think that the pxa clock driver may be shared among all PXA silicons
>> except for the clock table. What's your opinion?
> I don't think so because of the core clocks.
> These ones are specific to each pxa, and so their computation is :
>  - pxa25x plays with CCCR and specific L, M and N2 multiplication tables
>  - pxa27x plays with CCCR and specific L, M and N2 multiplication tables
>  - pxa3xx plays with ASCR, MEMCLKCFG, and AC97 div
>
> I don't see very well how a clock table could describe that. Do you have
> something specific in mind ?
>

As I remember, those registers bits are encoded. So we can define a clock mux
that connected to those fixed clock dividers. Then the clock gate is
the child of
the clock mux.

In DTS file, peripheral device node could specify a clock rate. In
peripheral device
driver, it could also change the clock rate by clk_set_rate().

>>>> Also (for my understanding) when you say that you plan to do
>>>> pxa25x and pxa3xx next, does that include pxa26x and pxa93x?
>>> I don't have the Technical Reference Manuals for these ones so the answer is
>>> no. And Google wasn't a great friend at providing them.
>>>
>>
>> Converting them into new clock driver may not rely on the reference manual.
> Actually I went through the code and :
>  - pxa26x is only a superset of pxa25x with one more clock : pxa26x-gpio
>  - pxa93x is the same clock set as pxa3xx, right ?
> So if I convert pxa25x, pxa27x and pxa3xx I'll cover everything, right ?
>
>>>> I assume it does as they are apparently minor revisions of the
>>>> former, but it's not completely clear from your description.
>>> My description doesn't mention them, as I have no information about them, nor
>>> any hardware to test on.
>>>
>>
>> We can request others to help testing in the mailing list.
> That's exactly what will enable pxa25x and pxa3xx. I have them converted in my
> tree, but I don't want to mix these patches in as I can't test them, and testing
> brings in bigger delays.

Delay shouldn't be the block issue.

Regards
Haojian
