From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 16:14:29 +0100
Subject: [PATCH 0/3] arm64: Avoid overlapping EFI regions
Message-ID: <1464707672-21882-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aim of this series is to avoid the pud/pmd splitting in the arm64
create_pgd_mapping() code. AFAICT, efi_create_mapping() was the last
user to generate overlapping mappings. If I'm mistaken and this is not
the last user, we have to fix the rest as well.

The EFI memory map on my Juno looks like this:

[    0.000000] efi: Processing EFI memory map:
[    0.000000] efi:   0x000008000000-0x00000bffffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x00001c170000-0x00001c170fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
[    0.000000] efi:   0x000080000000-0x00008007ffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x000080080000-0x000080d8ffff [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x000080d90000-0x00009fdfffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x00009fe00000-0x00009fe0ffff [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x00009fe10000-0x0000dfffffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0000e00f0000-0x0000febd5fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0000febd6000-0x0000febd9fff [ACPI Reclaim Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0000febda000-0x0000febdafff [ACPI Memory NVS    |   |  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0000febdb000-0x0000febdcfff [ACPI Reclaim Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0000febdd000-0x0000feffffff [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x000880000000-0x0009f9644fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009f9645000-0x0009f9646fff [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009f9647000-0x0009fa356fff [Loader Code        |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009fa357000-0x0009faf6efff [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009faf6f000-0x0009fafa9fff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0009fafaa000-0x0009ff2b1fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009ff2b2000-0x0009ffb70fff [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009ffb71000-0x0009ffb89fff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009ffb8a000-0x0009ffb8dfff [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009ffb8e000-0x0009ffb8efff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009ffb8f000-0x0009ffdddfff [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009ffdde000-0x0009ffe5ffff [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009ffe60000-0x0009ffe76fff [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009ffe77000-0x0009fff6dfff [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC]
[    0.000000] efi:   0x0009fff6e000-0x0009fffaefff [Runtime Code       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0009fffaf000-0x0009ffffefff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
[    0.000000] efi:   0x0009fffff000-0x0009ffffffff [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC]

Catalin Marinas (3):
  efi: Introduce *_continue efi_memory_desc iterators
  arm64: efi: Ensure efi_create_mapping() does not map overlapping
    regions
  arm64: mm: Remove split_p*d() functions

 arch/arm64/kernel/efi.c | 22 +++++++++++++++++++---
 arch/arm64/mm/mmu.c     | 47 ++++-------------------------------------------
 include/linux/efi.h     | 19 +++++++++++++++++--
 3 files changed, 40 insertions(+), 48 deletions(-)
