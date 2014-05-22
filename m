From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 May 2014 14:47:59 +0200
Subject: [PATCH 1/4] ARM: mvebu: fix big endian booting after coherency code
 rework
In-Reply-To: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400762882-10116-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the introduction of the cpuidle support for Armada XP, the
coherency code was significantly reworked, especially in the
coherency_ll.S file. However, when the ll_get_cpuid function was
created, the big-endian specific code that switches the endianess of
the register was not updated properly.

This patch fixes this code, and therefore makes big endian systems
bootable again.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Fixes: 2e8a5942f875 ("ARM: mvebu: Split low level functions to manipulate HW coherency")
Reported-by: Kevin Hilman <khilman@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
---
Jason, the offending commit is only scheduled for 3.16, so there is no
need to push this patch for 3.15 or stable.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 6828f9f..a5e62c6 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -49,7 +49,7 @@ ENTRY(ll_get_cpuid)
 	and	r3, r3, #15
 	mov	r2, #(1 << 24)
 	lsl	r3, r2, r3
-ARM_BE8(rev	r1, r1)
+ARM_BE8(rev	r3, r3)
 	mov	pc, lr
 ENDPROC(ll_get_cpuid)
 
-- 
1.9.3
