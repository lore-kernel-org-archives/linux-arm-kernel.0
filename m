From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Nov 2016 13:14:35 +0100
Subject: [PATCH 01/16] ARM: scu: Provide support for parsing SCU device
 node to enable SCU
In-Reply-To: <62d93a1f-fd34-771b-4280-6b7cde5c61ad@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <3360559.T0zQaY0FJ3@wuerfel>
 <62d93a1f-fd34-771b-4280-6b7cde5c61ad@samsung.com>
Message-ID: <9481995.AMBiYg893F@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 18, 2016 8:54:30 AM CET pankaj.dubey wrote:
> >> Please let me know if any concern in this approach.
> > 
> > I think ideally we wouldn't even need to know the virtual address
> > outside of smp_scu.c. If we can move all users of the address
> > into that file directly, it could become a local variable and
> > we change scu_power_mode() and scu_get_core_count() instead to
> > not require the address argument.
> > 
> 
> If we change scu_get_core_count() without address argument, what about
> those platforms which are calling this API very early boot (mostly in
> smp_init_cpus), during this stage we can't use iomap. These platforms
> are doing static mapping of SCU base, and passing virtual address.
> 
> Currently following are platforms which needs SCU virtual address at
> very early stage mostly for calling scu_get_core_count(scu_address):
> IMX, ZYNQ, SPEAr, and OMAP2.

Ah, you are right, I missed how this is done earlier than the
scu_enable() call.

> I can think of handling of these platform's early need of SCU in the
> following way:
> 
> Probably we need something like early_a9_scu_get_core_count() which can
> be handled in this way in smp_scu.c file itself:
> 
> +static struct map_desc scu_map __initdata = {
> +       .length = SZ_256,
> +       .type   = MT_DEVICE,
> +};
> +
> +static void __iomem *early_scu_map_io(void)
> +{
> +       unsigned long base;
> +       void __iomem *scu_base;
> +
> +       base = scu_a9_get_base();
> +       scu_map.pfn = __phys_to_pfn(base);
> +       scu_map.virtual = base;
> +       iotable_init(&scu_map, 1);
> +       scu_base = (void __iomem *)base;
> +       return scu_base;
> +}

Unfortunately, this doesn't work because scu_map.virtual must be
picked by the platform code in a way that doesn't conflict
with anything else.  Setting up the iotable is probably not
something we should move into the smp_scu.c file but leave where
it currently is. You copied the trick from zynq that happens
to work there but probably not on the other three.

At some point we decided that at least new platforms should
always get the core count from DT rather than from the SCU,
but I don't know if we have to keep supporting old DTB files
without a full description of the CPUs on any of the
four platforms.

I see that there are four other users of scu_get_core_count()
that all call it from ->prepare_cpus, and we can probably
just use num_possible_cpus() at that point as the count
must have been initialized from DT already. 

> +/*
> + * early_a9_scu_get_core_count - Get number of CPU cores at very early boot
> + * Only platforms which needs number_of_cores during early boot should
> call this
> + */
> +unsigned int __init early_a9_scu_get_core_count(void)
> +{
> +       void __iomem *scu_base;
> +
> +       scu_base = early_scu_map_io();
> +       return scu_get_core_count(scu_base);
> +}
> +
> 
> Please let me know how about using above approach to simplify platform
> specific code of early users of SCU address.
> 
> Also for rest platforms, which are not using scu base at very early
> stage, but are using virtual address which is mapped either from SCU
> device node or using s9_scu_get_base() to map to SCU virtual address. To
> separate these two we discussed to separate scu_enable in two helper
> APIs as of_scu_enable and s9_scu_enable. So if we change
> scu_get_core_count which do not requires address argument, this also
> needs to be separated in two as of_scu_get_core_count and
> s9_scu_get_core_count.

We can probably leave get_core_count code alone for now, or
we change it so that we pass a virtual address into it
from the platform and have the SCU mapped there. One nice
property of the early mapping is that the later ioremap()
will just return the same virtual address, so we don't get
a double mapping when calling the scu_enable variant later.

Adding two functions of each doesn't sound too great though,
it would make the API more complicated when the intention was
to make it simpler by leaving out the address argument.

Maybe something like this?

diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 72f9241ad5db..c248a16e980f 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -24,6 +24,8 @@
 #define SCU_INVALIDATE		0x0c
 #define SCU_FPGA_REVISION	0x10
 
+static void __iomem *scu_base_addr;
+
 #ifdef CONFIG_SMP
 /*
  * Get the number of CPU cores from the SCU configuration
@@ -41,6 +43,9 @@ void scu_enable(void __iomem *scu_base)
 {
 	u32 scu_ctrl;
 
+	if (scu_base)
+		scu_base = scu_base_addr;
+
 #ifdef CONFIG_ARM_ERRATA_764369
 	/* Cortex-A9 only */
 	if ((read_cpuid_id() & 0xff0ffff0) == 0x410fc090) {
@@ -85,6 +90,9 @@ int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 	unsigned int val;
 	int cpu = MPIDR_AFFINITY_LEVEL(cpu_logical_map(smp_processor_id()), 0);
 
+	if (scu_base)
+		scu_base = scu_base_addr;
+
 	if (mode > 3 || mode == 1 || cpu > 3)
 		return -EINVAL;
 
@@ -94,3 +102,31 @@ int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 
 	return 0;
 }
+
+int __init scu_probe_a9(void)
+{
+	phys_addr_t base;
+
+	if (!scu_a9_has_base)
+		return -ENODEV;
+
+	base = scu_a9_get_base()
+	if (!base)
+		return -ENODEV;
+
+	scu_base_addr = ioremap(base, PAGE_SIZE);
+	if (scu_base_addr)
+		return -ENOMEM;
+
+	return scu_get_core_count(scu_base_addr);
+}
+
+int __init scu_probe_dt(void)
+{
+	...
+	scu_base_addr = of_iomap(np, 0);
+	if (scu_base_addr)
+		return -ENOMEM;
+
+	return scu_get_core_count(scu_base_addr);
+}



	Arnd
