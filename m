From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 Mar 2017 19:00:43 +0000
Subject: [PATCH v3 0/8] arm64: efi: PE/COFF cleanup/hardening
Message-ID: <20170323190051.14882-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This cleans up the PE/COFF EFI header, by taking some of Mark's patches
and use them to replace open coded constants with symbolic ones, and
remove incorrect values or unused sections.

Finally, it updates the section layout so that the kernel Image can be
mapped in a way that does not require setting RWX permissions anywhere.
Note that this is currently not a huge win, given that most current UEFI
implementations map all of RAM RWX by default, but this is finally gaining
some attention in the Tianocore community, and patches have been merged into
EDK2 to apply strict permissions to all of memory (to the extent possible
without breaking loaders like GRUB that assume EFI_LOADER_DATA memory is
mapped executable)

Changes since v2:
- drop ARM patches for now
- rebase onto today's arm64 for-next/core

Changes since v1:
- added missing secondary SOB on Mark's patches
- leave Image header as before, only move the PE header to a separate file
- put PE header fixes in a separate patch
- add acks from Mark and Peter (#6)
- give ARM the same treatment as arm64 (#10 - #13)
- add NB10 PE debuglink entry to ARM PE/COFF header as well (#9, #14)

Ard Biesheuvel (6):
  arm64: efi: move EFI header and related data to a separate .S file
  arm64: efi: clean up Image header after PE header has been split off
  arm64: efi: remove forbidden values from the PE/COFF header
  arm64: efi: remove pointless dummy .reloc section
  arm64: efi: replace open coded constants with symbolic ones
  arm64: efi: split Image code and data into separate PE/COFF sections

Mark Rutland (2):
  include: pe.h: allow for use in assembly
  include: pe.h: add some missing definitions

 arch/arm64/kernel/efi-header.S  | 155 +++++++++++++++++
 arch/arm64/kernel/head.S        | 162 +-----------------
 arch/arm64/kernel/vmlinux.lds.S |   2 +
 include/linux/pe.h              | 177 ++++++++++----------
 4 files changed, 255 insertions(+), 241 deletions(-)
 create mode 100644 arch/arm64/kernel/efi-header.S

-- 
2.9.3
