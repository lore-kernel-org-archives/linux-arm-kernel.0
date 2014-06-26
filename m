From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jun 2014 16:22:01 +0300
Subject: [PATCH] clk: define and export __clk_get_debug for providers
Message-ID: <1403788921-7963-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define and export a new function __clk_get_debug which returns the debugfs
directory entry pointer. This can be used by clock providers to add debugfs
entries which are not related to a specific clock type. Examples include the
ability to measure the rate of a clock. It can also be used by modules to
create new debugfs entries. This is useful if you want to expose features
for testing which can potentially cause system instability such as allowing
to change a clock's rate from userspace.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/clk.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8b73ede..5fe7942 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -652,6 +652,15 @@ unsigned long __clk_get_flags(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_get_flags);
 
+struct dentry *__clk_get_dentry(struct clk *clk)
+{
+	if (!clk)
+		return NULL;
+
+	return clk->dentry;
+}
+EXPORT_SYMBOL_GPL(__clk_get_dentry);
+
 bool __clk_is_prepared(struct clk *clk)
 {
 	int ret;
-- 
1.7.7.rc0.72.g4b5ea.dirty
