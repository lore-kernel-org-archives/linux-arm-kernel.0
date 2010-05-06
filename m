From: mostawesomedude@gmail.com (Corbin Simpson)
Date: Wed,  5 May 2010 18:19:52 -0700
Subject: [PATCH] arch/arm: Use constants instead of magic numbers in
	do_gettimeofday.
Message-ID: <1273108792-8097-1-git-send-email-MostAwesomeDude@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Part of the Didj patch.

Signed-off-by: Corbin Simpson <MostAwesomeDude@gmail.com>
---
 arch/arm/kernel/time.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index 2875380..5cb4ff9 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -104,12 +104,12 @@ void do_gettimeofday(struct timeval *tv)
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 		usec = system_timer->offset();
 		sec = xtime.tv_sec;
-		usec += xtime.tv_nsec / 1000;
+		usec += xtime.tv_nsec / NSEC_PER_USEC;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 
 	/* usec may have gone up a lot: be safe */
-	while (usec >= 1000000) {
-		usec -= 1000000;
+	while (usec >=  USEC_PER_SEC) {
+		usec -= USEC_PER_SEC;
 		sec++;
 	}
 
-- 
1.6.6.1
