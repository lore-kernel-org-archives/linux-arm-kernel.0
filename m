From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  6 Nov 2018 12:37:28 +0100
Subject: [PATCH 0/4] arm/efi: fix memblock reallocation crash due to
 persistent reservations
Message-ID: <20181106113732.16351-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series addresses the kexec/kdump crash on arm64 system with many CPUs
that was reported by Bhupesh.

Patches #1 and #2 fix the actual crash. Patches #3 and #4 optimize the
EFI persistent memreserve infrastructure so that fewer memblock reservations
are required.

Ard Biesheuvel (4):
  arm64: memblock: don't permit memblock resizing until linear mapping
    is up
  efi/arm: defer persistent reservations until after paging_init()
  efi: permit multiple entries in persistent memreserve data structure
  efi: reduce the amount of memblock reservations for persistent
    allocations

 arch/arm/kernel/setup.c                 |  1 +
 arch/arm64/kernel/setup.c               |  1 +
 arch/arm64/mm/init.c                    |  2 -
 arch/arm64/mm/mmu.c                     |  2 +
 drivers/firmware/efi/efi.c              | 59 ++++++++++++++------
 drivers/firmware/efi/libstub/arm-stub.c |  2 +-
 include/linux/efi.h                     | 23 +++++++-
 7 files changed, 68 insertions(+), 22 deletions(-)

-- 
2.19.1
