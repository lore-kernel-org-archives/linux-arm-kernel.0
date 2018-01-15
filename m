From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 15 Jan 2018 10:51:16 +0000
Subject: [bug report] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20180112201334.sfqjnyw4or4msfeq@mwanda>
References: <20180112201334.sfqjnyw4or4msfeq@mwanda>
Message-ID: <6457a5ff-21d7-0867-2cf1-3b5d08349e2e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

Thanks for the report.

On 12/01/18 20:13, Dan Carpenter wrote:
> Hello Suzuki K Poulose,
> 
> The patch 7520fa99246d: "perf: ARM DynamIQ Shared Unit PMU support"
> from Jan 2, 2018, leads to the following static checker warning:
> 
> 	drivers/perf/arm_dsu_pmu.c:680 dsu_pmu_init_pmu()
> 	warn: impossible condition '(dsu_pmu->num_counters == -1) => (0-255 == (-1))'
> 
> drivers/perf/arm_dsu_pmu.c
>     674  /*
>     675   * dsu_pmu_init_pmu: Initialise the DSU PMU configurations if
>     676   * we haven't done it already.
>     677   */
>     678  static void dsu_pmu_init_pmu(struct dsu_pmu *dsu_pmu)
>     679  {
>     680          if (dsu_pmu->num_counters == -1)
>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> A u8 variable can't ever be -1.
> 
>     681                  dsu_pmu_probe_pmu(dsu_pmu);
>     682          /* Reset the interrupt overflow mask */
>     683          dsu_pmu_get_reset_overflow();
>     684  }
> 
> regards,
> dan carpenter
> 

Here is the fix.

---8>---

perf: dsu: Use signed field for dsu_pmu->num_counters
    
We set dsu_pmu->num_counters to -1, when the DSU is allocated
but not initialised when none of the CPUs are active in the DSU.
However, we use an unsigned field for num_counters. Switch this
to a signed field.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 37c0526c93d5..93c50e377507 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -120,7 +120,7 @@ struct dsu_pmu {
  	cpumask_t			associated_cpus;
  	cpumask_t			active_cpu;
  	struct hlist_node		cpuhp_node;
-	u8				num_counters;
+	s8				num_counters;
  	int				irq;
  	DECLARE_BITMAP(cpmceid_bitmap, DSU_PMU_MAX_COMMON_EVENTS);
  };
