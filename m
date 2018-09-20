From: peda@axentia.se (Peter Rosin)
Date: Thu, 20 Sep 2018 19:31:19 +0200
Subject: [RFC PATCH 3/4] i2c: core: use I2C locking behaviour also for
 SMBUS
In-Reply-To: <20180920161423.13990-4-wsa+renesas@sang-engineering.com>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-4-wsa+renesas@sang-engineering.com>
Message-ID: <e31d69ed-d849-db98-00c2-27d489a2dac1@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-09-20 18:14, Wolfram Sang wrote:
> If I2C transfers are executed in atomic contexts, trylock is used
> instead of lock. This behaviour was missing for SMBUS, although a lot of
> transfers are of SMBUS type, either emulated or direct. So, factor out
> the locking routine into a helper and use it for I2C and SMBUS.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Is it ok with static analyzers to "hide" the locking in helpers like
this? Will it not be harder for them to "see" what's going on? But I
don't think we have any annotations anyway, so...

Acked-by: Peter Rosin <peda@axentia.se>


> ---
>  drivers/i2c/i2c-core-base.c  | 11 +++--------
>  drivers/i2c/i2c-core-smbus.c |  7 ++++++-
>  drivers/i2c/i2c-core.h       | 12 ++++++++++++
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 799776c6d421..904b4d2ebefa 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1943,14 +1943,9 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  	 *    one (discarding status on the second message) or errno
>  	 *    (discarding status on the first one).
>  	 */
> -	if (in_atomic() || irqs_disabled()) {
> -		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT);
> -		if (!ret)
> -			/* I2C activity is ongoing. */
> -			return -EAGAIN;
> -	} else {
> -		i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
> -	}
> +	ret = __i2c_lock_bus_helper(adap);
> +	if (ret)
> +		return ret;
>  
>  	ret = __i2c_transfer(adap, msgs, num);
>  	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 9cd66cabb84f..dbb46edb8e02 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -20,6 +20,8 @@
>  #include <linux/i2c-smbus.h>
>  #include <linux/slab.h>
>  
> +#include "i2c-core.h"
> +
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/smbus.h>
>  
> @@ -530,7 +532,10 @@ s32 i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  {
>  	s32 res;
>  
> -	i2c_lock_bus(adapter, I2C_LOCK_SEGMENT);
> +	res = __i2c_lock_bus_helper(adapter);
> +	if (res)
> +		return res;
> +
>  	res = __i2c_smbus_xfer(adapter, addr, flags, read_write,
>  			       command, protocol, data);
>  	i2c_unlock_bus(adapter, I2C_LOCK_SEGMENT);
> diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
> index 37576f50fe20..6e98aa811980 100644
> --- a/drivers/i2c/i2c-core.h
> +++ b/drivers/i2c/i2c-core.h
> @@ -29,6 +29,18 @@ extern int		__i2c_first_dynamic_bus_num;
>  
>  int i2c_check_7bit_addr_validity_strict(unsigned short addr);
>  
> +static inline int __i2c_lock_bus_helper(struct i2c_adapter *adap)
> +{
> +	int ret = 0;
> +
> +	if (in_atomic() || irqs_disabled())
> +		ret = i2c_trylock_bus(adap, I2C_LOCK_SEGMENT) ? 0 : -EAGAIN;
> +	else
> +		i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_ACPI
>  const struct acpi_device_id *
>  i2c_acpi_match_device(const struct acpi_device_id *matches,
> 
