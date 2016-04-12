From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 12 Apr 2016 11:54:37 -0600
Subject: [PATCH V2 00/15] coresight: tmc: make driver usable by Perf 
Message-ID: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset makes the TMC driver usable from Perf by way of the
recently added AUX area functionality.

The first 12 patches remodel the driver so that the functionality
is compartmented enough to be used as building blocks when interfacing
with the Perf subsystem.

Patch 13 and 14 implement the AUX area API, taking heavily on the existing
ETB10 implementation.

Finally patch 15 allows the TMC to be used as a link rather than a sink,
something that is required when dealing with an ETF component.

Best regards,
Mathieu

Changes for V2:
- Renamed functions tmc_read_prepare/unprepare_etf() to 
  tmc_read_prepare/unprepare_etb().
- Consolidated return points in functions tmc_enable_etf/etr_sink().
- Re-wrote allocation schemed in functions tmc_enable_etf/etr_sink().
- Fixed description typos in patch 7/15.
- Fixed problem with linksink devices when disabling a path in patch 15/15.

Mathieu Poirier (15):
  coresight: tmc: modifying naming convention
  coresight: tmc: waiting for TMCReady bit before programming
  coresight: tmc: re-implementing tmc_read_prepare/unprepare() functions
  coresight: tmc: introducing new header file
  coresight: tmc: splitting driver in ETB/ETF and ETR components
  coresight: tmc: making prepare/unprepare functions generic
  coresight: tmc: allocating memory when needed
  coresight: tmc: getting the right read_count on tmc_open()
  coresight: tmc: adding mode of operation for link/sinks
  coresight: tmc: dump system memory content only when needed
  coresight: tmc: make sysFS and Perf mode mutually exclusive
  coresight: tmc: keep track of memory width
  coresight: tmc: implementing TMC-ETF AUX space API
  coresight: tmc: implementing TMC-ETR AUX space API
  coresight: configuring ETF in FIFO mode when acting as link

 drivers/hwtracing/coresight/Makefile            |   4 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 611 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 467 ++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 450 ++---------------
 drivers/hwtracing/coresight/coresight-tmc.h     | 166 +++++++
 drivers/hwtracing/coresight/coresight.c         |  32 +-
 6 files changed, 1312 insertions(+), 418 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc-etr.c
 create mode 100644 drivers/hwtracing/coresight/coresight-tmc.h

-- 
2.5.0
