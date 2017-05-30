From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 30 May 2017 18:36:40 +0000
Subject: [PATCH 0/7] ARM: efi: PE/COFF cleanup/hardening
Message-ID: <20170530183647.28557-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the ARM counterpart of the changes now in v4.12 to clean up
the PE/COFF header that makes the kernel zImage loadable directly from
UEFI, and to enhance it with hardening and debug features.

First of all, the cleanup consists of making the header comply with the
PE/COFF spec (#1), removing the .reloc section (#2) and replacing all
open coded constants with #defines from linux/pe.h

Patch #4 is a standalone patch that removes ksymtab/kcrctab sections that
may get pulled in inadvertently when the decompressor is built with EFI
support. Note that these sections are tiny and harmless by themselves, but
the linker may dump them in unexpected places if they are not placed
explicitly, which may interfere with the image layout. This is especially
important when signing zImages for UEFI secure boot.

Patch #5 changes the description of the decompressor in memory, so that the
UEFI firmware can apply strict ro/nx protections, resulting in a more secure
execution environment for the UEFI stub.

Patch #6 splits the decompressor .start and .text output sections, so that
the ELF view aligns with the PE/COFF view of the binary. This is useful for
debugging, but has no other benefits (or downsides, for that matter)

Patch #7 enhances the decompressor binary with a NB10 Codeview debug entry
referring to the path to arch/arm/boot/compressed/vmlinux on the build host.
This is another debug feature that allows seamless source level single step
debugging of the UEFI stub while executing in the context of the firmware.

Ard Biesheuvel (7):
  arm: efi: remove forbidden values from the PE/COFF header
  arm: efi: remove pointless dummy .reloc section
  arm: efi: replace open coded constants with symbolic ones
  arm: compressed: discard ksymtab/kcrctab sections
  arm: efi: split zImage code and data into separate PE/COFF sections
  arm: compressed: put zImage header and EFI header in dedicated section
  arm: efi: add PE/COFF debug table to EFI header

 arch/arm/boot/compressed/Makefile      |   4 +
 arch/arm/boot/compressed/efi-header.S  | 247 ++++++++++++--------
 arch/arm/boot/compressed/vmlinux.lds.S |  39 +++-
 3 files changed, 180 insertions(+), 110 deletions(-)

-- 
2.9.3
