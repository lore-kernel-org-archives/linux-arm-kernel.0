From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 9 Sep 2016 12:18:11 +0900
Subject: [PATCH v3 2/3] hwmon: xgene: Add hwmon driver
In-Reply-To: <57D141DF.2010603@arm.com>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
 <13081573.BbD3TmEU5Y@wuerfel> <20160907223705.GA31582@roeck-us.net>
 <2992356.ULGoZEEDZp@wuerfel> <57D141DF.2010603@arm.com>
Message-ID: <20160909031809.GG16712@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 11:47:59AM +0100, James Morse wrote:
> Hi,
> 
> On 08/09/16 09:14, Arnd Bergmann wrote:
> > On Wednesday, September 7, 2016 3:37:05 PM CEST Guenter Roeck wrote:
> >> On Wed, Sep 07, 2016 at 11:41:44PM +0200, Arnd Bergmann wrote:
> >>> On Thursday, July 21, 2016 1:55:56 PM CEST Hoan Tran wrote:
> >>>> +               ctx->comm_base_addr = cppc_ss->base_address;
> >>>> +               if (ctx->comm_base_addr) {
> >>>> +                       ctx->pcc_comm_addr =
> >>>> +                                       acpi_os_ioremap(ctx->comm_base_addr,
> >>>> +                                                       cppc_ss->length);
> >>>>
> >>>
> >>> This causes the arm64 allmodconfig build to fail now, according to
> >>> kernelci:
> >>>
> >>>       1  ERROR: "memblock_is_memory" [drivers/hwmon/xgene-hwmon.ko] undefined!
> >>>
> >>> Should this perhaps call ioremap() or memremap() instead?
> >>>
> >> Hmmm ... almost sounds to me like blaming the messenger. e7cd190385d1 ("arm64:
> >> mark reserved memblock regions explicitly in iomem") starts using a function
> >> in acpi_os_ioremap() which is not exported. On top of that, memblock_is_memory()
> >> is declared as __init_memblock, which makes me really uncomfortable.
> >> If acpi_os_ioremap() must not be used by modules, and possibly only during
> >> early (?) initialization, maybe its declaration should state those limitations ?
> > 
> > Ah, I didn't notice that. I guess both patches were correct individually and
> > got added to linux-next around the same time but caused allmodconfig to blow up
> > when used together.
> > 
> > Adding everyone who was involved in the memblock patch to Cc here, maybe one
> > of them has an idea what the correct fix is. There are only two other drivers
> > using acpi_os_ioremap() and one of them is x86-specific, so it's still likely
> > that drivers are not actually supposed to use this symbol. Making
> > acpi_os_ioremap() an exported function in arm64 would also work.
> 
> You could use acpi_os_map_iomem()/acpi_os_unmap_iomem() from acpi/acpi_io.h.
> If there isn't an existing mapping these end up in acpi_os_ioremap(), and are
> already EXPORT_SYMBOL_GPL().

acpi_os_ioremap() is re-defined in arm64/include/asm/acpi.h.

The problem is that, as memblock_is_memory() is declared as __init,
we cannot build any drivers which call acpi_os_ioremap() as modules.

As far as this specific issue is concerned, if we make a change like:

===8<===
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -207,7 +207,7 @@ static void __init request_standard_resources(void)
                res = alloc_bootmem_low(sizeof(*res));
                if (memblock_is_nomap(region)) {
                        res->name  = "reserved";
-                       res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+                       res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
                } else {
                        res->name  = "System RAM";
                        res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
===>8===

and revert the following hunk from the commit:

===8<===
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -12,7 +12,7 @@
 #ifndef _ASM_ACPI_H
 #define _ASM_ACPI_H
 
-#include <linux/mm.h>
+#include <linux/memblock.h>
 #include <linux/psci.h>
 
 #include <asm/cputype.h>
@@ -32,7 +32,11 @@
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
                                            acpi_size size)
 {
-       if (!page_is_ram(phys >> PAGE_SHIFT))
+       /*
+        * EFI's reserve_regions() call adds memory with the WB attribute
+        * to memblock via early_init_dt_add_memory_arch().
+        */
+       if (!memblock_is_memory(phys))
                return ioremap(phys, size);
 
        return ioremap_cache(phys, size);
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
===>8===

The build error will be gone. (and still kdump should work.)

But I don't know how we should distinguish IORESOURCE_MEM and
IORESOURCE_SYSTEM_RAM.

Thanks,
-Takahiro AKASHI

> (I'm still waiting for allmodconfig on linux-next to finish building)
> 
> 
> Thanks,
> 
> James
> 
> 
