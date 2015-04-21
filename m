From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 21 Apr 2015 11:06:10 +0800
Subject: [PATCH 2/2 RESEND] ARM: prima2: add NetWork on Chip driver for
 atlas7
In-Reply-To: <CAGsJ_4yPpiknFRCryX=FOMixF8TUH5JiHaFV-c5JQmaophi+dg@mail.gmail.com>
References: <1429012556-14041-1-git-send-email-21cnbao@gmail.com>
 <1429012556-14041-2-git-send-email-21cnbao@gmail.com>
 <4918744.ypGiyU8ujI@wuerfel>
 <CAGsJ_4yPpiknFRCryX=FOMixF8TUH5JiHaFV-c5JQmaophi+dg@mail.gmail.com>
Message-ID: <CAGsJ_4x_WoncNPM=h9Hzn10WrS5e8jhisgQeXO7jCJ8MwZ1ihA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-16 10:48 GMT+08:00 Barry Song <21cnbao@gmail.com>:
> 2015-04-15 23:53 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Tuesday 14 April 2015 11:55:56 Barry Song wrote:
>>> diff --git a/Documentation/devicetree/bindings/bus/atlas7-noc.txt b/Documentation/devicetree/bindings/bus/atlas7-noc.txt
>>> new file mode 100644
>>> index 0000000..449ddb5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/bus/atlas7-noc.txt
>>> @@ -0,0 +1,34 @@
>>> +Device tree bindings for CSRatlas7 NoC(Network on Chip)
>>> +
>>> +CSR atlas7 uses a NoC bus, SoC is splitted into mutiple MACROs. Every MACRO
>>> +holds some hardware modules. For each MACRO
>>> +properties:
>>> +- compatible : Should be "arteris, flexnoc"
>>> +- #address-cells: should be 1
>>> +- #size-cells: should be 1
>>> +- ranges : the child address space are mapped 1:1 onto the parent address space
>>> +
>>> +Sub-nodes:
>>> +All the devices connected to noc are described using sub-node to noc. For
>>> +example, AUDMSCM MARCO includes multimediam nodes such as KAS, AC97, IACC, I2S,
>>> +USP0~3, LVDS.
>>> +For each MARCO, there is at least a firewall sub-node. This firewall can detect
>>> +illegal hardware access for security protection.
>>> +
>>> +Firewall sub-nodes:
>>> +properties:
>>> +- compatible : Should be one of
>>> +     "sirf,nocfw-cpum",
>>> +     "sirf,nocfw-cgum",
>>> +     "sirf,nocfw-btm",
>>> +     "sirf,nocfw-gnssm",
>>> +     "sirf,nocfw-gpum",
>>> +     "sirf,nocfw-mediam",
>>> +     "sirf,nocfw-vdifm",
>>> +     "sirf,nocfw-audiom",
>>> +     "sirf,nocfw-ddrm",
>>> +     "sirf,nocfw-rtcm",
>>> +     "sirf,nocfw-dramfw",
>>> +     "sirf,nocfw-spramfw"
>>> +- reg: A resource specifier for the register space
>>> +- interrupts : Should be the interrupt number - optional
>>
>> I think we should have a more generic binding here, which describes the
>> differences between the instances of this bus in separate properties
>> rather than keying them off the compatible string.
>>
>
> if there is a general binding, it might be "sirf, nocfw" string with
> different properties. here each firewall has name, index, different
> register offset and initialization.
> it seems we need some careful thinking to figure out what is suitable
> to be a property.
>
>> That way you get a simpler driver that is automatically reusable
>> across chip generations, potentially using small extensions, but
>> not per-chip instance lists.
>>
>>> diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
>>> index 8cadb30..4a9dcad 100644
>>> --- a/arch/arm/mach-prima2/common.c
>>> +++ b/arch/arm/mach-prima2/common.c
>>> @@ -15,6 +15,13 @@
>>>  #include <linux/of_platform.h>
>>>  #include "common.h"
>>>
>>> +static void __init sirfsoc_init_mach(void)
>>> +{
>>> +     of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>> +
>>> +     sirfsoc_noc_init();
>>> +}
>>> +
>>>  static void __init sirfsoc_init_late(void)
>>>  {
>>>       sirfsoc_pm_init();
>>> @@ -60,6 +67,7 @@ static const char *const atlas7_dt_match[] __initconst = {
>>>  DT_MACHINE_START(ATLAS7_DT, "Generic ATLAS7 (Flattened Device Tree)")
>>>       /* Maintainer: Barry Song <baohua.song@csr.com> */
>>>       .smp            = smp_ops(sirfsoc_smp_ops),
>>> +     .init_machine   = sirfsoc_init_mach,
>>>       .dt_compat      = atlas7_dt_match,
>>>  MACHINE_END
>>>  #endif
>>
>> I think we can avoid adding this part.
>
> this has not be avoided because platform_driver.probe() is not able to
> call hook_fault_code(). this results in a section mismatch.
> we used to have a platform_driver, finally, i feel it is more
> difficult to convince people to move hook_fault_code() to support
> hotplug.
> do you think it is reasonable to refine hook_fault_code() to hotplug support?
>

here the background is that firewall can stop illegal memory/devices
access for both CPU and DMA, and generate error information for these
illegal behaviors. for example, if non-secure linux access secure RAM,
interrupts and aborts will generate.

1. for CPU, firewall can generate external async abort and interrupts,
both aborts and interrupts enable can be set/clear in firewall.
2. for non-CPU, firewall can generate interrupts.

originally, we want to use aborts for CPU firewall as we suppose the
abort should be sync, then we can capture the instructions causing the
aborts directly, and easy the debug. but finally HW guys told us the
abort is async. so here it seems there is no difference for us to move
to interrupts for CPU. then we can unify the codes for all MARCOs and
avoid the hook_fault_code(). and codes should also be more clean.

i need your comments for this, and now i strongly feel we can move to
interrupts for all. the external async aborts have no more helps for
debugging the illegal access for CPU.

-barry
