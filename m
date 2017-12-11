From: prarit@redhat.com (Prarit Bhargava)
Date: Mon, 11 Dec 2017 10:50:57 -0500
Subject: [PATCH v2 0/2] acpi, x86: Add SPCR table support
Message-ID: <20171211155059.17062-1-prarit@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SPCR (Serial Port Console Redirection) Table provides information
about the configuration of the serial port.  This information can be used to
configure the early console.

SPCR support was added for ARM64 and is made available across all arches
in this patchset.  The first patch adds a weak per-arch configuration function
and moves the SPCR code into ACPI.  The second patch adds support to x86.

The existing behaviour on ARM64 is maintained.  If the SPCR exists the
earlycon and console are automatically configured.

The existing default behaviour on x86 is also maintained.  If no console or
earlycon parameter is defined and the SPCR exists, the serial port is not
configured.  If the earlycon parameter is used both the early console
and the console are configured using the data from the SPCR.

Additional testing (requested by Timur): On Gigabyte (no quirks), Qualcomm
Amberwing systems to test Qualcomm quirks, HPE Mantis system to test xgene
quirks.  Tested several x86 systems with and without a SPCR to confirm
no changes in default behaviour.

[v2]: See 1/2 for code changes.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: linux-doc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-pm at vger.kernel.org
Cc: linux-acpi at vger.kernel.org
Cc: linux-serial at vger.kernel.org
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Timur Tabi <timur@codeaurora.org>

Prarit Bhargava (2):
  acpi, spcr: Make SPCR avialable to other architectures
  acpi, x86: Use SPCR table for earlycon on x86

 Documentation/admin-guide/kernel-parameters.txt |   9 +-
 arch/arm64/kernel/acpi.c                        | 128 ++++++++++++++++-
 arch/x86/kernel/acpi/boot.c                     |   4 +
 drivers/acpi/Kconfig                            |   7 +-
 drivers/acpi/spcr.c                             | 180 ++++++------------------
 drivers/tty/serial/earlycon.c                   |  15 +-
 include/linux/acpi.h                            |  14 +-
 include/linux/serial_core.h                     |   2 -
 8 files changed, 198 insertions(+), 161 deletions(-)

-- 
2.15.0.rc0.39.g2f0e14e64
