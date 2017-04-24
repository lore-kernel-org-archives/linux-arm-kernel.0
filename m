From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 24 Apr 2017 11:31:43 +0000
Subject: [PATCH] arm64: pmuv3: Support v8.1 PMUv3 extension
Message-ID: <1493033503-4712-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMUVer field can have a value 4 for PMUv3 which supports 16 bit
evtCount field (this is documented in ARM Architecture Reference Manual
Supplement ARMv8.1).

The current check for PMUVer to be equal to 1 fails on ThunderX2 which
has value 4 in PMUVer field. Fix this.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---

This applies on top of the current arm64 tree and fixes a breakage due
to the  ACPI perf patches.


 arch/arm64/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 98c7493..5388ed8 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -972,7 +972,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	dfr0 = read_sysreg(id_aa64dfr0_el1);
 	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
 			ID_AA64DFR0_PMUVER_SHIFT);
-	if (pmuver != 1)
+	if (pmuver != 1 && pmuver != 4)
 		return;
 
 	probe->present = true;
-- 
2.7.4
