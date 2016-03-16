From: opensource.ganesh@gmail.com (Ganesh Mahendran)
Date: Wed, 16 Mar 2016 17:32:23 +0800
Subject: [PATCH] Revert "arm64: Increase the max granular size"
Message-ID: <1458120743-12145-1-git-send-email-opensource.ganesh@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reverts commit 97303480753e ("arm64: Increase the max granular size").

The commit 97303480753e ("arm64: Increase the max granular size") will
degrade system performente in some cpus.

We test wifi network throughput with iperf on Qualcomm msm8996 CPU:
----------------
run on host:
  # iperf -s
run on device:
  # iperf -c <device-ip-addr> -t 100 -i 1
----------------

Test result:
----------------
with commit 97303480753e ("arm64: Increase the max granular size"):
    172MBits/sec

without commit 97303480753e ("arm64: Increase the max granular size"):
    230MBits/sec
----------------

Some module like slab/net will use the L1_CACHE_SHIFT, so if we do not
set the parameter correctly, it may affect the system performance.

So revert the commit.

Cc: stable at vger.kernel.org
Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
---
 arch/arm64/include/asm/cache.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 5082b30..bde4499 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -18,7 +18,7 @@
 
 #include <asm/cachetype.h>
 
-#define L1_CACHE_SHIFT		7
+#define L1_CACHE_SHIFT		6
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 /*
-- 
1.7.9.5
