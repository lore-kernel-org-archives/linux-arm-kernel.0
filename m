From: chrisp@alliedtelesis.co.nz (Chris Packham)
Date: Sat, 3 Jan 2015 10:51:35 +1300 (NZDT)
Subject: [RFC/PATCHv2 2/5] ARM: mvebu: use dt_fixup to provide fallback
 for enable-method
In-Reply-To: <CAL_JsqJggc9+xaY5gkEa9_LeJUfcD-HOcD+=ZVjQbSTG6x2RhA@mail.gmail.com>
References: <1419369212-17047-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <1419369212-17047-3-git-send-email-chris.packham@alliedtelesis.co.nz>
 <CAL_JsqJggc9+xaY5gkEa9_LeJUfcD-HOcD+=ZVjQbSTG6x2RhA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1501031022030.12776@chrisp-dl.ws.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Sat, 27 Dec 2014, Rob Herring wrote:

> On Tue, Dec 23, 2014 at 3:13 PM, Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
>> When the device tree doesn't define an enable-method insert a property
>> into the flattened device tree. arm_dt_init_cpu_maps() will then parse
>> this an set smp_ops appropriately. Now that we have this fallback it is
>> no longer necessary to set .smp in the DT_MACHINE definition.
>> Additionally Armada 370, which is a single core device, no longer has any
>> smp operations defined.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>> As Arnd and Maxime suggested this replaces the unconditional setting of
>> smp_ops[1] with a fixup that inserts an appropriate property in the
>> device-tree if needed. It turned out not to be terribly tricky to
>> implement that checked each possible CPU node. One assumption I've made
>> is that the cpu nodes are numbered contiguously but that seems to be
>> reasonable.
>
> In general, that's not a good assumption, but may be okay for Armada.
>

I guess that should read "reasonable for Armada". This is a Armada 
specific fixup so I think that's OK. Still it wouldn't hurt to remove the 
break and just iterate from 0 to NR_CPUS.

>> [1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309766.html
>
> I'm not really convinced this is better than a 1-line function...
>

Arnd, Maxime care to comment? I'm good either way. One justification was 
that we were using a function called "dt_fixup" to do something other than 
maniplulate the device tree. We could add a new function pointer for this 
but I think I'm a bit too much of a newbie to start adding new 
machine_desc functions and modifying core code.

>>
>>  arch/arm/mach-mvebu/board-v7.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
>> index d0d39f1..08eb6a9 100644
>> --- a/arch/arm/mach-mvebu/board-v7.c
>> +++ b/arch/arm/mach-mvebu/board-v7.c
>> @@ -17,6 +17,8 @@
>>  #include <linux/clk-provider.h>
>>  #include <linux/of_address.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/of_fdt.h>
>> +#include <linux/libfdt.h>
>>  #include <linux/io.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/dma-mapping.h>
>> @@ -198,6 +200,44 @@ static void __init mvebu_dt_init(void)
>>         of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
>>
>> +static void __init armada_370_xp_dt_fixup(void)
>> +{
>> +       int offset, node;
>> +       int i, len;
>> +       void *prop;
>> +       char buffer[20];
>> +       unsigned long root = of_get_flat_dt_root();
>> +
>> +       if (!IS_ENABLED(CONFIG_SMP) ||
>
> This doesn't need to be conditional on SMP. You should fixup the DT
> independent of kernel options.
>

Will remove in the next round.

>> +           !of_flat_dt_is_compatible(root, "marvell,armadaxp"))
>> +               return;
>> +
>> +       offset = fdt_path_offset(initial_boot_params, "/cpus");
>> +       if (offset < 0)
>> +               return;
>> +
>> +       prop = fdt_getprop(initial_boot_params, offset, "enable-method", &len);
>> +       if (prop)
>> +               return;
>> +
>> +       for (i = 0; i < NR_CPUS; i++) {
>> +               snprintf(buffer, sizeof(buffer), "cpu@%d", i);
>> +               node = fdt_subnode_offset(initial_boot_params, offset, buffer);
>
> You can use fdt_node_offset_by_compatible with the cpu compatible
> string here instead.
>

I'll look into that for the next version. Will 
fdt_node_offset_by_compatible() allow me to iterate through all nodes with 
that compatible string?

>> +               if (node < 0)
>> +                       break;
>> +               prop = fdt_getprop(initial_boot_params, node,
>> +                                  "enable-method", &len);
>
> Do you really need to search thru all of the nodes? enable-method
> should either be present on all or none.
>

I'm following what arm_dt_init_cpu_maps does. I agree that these days a 
valid device tree should have this set for every cpu node but we're trying 
to be compaitble with older dtbs.

>> +               if (prop)
>> +                       return;
>> +       }
>> +
>> +       pr_info("No enable-method defined. "
>> +               "Falling back to \"marvell,armada-xp-smp\"\n");
>> +
>> +       fdt_setprop(initial_boot_params, offset, "enable-method",
>> +                   "marvell,armada-xp-smp", sizeof("marvell,armada-xp-smp"));
>
> Use fdt_setprop_string here.

Will do in the next round.

>
> enable-method is supposed to be a per cpu property. The Marvell berlin
> binding is wrong here and should not be copied.
>

Are you suggesting that I set the enable-method on the individual CPU 
nodes instead of /cpus? That would be easy enough to do and 
arm_dt_init_cpu_maps would do the right thing.

One consideration is a device-tree with an enable-method on /cpu at 2 but not 
on /cpu at 1. The existing code would handle this, after this proposed change 
we'd set the enable-method on /cpu at 1 negating the effect of it being set 
on /cpu at 2. This is a pretty contrived example, I'm not sure that such a 
device tree exists. We probably do need to handle the case of the 
enable-method being set on /cpus and not the individual nodes.

> Rob
>
>> +}
>> +
>>  static const char * const armada_370_xp_dt_compat[] = {
>>         "marvell,armada-370-xp",
>>         NULL,
>> @@ -206,11 +246,11 @@ static const char * const armada_370_xp_dt_compat[] = {
>>  DT_MACHINE_START(ARMADA_370_XP_DT, "Marvell Armada 370/XP (Device Tree)")
>>         .l2c_aux_val    = 0,
>>         .l2c_aux_mask   = ~0,
>> -       .smp            = smp_ops(armada_xp_smp_ops),
>>         .init_machine   = mvebu_dt_init,
>>         .init_irq       = mvebu_init_irq,
>>         .restart        = mvebu_restart,
>>         .dt_compat      = armada_370_xp_dt_compat,
>> +       .dt_fixup       = armada_370_xp_dt_fixup,
>>  MACHINE_END
>>
>>  static const char * const armada_375_dt_compat[] = {
>> --
>> 2.2.0.rc0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
