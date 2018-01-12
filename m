From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 12 Jan 2018 23:13:34 +0300
Subject: [bug report] perf: ARM DynamIQ Shared Unit PMU support
Message-ID: <20180112201334.sfqjnyw4or4msfeq@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Suzuki K Poulose,

The patch 7520fa99246d: "perf: ARM DynamIQ Shared Unit PMU support"
from Jan 2, 2018, leads to the following static checker warning:

	drivers/perf/arm_dsu_pmu.c:680 dsu_pmu_init_pmu()
	warn: impossible condition '(dsu_pmu->num_counters == -1) => (0-255 == (-1))'

drivers/perf/arm_dsu_pmu.c
   674  /*
   675   * dsu_pmu_init_pmu: Initialise the DSU PMU configurations if
   676   * we haven't done it already.
   677   */
   678  static void dsu_pmu_init_pmu(struct dsu_pmu *dsu_pmu)
   679  {
   680          if (dsu_pmu->num_counters == -1)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
A u8 variable can't ever be -1.

   681                  dsu_pmu_probe_pmu(dsu_pmu);
   682          /* Reset the interrupt overflow mask */
   683          dsu_pmu_get_reset_overflow();
   684  }

regards,
dan carpenter
