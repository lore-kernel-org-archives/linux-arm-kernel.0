From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 27 Jul 2015 08:50:58 +0530
Subject: [PATCH 07/10] opp: Add OPP sharing information to OPP library
In-Reply-To: <55AD33F3.4000302@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <2e1c7fcc1fb62f73c82bd57d196d054ba2607a55.1434369079.git.viresh.kumar@linaro.org>
 <55A986DD.3010104@codeaurora.org> <20150718063304.GD11802@linux>
 <55AD33F3.4000302@codeaurora.org>
Message-ID: <20150727032058.GI19944@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20-07-15, 10:46, Stephen Boyd wrote:
> >+static struct device_opp *_managed_opp(const struct device_node *np)
> >+{
> >+	struct device_opp *dev_opp;
> >+
> >+	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
> >+		if (dev_opp->np == np) {
> >+			/*
> >+			 * Multiple devices can point to the same OPP table and
> >+			 * so will have same node-pointer, np.
> >+			 *
> >+			 * But the OPPs will be considered as shared only if the
> >+			 * OPP table contains a "opp-shared" property.
> >+			 */
> >+			if (dev_opp->shared_opp)
> >+				return dev_opp;
> >+			else
> >+				return NULL;
> >+		
> 
> The janitors will probably find this and say that it could be
> simplified to an if () and a return without the else.

And I am trying to make the janitors happy with this:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index eb920e3f115b..8c81784fe473 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -168,7 +168,7 @@ static struct device_opp *_managed_opp(const struct device_node *np)
 {
        struct device_opp *dev_opp;
 
-       list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
+       list_for_each_entry_rcu(dev_opp, &dev_opp_list, node) {
                if (dev_opp->np == np) {
                        /*
                         * Multiple devices can point to the same OPP table and
@@ -177,11 +177,9 @@ static struct device_opp *_managed_opp(const struct device_node *np)
                         * But the OPPs will be considered as shared only if the
                         * OPP table contains a "opp-shared" property.
                         */
-                       if (dev_opp->shared_opp)
-                               return dev_opp;
-                       else
-                               return NULL;
+                       return dev_opp->shared_opp ? dev_opp : NULL;
                }
+       }
 
        return NULL;
 }

-- 
viresh
