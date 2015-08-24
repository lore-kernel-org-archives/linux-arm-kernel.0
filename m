From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 24 Aug 2015 14:47:10 +0100
Subject: [PATCH] irqchip, gicv3-its, numa: Workaround for Cavium ThunderX
 erratum 23144
In-Reply-To: <CAFpQJXUTNss=u2x7Ynd9wOObZn_ZHkcMz2+F4MKooy5jrvZ02w@mail.gmail.com>
References: <20150822131050.GK1820@rric.localdomain>	<55DAEF3C.5090303@arm.com>	<CAFpQJXVVcdag7OQnCxqyEw601Y32eO2rHCmH1_bVzyvg+OPzRA@mail.gmail.com>	<55DB11F3.1070604@arm.com>
 <CAFpQJXUTNss=u2x7Ynd9wOObZn_ZHkcMz2+F4MKooy5jrvZ02w@mail.gmail.com>
Message-ID: <55DB205E.9070205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/15 14:27, Ganapatrao Kulkarni wrote:
> On Mon, Aug 24, 2015 at 6:15 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

>>>>>  static void its_enable_cavium_thunderx(void *data)
>>>>>  {
>>>>> -     struct its_node *its = data;
>>>>> +     struct its_node __maybe_unused *its = data;
>>>>>
>>>>> -     its->flags |= ITS_FLAGS_CAVIUM_THUNDERX;
>>>>> +#ifdef CONFIG_CAVIUM_ERRATUM_22375
>>>>> +     its->flags |= ITS_WORKAROUND_CAVIUM_22375;
>>>>> +     pr_info("ITS: Enabling workaround for 22375, 24313\n");
>>>>> +#endif
>>>>> +
>>>>> +#ifdef CONFIG_CAVIUM_ERRATUM_23144
>>>>> +     if (num_possible_nodes() > 1) {
>>>>> +             its->numa_node = its_get_node_thunderx(its);
>>>>
>>>> I'd rather see numa_node being always initialized to something useful.
>>>> If you're adding numa support, why can't this be initialized via
>>>> standard topology bindings?
>>> IIUC, topology defines only cpu topology.
>>
>> Well, welcome to a much more complex system where both your CPUs and
>> your IOs have some degree of affinity. This needs to be described
>> properly, and not hacked on the side.
> ok, will add description for the function.

I sense that you misunderstood what I meant. What I'd like to see is
some topology information coming from DT, showing the relationship
between a device (your ITS) and a given node (your socket). This can
then be used from two purposes:

- find the optimal affinity for a MSI so that it doesn't default to a
foreign node (a reasonable performance expectation),
- work around implementation bugs where an LPI cannot be routed to a
redistributor that is on a foreign node.

I really don't feel like adding a hack just for the second point, and
I'd rather get the big picture right so that your workaround is just a
special case of the generic one.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
