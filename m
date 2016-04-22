From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 22 Apr 2016 11:13:57 -0600
Subject: [PATCH V3 00/18] coresight: tmc: make driver usable by Perf 
Message-ID: <1461345255-11758-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes the TMC driver usable from Perf by way of the
recently added AUX area functionality.  Note that only the kernel
side of the operation is presented here.  The user space perf tool
enhancement are kept here[1].  Upstreaming of that portion will 
follow when the kernel side has been addressed.

The first 15 patches remodel the driver so that the functionality
is compartmented enough to be used as building blocks when interfacing
with the Perf subsystem.

Patch 16 and 17 implement the AUX area API, taking heavily on the existing
ETB10 implementation.

Finally patch 18 allows the TMC to be used as a link rather than a sink,
something that is required when dealing with an ETF component.

Best regards,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git/shortlog/refs/heads/perf-opencsd-4.6-rc2

Changes for V3:
- Reworked drvdata::memwidth assignment.
- cleaned up coresight-tmc.h header file.
- Added WARN_ON[_ONCE]() on error paths.
- Added missing spinlock release.
- Using a type 'long' when dealing with local_[cmp]xchg()
- Added Suzuki K Poulose's Reviewed-by.

Changes for V2:
- Renamed functions tmc_read_prepare/unprepare_etf() to 
  tmc_read_prepare/unprepare_etb().
- Consolidated return points in functions tmc_enable_etf/etr_sink().
- Re-wrote allocation schemed in functions tmc_enable_etf/etr_sink().
- Fixed description typos in patch 7/15.
- Fixed problem with linksink devices when disabling a path in patch 15/15.

Mathieu Poirier (18):
  coresight: tmc: modifying naming convention
  coresight: tmc: waiting for TMCReady bit before programming
  coresight: tmc: re-implementing tmc_read_prepare/unprepare() functions
  coresight: tmc: clearly define number of transfers per burst
  coresight: tmc: introducing new header file
  coresight: tmc: cleaning up header file
  coresight: tmc: splitting driver in ETB/ETF and ETR components
  coresight: tmc: making prepare/unprepare functions generic
  coresight: tmc: allocating memory when needed
  coresight: tmc: getting the right read_count on tmc_open()
  coresight: tmc: adding mode of operation for link/sinks
  coresight: tmc: dump system memory content only when needed
  coresight: tmc: make sysFS and Perf mode mutually exclusive
  coresight: tmc: keep track of memory width
  coresight: moving struct cs_buffers to header file
  coresight: tmc: implementing TMC-ETF AUX space API
  coresight: tmc: implementing TMC-ETR AUX space API
  coresight: configuring ETF in FIFO mode when acting as link

 drivers/hwtracing/coresight/Makefile            |   4 +-
 drivers/hwtracing/coresight/coresight-etb10.c   |  20 -
 drivers/hwtracing/coresight/coresight-priv.h    |  20 +
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 603 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 469 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 485 +++----------------
 drivers/hwtracing/coresight/coresight-tmc.h     | 145 ++++++
 drivers/hwtracing/coresight/coresight.c         |  32 +-
 8 files changed, 1339 insertions(+), 439 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc.h

-- 
2.5.0
