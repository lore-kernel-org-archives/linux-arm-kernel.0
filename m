From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Aug 2013 17:03:46 +0200
Subject: [PATCH v3 4/5] clk: Assign module owner of a clock being registered
In-Reply-To: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
References: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1377270227-1030-5-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign module owner of a driver of a device passed to _clk_register()
and __clk_register() functions so the module_{get,put} calls in
__clk_get(), __clk_put() can have required effect.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Initially I had an 'owner' field added to struct clk_init_data so it can
be set explicitly in clock providers.  But this required modifications
of all users of (devm_)clk_register() as struct clk_init_data instance
was in most cases an unitialized stack variable.  This would also require
adding yet another argument to various clk_register_* functions
registering the standard clocks.  So I went for assigning clk->owner from
dev->driver->owner.  The disadvantages are that dereferencing dev->driver
may be potentially unsafe when not holding struct device::mutex.  And
there might be cases where clk->owner will need to be NULL.  One option
is to set dev argument of clk_register_*() to NULL for that, but it
predates devm_*.

Presumably a requirement could be added that callers of clk_register*()
must ensure dev->driver won't change during a call to these functions ?
---
 drivers/clk/clk.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c173f30..272d68d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1692,6 +1692,10 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 	clk->flags = hw->init->flags;
 	clk->parent_names = hw->init->parent_names;
 	clk->num_parents = hw->init->num_parents;
+	if (dev && dev->driver)
+		clk->owner = dev->driver->owner;
+	else
+		clk->owner = NULL;

 	ret = __clk_init(dev, clk);
 	if (ret)
@@ -1712,6 +1716,8 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 		goto fail_name;
 	}
 	clk->ops = hw->init->ops;
+	if (dev && dev->driver)
+		clk->owner = dev->driver->owner;
 	clk->hw = hw;
 	clk->flags = hw->init->flags;
 	clk->num_parents = hw->init->num_parents;
--
1.7.9.5
