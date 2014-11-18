From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Tue, 18 Nov 2014 19:43:54 +0000
Subject: [RFC PATCHv2] ARM: mvebu: Let the device-tree determine smp_ops
In-Reply-To: <20141118082151.GX6414@lukather>
References: <20141106201603.GF4974@lunn.ch>
 <1415327626-16079-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141117095640.03e25d17@free-electrons.com>
 <alpine.DEB.2.10.1411181233160.902@chrisp-dl.ws.atlnz.lc>
 <546A9378.2080907@alliedtelesis.co.nz> <20141118082151.GX6414@lukather>
Message-ID: <546BA17A.40502@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 11/18/2014 09:21 PM, Maxime Ripard wrote:
> On Tue, Nov 18, 2014 at 12:31:52AM +0000, Chris Packham wrote:
>>
>>
>> On 11/18/2014 12:34 PM, Chris Packham wrote:
>>> Hi Thomas, Maxime
>>>
>>> On Mon, 17 Nov 2014, Thomas Petazzoni wrote:
>>>
>>>> Dear Chris Packham,
>>>>
>>>> On Fri,  7 Nov 2014 15:33:46 +1300, Chris Packham wrote:
>>>>> The machine specific SMP operations can be configured either via
>>>>> setup_arch or via arm_dt_init_cpu_maps. For the ARMADA_370_XP_DT devices
>>>>> both of these are called and setup_arch wins because it is called last.
>>>>> This means that it is not possible to substitute a different set of SMP
>>>>> operations via the device-tree.
>>>>>
>>>>> For the ARMADA_370_XP_DT compatible devices add a smp_init function that
>>>>> detects if the device tree has an enable-method defined. If it does
>>>>> return true to indicate that the smp_ops have already been set which
>>>>> will prevent setup_arch from overriding them.
>>>>>
>>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>>
>>>> My colleague Maxime Ripard (in Cc) rightfully suggests exploring a
>>>> different option: what about getting rid completely of the .smp field
>>>> of the DT_MACHINE structure, and instead have some code run early
>>>> enough that looks if an enable-method is defined, and if not, defines
>>>> it to the default value. This way, we continue to be backward
>>>> compatible in terms of DT, but we always use the enable-method from the
>>>> DT, and not sometimes from DT, sometimes from the DT_MACHINE structure.
>>>>
>>>> Unfortunately, it will have to be done on the flattened DT, because the
>>>> DT is unflattened right before the enable-method properties are looked
>>>> up:
>>>>
>>>>         unflatten_device_tree();
>>>>
>>>>         arm_dt_init_cpu_maps();
>>>>
>>>> And manipulating the DT in its flattened format, while possible in
>>>> ->dt_fixup(), is a pain, and probably doesn't allow adding new
>>>> properties anyway.
>>>>
>>>> So, in the end, maybe this idea doesn't work, I haven't checked
>>>> completely.
>>>>
>>>
>>> So yeah it's tricky to work with the flattened dt. Not impossible the
>>> powerpc arch code does quite a lot with it. Arm does less but still uses
>>> it in atags_to_fdt.c. Below is a rough attempt at an implementation that
>>> seems to work. Because of the flattened dt it's harder to iterate
>>> through the cpu nodes so I haven't implemented anything to look for an
>>> enable-method attached to them.
>>
>> (I really need to figure out how to tell Thunderbird how to wrap some
>> parts but not others)
>>
>>>
>>> ---- 8< ----
>>> Subject: [PATCH] ARM: mvebu: use dt_fixup to provide fallback for
>>>    enable-method
>>>
>>> When the device tree doesn't define an enable-method insert a property
>>> into the flattened device tree. arm_dt_init_cpu_maps() will then parse
>>> this an set smp_ops appropriately. Now that we have this fallback it is
>>> no longer necessary to set .smp in the DT_MACHINE definition.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>    arch/arm/mach-mvebu/Makefile   |  2 ++
>>>    arch/arm/mach-mvebu/board-v7.c | 23 ++++++++++++++++++++++-
>>>    2 files changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
>>> index 1636cdb..f818eaf 100644
>>> --- a/arch/arm/mach-mvebu/Makefile
>>> +++ b/arch/arm/mach-mvebu/Makefile
>>> @@ -14,3 +14,5 @@ endif
>>>
>>>    obj-$(CONFIG_MACH_DOVE)         += dove.o
>>>    obj-$(CONFIG_MACH_KIRKWOOD)     += kirkwood.o kirkwood-pm.o
>>> +
>>> +CFLAGS_board-v7.o = -I$(src)/../../../scripts/dtc/libfdt
>>> \ No newline at end of file
>>> diff --git a/arch/arm/mach-mvebu/board-v7.c
>>> b/arch/arm/mach-mvebu/board-v7.c
>>> index b2524d6..45851a2 100644
>>> --- a/arch/arm/mach-mvebu/board-v7.c
>>> +++ b/arch/arm/mach-mvebu/board-v7.c
>>> @@ -17,6 +17,8 @@
>>>    #include <linux/clk-provider.h>
>>>    #include <linux/of_address.h>
>>>    #include <linux/of_platform.h>
>>> +#include <linux/of_fdt.h>
>>> +#include <linux/libfdt.h>
>>>    #include <linux/io.h>
>>>    #include <linux/clocksource.h>
>>>    #include <linux/dma-mapping.h>
>>> @@ -184,6 +186,25 @@ static void __init mvebu_dt_init(void)
>>>        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>>    }
>>>
>>> +static void __init armada_370_xp_dt_fixup(void)
>>> +{
>>> +    void *prop;
>>> +    int offset;
>>> +    int len;
>>> +
>>> +    offset = fdt_path_offset(initial_boot_params, "/cpus");
>>> +    prop = fdt_getprop(initial_boot_params, offset, "enable-method",
>>> &len);
>>> +
>>> +    if (!prop) {
>>> +        pr_info("No enable-method defined. "
>>> +            "Falling back to \"marvell,armada-xp-smp\"\n");
>>> +
>>> +        fdt_appendprop(initial_boot_params, offset, "enable-method",
>>> +                   "marvell,armada-xp-smp",
>>> +                   sizeof("marvell,armada-xp-smp"));
>>
>> Instead of inserting something into the device tree I could just call
>> set_smp_ops here. That might be safer than trying to insert something
>> into the device tree.
>
> I don't think this is necessary. Injecting something in the DT is
> safe, u-boot does that at every boot :)
>

Actually I thought a bit more about this option this morning. What I'm 
trying to do is provide a fallback that defines smp_ops when there isn't 
an enable-method in the device tree. I don't actually need do do 
anything to the incoming device tree, I don't even need to look at it. I 
can unconditionally call set_smp_ops() and if the device tree has an 
enable-method it will override whatever has been configured. If the 
device tree doesn't define an enable-method it will use the default that 
I've configured here. That's actually very little code and can all be 
contained in board-v7.c.
