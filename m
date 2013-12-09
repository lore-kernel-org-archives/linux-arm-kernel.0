From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 09 Dec 2013 13:11:12 +0000
Subject: [PATCH] ARM: cacheflush: correctly limit range of memory region
 being flushed
Message-ID: <1386594672.3380.21.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __do_cache_op function operates with a 'chunk' size of one page
but fails to limit the size of the final chunk so as to not exceed
the specified memory region. Fix this.

Cc: <stable@vger.kernel.org>
Reported-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

I'm reposting this patch for extra visibility, it was discussed in the
thread title '[GIT PULL] Cacheflush updates for 3.12', see
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/216265.html

This patch is in Russell King's patch system as patch 7917...
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7917/1

 arch/arm/kernel/traps.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index dbf0923..7940241 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -509,9 +509,10 @@ static inline int
 __do_cache_op(unsigned long start, unsigned long end)
 {
 	int ret;
-	unsigned long chunk = PAGE_SIZE;
 
 	do {
+		unsigned long chunk = min(PAGE_SIZE, end - start);
+
 		if (signal_pending(current)) {
 			struct thread_info *ti = current_thread_info();
 
-- 
1.7.10.4
