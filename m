From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 2 Jul 2015 11:54:55 +0530
Subject: [PATCH 03/10] OPP: Allocate dev_opp from _add_device_opp()
In-Reply-To: <55948DB0.8060500@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <83bd3b9837b30bab62f41aed3dd2cdf52cc21688.1434369079.git.viresh.kumar@linaro.org>
 <55948DB0.8060500@codeaurora.org>
Message-ID: <20150702062455.GD31684@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01-07-15, 18:02, Stephen Boyd wrote:
> On 06/15/2015 04:57 AM, Viresh Kumar wrote:
> > + * _add_device_opp() - Returns device OPP table
> 
> Find device OPP table, or allocate a new one?

Sure.

> >  static int _opp_add_dynamic(struct device *dev, unsigned long freq,
> >  			    long u_volt, bool dynamic)
> >  {
> > -	struct device_opp *dev_opp = NULL;
> > -	struct dev_pm_opp *opp, *new_opp;
> > +	struct device_opp *dev_opp;
> > +	struct dev_pm_opp *opp = NULL, *new_opp;
> 
> Hm...

> >  	/* Duplicate OPPs ? */
> > -	if (new_opp->rate == opp->rate) {
> > +	if (opp && new_opp->rate == opp->rate) {
> 
> Isn't opp always non-NULL at this point? Maybe this if statement should
> be moved into the list_for_each_entry_rcu() loop.

when the dev_opp was getting created for the first time, before this
patch, we used to do a 'goto list_add'. And so control never reached
here, but now we might find a empty list of OPPs and so 'opp' can be
NULL here.

Not sure about moving this to the loop, as we are already taking
'dev_opp_list_lock' in this routine.

> > +remove_dev_opp:
> > +	_remove_device_opp(dev_opp);
> 
> Doesn't this just return early because dev_opp has something in it?

Hmm, it isn't required probably.

---------------------8<-----------------------

Message-Id: <b13057f196330d0e08f3c517676cc3116b1be4ae.1435818265.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 12 Jun 2015 12:43:14 +0530
Subject: [PATCH] OPP: Allocate dev_opp from _add_device_opp()

There is no need to complicate _opp_add_dynamic() with allocation of
dev_opp as well. Allocate it from _add_device_opp() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 7895fdd64192..f8df0ad3e822 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -408,11 +408,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
 /**
- * _add_device_opp() - Allocate a new device OPP table
+ * _add_device_opp() - Find device OPP table or allocate a new one
  * @dev:	device for which we do this operation
  *
- * New device node which uses OPPs - used when multiple devices with OPP tables
- * are maintained.
+ * It tries to find an existing table first, if it couldn't find one, it
+ * allocates a new OPP table and returns that.
  *
  * Return: valid device_opp pointer if success, else NULL.
  */
@@ -420,6 +420,11 @@ static struct device_opp *_add_device_opp(struct device *dev)
 {
 	struct device_opp *dev_opp;
 
+	/* Check for existing list for 'dev' first */
+	dev_opp = _find_device_opp(dev);
+	if (!IS_ERR(dev_opp))
+		return dev_opp;
+
 	/*
 	 * Allocate a new device OPP table. In the infrequent case where a new
 	 * device is needed to be added, we pay this penalty.
@@ -575,8 +580,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
 static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 			    long u_volt, bool dynamic)
 {
-	struct device_opp *dev_opp = NULL;
-	struct dev_pm_opp *opp, *new_opp;
+	struct device_opp *dev_opp;
+	struct dev_pm_opp *opp = NULL, *new_opp;
 	struct list_head *head;
 	int ret;
 
@@ -592,19 +597,11 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	new_opp->rate = freq;
 	new_opp->u_volt = u_volt;
 	new_opp->available = true;
-	new_opp->dynamic = dynamic;
 
-	/* Check for existing list for 'dev' */
-	dev_opp = _find_device_opp(dev);
-	if (IS_ERR(dev_opp)) {
-		dev_opp = _add_device_opp(dev);
-		if (!dev_opp) {
-			ret = -ENOMEM;
-			goto free_opp;
-		}
-
-		head = &dev_opp->opp_list;
-		goto list_add;
+	dev_opp = _add_device_opp(dev);
+	if (!dev_opp) {
+		ret = -ENOMEM;
+		goto free_opp;
 	}
 
 	/*
@@ -620,7 +617,7 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 	}
 
 	/* Duplicate OPPs ? */
-	if (new_opp->rate == opp->rate) {
+	if (opp && new_opp->rate == opp->rate) {
 		ret = opp->available && new_opp->u_volt == opp->u_volt ?
 			0 : -EEXIST;
 
@@ -630,7 +627,7 @@ static int _opp_add_dynamic(struct device *dev, unsigned long freq,
 		goto free_opp;
 	}
 
-list_add:
+	new_opp->dynamic = dynamic;
 	new_opp->dev_opp = dev_opp;
 	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
