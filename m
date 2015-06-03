From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Wed, 3 Jun 2015 09:37:09 -0500
Subject: [V5 PATCH 2/5] arm64 : Introduce support for ACPI _CCA object
In-Reply-To: <1432867099.24429.4.camel@deneb.redhat.com>
References: <1432159758-4486-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1432159758-4486-3-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1432867099.24429.4.camel@deneb.redhat.com>
Message-ID: <556F1115.3080302@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/28/2015 9:38 PM, Mark Salter wrote:
> On Wed, 2015-05-20 at 17:09 -0500, Suravee Suthikulpanit wrote:
>> >Fromhttp://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf,
>> >section 6.2.17 _CCA states that ARM platforms require ACPI _CCA
>> >object to be specified for DMA-cabpable devices. Therefore, this patch
>> >specifies ACPI_CCA_REQUIRED in arm64 Kconfig.
>> >
>> >In addition, to handle the case when _CCA is missing, arm64 would assign
>> >dummy_dma_ops to disable DMA capability of the device.
>> >
>> >Acked-by: Catalin Marinas<catalin.marinas@arm.com>
>> >Signed-off-by: Mark Salter<msalter@redhat.com>
>> >Signed-off-by: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.com>
>> >---
>> >  arch/arm64/Kconfig                   |  1 +
>> >  arch/arm64/include/asm/dma-mapping.h | 18 ++++++-
>> >  arch/arm64/mm/dma-mapping.c          | 92 ++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 109 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> >index 4269dba..95307b4 100644
>> >--- a/arch/arm64/Kconfig
>> >+++ b/arch/arm64/Kconfig
>> >@@ -1,5 +1,6 @@
>> >  config ARM64
>> >  	def_bool y
>> >+	select ACPI_CCA_REQUIRED if ACPI
>> >  	select ACPI_GENERIC_GSI if ACPI
>> >  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>> >  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>> >diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
>> >index 9437e3d..f0d6d0b 100644
>> >--- a/arch/arm64/include/asm/dma-mapping.h
>> >+++ b/arch/arm64/include/asm/dma-mapping.h
>> >@@ -18,6 +18,7 @@
>> >
>> >  #ifdef __KERNEL__
>> >
>> >+#include <linux/acpi.h>
>> >  #include <linux/types.h>
>> >  #include <linux/vmalloc.h>
>> >
> ^^^ This hunk causes build issues with a couple of drivers:
>
> drivers/scsi/megaraid/megaraid_sas_fp.c:69:0: warning: "FALSE" redefined [enabled by default]
>   #define FALSE 0
>   ^
> In file included from include/acpi/acpi.h:58:0,
>                   from include/linux/acpi.h:37,
>                   from ./arch/arm64/include/asm/dma-mapping.h:21,
>                   from include/linux/dma-mapping.h:86,
>                   from ./arch/arm64/include/asm/pci.h:7,
>                   from include/linux/pci.h:1460,
>                   from drivers/scsi/megaraid/megaraid_sas_fp.c:37:
> include/acpi/actypes.h:433:0: note: this is the location of the previous definition
>   #define FALSE                           (1 == 0)
>   ^
>
>
> In file included from include/acpi/acpi.h:58:0,
>                   from include/linux/acpi.h:37,
>                   from ./arch/arm64/include/asm/dma-mapping.h:21,
>                   from include/linux/dma-mapping.h:86,
>                   from include/scsi/scsi_cmnd.h:4,
>                   from drivers/scsi/ufs/ufshcd.h:60,
>                   from drivers/scsi/ufs/ufshcd.c:43:
> include/acpi/actypes.h:433:41: error: expected identifier before ?(? token
>   #define FALSE                           (1 == 0)
>                                           ^
> drivers/scsi/ufs/unipro.h:203:2: note: in expansion of macro ?FALSE?
>    FALSE = 0,
>    ^
>
> This happens because the ACPI definitions of TRUE and FALSE conflict
> with local definitions in megaraid and enum declaration in ufs.
>
Mark,

Thanks for pointing this out. Although, I would think that the 
megaraid_sas_fp.c should have had the #ifndef to check before defining 
the TRUE and FALSE as following.

#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

This seems to be what other drivers are also doing. If this is okay, I 
can send out a fix-up patch for the megaraid driver.

Thanks,

Suravee
