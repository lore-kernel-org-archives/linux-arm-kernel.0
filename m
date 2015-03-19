From: joshc@ni.com (Josh Cartwright)
Date: Thu, 19 Mar 2015 08:33:53 -0500
Subject: [PATCH 2/2] ARM: zynq: drop use of slcr_unlock in
 zynq_slcr_system_restart
In-Reply-To: <1426772033-29277-1-git-send-email-joshc@ni.com>
References: <BN1BFFO11FD008F29B247339CE49EAEA6AE2010@BN1BFFO11FD008.protection.gbl>
 <1426772033-29277-1-git-send-email-joshc@ni.com>
Message-ID: <1426772033-29277-2-git-send-email-joshc@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SLCR is unconditionally unlocked early on boot in zynq_slcr_init()
and not unlocked.  As such, it is not necessary to explicitly unlock in
the restart codepath.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 arch/arm/mach-zynq/slcr.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index fa4c796..698dc3b 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -102,13 +102,6 @@ int zynq_slcr_system_restart(struct notifier_block *nb,
 	u32 reboot;
 
 	/*
-	 * Unlock the SLCR then reset the system.
-	 * Note that this seems to require raw i/o
-	 * functions or there's a lockup?
-	 */
-	zynq_slcr_unlock();
-
-	/*
 	 * Clear 0x0F000000 bits of reboot status register to workaround
 	 * the FSBL not loading the bitstream after soft-reboot
 	 * This is a temporary solution until we know more.
-- 
2.3.3
