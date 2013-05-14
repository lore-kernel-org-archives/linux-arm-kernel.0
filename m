From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:27:22 +0100
Subject: [PATCH v2 0/3] Separate generic header usage from ARCH_MULTIPLATFORM
Message-ID: <1368530845-7415-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original aim of this series was to restore the ability to build a NOMMU
kernel for Versatile Express, something that was lost when we converted
ARCH_VEXPRESS for ARCH_MULTIPLATFORM.

In order to do this, it is necessary to abstract the use of generic headers
from selection of ARCH_MULTIPLATFORM so that the two can be used separately.
This is necessary becuase building a multiplatform kernel for processors
without and MMU doesn't make sense (it is necessary to hardcode certain mem-map
related data) and the versatile express can host NOMMU processors.

This series performs this separation, and then goes on to add a 'dummy'
ARCH_VEXPRESS_NOMMU platform that can be selected as standalone platform.

Patch 2 was sent to the list as an RFC some time ago where it was ACKd, but
alone is not sufficient to solve the problem, hence this follow-up series.

Changes since V1:
 - Rebase on to 3.10-rc1: fixup conflict from CONFIG_UNCOMPRESS_INCLUDE-foo

Jonathan Austin (3):
  ARM: allow platforms to use generic headers without
    ARCH_MULTIPLATFORM
  ARM: nommu: re-enable use of vexpress without ARCH_MULTIPLATFORM
  ARM: vexpress-nommu: add a Makefile.boot to restore single-platform
    build

 arch/arm/Kconfig                     |   21 +++++++++++++++++++++
 arch/arm/Kconfig.debug               |    4 ++--
 arch/arm/Makefile                    |    2 +-
 arch/arm/include/asm/timex.h         |    2 +-
 arch/arm/mach-mvebu/Makefile         |    2 +-
 arch/arm/mach-omap2/Makefile         |    2 +-
 arch/arm/mach-vexpress/Makefile      |    2 +-
 arch/arm/mach-vexpress/Makefile.boot |    4 ++++
 arch/arm/plat-omap/Makefile          |    2 +-
 arch/arm/plat-orion/Makefile         |    2 +-
 arch/arm/plat-versatile/Makefile     |    2 +-
 11 files changed, 35 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-vexpress/Makefile.boot

-- 
1.7.9.5
