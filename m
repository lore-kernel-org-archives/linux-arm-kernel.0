From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 16:21:22 +0900
Subject: [PATCH 2/9] ARM: dts: uniphier: rework UniPhier System Bus nodes
In-Reply-To: <CAOesGMimq4Xf3sUB4bkkdr7whiaRDaL6JM1Nu2zN_QfJSHoQxg@mail.gmail.com>
References: <1455588911-9827-1-git-send-email-yamada.masahiro@socionext.com>
 <1455588911-9827-3-git-send-email-yamada.masahiro@socionext.com>
 <20160225002641.GC10126@localhost>
 <CAK7LNARSXAw42bU4x+rgbWVmoru_5C8CMUHvTN22qm4eCDSvKA@mail.gmail.com>
 <CAOesGMimq4Xf3sUB4bkkdr7whiaRDaL6JM1Nu2zN_QfJSHoQxg@mail.gmail.com>
Message-ID: <CAK7LNATZCG1mv5zjgVjXdftcDT8myK87=Y30DARvrk3fdSSo5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,


2016-02-25 16:20 GMT+09:00 Olof Johansson <olof@lixom.net>:
> On Wed, Feb 24, 2016 at 6:22 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Hi Olof,
>>
>>
>> 2016-02-25 9:26 GMT+09:00 Olof Johansson <olof@lixom.net>:
>>> Hi,
>>>
>>> On Tue, Feb 16, 2016 at 11:15:04AM +0900, Masahiro Yamada wrote:
>>>
>>>> diff --git a/arch/arm/mach-uniphier/platsmp.c b/arch/arm/mach-uniphier/platsmp.c
>>>> index e1cfc1d..b53a8d9 100644
>>>> --- a/arch/arm/mach-uniphier/platsmp.c
>>>> +++ b/arch/arm/mach-uniphier/platsmp.c
>>>> @@ -30,7 +30,7 @@
>>>>   * The secondary CPUs check this register from the boot ROM for the jump
>>>>   * destination.  After that, it can be reused as a scratch register.
>>>>   */
>>>> -#define UNIPHIER_SBC_ROM_BOOT_RSV2   0x1208
>>>> +#define UNIPHIER_SMPCTRL_ROM_BOOT_RSV2       0x208
>>>>
>>>>  static void __iomem *uniphier_smp_rom_boot_rsv2;
>>>>  static unsigned int uniphier_smp_max_cpus;
>>>> @@ -98,15 +98,14 @@ static int __init uniphier_smp_prepare_trampoline(unsigned int max_cpus)
>>>>       phys_addr_t rom_rsv2_phys;
>>>>       int ret;
>>>>
>>>> -     np = of_find_compatible_node(NULL, NULL,
>>>> -                             "socionext,uniphier-system-bus-controller");
>>>> -     ret = of_address_to_resource(np, 1, &res);
>>>> +     np = of_find_compatible_node(NULL, NULL, "socionext,uniphier-smpctrl");
>>>> +     ret = of_address_to_resource(np, 0, &res);
>>>>       if (ret) {
>>>> -             pr_err("failed to get resource of system-bus-controller\n");
>>>> +             pr_err("failed to get resource of uniphier-smpctrl\n");
>>>>               return ret;
>>>>       }
>>>>
>>>> -     rom_rsv2_phys = res.start + UNIPHIER_SBC_ROM_BOOT_RSV2;
>>>> +     rom_rsv2_phys = res.start + UNIPHIER_SMPCTRL_ROM_BOOT_RSV2;
>>>>
>>>>       ret = uniphier_smp_copy_trampoline(rom_rsv2_phys);
>>>>       if (ret)
>>>
>>> The previous binding has already been released. You can update, but your driver
>>> should be able to handle the previous binding.
>>>
>>> So, you still need to keep the old code around.
>>>
>>> This has the benefit of breaking the dependency between the code change and the
>>> DT change, so you no longer have to change your platform code at the same time
>>> as the DT to avoid regressions.
>>>
>>>
>>> Please adjust and resend. I'll hold off applying the series until then, so we
>>> don't have a partially applied series.
>>
>>
>>
>> How long do I have to keep the support for the old binding?
>
> You know your platform best -- how many users do you think you have
> out there that might have built DTS files based on the old binding?
>
> If there's a good chance there are none, or if you're in good contact
> with them and can ask them to update, then you can be more flexible.
>
>> [1]
>> Everyone makes mistakes.
>> The constraint for the DT-binding is really really painful.
>>
>> This is how it happened.
>>
>> At first, I implemented uniphier-system-bus.c based on the old binding.
>> Then, during the review, Mark suggested me to change the driver design:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/387938.html
>>
>> I followed his suggestion, but I needed to changed the DT-binding as well.
>> Before that time, the DT and other support code for UniPhier had been
>> partially merged
>> in the mainline.  So, in the current tree exist two bindings that are
>> not compatible to
>> each other.  This situation is really a mess.
>> I want to clean up the code as soon as possible.
>
> Yeah, I understand that it's hard to come up with perfect bindings
> from day one, and that's why we sometimes have to play by ear.
>
> It's not a bad idea to get practice on how to solve it -- in this case
> it wouldn't really bad that bad. If you use variables to hold the base
> addresses, and get them from either binding, you'll only special-case
> during probe and not anywhere else in the driver.
>
> The general idea of decoupling DT changes from code changes is also a
> good habit.
>
>> [2]
>> For now, DT is mostly developed in the kernel tree in practice,
>> while DT is not theoretically only for Linux.
>> Everybody (at least every user of UniPhier SoCs) uses the combination
>> of a DTB and a kernel image
>> generated from the same Linux tree.
>> I see no reason to use a new DTB + an old kernel image, or vice versa.
>
> We're not aiming to support new DTB + old kernel image. The main
> problem is if someone has a product DTB that's not yet merged, and you
> change the binding, then their DTB might no longer work. It's not a
> huge deal, and for most changes it's fairly harmless, but the general
> principle still applies.
>
> As I said earlier, you know the users of your platform the best (I
> hope :), so you'll have the best feel for whether this is a breakage
> they will hurt from or not.
>
>> [3]
>> This binding is UniPhier-specific.  No impact on other SoC vendors.
>> Everything is under my control.
>>
>>
>>
>> For now, I will prepare the logic to support the old binding,
>> but for the reasons above, please let me drop the support for the old
>> one some time later.
>
> Yeah, I'm perfectly fine with not keeping it for a long time. For
> example, feel free to remove it next release if you think that will
> work for your downstream users.


OK, I split the series into two.  (DT and non-DT updates)

Thanks.


-- 
Best Regards
Masahiro Yamada
