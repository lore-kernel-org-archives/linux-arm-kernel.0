From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Oct 2015 14:40:56 +0100
Subject: [PATCH 0/3] remove UEFI reserved regions from the linear mapping
Message-ID: <1446126059-25336-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is yet another approach to solving the issues around removing RAM
regions known to UEFI from the linear mapping while preserving the record
of the fact that these regions are backed by memory.

The previous approach added a memblock flag called MEMBLOCK_NOMAP to keep
track of RAM regions that should be removed from the linear mapping.

The primary motivation for the new approach is the observation that there
is only a single use case that requires this, which is acpi_os_ioremap().
Since ACPI implies UEFI on arm64 platforms, and since acpi_os_ioremap()
uses page_is_ram() internally (which is a __weak generic function), we
can simply reimplement page_is_ram() to take the UEFI memory map into
account if we are booted via UEFI.

Once we have a page_is_ram() implementation in place that will return true
even for RAM that is known to UEFI but not covered by the linear mapping,
we can remove all UEFI reserved and runtime regions from the linear mapping
as well.

As is obvious from the diffstat, this is the approach with the least impact,
both in terms of number of changes and in terms of the locality of the changes.
If we end up needing this information for other reasons (e.g., /dev/mem access
to /reserved-memory subnodes with the nomap property on !EFI systems), we can
always revisit this, but for now, I think this approach is the most suitable.

Patch #1 slightly reorders the UEFI runtime services initialization routines
so that the EFI_MEMMAP flag is only set if the permanent mapping of the UEFI
memory map is in place.

Patch #2 reimplements page_is_ram() for arm64.

Patch #3 updates the UEFI init code to remove the UEFI runtime regions and the
UEFI memory map from the linear mapping.

Ard Biesheuvel (3):
  arm64/efi: set EFI_MEMMAP bit only after mapping the memory map
  arm64: reimplement page_is_ram() using memblock and UEFI memory map
  arm64/efi: memblock_remove() rather than _reserve UEFI reserved memory

 arch/arm64/kernel/efi.c | 39 ++++++++++----------
 arch/arm64/mm/mmu.c     | 34 +++++++++++++++++
 2 files changed, 54 insertions(+), 19 deletions(-)

-- 
2.1.4
