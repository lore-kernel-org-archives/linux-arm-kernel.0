From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 12 Jan 2015 17:51:52 +0000
Subject: [GIT PULL] UEFI updates for arm64
Message-ID: <CAKv+Gu-svNbDNhHgFfiT0XPBhMNugWzPZiU4yUzkT9tf0OZ_bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  http://git.linaro.org/people/ard.biesheuvel/linux-arm.git tags/for-3.20

for you to fetch changes up to 9679be103108926cfe9e6fd2f6829cefa77e47b0:

  arm64/efi: remove idmap manipulations from UEFI code (2015-01-12
16:29:32 +0000)

Some patches touch files under drivers/firmware/efi, these have been
acked by Matt
Fleming, and he is aware that this series is being offered for merging
through the
arm64 tree

Regards,
Ard.


----------------------------------------------------------------
UEFI updates for arm64

This series consists of a reimplementation of the virtual remapping of
UEFI Runtime Services in a way that is stable across kexec, including
the required preparatory refactoring and other work to set the stage,
and some cleaning up afterwards to remove boot services memory and
identitity map handling that has now become redundant.

----------------------------------------------------------------
Ard Biesheuvel (8):
      arm64/mm: add explicit struct_mm argument to __create_mapping()
      arm64/mm: add create_pgd_mapping() to create private page tables
      efi: split off remapping code from efi_config_init()
      efi: efistub: allow allocation alignment larger than EFI_PAGE_SIZE
      arm64/efi: set EFI_ALLOC_ALIGN to 64 KB
      arm64/efi: move SetVirtualAddressMap() to UEFI stub
      arm64/efi: remove free_boot_services() and friends
      arm64/efi: remove idmap manipulations from UEFI code

 arch/arm64/include/asm/efi.h                   |  38 ++-
 arch/arm64/include/asm/mmu.h                   |   5 +-
 arch/arm64/include/asm/pgtable.h               |   5 +
 arch/arm64/kernel/efi.c                        | 369 ++++++++-----------------
 arch/arm64/kernel/setup.c                      |   2 +-
 arch/arm64/mm/mmu.c                            |  60 ++--
 drivers/firmware/efi/efi.c                     |  56 ++--
 drivers/firmware/efi/libstub/arm-stub.c        |  59 ++++
 drivers/firmware/efi/libstub/efi-stub-helper.c |  25 +-
 drivers/firmware/efi/libstub/efistub.h         |   4 +
 drivers/firmware/efi/libstub/fdt.c             |  62 ++++-
 include/linux/efi.h                            |   2 +
 12 files changed, 362 insertions(+), 325 deletions(-)
