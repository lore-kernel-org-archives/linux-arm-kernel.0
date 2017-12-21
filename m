From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 21 Dec 2017 12:19:27 +0530
Subject: [PATCH] irqchip/gic-v3-its: Flush GICR caching for a cross node
 collection move of an irq
In-Reply-To: <acac628e-d4fa-5b16-2619-144818f2261a@arm.com>
References: <20171220091544.4467-1-ganapatrao.kulkarni@cavium.com>
 <a2754c68-0a6b-e23d-1ed7-693ce4f7f89c@arm.com>
 <CAKTKpr47HZmoShXvAG5d4DZQORvrMccdaL8-mEWmpEsNMX5_3w@mail.gmail.com>
 <acac628e-d4fa-5b16-2619-144818f2261a@arm.com>
Message-ID: <CAKTKpr43usPBwTan511kSHWuWipJqdrdtmbR0BohsCTE-OB11g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 6:42 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 20/12/17 09:34, Ganapatrao Kulkarni wrote:
>> Hi Marc,
>>
>> On Wed, Dec 20, 2017 at 2:56 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 20/12/17 09:15, Ganapatrao Kulkarni wrote:
>>>> When an interrupt is moved, it is possible that an implementation that
>>>> supports caching might still have cached data for a previous
>>>> (no longer valid) mapping of the interrupt. In particular, in a distributed
>>>> GIC implementation like multi-socket SoC platfroms. Hence it is necessary
>>>> to flush cached entries after cross node collection migration.
>>>>
>>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>> ---
>>>>  drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>>> index 4039e64..ea849a1 100644
>>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>>> @@ -1119,6 +1119,12 @@ static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>>>>       if (cpu != its_dev->event_map.col_map[id]) {
>>>>               target_col = &its_dev->its->collections[cpu];
>>>>               its_send_movi(its_dev, target_col, id);
>>>> +             /* Issue INV for cross node collection move on
>>>> +              * multi socket systems.
>>>> +              */
>>>> +             if (cpu_to_node(cpu) !=
>>>> +                             cpu_to_node(its_dev->event_map.col_map[id]))
>>>> +                     its_send_inv(its_dev, id);
>>>>               its_dev->event_map.col_map[id] = cpu;
>>>>               irq_data_update_effective_affinity(d, cpumask_of(cpu));
>>>>       }
>>>>
>>>
>>> The MOVI command doesn't have any such requirement (it only mandates
>>> synchronization), and doesn't say anything about distributed vs monolithic.
>>
>> GIC-v3 spec do mention to issue ITS INV command or a write to GICR_INVLPIR.
>> pasting below snippet of MOVI command description.
>>
>> "When an interrupt is moved to a collection, it is possible that an
>> implementation that supports speculative caching
>> might still have cached data for a previous (no longer valid) mapping
>> of the interrupt. Hence, implementations
>> must take care to invalidate any data associated with an interrupt
>> when it is moved. In particular, in a distributed
>> implementation, the ITS must write to the appropriate GICR_* register
>> to perform the invalidation in the redistributor."
>
> Doing some documentation archaeology, I found that this wording has been
> dropped from the engineering specification in August 2014, and was never
> included in the architecture specification. I suggest you start using a
> slightly more up-to-date set of documentation...

thanks Marc for digging in to archive.

>
> Now, back to your point: what it says in the bit of (confidential)
> document that you quoted is that the *HW* must perform the invalidation
> (that's what the words "implementations" and "ITS" refer to), not some
> random bits of SW.
>
> If you know of an implementation that suffers from this, please resend a
> patch that handles this as a quirk, with a proper erratum number.

Sure, this is being discussed internally and will repost as errata fix
at the earliest.

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

thanks
Ganapat
