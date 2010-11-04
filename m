From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Nov 2010 17:30:45 +0000
Subject: [PATCH] ARM: vexpress ct-ca9x4: only set twd_base if local timers are
	being used
Message-ID: <1288891845-12630-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit bde28b84, I made the assumption that CONFIG_SMP is always set
for the quad-core ct-ca9x4 platform. As it turns out, people who aren't
using the SMP goodness are confronted with a build failure.

This patch fixes this issue by ensure that twd_base is only set if
local timers are being used (and therefore SMP support is configured).

Reported-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-vexpress/ct-ca9x4.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index c2e405a..fd25ccd 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -54,7 +54,9 @@ static struct map_desc ct_ca9x4_io_desc[] __initdata = {
 
 static void __init ct_ca9x4_map_io(void)
 {
+#ifdef CONFIG_LOCAL_TIMERS
 	twd_base = MMIO_P2V(A9_MPCORE_TWD);
+#endif
 	v2m_map_io(ct_ca9x4_io_desc, ARRAY_SIZE(ct_ca9x4_io_desc));
 }
 
-- 
1.7.0.4
