From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:22:15 +0100
Subject: [PATCH kexec-tools 14/32] arm: fix off-by-one on memory end
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXT5-0004iJ-VX@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The memory range end is inclusive, not exclusive (see x86).  We should
not be adding one to the value parsed from the /proc/iomem resources.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/kexec-arm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 4e90e69..e47fc00 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -51,7 +51,6 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 		if (count != 2)
 			continue;
 		str = line + consumed;
-		end = end + 1;
 
 		if (memcmp(str, "System RAM\n", 11) == 0) {
 			type = RANGE_RAM;
-- 
1.9.1
