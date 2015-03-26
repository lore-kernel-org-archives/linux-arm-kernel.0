From: will.deacon@arm.com (Will Deacon)
Date: Thu, 26 Mar 2015 15:15:10 +0000
Subject: [patch v11 12/23] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <20150325171735.GI14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org>
 <20150325171735.GI14585@localhost>
Message-ID: <20150326151510.GI2805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 05:17:35PM +0000, Catalin Marinas wrote:
> On Tue, Mar 24, 2015 at 10:02:45PM +0800, Hanjun Guo wrote:
> > +/**
> > + * acpi_map_gic_cpu_interface - generates a logical cpu number
> > + * and map to MPIDR represented by GICC structure
> > + * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
> > + * @enabled: this cpu is enabled or not
> > + *
> > + * Returns the logical cpu number which maps to MPIDR
> > + */
> > +static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
> 
> So here we have an u8 enabled.
> 
> > +static int __init
> > +acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
> > +				const unsigned long end)
> > +{
> > +	struct acpi_madt_generic_interrupt *processor;
> > +
> > +	processor = (struct acpi_madt_generic_interrupt *)header;
> > +
> > +	if (BAD_MADT_ENTRY(processor, end))
> > +		return -EINVAL;
> > +
> > +	acpi_table_print_madt_entry(header);
> > +
> > +	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
> > +		processor->flags & ACPI_MADT_ENABLED);
> 
> and here processor->flags is u32. Luckily, ACPI_MADT_ENABLED is 1 and we
> don't lose any information. So either make the enabled above a bool or
> simply pass the flags with the check in acpi_map_gic_cpu_interface()
> (personal preference for the latter).

I've applied the following patch on top of the series.

Will

--->8

commit 8ef320319592693f4a6286d80df210fd47b3e356
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Mar 26 15:09:20 2015 +0000

    ARM64 / ACPI: fix usage of acpi_map_gic_cpu_interface
    
    acpi_parse_gic_cpu_interface calls acpi_map_gic_cpu_interface by both
    passing a 32-bit value in the u8 enabled parameter and then subsequently
    ignoring its return value.
    
    Sort it out.
    
    Reported-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index cd60329da8c4..07649e413244 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -103,9 +103,12 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
  *
  * Returns the logical cpu number which maps to MPIDR
  */
-static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
+static int __init
+acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 {
 	int i;
+	u64 mpidr = processor->arm_mpidr & MPIDR_HWID_BITMASK;
+	bool enabled = !!(processor->flags & ACPI_MADT_ENABLED);
 
 	if (mpidr == INVALID_HWID) {
 		pr_info("Skip MADT cpu entry with invalid MPIDR\n");
@@ -178,11 +181,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(header);
-
-	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
-		processor->flags & ACPI_MADT_ENABLED);
-
-	return 0;
+	return acpi_map_gic_cpu_interface(processor);
 }
 
 /* Parse GIC cpu interface entries in MADT for SMP init */
