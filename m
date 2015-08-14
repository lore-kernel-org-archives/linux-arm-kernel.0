From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Aug 2015 14:14:28 +0100
Subject: [PATCH 1/3] Honor ACPI _CCA attribute setting
In-Reply-To: <55CD4832.7070301@amd.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
 <1439416290-21228-2-git-send-email-jeremy.linton@arm.com>
 <55CD4832.7070301@amd.com>
Message-ID: <20150814131427.GD16368@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 08:45:22AM +0700, Suravee Suthikulpanit wrote:
> On 8/13/15 04:51, Jeremy Linton wrote:
> >ACPI configurations can now mark devices as noncoherent,
> >support that choice.
> >
> >Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> >---
> >  include/acpi/acpi_bus.h | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> >diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> >index 83061ca..7ecb8e4 100644
> >--- a/include/acpi/acpi_bus.h
> >+++ b/include/acpi/acpi_bus.h
> >@@ -399,7 +399,7 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
> >  	 * case 1. Do not support and disable DMA.
> >  	 * case 2. Support but rely on arch-specific cache maintenance for
> >  	 *         non-coherence DMA operations.
> >-	 * Currently, we implement case 1 above.
> >+	 * Currently, we implement case 2 above.
> >  	 *
> >  	 * For the case when _CCA is missing (i.e. cca_seen=0) and
> >  	 * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
> >@@ -407,7 +407,8 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
> >  	 *
> >  	 * See acpi_init_coherency() for more info.
> >  	 */
> >-	if (adev->flags.coherent_dma) {
> >+	if (adev->flags.coherent_dma ||
> >+	    (adev->flags.cca_seen && IS_ENABLED(CONFIG_ARM64))) {
> >  		ret = true;
> >  		if (coherent)
> >  			*coherent = adev->flags.coherent_dma;
> >
> 
> This change was in my earlier revisions for the original patch series to add
> ACPI CCA support. At the time, this was pushed back since we were not sure
> whether this would be a useful case, and whether such hardware exists.
> 
> Would it be useful to document somewhere (may be in the GIT commit message)
> about which hardware might need this?

So far, it's the ARM Juno development board (the emphasis here is on
being able to use it for development, not a production system).

I think the commit log should also give you credit for the original
implementation.

> Arnd/Catalin, any feedback on this?

That's where it was left in the previous thread:

https://lkml.org/lkml/2015/5/21/376

(and I'll refrain from further comments ;))

-- 
Catalin
