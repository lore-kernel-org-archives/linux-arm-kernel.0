From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 28 Apr 2011 10:22:12 +0200
Subject: [PATCH 1/3] i2c: append hardware lock with bus lock
In-Reply-To: <1303963358-4652-1-git-send-email-haojian.zhuang@gmail.com>
References: <2011042801>
	<1303963358-4652-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20110428102212.2d8d607c@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Thu, 28 Apr 2011 12:02:36 +0800, Haojian Zhuang wrote:
> Both AP and CP are contained in Marvell PXA910 silicon. These two ARM
> cores are sharing one pair of I2C pins.
> 
> In order to keep I2C transaction operated with atomic, hardware lock
> (RIPC) is required. Because of this, bus lock in AP side can't afford
> this requirement. Now hardware lock is appended.

I have no objection to the idea, but one question: when using the
hardware lock, isn't the software mutex redundant? I would expect that
you call the hardware_lock/unlock functions _instead_ of
rt_mutex_lock/unlock, rather than in addition to it. Or do you still
need the rt_mutex to prevent priority inversion?

> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/i2c/i2c-core.c |   22 ++++++++++++++++++----
>  include/linux/i2c.h    |    3 +++
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 045ba6e..412c7a5 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -448,8 +448,11 @@ void i2c_lock_adapter(struct i2c_adapter *adapter)
>  
>  	if (parent)
>  		i2c_lock_adapter(parent);
> -	else
> +	else {
>  		rt_mutex_lock(&adapter->bus_lock);
> +		if (adapter->hardware_lock)
> +			adapter->hardware_lock();
> +	}
>  }
>  EXPORT_SYMBOL_GPL(i2c_lock_adapter);
>  
> @@ -460,11 +463,19 @@ EXPORT_SYMBOL_GPL(i2c_lock_adapter);
>  static int i2c_trylock_adapter(struct i2c_adapter *adapter)
>  {
>  	struct i2c_adapter *parent = i2c_parent_is_i2c_adapter(adapter);
> +	int ret = 0;
>  
>  	if (parent)
>  		return i2c_trylock_adapter(parent);
> -	else
> -		return rt_mutex_trylock(&adapter->bus_lock);
> +	else {
> +		ret = rt_mutex_trylock(&adapter->bus_lock);
> +		if (ret && adapter->hardware_trylock) {
> +			ret = adapter->hardware_trylock();
> +			if (!ret)
> +				i2c_unlock_adapter(adapter);
> +		}
> +		return ret;
> +	}
>  }
>  
>  /**
> @@ -477,8 +488,11 @@ void i2c_unlock_adapter(struct i2c_adapter *adapter)
>  
>  	if (parent)
>  		i2c_unlock_adapter(parent);
> -	else
> +	else {
> +		if (adapter->hardware_unlock)
> +			adapter->hardware_unlock();
>  		rt_mutex_unlock(&adapter->bus_lock);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
>  
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 06a8d9c..b283b4e 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -361,6 +361,9 @@ struct i2c_adapter {
>  
>  	/* data fields that are valid for all devices	*/
>  	struct rt_mutex bus_lock;
> +	void (*hardware_lock)(void);
> +	void (*hardware_unlock)(void);
> +	int (*hardware_trylock)(void);
>  
>  	int timeout;			/* in jiffies */
>  	int retries;


-- 
Jean Delvare
