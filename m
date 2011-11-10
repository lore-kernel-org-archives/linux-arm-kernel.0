From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 10 Nov 2011 17:30:05 +0530
Subject: [PATCH v7 17/21] OMAP2+: UART: Remove omap_uart_can_sleep and add
 pm_qos
In-Reply-To: <87r51i1kva.fsf@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
 <1318952110-10659-3-git-send-email-govindraj.raja@ti.com>
 <87vcqz33y8.fsf@ti.com>
 <4EB8F368.5070603@ti.com> <87r51i1kva.fsf@ti.com>
Message-ID: <CAAL8m4zLEnQE+BkK4xmLUBkREYOuqjmbBweKS0_qcEYUMo71nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Nov 9, 2011 at 12:50 AM, Kevin Hilman <khilman@ti.com> wrote:
> Rajendra Nayak <rnayak@ti.com> writes:
>
>> Hi Kevin,
>>
>> On Saturday 05 November 2011 04:12 AM, Kevin Hilman wrote:
>>> However, as mentioned previously[1], due to a HW sleepdep between MPU
>>> and CORE, this constraint isn't actually needed for CORE UARTs, so it's
>>> a bit wasteful to go through all the constraint setting for no reason.
>>
>> I had a short chat with Govind on this and was trying to understand
>> this better.
>> Are you referring to the 'autodeps' for omap3 here, because they would
>> prevent any clock domain from idling as long as MPU or IVA are active,
>
> No, I was thinking of HW sleepdeps. ?However, I looked back at the
> OMAP3430 TRM and see that MPU does not have a HW sleepdep on CORE like I
> thought.
>
>> but not the other way round. Which means MPU can still idle, while CORE
>> does not.
>>
>> My guess was, its probably the CORE domain idling itself thats causing
>> the UART sluggishness, (and not MPU idling), due to higher latency,
>> which is prevented with an active UART module in CORE, but not in PER.
>
> OK, that indeed makes sense. ?Thanks for correcting me.
>
>> So Govind did a small experiment to prevent just CORE idling and let MPU
>> idle alone and that did not show any sluggishness.
>
> OK, good.
>
>> Now, putting a pm-qos constraint for a UART in CORE still looks
>> redundant because the latency requirement that UART has is in
>> some way *indirectly* met (because the active UART in CORE prevents
>> CORE transitions in idle).
>> But don't you think the UART driver should express its
>> latency constraints regardless, without thinking of any indirect ways
>> in which the same requirements would have already been met?
>
> Yes, you're right. ?The driver should not need to know which powerdomain
> a given UART is in. ?It's probably best (and most portable) to have UART
> always express its requirements all the time.
>
> Thanks for digging into this,
>

I have fixed this and other uart_v7 comments and have re-based the
patch series on top
of 3.2-rc1 along with Tero's v9 irq chaining patches and tested the same.
Available here [1].

Can this patches series be added to a test branch for upstreaming or do you
think there are still some outstanding comments that needs to be discussed?

--
Thanks,
Govindraj.R

[1]:

git://gitorious.org/runtime_3-0/runtime_3-0.git
3.2-rc1_uart_runtime
