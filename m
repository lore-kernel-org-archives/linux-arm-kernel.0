From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 28 Nov 2018 15:01:12 -0700
Subject: [PATCH v4 0/6] perf: Add ioctl for PMU driver configuration 
Message-ID: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the fourth iteration of a set that adds the capability to communicate
event specific configuration to PMU kernel drivers using an ioctl().  Though
targeted at the identification of CoreSight sinks when operating in CPU-wide
trace scenarios the functionality is made generic enough for anyone to use.

The work fits in a wider scheme to support CPU-wide trace scenarios on CoreSight
that is available here[1].  If someone is to test the functionality using this 
branch, note that only dumping of CPU-wide trace data is working.  Full decoding
capability is being verified.

Patch 1 to 3 deal with kernel enhancement to the perf core while patch 4 is
CoreSight specific.  Patches 5 and 6 concentrate on the perf tools.

# Before this set: 

root at juno:/home/linaro# perf record -e cs_etm/@20070000.etr/ -C 2,3 sleep 1
failed to mmap with 12 (Cannot allocate memory)

# After this set:

root at juno:/home/linaro# perf record -e cs_etm/@20070000.etr/ -C 2,3 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.145 MB perf.data ]


Thanks,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/log/?h=cpu-wide-coresight 

---
Changes for V4:
. Made passing of information between ioctl() and PMU simpler.
. Rebased to 4.20-rc4


Mathieu Poirier (6):
  perf: Introduce ioctl to communicate driver configuration to kernel
  perf/core: Use ioctl to communicate driver configuration to kernel
  perf/aux: Make perf_event accessible to setup_aux()
  coresight: Use PMU driver configuration for sink selection
  perf tools: Make perf_evsel accessible to PMU driver configuration
    code
  perf tools: Use ioctl function to send sink configuration to kernel

 arch/s390/kernel/perf_cpum_sf.c                  |  6 +--
 arch/x86/events/intel/bts.c                      |  4 +-
 arch/x86/events/intel/pt.c                       |  5 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 64 ++++++++++++++++------
 drivers/perf/arm_spe_pmu.c                       |  6 +--
 include/linux/perf_event.h                       | 40 +++++++++++++-
 include/uapi/linux/perf_event.h                  |  1 +
 kernel/events/core.c                             | 69 ++++++++++++++++++++++++
 kernel/events/ring_buffer.c                      |  2 +-
 tools/include/uapi/linux/perf_event.h            |  1 +
 tools/perf/arch/arm/util/cs-etm.c                | 67 ++++++++++++++++++++++-
 tools/perf/arch/arm/util/cs-etm.h                |  3 +-
 tools/perf/util/drv_configs.c                    | 30 +++--------
 tools/perf/util/evsel.c                          |  7 +++
 tools/perf/util/evsel.h                          |  1 +
 tools/perf/util/pmu.h                            |  3 +-
 16 files changed, 257 insertions(+), 52 deletions(-)

-- 
2.7.4
