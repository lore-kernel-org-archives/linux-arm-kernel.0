From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Fri, 17 Mar 2017 22:10:34 +0530
Subject: [PATCH] ARM: nommu: access ID_PFR1 only if CPUID scheme
Message-ID: <20170317164034.4036-1-afzal.mohd.ma@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg upon trying to boot no-MMU Kernel on ARM926EJ reported boot
failure. He root caused it to ID_PFR1 access introduced by the
commit mentioned in the fixes tag below.

All CP15 processors need not have processor feature registers, only
for architectures defined by CPUID scheme would have it. Hence check
for it before accessing processor feature register, ID_PFR1.

Fixes: f8300a0b5de0 ("ARM: 8647/2: nommu: dynamic exception base address setting")
Reported-by: Greg Ungerer <gerg@uclinux.org>
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Hi Russell,

It would be good to have the fix go in during -rc, as,

1. Culprit commit went in during the last merge window
2. Though nothing supported in mainline is known to be broken, the
    original change needs to be modified to be reliable

Vladimir, this is being posted as the issue is taken care run time.

Regards
afzal

---
 arch/arm/mm/nommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 3b5c7aaf9c76..33a45bd96860 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -303,7 +303,10 @@ static inline void set_vbar(unsigned long val)
  */
 static inline bool security_extensions_enabled(void)
 {
-	return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
+	/* Check CPUID Identification Scheme before ID_PFR1 read */
+	if ((read_cpuid_id() & 0x000f0000) == 0x000f0000)
+		return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
+	return 0;
 }
 
 static unsigned long __init setup_vectors_base(void)
-- 
2.12.0
