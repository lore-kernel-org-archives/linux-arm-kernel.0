From: ccross@android.com (Colin Cross)
Date: Sat, 19 Feb 2011 14:25:55 -0800
Subject: [PATCH v2 06/21] ARM: tegra: clock: Initialize clocks that have no
	enable
In-Reply-To: <1298154371-5641-1-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
Message-ID: <1298154371-5641-8-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assume that any clock that has no enable op is always on.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/clock.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index 0ea5d92..79c0bd8 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -166,6 +166,15 @@ void clk_init(struct clk *c)
 	if (c->ops && c->ops->init)
 		c->ops->init(c);
 
+	if (!c->ops || !c->ops->enable) {
+		c->refcnt++;
+		c->set = 1;
+		if (c->parent)
+			c->state = c->parent->state;
+		else
+			c->state = ON;
+	}
+
 	clk_recalculate_rate(c);
 
 	list_add(&c->node, &clocks);
-- 
1.7.3.1
