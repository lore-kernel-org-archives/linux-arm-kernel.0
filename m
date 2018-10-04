From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Thu, 4 Oct 2018 09:26:02 -0700
Subject: [PATCH i2c-next v5 2/5] i2c: Add support for 'timeout-ms' and
 '#retries' OF properties
In-Reply-To: <20181003223107.16133-3-jae.hyun.yoo@linux.intel.com>
References: <20181003223107.16133-1-jae.hyun.yoo@linux.intel.com>
 <20181003223107.16133-3-jae.hyun.yoo@linux.intel.com>
Message-ID: <1832adbf-fa95-ccfc-00e5-63568059bcd1@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1214,6 +1214,7 @@ EXPORT_SYMBOL_GPL(i2c_handle_smbus_host_notify);
>   static int i2c_register_adapter(struct i2c_adapter *adap)
>   {
>   	int res = -EINVAL;
> +	u32 timeout_ms;

Will change it to:

u32 timeout_ms = 0;

>   
>   	/* Can't register until after driver model init */
>   	if (WARN_ON(!is_registered)) {
> @@ -1239,8 +1240,21 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>   	INIT_LIST_HEAD(&adap->userspace_clients);
>   
>   	/* Set default timeout to 1 second if not already set */
> -	if (adap->timeout == 0)
> -		adap->timeout = HZ;
> +	if (adap->timeout == 0) {
> +		if (adap->dev.of_node)
> +			res = of_property_read_u32(adap->dev.of_node,
> +						   "timeout-ms",
> +						   &timeout_ms);
> +		if (res)
> +			timeout_ms = 0;
> +

Also, it should be:

if (adap->dev.of_node)
	of_property_read_u32(adap->dev.of_node, "timeout-ms",
			     &timeout_ms);

Will submit a new patch set.

Thanks,
Jae

> +		adap->timeout = timeout_ms ? msecs_to_jiffies(timeout_ms) : HZ;
> +	}
> +
> +	/* Set retries value if it has the OF property */
> +	if (adap->dev.of_node)
> +		of_property_read_u32(adap->dev.of_node, "#retries",
> +				     &adap->retries);
>   
>   	/* register soft irqs for Host Notify */
>   	res = i2c_setup_host_notify_irq_domain(adap);
> 
