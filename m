From: will.deacon@arm.com (Will Deacon)
Date: Fri,  6 Dec 2013 16:34:05 +0000
Subject: [PATCH] ARM: mcpm: remove redundant dsb instructions prior to sev
Message-ID: <1386347645-16570-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sync_cache_w already includes a dsb, so we can just use sev() directly
then following a cache-sync.

Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Hi guys,

I was auditing our uses of wfe (they're all fine) but noticed these
extra dsbs in the process.

Will

 arch/arm/common/mcpm_entry.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index 26020a03f659..74140ed9922f 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -167,7 +167,7 @@ void __mcpm_cpu_down(unsigned int cpu, unsigned int cluster)
 	dmb();
 	mcpm_sync.clusters[cluster].cpus[cpu].cpu = CPU_DOWN;
 	sync_cache_w(&mcpm_sync.clusters[cluster].cpus[cpu].cpu);
-	dsb_sev();
+	sev();
 }
 
 /*
@@ -183,7 +183,7 @@ void __mcpm_outbound_leave_critical(unsigned int cluster, int state)
 	dmb();
 	mcpm_sync.clusters[cluster].cluster = state;
 	sync_cache_w(&mcpm_sync.clusters[cluster].cluster);
-	dsb_sev();
+	sev();
 }
 
 /*
-- 
1.8.2.2
