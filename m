From: zhoujiewu@gmail.com (zhoujie wu)
Date: Wed, 4 Sep 2013 14:59:34 +0800
Subject: question about clk notifier in common clock tree
Message-ID: <CAAXpJNvOHWhOF9R7xADzTeYvM1JPFC+sJ6zZej9Ym5vab7D7VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

Now in our platform, we are using clk notifer to adjust voltage before
clock rate change or after rate change.

But for some clock modules, it even have to adjust voltage when clock
enable and disable.
For example, when it is working(clock enabled), it requires voltage
1.2V. When it finished its work, it could release it's voltage
requirement.
Do you think if it is ok we also send out notifier in __clk_prepare
and __clk_unprepare as below?

Thanks.

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 54a191c..2f64f1e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -34,6 +34,9 @@ static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);

+static int __clk_notify(struct clk *clk, unsigned long msg,
+ unsigned long old_rate, unsigned long new_rate);
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
@@ -697,6 +700,9 @@ void __clk_unprepare(struct clk *clk)
  if (clk->ops->unprepare)
  clk->ops->unprepare(clk->hw);

+ /* send out notifier for dvfs */
+ __clk_notify(clk, POST_RATE_CHANGE, clk->rate, 0);
+
  __clk_unprepare(clk->parent);
 }

@@ -738,6 +744,9 @@ int __clk_prepare(struct clk *clk)
  return ret;
  }
  }
+
+ /* send out notifier for dvfs */
+ __clk_notify(clk, PRE_RATE_CHANGE, 0, clk->rate);
  }

  clk->prepare_count++;


-- 
Zhoujie Wu
