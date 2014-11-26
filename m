From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 26 Nov 2014 14:47:47 +0530
Subject: [PATCH 4/8] opp: Introduce APIs to remove OPPs
In-Reply-To: <CAKohponz3MsgZNtm1i-aLx8kRRjJwUJjL=B3RE96EiivwXbF2A@mail.gmail.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
 <f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
 <20141125162434.GC5050@linux.vnet.ibm.com>
 <CAKohponBNOm_0_rZqbVKQSoOa81CjnKb8vcfzA6gbm1+Gxn+gg@mail.gmail.com>
 <20141125173943.GG5050@linux.vnet.ibm.com>
 <CAKohponz3MsgZNtm1i-aLx8kRRjJwUJjL=B3RE96EiivwXbF2A@mail.gmail.com>
Message-ID: <CAKohpomKym9dqzQDmS-7ipze4jCYDU4_UN4a36VceHuGezoiVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 November 2014 at 11:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Also it looks like I should use call_srcu() with kfree_rcu() for
> opp_set_availability() case as well to avoid any corner cases.

This is the diff I would be adding to this patch:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index f9d80e6..3f728cd 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -506,7 +506,7 @@ static void kfree_opp_rcu(struct rcu_head *head)
        struct dev_pm_opp *opp = container_of(head, struct dev_pm_opp,
rcu_head);

        pr_info("%s: opp:%p, dynamic:%d\n", __func__, opp, opp->dynamic);
-       kfree(opp);
+       kfree_rcu(opp);
 }

 static void kfree_device_rcu(struct rcu_head *head)
@@ -644,7 +644,7 @@ static int opp_set_availability(struct device
*dev, unsigned long freq,

        list_replace_rcu(&opp->node, &new_opp->node);
        mutex_unlock(&dev_opp_list_lock);
-       kfree_rcu(opp, rcu_head);
+       call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, kfree_opp_rcu);

        /* Notify the change of the OPP availability */
        if (availability_req)
