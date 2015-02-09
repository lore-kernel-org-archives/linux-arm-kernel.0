From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Feb 2015 09:52:48 +0000
Subject: [PATCH v8 14/21] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <20150209065512.GK13969@arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-15-git-send-email-hanjun.guo@linaro.org>
 <20150209065512.GK13969@arm.com>
Message-ID: <20150209095248.GB16587@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 09, 2015 at 06:55:12AM +0000, Will Deacon wrote:
> On Mon, Feb 02, 2015 at 12:45:42PM +0000, Hanjun Guo wrote:
> > Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obtained
> > from the GICC Structure introduced by ACPI 5.1.
> > 
> > MPIDR is the CPU hardware ID as local APIC ID on x86 platform, so we use
> > MPIDR not the GIC CPU interface ID to identify CPUs.
> > 
> > Further steps would typedef a phys_id_t for in arch code(with
> > appropriate size and a corresponding invalid value, say ~0) and use that
> > instead of an int in drivers/acpi/processor_core.c to store phys_id, then
> > no need for mpidr packing.
> > 
> > CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> > CC: Catalin Marinas <catalin.marinas@arm.com>
> > CC: Will Deacon <will.deacon@arm.com>
> > Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Tested-by: Yijing Wang <wangyijing@huawei.com>
> > Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> > Tested-by: Jon Masters <jcm@redhat.com>
> > Tested-by: Timur Tabi <timur@codeaurora.org>
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  arch/arm64/include/asm/acpi.h | 30 ++++++++++++++++++++++++++++++
> >  drivers/acpi/processor_core.c | 37 +++++++++++++++++++++++++++++++++++++
> >  2 files changed, 67 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > index 8984aa5..7e825b9 100644
> > --- a/arch/arm64/include/asm/acpi.h
> > +++ b/arch/arm64/include/asm/acpi.h
> > @@ -12,6 +12,8 @@
> >  #ifndef _ASM_ACPI_H
> >  #define _ASM_ACPI_H
> >  
> > +#include <asm/smp_plat.h>
> > +
> >  /* Basic configuration for ACPI */
> >  #ifdef	CONFIG_ACPI
> >  #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
> > @@ -45,6 +47,34 @@ static inline void enable_acpi(void)
> >  	acpi_noirq = 0;
> >  }
> >  
> > +/* MPIDR value provided in GICC structure is 64 bits, but the
> > + * existing phys_id (CPU hardware ID) using in acpi processor
> > + * driver is 32-bit, to conform to the same datatype we need
> > + * to repack the GICC structure MPIDR.
> > + *
> > + * bits other than following 32 bits are defined as 0, so it
> > + * will be no information lost after repacked.
> > + *
> > + * Bits [0:7] Aff0;
> > + * Bits [8:15] Aff1;
> > + * Bits [16:23] Aff2;
> > + * Bits [32:39] Aff3;
> > + */
> > +static inline u32 pack_mpidr(u64 mpidr)
> > +{
> > +	return (u32) ((mpidr & 0xff00000000) >> 8) | mpidr;
> > +}
> 
> I'm a bit puzzled by this packing:
> 
>   - Bit 31 of the MPIDR is RES1. Do we need to mask it out first?
>   - How does this work for uniprocessor systems where bit 30 is set?

I asked about this on a previous version of the patches but the comment
was only clarified in the map_gicc_mpidr() function (which duplicates
the packing here). This is not the real MPIDR but the one passed from
ACPI tables, so bits 24-31 are 0.

>   - Similarly for mythical multi-threaded implementations with bit 24 set.

Anyway, as I posted here:

http://article.gmane.org/gmane.linux.acpi.devel/73422

I think this function should go. I don't see the point of MPIDR packing
just because we can't use a proper 64-bit type here.

-- 
Catalin
