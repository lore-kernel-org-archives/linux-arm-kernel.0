From: myungjoo.ham@samsung.com (=?UTF-8?B?TXl1bmdKb28gSGFt?=)
Date: Wed, 09 Nov 2016 01:53:37 +0000
Subject: =?UTF-8?B?UkU6IFtQQVRDSCB2NF0gUE0vZGV2ZnJlcTogYWRkIHN1c3Bl?=
 =?UTF-8?B?bmQgZnJlcXVlbmN5IHN1cHBvcnQ=?=
References: <CGME20161108091840epcas3p21af60a1b0a4867306366633427567dc3@epcas3p2.samsung.com>
Message-ID: <851217549.619875.1478656417915.JavaMail.weblogic@ep2ml103c>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Add suspend frequency support and if needed set it to
> the frequency obtained from the suspend opp (can be defined
> using opp-v2 bindings and is optional).
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - use update_devfreq() instead devfreq_update_status()
> Changes in v3:
> - fix build error
> Changes in v4:
> - move dev_pm_opp_get_suspend_opp() to devfreq_add_device()
> 
>  drivers/devfreq/devfreq.c                 | 15 +++++++++++++--
>  drivers/devfreq/governor_simpleondemand.c |  9 +++++++++
>  include/linux/devfreq.h                   |  9 +++++++++
>  3 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3ea76..d9d56e1 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -363,7 +363,10 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
>  		mutex_unlock(&devfreq->lock);
>  		return;
>  	}
> -
> +	if (devfreq->suspend_freq) {
> +		update_devfreq(devfreq);
> +		devfreq->suspend_flag = true;

+	} else {
+ 		devfreq_update_status(devfreq, devfreq->previous_freq);
+	}
-   	devfreq_update_status(devfreq, devfreq->previous_freq);

update_devfreq() calls devfreq_update_status.
So let's call it only when update_devfreq is not called.

>  	devfreq->stop_polling = true;
>  	mutex_unlock(&devfreq->lock);
> @@ -394,7 +397,8 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  
>  	devfreq->last_stat_updated = jiffies;
>  	devfreq->stop_polling = false;
> -
> +	if (devfreq->suspend_freq)
> +		devfreq->suspend_flag = false;
>  	if (devfreq->profile->get_cur_freq &&
>  		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
>  		devfreq->previous_freq = freq;
> @@ -528,6 +532,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	struct devfreq *devfreq;
>  	struct devfreq_governor *governor;
>  	int err = 0;
> +	struct dev_pm_opp *suspend_opp;
>  
>  	if (!dev || !profile || !governor_name) {
>  		dev_err(dev, "%s: Invalid parameters.\n", __func__);
> @@ -563,6 +568,12 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
> +	rcu_read_lock();
> +	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
> +	if (suspend_opp)
> +		devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
> +	rcu_read_unlock();
> +
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>  		mutex_unlock(&devfreq->lock);
>  		devfreq_set_freq_table(devfreq);
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index ae72ba5..84b3ce1 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -29,6 +29,15 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	struct devfreq_simple_ondemand_data *data = df->data;
>  	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
>  
> +	/*
> +	 * if devfreq in suspend status and have suspend_freq,
> +	 * the frequency need to set to suspend_freq
> +	 */
> +	if (df->suspend_flag) {
> +		*freq =	df->suspend_freq;
> +		return 0;
> +	}
> +

If this is because of the case when devfreq_simple_ondemand_func() is called
before cancel_delayed_work_sync() in devfreq_monitor_suspend() and
after update_devfreq() in devfreq_monitor_suspend(),
you can use devfreq->stop_polling (and move devfreq->stop_polling = true; a bit earlier).

You do not need to introduce yet another variable, suspend_flag, in the devfreq struct.

The semantics of "stop_polling" fits the purpose well enough.

>  	err = devfreq_update_stats(df);
>  	if (err)
>  		return err;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2de4e2e..c463ae1 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -172,6 +172,7 @@ struct devfreq {
>  	struct delayed_work work;
>  
>  	unsigned long previous_freq;
> +	unsigned long suspend_freq;
>  	struct devfreq_dev_status last_status;
>  
>  	void *data; /* private data for governors */
> @@ -179,6 +180,7 @@ struct devfreq {
>  	unsigned long min_freq;
>  	unsigned long max_freq;
>  	bool stop_polling;
> +	bool suspend_flag;
>  
>  	/* information for device frequency transition */
>  	unsigned int total_trans;
> @@ -214,6 +216,8 @@ extern int devfreq_resume_device(struct devfreq *devfreq);
>  /* Helper functions for devfreq user device driver with OPP. */
>  extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  					   unsigned long *freq, u32 flags);
> +extern void devfreq_opp_get_suspend_opp(struct device *dev,
> +					struct devfreq *devfreq);

No more required.

>  extern int devfreq_register_opp_notifier(struct device *dev,
>  					 struct devfreq *devfreq);
>  extern int devfreq_unregister_opp_notifier(struct device *dev,
> @@ -348,6 +352,11 @@ static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +static inline void devfreq_opp_get_suspend_opp(struct device *dev,
> +					       struct devfreq *devfreq)
> +{
> +}
> +

No more required.

>  static inline int devfreq_register_opp_notifier(struct device *dev,
>  					 struct devfreq *devfreq)
>  {
> -- 
> 2.6.6
> 
> 
> 
