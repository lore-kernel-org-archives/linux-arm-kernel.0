From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 23:36:17 +0200
Subject: [PATCH 12/12] time/jiffies: bring back unconditional LATCH definition
In-Reply-To: <1348868177-21205-1-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
Message-ID: <1348868177-21205-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch a7ea3bbf5d "time/jiffies: Allow CLOCK_TICK_RATE to be undefined"
breaks the compilation of targets that rely on the LATCH definition,
because of recursive header file inclusion not defining CLOCK_TICK_RATE
before it is checked here.

This fixes the problem by moving LATCH back to where it was, but it
seems that there are still cases where SHIFTED_HZ is defined incorrectly
because of the same problem. Need to investigate further.

Without this patch, building h7201_defconfig results in:

arch/arm/mach-h720x/common.c: In function 'h720x_gettimeoffset':
arch/arm/mach-h720x/common.c:50:73: error: 'LATCH' undeclared (first use in this function)
arch/arm/mach-h720x/common.c:50:73: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/mach-h720x/common.c:51:1: warning: control reaches end of non-void function [-Wreturn-type]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/jiffies.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 05e3c2c7..d229ada 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -51,9 +51,10 @@
 #define SH_DIV(NOM,DEN,LSH) (   (((NOM) / (DEN)) << (LSH))              \
                              + ((((NOM) % (DEN)) << (LSH)) + (DEN) / 2) / (DEN))
 
-#ifdef CLOCK_TICK_RATE
 /* LATCH is used in the interval timer and ftape setup. */
-# define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
+#define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
+
+#ifdef CLOCK_TICK_RATE
 
 /*
  * HZ is the requested value. However the CLOCK_TICK_RATE may not allow
-- 
1.7.10
