From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Fri, 8 Jul 2011 20:37:52 +0200
Subject: [RFC PATCH v2 0/4] Core device subsystem
In-Reply-To: <CAHXqBFKKGj9c3fNiFRiR-BBdVffxg8bBHYh0_sCQvCZ3SDTewA@mail.gmail.com>
References: <1310115250-3859-1-git-send-email-marc.zyngier@arm.com>
	<CAHXqBFJiovYq5x_JDAxikvFs-t1To6yC-1uajBJFRX_jwjvejA@mail.gmail.com>
	<4E170134.1020306@arm.com> <4E171E93.8020608@arm.com>
	<CAHXqBFKKGj9c3fNiFRiR-BBdVffxg8bBHYh0_sCQvCZ3SDTewA@mail.gmail.com>
Message-ID: <CAHXqBFKUJQOH8LJRfeWjr=OabKtyBJkYWDT8PN8vUxR6dewNUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 8 lipca 2011 20:13 u?ytkownik Micha? Miros?aw <mirqus@gmail.com> napisa?:
> W dniu 8 lipca 2011 17:13 u?ytkownik Marc Zyngier
> <marc.zyngier@arm.com> napisa?:
>> On 08/07/11 14:08, Marc Zyngier wrote:
>>> So you're basically folding of_core_device_populate() and
>>> core_driver_init_class() into one call, and generating the
>>> of_device_ids on the fly. If you're going down that road,
>>> it would be even simpler to directly use of_device_ids
>>> instead of core_device_ids and skip the generation altogether.
>>>
>>> That would also remove the static declaration of devices to be
>>> probed in the architecture support code...
>>>
>>> Let me think of it and prototype that.
>>
>> See the attached patch against branch dt_gic_twd from
>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
>>
>> It boots fine on my PB11MP.
>>
>> What do you think?
[...]
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -712,9 +712,9 @@ static int __init gic_core_init(struct core_device *dev)
>> ? ? ? ?return 0;
>> ?}
>>
>> -static struct core_device_id gic_ids[] __initdata = {
>> - ? ? ? { .name = "arm,gic-spi" }, /* DT */
>> - ? ? ? { .name = "arm_gic" }, ? ? /* Static device */
>> +static struct of_device_id gic_ids[] __initdata = {
>> + ? ? ? { .compatible = "arm,gic-spi" }, /* DT */
>> + ? ? ? { .name = "arm_gic" }, ? ? ? ? ? /* Static device */
>> ? ? ? ?{ },
>> ?};
>
> This will also match devices with name "arm_gic" in DT. Unlikely, but
> probably not what you want.
>
> I thought about something more evil. ;) See below.
>
> Assuming we modify of_find_matching_node() to also return matched ID entry:
>
> ---- of_core_device_populate()
>
> const struct of_device_id *id;
> struct device_node *dn;
> struct core_device *dev;
>
> for_each_matching_node_id(dn, matches, id) {
> ?dev = create_core_dev(...);
> ?dev->init = id->data;
> ?add_to_list(class, dev);
> }
>
> if (intc class)
> ?sort_list()
>
> ----
>
> And then drivers would register like this:
>
> int __init etc_init(struct core_device *);
>
> DEFINE_CORE_DEVICE_TABLE_DT(class, name) = {
> ?{ .compatible = "etc", .data = etc_init },
> };
>
> DEFINE_CORE_DEVICE_TABLE_LEGACY(class, name) = {
> ?{ .name = "etc", .data = etc_init },
> };
>
>
> This removes the need for struct core_driver and instead uses linker
> to directly generate match tables for INTC and TIMER classes. This
> also allows to get rid of legacy IDs when kernel is built with support
> for boards not using DT.

DEFINE_CORE_DEVICE_TABLE_* could be implemented like this:

#define __DEFINE_CORE_DEVICE_TABLE(type,cls,name) \
  static const struct of_device_id __coredev_##type##_##name##_##cls[] \
    __used __section(.init.coredev_##type##_##cls)

#define DEFINE_CORE_DEVICE_TABLE_DT_IRQ(name) \
  __DEFINE_CORE_DEVICE_TABLE(dt, irq, name)
#define DEFINE_CORE_DEVICE_TABLE_LEGACY_IRQ(name) \
  __DEFINE_CORE_DEVICE_TABLE(legacy, irq, name)
#define DEFINE_CORE_DEVICE_TABLE_DT_TIMER(name) \
  __DEFINE_CORE_DEVICE_TABLE(dt, timer, name)
#define DEFINE_CORE_DEVICE_TABLE_LEGACY_TIMER(name) \
  __DEFINE_CORE_DEVICE_TABLE(legacy, timer, name)

(I folded 'class' parameter into the define's name but that might not
be the best idea if the class set is to be expanded - compiler error
for invalid classes can be generated also in other ways.)

Best Regards,
Micha? Miros?aw
