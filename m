From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jun 2011 15:40:00 +0100
Subject: [PATCHv2 0/4] ARM: pmu: improve PMU type identification
Message-ID: <1308148804-5518-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is version 2 of the patches originally posted here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052865.html

Changes since v1 include:

 * Added Acks from Jamie Iles & Rob Herring.
 * Add "arm-pmu" binding to the platform_device_id table, as driver name
   matching is not used when platform_driver::id_table exists.
 * Fixed name clash in PLAT_MATCH_PMU macro.
 * Removed unnecessary casts for platform_device_id::driver_data.
 * Aligned trailing backslashes on multi-line *_MATCH_PMU macros.
 * Removed spaces after casts.

The patches use {of,platform}_device_id tables to provide the PMU type, which
can be used similarly (the macros make entries look identical apart from the
{plat,of} prefix). This allows us to stop (ab)using platform_device::id, and
should allow for easier addition/modification of PMU driver bindings.

BSPs need no longer care about the Type of PMUs they register; as long as a
binding exists the type will be assigned correctly.

Rob, Jamie: would you mind if patches 3 & 4 were squashed together?
Patch 4 depends heavily on patch 3, and there doesn't seem to be a clean way of
fixing that.

Mark

Mark Rutland (4):
  ARM: pmu: refactor reservation
  ARM: pmu: reject duplicate PMU registrations
  ARM: pmu: add OF probing support
  ARM: pmu: add platform_device_id table support

 Documentation/devicetree/bindings/arm/pmu.txt |   22 ++++++
 arch/arm/include/asm/pmu.h                    |    2 +-
 arch/arm/kernel/perf_event.c                  |    4 +-
 arch/arm/kernel/pmu.c                         |   87 ++++++++++++++++++++-----
 4 files changed, 95 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
