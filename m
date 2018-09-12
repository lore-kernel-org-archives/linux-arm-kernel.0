From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Sep 2018 13:58:39 +0530
Subject: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices
 sharing OPP table
Message-ID: <cover.1536736872.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Niklas Cassle recently reported some regressions with his Qcom cpufreq
driver where he was getting some errors while creating the OPPs tables.

After looking into it I realized that the OPP core incorrectly creates
multiple OPP tables for the devices even if they are sharing the OPP
table in DT. This happens when the request comes using different CPU
devices. For example, dev_pm_opp_set_supported_hw() getting called using
CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.

This series redesigns the internals of the OPP core to fix that. The
redesign has simplified the core itself though.

@Niklas: Can you please confirm that this series fixes the issues you
have reported ? I have already tested it on Hikey960.

--
viresh

Viresh Kumar (11):
  OPP: Free OPP table properly on performance state irregularities
  OPP: Protect dev_list with opp_table lock
  OPP: Pass index to _of_init_opp_table()
  OPP: Parse OPP table's DT properties from _of_init_opp_table()
  OPP: Don't take OPP table's kref for static OPPs
  OPP: Create separate kref for static OPPs list
  cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
  OPP: Don't remove dynamic OPPs from _dev_pm_opp_remove_table()
  OPP: Use a single mechanism to free the OPP table
  OPP: Prevent creating multiple OPP tables for devices sharing OPP
    nodes
  OPP: Pass OPP table to _of_add_opp_table_v{1|2}()

 drivers/cpufreq/mvebu-cpufreq.c |   9 +-
 drivers/opp/core.c              | 147 ++++++++++++++++---------
 drivers/opp/cpu.c               |  11 +-
 drivers/opp/of.c                | 186 +++++++++++++++++---------------
 drivers/opp/opp.h               |  19 ++--
 include/linux/pm_opp.h          |   6 ++
 6 files changed, 221 insertions(+), 157 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c
