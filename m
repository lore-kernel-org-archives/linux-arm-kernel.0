From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue,  9 Oct 2018 17:39:27 +0200
Subject: [PATCH] Doc: lockdep: add information about performance impact
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
Message-ID: <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add some warning related to performance drop.
It should be mentioned that this is not for free
and the platfrom resources (cache, bus interconnect, etc.)
will be used more frequently.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 Documentation/locking/lockdep-design.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 49f58a0..1af3686 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -331,3 +331,22 @@ Run the command and save the output, then compare against the output from
 a later run of this command to identify the leakers.  This same output
 can also help you find situations where runtime lock initialization has
 been omitted.
+
+This feature can have performance impact, which affects context
+switching time, cache invalidations, delays on bus transactions.
+System performance in some use cases can drop x3-x4 times.
+Tested on ARM Exynos5422 and ARM64 Exynos5433 big.LITTLE architectures
+(overhead is really big).
+The overhead can be measures using hackbench which will show different
+finish time (11sec -> 3.4sec(no lockdep)).
+Use 'perf' with enabled events showing cache usage, and bus usage
+(it is architecture specyfic and if needed on ARM enable CCI to check
+bus transactions).
+When you check transaction on cache or buses, the results are way higher
+than normal for the same hackbench test:
+L1d cache invalidations: 26mln vs 4mln
+L2u cache invalidations: 42mln vs 12mln
+bus cyc/access: 30cyc/access vs. 20cyc/access
+context switch is x3 times cheaper.
+Apart from hackbench issue, there is dhrystone performance drop,
+1.05 DMIPS/MHz vs. 1.45 DMIPS/MHz (no lockdep) on 'big' core.
-- 
2.7.4
