From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 16 Nov 2010 18:32:13 +0100
Subject: [PATCH 5/8] OMAP2+: hwmod: rename omap_hwmod_mutex
	to	_hwmod_list_mutex
In-Reply-To: <20101116101808.22777.52852.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
	<20101116101808.22777.52852.stgit@twilight.localdomain>
Message-ID: <4CE2C01D.8010703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Funny, I was about to send you a RFC to get rid of that mutex :-)

Today that mutex is preventing us to be re-entrant during hwmod lookup 
and for_each_by_class iteration, and we'd like to in order to manage 
link between 2 hwmods.

The context is the link between mcbsp and sidetone on OMAP3. Since this 
module are tightly coupled, I was suggesting to Kishon to add the 
sidetone reference directly in the mcbsp hwmod in order to create a 
omap_device that will handle the 2 hwmods at the same time.

Since we are using the iteration to get all the hwmod that belongs to 
the mcbsp class we cannot call the lookup function to get the sidetone 
hwmod at that time.
For the moment we need to do 2 iteration and use intermediate storage to 
workaround that.

After checking the purpose of the mutex, I was wondering if this is 
useful. For the moment the creation of the hwmod list is done only at 
init time, and nothing is supposed to change that at runtime except the 
unregister function.

So I've started to get rid of this function, then of the mutex and I 
added the __init to all these registration functions to avoid the usage 
at runtime. It will save a little bit of memory as well.

Thanks to that we can now use the omap_hwmod_lookup inside the 
omap_hwmod_for_each_by_class.

Does that make sense to you?
I can send you the patches if you want.

Regards,
Benoit



On 11/16/2010 11:18 AM, Paul Walmsley wrote:
> This trivial patch renames omap_hwmod_mutex to _hwmod_list_mutex to indicate
> clearly that it is only used for hwmod list manipulation operations.
>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Beno?t Cousson<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   27 ++++++++++++++-------------
>   1 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 12a0b9a..0e85278 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -156,7 +156,8 @@
>   /* omap_hwmod_list contains all registered struct omap_hwmods */
>   static LIST_HEAD(omap_hwmod_list);
>
> -static DEFINE_MUTEX(omap_hwmod_mutex);
> +/* _hwmod_list_mutex protects the list of registered hwmods */
> +static DEFINE_MUTEX(_hwmod_list_mutex);
>
>   /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
>   static struct omap_hwmod *mpu_oh;
> @@ -874,7 +875,7 @@ static void _shutdown_sysc(struct omap_hwmod *oh)
>    * @name: find an omap_hwmod by name
>    *
>    * Return a pointer to an omap_hwmod by name, or NULL if not found.
> - * Caller must hold omap_hwmod_mutex.
> + * Caller must hold _hwmod_list_mutex.
>    */
>   static struct omap_hwmod *_lookup(const char *name)
>   {
> @@ -1502,7 +1503,7 @@ int omap_hwmod_register(struct omap_hwmod *oh)
>   	    (oh->_state != _HWMOD_STATE_UNKNOWN))
>   		return -EINVAL;
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>
>   	pr_debug("omap_hwmod: %s: registering\n", oh->name);
>
> @@ -1528,7 +1529,7 @@ int omap_hwmod_register(struct omap_hwmod *oh)
>   	ret = 0;
>
>   ohr_unlock:
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>   	return ret;
>   }
>
> @@ -1546,9 +1547,9 @@ struct omap_hwmod *omap_hwmod_lookup(const char *name)
>   	if (!name)
>   		return NULL;
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>   	oh = _lookup(name);
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>
>   	return oh;
>   }
> @@ -1574,13 +1575,13 @@ int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
>   	if (!fn)
>   		return -EINVAL;
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>   	list_for_each_entry(temp_oh,&omap_hwmod_list, node) {
>   		ret = (*fn)(temp_oh, data);
>   		if (ret)
>   			break;
>   	}
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>
>   	return ret;
>   }
> @@ -1663,10 +1664,10 @@ int omap_hwmod_unregister(struct omap_hwmod *oh)
>
>   	pr_debug("omap_hwmod: %s: unregistering\n", oh->name);
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>   	iounmap(oh->_mpu_rt_va);
>   	list_del(&oh->node);
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>
>   	return 0;
>   }
> @@ -2125,7 +2126,7 @@ int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name)
>    * @user: arbitrary context data to pass to the callback function
>    *
>    * For each omap_hwmod of class @classname, call @fn.  Takes
> - * omap_hwmod_mutex to prevent the hwmod list from changing during the
> + * _hwmod_list_mutex to prevent the hwmod list from changing during the
>    * iteration.  If the callback function returns something other than
>    * zero, the iterator is terminated, and the callback function's return
>    * value is passed back to the caller.  Returns 0 upon success, -EINVAL
> @@ -2145,7 +2146,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
>   	pr_debug("omap_hwmod: %s: looking for modules of class %s\n",
>   		 __func__, classname);
>
> -	mutex_lock(&omap_hwmod_mutex);
> +	mutex_lock(&_hwmod_list_mutex);
>
>   	list_for_each_entry(temp_oh,&omap_hwmod_list, node) {
>   		if (!strcmp(temp_oh->class->name, classname)) {
> @@ -2157,7 +2158,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
>   		}
>   	}
>
> -	mutex_unlock(&omap_hwmod_mutex);
> +	mutex_unlock(&_hwmod_list_mutex);
>
>   	if (ret)
>   		pr_debug("omap_hwmod: %s: iterator terminated early: %d\n",
>
>
