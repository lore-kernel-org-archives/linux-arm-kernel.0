From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 17 Oct 2017 00:02:20 +0530
Subject: [PATCH v9 3/5] perf utils: use pmu->is_uncore to detect PMU UNCORE
 devices
In-Reply-To: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
References: <20171016183222.25750-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171016183222.25750-4-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMU CORE devices are identified using sysfs filename cpu, however
on some platforms(like arm/arm64), PMU CORE sysfs name is not cpu.
Hence cpu cannot be used to differentiate PMU CORE/UNCORE devices.

commit:
 66ec1191 ("perf pmu: Unbreak perf record for arm/arm64 with events with explicit PMU")

has introduced pmu->is_uncore, which is set to PMU UNCORE devices only.
Adding changes to use pmu->is_uncore to identify UNCORE devices.

Acked-by: Will Deacon <will.deacon@arm.com>
Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/util/pmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8b17db5..9110718 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -603,7 +603,6 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	 */
 	i = 0;
 	while (1) {
-		const char *pname;
 
 		pe = &map->table[i++];
 		if (!pe->name) {
@@ -612,9 +611,13 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 			break;
 		}
 
-		pname = pe->pmu ? pe->pmu : "cpu";
-		if (strncmp(pname, name, strlen(pname)))
-			continue;
+		if (pmu->is_uncore) {
+			/* check for uncore devices */
+			if (pe->pmu == NULL)
+				continue;
+			if (strncmp(pe->pmu, name, strlen(pe->pmu)))
+				continue;
+		}
 
 		/* need type casts to override 'const' */
 		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
-- 
2.9.4
