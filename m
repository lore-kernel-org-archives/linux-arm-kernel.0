From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Wed, 8 Mar 2017 21:52:58 +0530
Subject: [PATCH v2 2/4] ARM: nommu: dynamic exception base address setting
In-Reply-To: <314159a7-b664-1256-647d-c05880ad7710@uclinux.org>
References: <314159a7-b664-1256-647d-c05880ad7710@uclinux.org>
Message-ID: <20170308162258.GA3515@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Was standing on one leg & hoping that nothing breaks, knocked down,

On Wed, Mar 08, 2017 at 01:21:36PM +1000, Greg Ungerer wrote:

> This patch (which is in mainline now as commit f8300a0b5d) breaks
> my patch series to support running the Versatile QEMU target with
> a nommu configured linux kernel.

Sorry

> > +	return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
> 
> The problem is here. This ends up generating the asm code:
> 
>   2ebacc:       ee103f31        mrc     15, 0, r3, cr0, cr1, {1}

Thanks for finding the root cause


i have in mind the diff at the end (need to recheck it's correctness),
saw your response that Vladimir's fix works for you, either (if this
works) way, let's fix ASAP.

Regards
afzal

---8<---
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 3b5c7aaf9c76..081562f5436e 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -303,7 +303,9 @@ static inline void set_vbar(unsigned long val)
  */
 static inline bool security_extensions_enabled(void)
 {
-	return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
+	if ((read_cpuid_id() & 0x000F0000) == 0x000F0000)
+		return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
+	return 0;
 }
 
 static unsigned long __init setup_vectors_base(void)
