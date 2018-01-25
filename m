From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 25 Jan 2018 10:31:27 +0000
Subject: [PATCH 0/4] efi/arm64: unmap the kernel during runtime service calls
Message-ID: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UEFI doesn't keep any secrets, so it is mostly unaffected by Meltdown and
Spectre. At boot time, when UEFI is in charge of everything, there is
simply no point in inferring things from the cache state if you can simply
read the data. At runtime, when UEFI runs in the execution context of the
OS, it is really up to the OS to ensure that lower privilege levels cannot
access OS data structures unpermitted.

This applies equally to Spectre variant 2: UEFI runtime services are not
entered directly from userland but always via the kernel, which carries
out any required branch predictor maintenance when switching between the
various tasks (and the UEFI runtime execution context may be considered
a separate task in this sense)

Spectre variant 1 is a different matter though. It requires code changes
and software rebuilds with updated compilers to be fully hardened against
it, although nobody seems to know exactly what that means at the moment.
Given the poor track record of vendors when it comes to keeping UEFI
firmware up to date, it is highly likely that vulnerable versions will
still be in circulation long after we fixed the OS.

Since UEFI interacts with data structures that the OS may consider opaque
(capsule images, authenticated variable updates), it is not really up to
the OS to reason about which invocation is safe and which one isn't. The
only solution really is to simply unmap the entire kernel during UEFI
runtime services invocations, so that there are no secrets to steal to
begin with.

Patch #1 is included for completeness. I sent it out before, and it is a
dependency for this series, but it is otherwise unrelated.

Patch #2 creates a separate stack for UEFI and puts it in the EFI page
tables, along with the asm wrapper that invokes the UEFI runtime services
and a vector table that is activated before and deactivated after the
service is called.

Patch #3 implements marshalling of all byref arguments taken by UEFI
runtime services. This is necessary because they will refer to memory
that is going to be unmapped.

Patch #4 implements the actual unmap/remap sequences, by setting/clearing
the EPD1 bit in TCR_EL1, and doing a local TLB flush.

Note that capsule update has been omitted. This is a bit involved, and
I'd rather get some feedback before burning too many cycles on that. All
other services should be functional, with the caveat that EFI variable
names are now limited to 1024 [wide] characters, and UEFI variables
themselves to 64 KB.

Ard Biesheuvel (4):
  efi: arm64: Check whether x18 is preserved by runtime services calls
  efi/arm64: map the stack and entry wrapper into the UEFI page tables
  efi/arm64: marshall runtime services arguments via buffer in TTBR0
  efi/arm64: unmap the kernel while executing UEFI services

 arch/arm/include/asm/efi.h          |   5 +
 arch/arm64/Kconfig                  |   1 -
 arch/arm64/include/asm/efi.h        |  30 +-
 arch/arm64/include/asm/stacktrace.h |   4 +
 arch/arm64/kernel/Makefile          |   3 +-
 arch/arm64/kernel/efi-rt-wrapper.S  | 112 +++++
 arch/arm64/kernel/efi.c             | 505 +++++++++++++++++++-
 arch/arm64/kernel/entry.S           |   1 +
 drivers/firmware/efi/arm-runtime.c  |   2 +
 9 files changed, 658 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/kernel/efi-rt-wrapper.S

-- 
2.11.0
