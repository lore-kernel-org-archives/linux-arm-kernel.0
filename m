From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Mar 2015 16:23:40 +0100
Subject: [RFC PATCH 0/3] arm64: relocatable kernel proof of concept
Message-ID: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches is a proof of concept of how we could potentially relocate
the kernel at runtime. This code is rough around the edges, and there are
a few unresolved issues, hence this RFC.

With these patches, the kernel can essentially execute at any virtual offset.
There are a couple of reasons why we would want this:
- performance: we can align PHYS_OFFSET so that most of the linear mapping can
  be done using 512 MB or 1 GB blocks (depending on page size), instead of
  the more granular level that is currently unavoidable if Image cannot be
  loaded at base of RAM (since PHYS_OFFSET is tied to the start of the kernel
  Image).
- security: with these changes, we can put the kernel Image anywhere in physical
  memory, and we can put the physical memory anywhere in the upper half of the
  virtual address range (modulo alignment). This gives us quite a number of
  bits of to play with if we were to randomize the kernel virtual address space.
  Also, this is entirely under the control of the boot loader, which is probably
  in better shape to get its hands on some entropy than the early kernel boot
  code.
- convenience: fewer constraints when loading the kernel into memory, as it
  can execute from anywhere.

How it works:
- an additional boot argument 'image offset' is passed in x1 by the boot loader,
  which should contain a value that is at least the offset of Image into physical
  memory. Higher values are also possible, and may be used to randomize the
  kernel VA space.
- the kernel binary is runtime relocated to PAGE_OFFSET + image offset

Issues:
- Since AArch64 uses the ELF RELA format (where the addends are in the
  relocation table and not in the code), the relocations need to be applied even
  if the Image runs from the same offset it was linked at. It also means that
  some values that are produced by the linker (_kernel_size_le, etc) are missing
  from the binary. This will probably need a fixup step.
- The module area may be out of range, which needs to be worked around with
  module PLTs. This is straight forward but I haven't implemented it yet for
  arm64.
- The core extable is most likely broken, and would need to be changed to use
  relative offsets instead of absolute addresses.
- Probably lots and lots of other roadblocks, hence this RFC

Output from QEMU/efi with 2 GB of memory:

Base of RAM:
  0x000040000000-0x00004000ffff [Loader Data        |   |  |  |  |   |WB|WT|WC|UC]

Physical location of Image:
  0x00007f400000-0x00007fe6ffff [Loader Data        |   |  |  |  |   |WB|WT|WC|UC]

Virtual kernel memory layout:
    vmalloc : 0xffffff8000000000 - 0xffffffbdbfff0000   (   246 GB)
    vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
              0xffffffbdc1000000 - 0xffffffbdc3000000   (    32 MB actual)
    fixed   : 0xffffffbffa9fe000 - 0xffffffbffac00000   (  2056 KB)
    PCI I/O : 0xffffffbffae00000 - 0xffffffbffbe00000   (    16 MB)
    modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)
    memory  : 0xffffffc000000000 - 0xffffffc080000000   (  2048 MB)
      .init : 0xffffffc03fb82000 - 0xffffffc03fdbe000   (  2288 KB)
      .text : 0xffffffc03f480000 - 0xffffffc03fb81344   (  7173 KB)
      .data : 0xffffffc03fdc2000 - 0xffffffc03fe28c00   (   411 KB)


Ard Biesheuvel (3):
  arm64: head.S: replace early literals with constant immediates
  arm64: add support for relocatable kernel
  arm64/efi: use relocated kernel

 arch/arm64/Kconfig              |  3 ++
 arch/arm64/Makefile             |  4 ++
 arch/arm64/kernel/efi-entry.S   |  6 ++-
 arch/arm64/kernel/efi-stub.c    |  5 ++-
 arch/arm64/kernel/head.S        | 94 +++++++++++++++++++++++++++++++----------
 arch/arm64/kernel/image.h       |  8 +++-
 arch/arm64/kernel/vmlinux.lds.S | 12 ++++++
 scripts/sortextable.c           |  4 +-
 8 files changed, 107 insertions(+), 29 deletions(-)

-- 
1.8.3.2
