From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 20 Oct 2016 12:21:23 +0100
Subject: [PATCH v2 0/3] efi: add support for seeding the kernel RNG from UEFI
Message-ID: <1476962486-18368-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements generic EFI core kernel code to seed the kernel entropy
pool from a Linux specific UEFI configuration table containing a random seed
supplied by the firmware. (#1)

In addition, it wires it up for ARM and arm64, by invoking the EFI_RNG_PROTOCOL
UEFI protocol from the stub, and populating such a UEFI config table using its
output.

Changes since v1:
- Add a patch to actually build random.c for the ARM version of the stub, so
  that the functionality that patch #3 adds is available on ARM as well as arm64
- Handle the kexec case, by updating the seed in the configuration table on
  reboot.

How to wire this up for x86 is left as an exercise for the Intel developer.

Ard Biesheuvel (3):
  efi: add support for seeding the RNG from a UEFI config table
  efi/libstub: add random.c to ARM build
  efi/arm*: libstub: invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table

 drivers/firmware/efi/efi.c                     | 67 ++++++++++++++++++++
 drivers/firmware/efi/libstub/Makefile          |  4 +-
 drivers/firmware/efi/libstub/arm-stub.c        |  2 +
 drivers/firmware/efi/libstub/efi-stub-helper.c |  9 ---
 drivers/firmware/efi/libstub/efistub.h         | 11 ++++
 drivers/firmware/efi/libstub/random.c          | 48 ++++++++++++++
 include/linux/efi.h                            |  9 +++
 7 files changed, 139 insertions(+), 11 deletions(-)

-- 
2.7.4
