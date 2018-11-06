From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2018 12:37:00 +0000
Subject: [PATCH v2 0/5] Spectre big.Little updates
Message-ID: <20181106123700.GA30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches allows Spectre to be worked around on
big.Little systems, and as far as I'm aware, completes the Spectre
workarounds as were known at the beginning of the year for 32-bit
ARM.

In order to solve Spectre for such systems, we need to introduce
per-CPU indirection of the "processor" vtable, but we are unable to
use the kernel's per-CPU infrastructure as this is not initialised
early enough.

To work around that, we fall back to using a static array of
processor vtables indexed by the logical CPU number.  This should
not be a problem as 32-bit ARM systems are limited to 8 logical
CPUs.

Changes in v2:
We use CPU0's vtable for some of the function methods to avoid
using the CPU number in pre-emptable code, and validate that these
methods are identical across all CPUs in the system.

 arch/arm/include/asm/cputype.h  |  1 +
 arch/arm/include/asm/proc-fns.h | 58 ++++++++++++++++++++++++++++++++---------
 arch/arm/kernel/bugs.c          |  4 +--
 arch/arm/kernel/head-common.S   |  6 ++---
 arch/arm/kernel/setup.c         | 40 +++++++++++++++++-----------
 arch/arm/kernel/smp.c           | 31 ++++++++++++++++++++++
 arch/arm/mm/proc-v7-bugs.c      | 17 ++----------
 7 files changed, 110 insertions(+), 47 deletions(-)


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
