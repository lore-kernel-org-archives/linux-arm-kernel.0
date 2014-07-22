From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Tue, 22 Jul 2014 22:18:08 +0800
Subject: [PATCH -next] ARM: mvebu: fix return value check in
 armada_xp_pmsu_cpufreq_init()
Message-ID: <1406038688-26417-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_get() returns ERR_PTR()
and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-mvebu/pmsu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index c30b7d7..4f6ef6e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -637,9 +637,9 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		}
 
 		clk = clk_get(cpu_dev, 0);
-		if (!clk) {
+		if (IS_ERR(clk)) {
 			pr_err("Cannot get clock for CPU %d\n", cpu);
-			return -ENODEV;
+			return PTR_ERR(clk);
 		}
 
 		/*
