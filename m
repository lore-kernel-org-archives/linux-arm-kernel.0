From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 15 Dec 2014 00:57:49 +0000
Subject: [RFC/PATCH 1/4 PATCH] ARM: mvebu: use dt_fixup to provide
 fallback for enable-method
In-Reply-To: <548DFCEA.7000801@alliedtelesis.co.nz>
References: <5488A2C0.5040804@alliedtelesis.co.nz>
 <1418360035-27975-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <2005632.nq5F7SJD3S@wuerfel> <548DFCEA.7000801@alliedtelesis.co.nz>
Message-ID: <548E3209.20307@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Answering my own question

On 12/15/2014 10:11 AM, Chris Packham wrote:
> Hi Arnd,
>
> On 12/13/2014 12:35 AM, Arnd Bergmann wrote:
>> On Friday 12 December 2014 17:53:55 Chris Packham wrote:
>>>> I briefly explored that approach here[1]. The tricky part would be
>>>> handling the fact that the enable method can be attached to either the
>>>> /cpus node or and individual /cpu entry (or is that something I can
>>>> ignore?).
>>>>
>>>> In the end I thought that the unconditional setting of smp_ops was
>>>> easier to implement and would achieve the same result.
>>>
>>> Actually as it turns out it's not that hard to implement something that
>>> checks both /cpus and /cpus/cpu at n. I'll include this with the next round
>>> after I've waited for anymore feedback.
>>
>> Ah, very nice!
>>
>>> ---8<---
>>> Subject: [PATCH] ARM: mvebu: use dt_fixup to provide fallback for
>>> enable-method
>>>
>>> When the device tree doesn't define an enable-method insert a property
>>> into the flattened device tree. arm_dt_init_cpu_maps() will then parse
>>> this an set smp_ops appropriately. Now that we have this fallback it is
>>> no longer necessary to set .smp in the DT_MACHINE definition.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>   arch/arm/mach-mvebu/Makefile   |  2 ++
>>>   arch/arm/mach-mvebu/board-v7.c | 37
>>> ++++++++++++++++++++++++++++++++++++-
>>>   2 files changed, 38 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
>>> index e24136b..68310f8 100644
>>> --- a/arch/arm/mach-mvebu/Makefile
>>> +++ b/arch/arm/mach-mvebu/Makefile
>>> @@ -14,3 +14,5 @@ endif
>>>   obj-$(CONFIG_MACH_DOVE)         += dove.o
>>>   obj-$(CONFIG_MACH_KIRKWOOD)     += kirkwood.o kirkwood-pm.o
>>>   obj-$(CONFIG_MACH_NETXBIG)     += netxbig.o
>>> +
>>> +CFLAGS_board-v7.o = -I$(src)/../../../scripts/dtc/libfdt
>>> \ No newline at end of file
>>
>> Why is this needed? Can't you just include <linux/libfdt.h> ?
>>
>
> I am already including linux/libfdt.h. Without the CFLAGS change I get
> the following compile error.
>
>    In file included from include/linux/libfdt.h:6:0,
>                     from arch/arm/mach-mvebu/board-v7.c:21:
>    include/linux/../../scripts/dtc/libfdt/libfdt.h:54:24: fatal error:
> libfdt_env.h: No such file or directory
>
> There seems to be precedence in other architectures/drivers
>
>    $ git grep -e '-I.*libfdt'
>    arch/mips/cavium-octeon/Makefile:CFLAGS_octeon-platform.o =
> -I$(src)/../../../scripts/dtc/libfdt
>    arch/mips/cavium-octeon/Makefile:CFLAGS_setup.o =
> -I$(src)/../../../scripts/dtc/libfdt
>    arch/mips/mti-sead3/Makefile:CFLAGS_sead3-setup.o =
> -I$(src)/../../../scripts/dtc/libfdt
>    arch/powerpc/kernel/Makefile:CFLAGS_prom.o              =
> -I$(src)/../../../scripts/dtc/libfdt
>    drivers/firmware/efi/libstub/Makefile:CFLAGS_fdt.o    +=
> -I$(srctree)/scripts/dtc/libfdt/
>    drivers/of/Makefile:CFLAGS_fdt.o = -I$(src)/../../scripts/dtc/libfdt
>    drivers/of/Makefile:CFLAGS_fdt_address.o =
> -I$(src)/../../scripts/dtc/libfdt
>
>>> +static void __init armada_370_xp_dt_fixup(void)
>>> +{
>>> +    int offset, node;
>>> +    int i, len;
>>> +    void *prop;
>>> +    char buffer[20];
>>> +
>>> +    offset = fdt_path_offset(initial_boot_params, "/cpus");
>>> +    if (offset < 0)
>>> +        return;
>>> +
>>> +    prop = fdt_getprop(initial_boot_params, offset, "enable-method",
>>> &len);
>>> +    if (prop)
>>> +        return;
>>> +
>>> +    for (i = 0; i < NR_CPUS; i++) {
>>> +        snprintf(buffer, sizeof(buffer), "cpu@%d", i);
>>> +        node = fdt_subnode_offset(initial_boot_params, offset, buffer);
>>> +        if (node < 0)
>>> +            break;
>>> +        prop = fdt_getprop(initial_boot_params, node,
>>> +                   "enable-method", &len);
>>> +        if (prop)
>>> +            return;
>>> +    }
>>> +
>>> +    pr_info("No enable-method defined. "
>>> +        "Falling back to \"marvell,armada-xp-smp\"\n");
>>> +
>>> +    fdt_setprop(initial_boot_params, offset, "enable-method",
>>> +            "marvell,armada-xp-smp", sizeof("marvell,armada-xp-smp"));
>>> +}
>>
>> I think it would be good to first check whether you are running on
>> Armada XP
>> or Armada 370, because the latter does not require this.
>>
>>     Arnd
>>
>
> Any suggestion as to what to check for. Based on the dts files in the
> current source seem compatible == "marvell,armada370" seems like a good
> choice. But I don't know for sure that there isn't a armada-xp variant
> out using a .dts with this set.

Adding the following at the top will do the trick (assuming
"marvell,armada370" is the right compatible string to use).

   	unsigned long root = of_get_flat_dt_root();

   	if (of_flat_dt_is_compatible(root, "marvell,armada370"))
   		return;

>
> Another option might be just to count the /cpu at n nodes.
