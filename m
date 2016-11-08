From: myungjoo.ham@samsung.com (=?UTF-8?B?TXl1bmdKb28gSGFt?=)
Date: Tue, 08 Nov 2016 02:06:58 +0000
Subject: =?UTF-8?B?UkU6IFtSRVNFTkQgUEFUQ0ggdjMgMS8yXSBQTS9kZXZmcmVx?=
 =?UTF-8?B?OiBhZGQgc3VzcGVuZCBmcmVxdWVuY3kgc3VwcG9ydA==?=
References: <1478500420-22045-1-git-send-email-hl@rock-chips.com>
 <CGME20161107063403epcas5p4f8d0d95b9a997ca7bf2b2702c3e5d337@epcas5p4.samsung.com>
Message-ID: <960394560.458817.1478570818491.JavaMail.weblogic@ep2ml102b>
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
> 
>  drivers/devfreq/devfreq.c                 | 18 ++++++++++++++++--
>  drivers/devfreq/governor_simpleondemand.c |  9 +++++++++
>  include/linux/devfreq.h                   |  8 ++++++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
>  
[]
> +void devfreq_opp_get_suspend_opp(struct device *dev, struct devfreq *devfreq)
> +{
> +	struct dev_pm_opp *suspend_opp;
> +
> +	rcu_read_lock();
> +	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
> +	if (suspend_opp)
> +		devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL(devfreq_opp_get_suspend_opp);
> +

Why do we need this function?

This could be done at the init time (devfreq_add_device).

Plus, when it does not have dev_pm_opp_get_suspend_opp() available,

>  /**
>   * devfreq_register_opp_notifier() - Helper function to get devfreq notified
>   *				   for any changes in the OPP availability
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index ae72ba5..a3efee0 100644
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
> +	if (df->stop_polling && df->suspend_freq) {
> +		*freq =	df->suspend_freq;
> +		return 0;
> +	}
> +

Why are you adding this? "Stop polling" does not necessarily mean that
we are doing suspend-to-RAM/disk. It may really mean just to stop at
the current frequency.


Cheers,
MyungJoo
