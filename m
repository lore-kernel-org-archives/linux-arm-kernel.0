From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Fri, 18 Nov 2016 08:54:30 +0530
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <3360559.T0zQaY0FJ3@wuerfel>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <20161114145143.GM1041@n2100.armlinux.org.uk>
 <fe90b6cc-81b1-772e-ab78-f2199957ec96@samsung.com>
 <CGME20161117170359epcas3p16c0c23136eb1ec0ba0c4e0a3307903cc@epcas3p1.samsung.com>
 <3360559.T0zQaY0FJ3@wuerfel>
Message-ID: <62d93a1f-fd34-771b-4280-6b7cde5c61ad@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 17 November 2016 10:33 PM, Arnd Bergmann wrote:
> On Thursday, November 17, 2016 9:50:27 AM CET pankaj.dubey wrote:
>>
>>>>> of_scu_enable() which _only_ looks up the SCU address in DT and enables
>>>>> it if it finds it, otherwise returning failure.
>>>>>
>>>>> a9_scu_enable() which tries to use the A9 provided SCU address and
>>>>> enables it if it finds it, otherwise returning failure.
>>>>>
>>
>> OK, In that case I can see need for following four helpers as:
>>
>> 1: of_scu_enable() which will __only__ lookup the SCU address in DT and
>> enables it if it finds, otherwise return -ENOMEM failure.
>> This helper APIs is required and sufficient for most of platforms such
>> as exynos, berlin, realview, socfpga, STi, ux500, vexpress, rockchip and
>> mvebu
>>
>> 2: a9_scu_enable(), which will __only__ use A9 provided SCU address and
>> enables it, if address mapped successfully, otherwise returning failure.
>> This helper APIs is required and sufficient for two ARM platforms as of
>> now tegra and hisi.
>>
>> 3: of_scu_get_base() which will lookup the SCU address in DT and if node
>> found maps address and returns ioremapped address to caller.
>> This helper APIs is required for three ARM plaforms rockchip, mvebu and
>> ux500, along with scu_enable() API to enable and find number_of_cores.
>>
>> 4: s9_scu_iomap_base() which will internally use s9_scu_get_base() and
>> do ioremap of scu address and returns ioremapped address to the caller
>> along with ownership (caller has responsibility to unmap it).
>> This helper APIs is required to simplify SCU enable and related code in
>> two ARM plaforms BCM ans ZX.
>>
>> For remaining two ARM platforms (IMX and ZYNQ), none of these helpers
>> are useful for the time-being, as they need SCU mapping very early of
>> boot, where we can't use iomap APIs. So I will drop patches related to
>> these platforms in v2 version.
>>
>> Please let me know if any concern in this approach.
> 
> I think ideally we wouldn't even need to know the virtual address
> outside of smp_scu.c. If we can move all users of the address
> into that file directly, it could become a local variable and
> we change scu_power_mode() and scu_get_core_count() instead to
> not require the address argument.
> 

If we change scu_get_core_count() without address argument, what about
those platforms which are calling this API very early boot (mostly in
smp_init_cpus), during this stage we can't use iomap. These platforms
are doing static mapping of SCU base, and passing virtual address.

Currently following are platforms which needs SCU virtual address at
very early stage mostly for calling scu_get_core_count(scu_address):
IMX, ZYNQ, SPEAr, and OMAP2.

I can think of handling of these platform's early need of SCU in the
following way:

Probably we need something like early_a9_scu_get_core_count() which can
be handled in this way in smp_scu.c file itself:

+static struct map_desc scu_map __initdata = {
+       .length = SZ_256,
+       .type   = MT_DEVICE,
+};
+
+static void __iomem *early_scu_map_io(void)
+{
+       unsigned long base;
+       void __iomem *scu_base;
+
+       base = scu_a9_get_base();
+       scu_map.pfn = __phys_to_pfn(base);
+       scu_map.virtual = base;
+       iotable_init(&scu_map, 1);
+       scu_base = (void __iomem *)base;
+       return scu_base;
+}
+
+/*
+ * early_a9_scu_get_core_count - Get number of CPU cores at very early boot
+ * Only platforms which needs number_of_cores during early boot should
call this
+ */
+unsigned int __init early_a9_scu_get_core_count(void)
+{
+       void __iomem *scu_base;
+
+       scu_base = early_scu_map_io();
+       return scu_get_core_count(scu_base);
+}
+

Please let me know how about using above approach to simplify platform
specific code of early users of SCU address.

Also for rest platforms, which are not using scu base at very early
stage, but are using virtual address which is mapped either from SCU
device node or using s9_scu_get_base() to map to SCU virtual address. To
separate these two we discussed to separate scu_enable in two helper
APIs as of_scu_enable and s9_scu_enable. So if we change
scu_get_core_count which do not requires address argument, this also
needs to be separated in two as of_scu_get_core_count and
s9_scu_get_core_count.


Thanks,
Pankaj Dubey

> The only user I could find outside of that file is
> 
> static int shmobile_smp_scu_psr_core_disabled(int cpu)
> {
>         unsigned long mask = SCU_PM_POWEROFF << (cpu * 8);
> 
>         if ((__raw_readl(shmobile_scu_base + 8) & mask) == mask)
>                 return 1;
> 
>         return 0;
> }
> 
> which can be done in the same file as well.
> 
>>>>> Then callers can decide which of these to call, and what error messages
>>>>> to print on their failures.
>>>>
>>>> Splitting the function in two is probably simpler overall, but
>>>> we may still have to look at all the callers: Any platform that
>>>> currently tries to map it on any CPU and doesn't warn about the
>>>> absence of the device node (or about scu_a9_has_base() == false)
>>>> should really continue not to warn about that.
>>>
>>> Did you miss the bit where none of of_scu_enable() or a9_scu_enable()
>>> should produce any warnings or errors to be printed.  It's up to the
>>> caller to report the failure, otherwise doing this doesn't make sense:
>>>
>>>       if (of_scu_enable() < 0 && a9_scu_enable() < 0)
>>>               pr_err("Failed to map and enable the SCU\n");
>>>
>>> because if of_scu_enable() prints a warning/error, then it's patently
>>> misleading.
>>>
> 
> That's why I said "otherwise we can leave the warning in the caller
> after checking the return code of the new APIs." for the case where
> we actually need it.
> 
>> I will move out error message out of these helpers and let caller
>> (platform specific code) handle and print error if required.
> 
> Ok.
> 
> 	Arnd
> 
> 
> 
