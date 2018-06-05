From: kim.phillips@arm.com (Kim Phillips)
Date: Tue,  5 Jun 2018 16:06:56 -0500
Subject: [PATCH v4 00/14] coresight: allow to build components as modules
Message-ID: <20180605210710.22227-1-kim.phillips@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow to build coresight as modules.  This enhances developer
efficiency by allowing the development to take place exclusively
on the target, and without needing to reboot in between changes.

depends on:
 - "amba: Export amba_bustype"
   https://patchwork.kernel.org/patch/10387433/
   Queued for 4.18 here:
   http://git.armlinux.org.uk/cgit/linux-arm.git/commit/?h=for-next&id=e9ac68c34f70a0c8d51ee63d259f7c8e79b362c1 

 - "coresight: Don't use contextID with PID namespaces"
   https://www.spinics.net/lists/arm-kernel/msg652755.html
   Queued for 4.18 here:
   http://git.linaro.org/kernel/coresight.git/log/?h=next

those depends plus this series, available here:
 - git://linux-arm.org/linux-kp.git, coresight-modules branch

Changes from v3:
 - rebased on coresight/next
 - re-split per-module-wise (Mathieu P)
   - some unnecessary changes were removed as a consequence
   - git bisectability maintained
 - module get/put in coresight_build_path/release_path, respectively
   instead of enable/disable functions (Suzuki P)
   - this prevents drivers from being unloaded when they are part of
     the path in use, either by sysfs or perf mode.
 - rename few source files e.g., coresight.c -> coresight-core.c in
   order to have the resultant module be more intuitively called coresight.ko
   instead of coresight-core.ko.

Changes from v2:
 - split into multiple patches, for reviewer clarity (Greg K-H)

Changes from v1:
 - remove depends on coresight that are in the if CORESIGHT block
   (Randy Dunlap)
 - rebased and removed coresight_vpid_to_pid relocation on this
   new series this patch now depends on:
        https://www.spinics.net/lists/arm-kernel/msg652755.html
   That new series eliminates patch 2/4 from this series (patches
   1 and 4 of this series remain the same).
 - actually call tmc_read_unprepare() in tmc_remove() this time,
   instead of open-coding the kfree, dma_free_coherent calls.

Changes from versions previously sent to coresight mailing list:

 - tmc_remove: free buffer used by TMC-ETR and TMC-ETF by calling
   tmc_read_unprepare()
 - fixed an unbalanced pm_runtime_enable in coresight-replicator
 - etm[4]_remove():  call cpuhp_remove_state_nocalls() and
   etm_perf_symlink(.., false) to clear up cpuhp and symlink state
 - add module parent checks for all enable/disable functions, source
   and sink modules
   - refactored device ptr dereferences by introducing a new parent_dev
     variable
 - corrected replicator author
 - whitespace fix in funnel driver

 - added user Kconfig help text with the names of the modules.
 - Addressed Mathieu's comments:
   - renamed coresight-link-sink-tmc coresight-tmc-core
   - prevent ability to crash the system by removing drivers from an
     active path by adding try_module_get() and module_put() calls in
     funnel and replicator drivers' enable and disable functions (thanks for
     figuring that out, Mathieu).

 - Addressed most of Mathieu's comments:
   - rm __inits causing linker section mismatch errors
   - barrier_pkt made static, moved to coresight_priv.h
   - rm unnecessary tmc_* EXPORT_SYMBOL leftovers
   - add some missing MODULE_AUTHORs


Kim Phillips (14):
  coresight: cpu_debug: minor module fixups
  coresight: use IS_ENABLED for CONFIGs that may be modules
  coresight: move shared barrier_pkt[] to coresight_priv.h
  coresight: export coresight_timeout and etm_perf_symlink
  coresight: get/put module in coresight_build/release_path
  coresight: allow stm to be built as a module
  coresight: allow dynamic-replicator to be built as a module
  coresight: allow etm3x to be built as a module
  coresight: allow etm4x to be built as a module
  coresight: allow etb to be built as a module
  coresight: allow tpiu to be built as a module
  coresight: allow tmc to be built as a module
  coresight: allow funnel and replicator drivers to be built as modules
  coresight: allow the coresight core driver to be built as a module

 drivers/hwtracing/coresight/Kconfig           | 48 +++++++++++++++----
 drivers/hwtracing/coresight/Makefile          | 20 ++++----
 .../{coresight.c => coresight-core.c}         | 23 ++++-----
 .../hwtracing/coresight/coresight-cpu-debug.c |  2 +
 .../coresight/coresight-dynamic-replicator.c  | 19 +++++++-
 drivers/hwtracing/coresight/coresight-etb10.c | 20 +++++++-
 .../hwtracing/coresight/coresight-etm-perf.c  | 18 ++++++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  2 +-
 ...resight-etm3x.c => coresight-etm3x-core.c} | 24 +++++++++-
 ...resight-etm4x.c => coresight-etm4x-core.c} | 25 +++++++++-
 .../hwtracing/coresight/coresight-funnel.c    | 18 ++++++-
 drivers/hwtracing/coresight/coresight-priv.h  | 10 +++-
 .../coresight/coresight-replicator.c          | 22 ++++++++-
 drivers/hwtracing/coresight/coresight-stm.c   | 20 +++++++-
 .../{coresight-tmc.c => coresight-tmc-core.c} | 22 ++++++++-
 drivers/hwtracing/coresight/coresight-tpiu.c  | 19 +++++++-
 include/linux/coresight.h                     |  2 +-
 17 files changed, 270 insertions(+), 44 deletions(-)
 rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (98%)
 rename drivers/hwtracing/coresight/{coresight-etm3x.c => coresight-etm3x-core.c} (97%)
 rename drivers/hwtracing/coresight/{coresight-etm4x.c => coresight-etm4x-core.c} (97%)
 rename drivers/hwtracing/coresight/{coresight-tmc.c => coresight-tmc-core.c} (95%)

-- 
2.17.0
