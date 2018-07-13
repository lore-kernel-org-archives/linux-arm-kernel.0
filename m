From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 13 Jul 2018 09:34:36 +0900
Subject: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
In-Reply-To: <20180712164918.GA26935@arm.com>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com>
Message-ID: <20180713003434.GZ28220@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
> Hi Akashi,
> 
> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
> > This patch series is a set of bug fixes to address kexec/kdump
> > failures which are sometimes observed on ACPI-only system and reported
> > in LAK-ML before.
> 
> I tried picking this up, along with Ard's fixup, but I'm seeing a build
> failure for allmodconfig:
> 
> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
> 
> I didn't investigate further. Please can you fix this?

Because CONFIG_ACPI is on and CONFIG_EFI is off.

This can happen in allmodconfig as CONFIG_EFI depends on
!CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.

Looking at __acpi_get_mem_attributes(), since there is no information
available on memory attributes, what we can do at best is
  * return PAGE_KERNEL (= cacheable) for mapped memory,
  * return DEVICE_nGnRnE (= non-cacheable) otherwise
(See a hunk to be applied on top of my patch#4.)

I think that, after applying, acpi_os_ioremap() would work almost
in the same way as the original before my patchset given that
MAP memblock attribute is used only under CONFIG_EFI for now.

Make sense?

-Takahiro AKASHI

> Will
---8<---
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index ed46dc188b22..cad3ed2666ef 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -238,6 +238,7 @@ void __init acpi_boot_table_init(void)
 
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 {
+#ifdef CONFIG_EFI
 	/*
 	 * According to "Table 8 Map: EFI memory types to AArch64 memory
 	 * types" of UEFI 2.5 section 2.3.6.1, each EFI memory type is
@@ -255,5 +256,9 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 		return __pgprot(PROT_NORMAL_WT);
 	if (attr & EFI_MEMORY_WC)
 		return __pgprot(PROT_NORMAL_NC);
+#else
+	if (memblock_is_map_memory(addr))
+		return PAGE_KERNEL;
+#endif
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
