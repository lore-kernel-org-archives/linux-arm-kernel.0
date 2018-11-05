From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Nov 2018 19:44:32 +0100
Subject: [PATCH 0/6] ARM: compressed: clean up section layout and enable EFI
 debugging
Message-ID: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the decompressor section layout is somewhat unusual: head.S
puts code into a .start and a .text section, which are expected to be
emitted back to back, unless other objects are included that define a
.start section as well, in which case execution is expected to proceed 
linearly from head.S's section .start section into the other .start
section and then onward into head.S's .text section.

This relies on the input files to be consumed by the linker in the same
order they were specified on the command line, but this is not actually
guaranteed by the linker, so it is better to make the inclusion of this
code specific by using function calls. Also, it is better to use a jump
instruction when going from one section to the next rather than relying
on code flow to proceed seamlessly from one to the other.

The reason I am cleaning this up is because I want to modify the section
layout slightly, so that the ELF and PE/COFF layouts are identical. This
permits a debug feature to be enabled that makes it possible to do single
step debugging from the EFI stub into the firmware and back, which is very
useful for debugging the handover from UEFI to the decompressor.

Ard Biesheuvel (6):
  ARM: compressed: move sharpsl startup code into subroutine
  ARM: compressed: move sa1100 startup code into subroutine
  ARM: compressed: move xscale startup code into subroutine
  ARM: compressed: move BE32 handling into head.S
  ARM: compressed: put zImage header and EFI header in dedicated section
  ARM: efi: add PE/COFF debug table to EFI header

 arch/arm/boot/compressed/Makefile       | 12 ++---
 arch/arm/boot/compressed/big-endian.S   | 14 ------
 arch/arm/boot/compressed/efi-header.S   | 47 ++++++++++++++++++++
 arch/arm/boot/compressed/head-sa1100.S  |  9 ++--
 arch/arm/boot/compressed/head-sharpsl.S | 24 +++++-----
 arch/arm/boot/compressed/head-xscale.S  |  7 +--
 arch/arm/boot/compressed/head.S         | 20 +++++++--
 arch/arm/boot/compressed/vmlinux.lds.S  |  4 +-
 8 files changed, 92 insertions(+), 45 deletions(-)
 delete mode 100644 arch/arm/boot/compressed/big-endian.S

-- 
2.19.1
