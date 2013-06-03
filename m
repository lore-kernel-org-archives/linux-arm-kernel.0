From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 03 Jun 2013 11:15:32 +0100
Subject: [RFC PATCH 2/3] drivers: mfd: vexpress: add timeout API to
 vexpress config interface
In-Reply-To: <1369399986-15649-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1369399986-15649-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1369399986-15649-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1370254532.3407.36.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-05-24 at 13:53 +0100, Lorenzo Pieralisi wrote:
> In case some transactions to the Serial Power Controller (SPC) are lost owing
> to multiple operations handled at once by the M3 controller the OS needs to
> rely on a configuration API that can time out so that failures do not result
> in an unusable system.
> 
> This patch adds a timeout API to the vexpress config programming interface,
> and refactors the existing read/write functions so that they can be reused
> seamlessly on top of the newly defined API.

Isn't one of the main purposes of the config interface to serialise
transactions to the config bus, so why would the SPC be handling
multiple transactions at once? And if we can in fact loose transactions
doesn't this mean we get random failures in the system? E.g. if this
happened at boot in vexpress_spc_populate_opps then cpufreq will fail.

Also, I think the code implementing timeouts is broken, see below.

> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Achin Gupta <achin.gupta@arm.com>
> Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Jon Medhurst <tixy@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  drivers/mfd/vexpress-config.c | 26 +++++++---
>  include/linux/vexpress.h      | 23 ++++++--
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mfd/vexpress-config.c b/drivers/mfd/vexpress-config.c
> index 1af2b0e..6f4aa5a 100644
> --- a/drivers/mfd/vexpress-config.c
> +++ b/drivers/mfd/vexpress-config.c
> @@ -266,8 +266,18 @@ int vexpress_config_wait(struct vexpress_config_trans *trans)
>  }
>  EXPORT_SYMBOL(vexpress_config_wait);
>  
> -int vexpress_config_read(struct vexpress_config_func *func, int offset,
> -		u32 *data)
> +int vexpress_config_wait_timeout(struct vexpress_config_trans *trans,
> +			long jiffies)
> +{
> +	int ret;
> +	ret = wait_for_completion_timeout(&trans->completion, jiffies);

If the request times out, don't we need to call vexpress_config_complete
to dequeue the timed out request and trigger the next one? Though we
will still have a problem where the timeout happens but the request
then does in fact complete normally, in that case we would signal
completion of the second request before it has in fact completed.

So, if transactions really can get silently dropped by thing on the end
of the config bus, then we must have a mechanism for associating a
particular transaction with a completion signal, otherwise we won't know
what transaction actually got completed OK and which ones were dropped
and should receive -ETIMEDOUT.

Finally, I don't think these issues are purely theoretical, I'm pretty
certain that the kernel panics and spinlock bad magic errors I see with
his patch series are due to requests completing after they have been
timed out and then the stack based transaction object is being accessed
after it has gone out of scope.

> +	return ret ? trans->status : -ETIMEDOUT;
> +}
> +EXPORT_SYMBOL(vexpress_config_wait_timeout);
> +
> +int vexpress_config_read_timeout(struct vexpress_config_func *func, int offset,
> +		u32 *data, long jiffies)
>  {
>  	struct vexpress_config_trans trans = {
>  		.func = func,
> @@ -279,14 +289,14 @@ int vexpress_config_read(struct vexpress_config_func *func, int offset,
>  	int status = vexpress_config_schedule(&trans);
>  
>  	if (status == VEXPRESS_CONFIG_STATUS_WAIT)
> -		status = vexpress_config_wait(&trans);
> +		status = vexpress_config_wait_timeout(&trans, jiffies);
>  
>  	return status;
>  }
> -EXPORT_SYMBOL(vexpress_config_read);
> +EXPORT_SYMBOL(vexpress_config_read_timeout);
>  
> -int vexpress_config_write(struct vexpress_config_func *func, int offset,
> -		u32 data)
> +int vexpress_config_write_timeout(struct vexpress_config_func *func,
> +				  int offset, u32 data, long jiffies)
>  {
>  	struct vexpress_config_trans trans = {
>  		.func = func,
> @@ -298,8 +308,8 @@ int vexpress_config_write(struct vexpress_config_func *func, int offset,
>  	int status = vexpress_config_schedule(&trans);
>  
>  	if (status == VEXPRESS_CONFIG_STATUS_WAIT)
> -		status = vexpress_config_wait(&trans);
> +		status = vexpress_config_wait_timeout(&trans, jiffies);
>  
>  	return status;
>  }
> -EXPORT_SYMBOL(vexpress_config_write);
> +EXPORT_SYMBOL(vexpress_config_write_timeout);
> diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
> index 50368e0..e5015d8 100644
> --- a/include/linux/vexpress.h
> +++ b/include/linux/vexpress.h
> @@ -15,6 +15,7 @@
>  #define _LINUX_VEXPRESS_H
>  
>  #include <linux/device.h>
> +#include <linux/sched.h>
>  
>  #define VEXPRESS_SITE_MB		0
>  #define VEXPRESS_SITE_DB1		1
> @@ -102,10 +103,24 @@ struct vexpress_config_func *__vexpress_config_func_get(
>  void vexpress_config_func_put(struct vexpress_config_func *func);
>  
>  /* Both may sleep! */
> -int vexpress_config_read(struct vexpress_config_func *func, int offset,
> -		u32 *data);
> -int vexpress_config_write(struct vexpress_config_func *func, int offset,
> -		u32 data);
> +int vexpress_config_read_timeout(struct vexpress_config_func *func, int offset,
> +		u32 *data, long jiffies);
> +int vexpress_config_write_timeout(struct vexpress_config_func *func,
> +		int offset, u32 data, long jiffies);
> +
> +static inline int vexpress_config_read(struct vexpress_config_func *func,
> +				 int offset, u32 *data)
> +{
> +	return vexpress_config_read_timeout(func, offset, data,
> +					     MAX_SCHEDULE_TIMEOUT);
> +}
> +
> +static inline int vexpress_config_write(struct vexpress_config_func *func,
> +				 int offset, u32 data)
> +{
> +	return vexpress_config_write_timeout(func, offset, data,
> +					     MAX_SCHEDULE_TIMEOUT);
> +}
>  
>  /* Platform control */
>  

-- 
Tixy
