From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 25 Apr 2014 13:27:12 -0400
Subject: [PATCH v7 0/3] PSCI v0.2 support and DT bindings
Message-ID: <1398446835-5532-1-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces some functions as defined in the PSCI v0.2 spec
and a corresponding DT binding to differentiate it from previous PSCI versions.
Since PSCIv0.2 has standard function IDs, it is possible to statically assign them
rather than depend on values from DT.

This patchset depends on the PSCI header (/uapi/linux/psci.h) introduced by
http://www.spinics.net/lists/arm-kernel/msg319712.html

Changes in v7:
		-	Add two new functions: SYSTEM_OFF and SYSTEM_RESET as defined in PSCIv0.2.
		-	Added a delay before calling cpu_kill to avoid race with cpu_die.

Changes in v6:
		-	rebase on top of uapi/linux/psci.h introduced by Anups patch
http://www.spinics.net/lists/arm-kernel/msg319712.html
		-	rebase on top of Catalins tree tip.

Changes in v5:
        -       Add uapi/linux/psci.h to kbuild
        -       ret with err if PSCI_ID_VERSION is not implemented.

Changes in v4:
        -       Correct copyright banner format.
        -       Check if PSCI Version ID is supported.
        -       Add all PSCI RET codes in uapi header.
        -       Explicitely ret 1 from psci_cpu_kill()

Changes in v3:
        -       Roll up common functionality for getting conduit method.
        -       Remove #defines for ARM32 and ARM64 in uapi/linux/psci.h
        -       Remove functions not supported by PSCI v0.1
        -       Misc cleanups.
        -       Add PSCI_AFFINITY_INFO return types in uapi header.
        -       Changed function names for PSCI v0.1 and PSCI v0.2
        -       Added copyright info to uapi header.
        -       Fixed args to affinity_info call.
        -       Fix typo in psci_init definition when PSCI is not defined.

Changes in v2:

        -       Add AFFINITY_INFO and MIGRATE_INFO_TYPE functions.
        -       Add binding Documentation.
        -       Add function to get PSCI version.
        -       Add common #defines in uapi/linux/psci.h
        -       Implement cpu_kill and check if CPU is dead via AFFINITY_INFO.
        -       Misc cleanups.

Changes in v1:

        -       Add new binding "arm, psci-0.2"
        -       Separate conduit and PSCI function assignment methods.


*** BLURB HERE ***

Ashwin Chaugule (3):
  PSCI: Add initial support for PSCIv0.2 functions
  Documentation: devicetree: Add new binding for PSCIv0.2
  ARM: Check if a CPU has gone offline

 Documentation/devicetree/bindings/arm/psci.txt |  35 ++++-
 arch/arm/include/asm/psci.h                    |   7 +-
 arch/arm/kernel/psci.c                         | 196 +++++++++++++++++++-----
 arch/arm/kernel/psci_smp.c                     |  32 ++++
 arch/arm64/include/asm/psci.h                  |   2 +-
 arch/arm64/kernel/psci.c                       | 200 ++++++++++++++++++++-----
 include/uapi/linux/psci.h                      |   5 +
 7 files changed, 399 insertions(+), 78 deletions(-)

-- 
1.8.3.2
