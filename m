From: jglauber@cavium.com (Jan Glauber)
Date: Thu, 20 Oct 2016 11:30:36 +0200
Subject: [PATCH v3 0/5] Cavium ThunderX uncore PMU support
Message-ID: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the long time it took for re-cooking this patch set.
The v3 should address all of Marks previous comments, things I didn't
change are listed below.

Not changed:
- Stick to NUMA node ID to detect the socket a device belongs to but made
  uncore depend on CONFIG_NUMA.
- Stick to initcall for uncore framework because it is easier to do the
  scanning for the same type of PCI devices, also I don't know if the PCI layer
  would allow for several drivers to register for the same device ID.

Note:
I'm using perf_sw_context in difference to perf_invalid_context
(see WARN_ON in perf_pmu_register). Reason is that with perf_invalid_context
add() is never called and the counter results are shown as "unsupported" by
perf. With perf_sw_context everything works as expected.

Patches are against 4.9.0-rc1

Changes to v2:
- Embedded struct pmu and killed uncore->type
- Simplified add functions
- Unified functions where possible into a common implementation
- Use arrays to translate non-contiguous counter addresses to event_id's
  visible to the user
- Sorted includes
- Got rid of division for previous counter values
- Removed unneeded WARN_ONs
- Use sizeof(*ptr)
- Use bool for event_valid return
- Fixed HES_STOPPED logic
- Added some design notes and improved (hopefully) comments
- Removed pass1 counter support for now
- Merged EVENT_ATTR and EVENT_PTR defines into one (unreadable) thing
- Use pmu_enable|disable to start|stop the OCX TLK counter set
- Moved cpumask into thunder_uncore struct
- Switched to new cpuhp stuff. I still don't care about the CPU location
  used to access an uncore device, it may cross the CCPI and
  we'll pay a performance penalty. We might optimize this later, for now
  I feel it is not worth the time optimizing it.

------------------------

Jan Glauber (5):
  arm64: perf: Basic uncore counter support for Cavium ThunderX SOC
  arm64: perf: Cavium ThunderX L2C TAD uncore support
  arm64: perf: Cavium ThunderX L2C CBC uncore support
  arm64: perf: Cavium ThunderX LMC uncore support
  arm64: perf: Cavium ThunderX OCX TLK uncore support

 drivers/perf/Kconfig                        |  13 +
 drivers/perf/Makefile                       |   1 +
 drivers/perf/uncore/Makefile                |   5 +
 drivers/perf/uncore/uncore_cavium.c         | 355 ++++++++++++++++++++++++++
 drivers/perf/uncore/uncore_cavium.h         |  75 ++++++
 drivers/perf/uncore/uncore_cavium_l2c_cbc.c | 148 +++++++++++
 drivers/perf/uncore/uncore_cavium_l2c_tad.c | 379 ++++++++++++++++++++++++++++
 drivers/perf/uncore/uncore_cavium_lmc.c     | 118 +++++++++
 drivers/perf/uncore/uncore_cavium_ocx_tlk.c | 344 +++++++++++++++++++++++++
 include/linux/cpuhotplug.h                  |   1 +
 10 files changed, 1439 insertions(+)
 create mode 100644 drivers/perf/uncore/Makefile
 create mode 100644 drivers/perf/uncore/uncore_cavium.c
 create mode 100644 drivers/perf/uncore/uncore_cavium.h
 create mode 100644 drivers/perf/uncore/uncore_cavium_l2c_cbc.c
 create mode 100644 drivers/perf/uncore/uncore_cavium_l2c_tad.c
 create mode 100644 drivers/perf/uncore/uncore_cavium_lmc.c
 create mode 100644 drivers/perf/uncore/uncore_cavium_ocx_tlk.c

-- 
1.9.1
