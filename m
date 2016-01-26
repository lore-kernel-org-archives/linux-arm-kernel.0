From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 26 Jan 2016 09:23:41 +0000
Subject: [PATCH 2/4] ARM: fix cpu feature extracting helper
In-Reply-To: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
References: <1453800223-18590-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1453800223-18590-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b8c9592 "ARM: 8318/1: treat CPU feature register fields as signed
quantities" introduced helper to extract signed quantities of 4-bit
blocks. However, with a current code feature with value 0b1000 isn't
rejected as negative. So fix the "if" condition.

Reported-by: Jonathan Brawn <Jon.Brawn@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/cputype.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index b23c6c8..1ee94c7 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -276,7 +276,7 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
 	int feature = (features >> field) & 15;
 
 	/* feature registers are signed values */
-	if (feature > 8)
+	if (feature > 7)
 		feature -= 16;
 
 	return feature;
-- 
1.7.9.5
