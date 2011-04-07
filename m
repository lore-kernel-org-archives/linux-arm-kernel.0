From: wni@nvidia.com (wni at nvidia.com)
Date: Thu,  7 Apr 2011 11:30:00 +0800
Subject: [PATCH v1] tegra: remove the clock sleepable WARNING
Message-ID: <1302147000-17854-1-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Ni <wni@nvidia.com>

The dvfs will try to init clock, it trickles down to the child clock.
Part of that init is to set cansleep flag. When setting a clock as cansleep,
in which case the entire list of clocks is traversed to set the children as
cansleep as well. in here, the clk_set_cansleep can only be called on clocks
that are the sole parent of all of their child clocks, meaning the child clock
can not be reparented onto a different, possibly non-sleeping, clock.
If the child clock has the set_parent callback, the driver warns that this case
is not proper, it will show WARNING:
"can't make child clock xxx of xxx sleepable if it's parent could change"
But Some clocks only has one parent, although they have set_parent callback.
These clocks' flags is set to 0, not MUX, it means they can not be reparented.
So we can remove this WARNING if !(flags & MUX).

Signed-off-by: Wei Ni <wni@nvidia.com>
---
v1: This patch against linux-tegra-2.6.37 branch in 
git://android.git.kernel.org/kernel/tegra.git

 arch/arm/mach-tegra/clock.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index f556977..d0b6b45 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -187,7 +187,8 @@ static void __clk_set_cansleep(struct clk *c)
 		if (child->parent != c)
 			continue;
 
-		WARN(child->ops && child->ops->set_parent,
+		WARN(child->ops && child->ops->set_parent
+			&& (child->flags & MUX),
 			"can't make child clock %s of %s "
 			"sleepable if it's parent could change",
 			child->name, c->name);
-- 
1.7.0
