From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 18:21:57 +0200
Subject: [PATCH 1/2] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <1370619743-15245-2-git-send-email-gregory.clement@free-electrons.com>
References: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
 <1370619743-15245-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130607182157.34188f72@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri,  7 Jun 2013 17:42:22 +0200, Gregory CLEMENT wrote:

>  /* Driver states */
>  enum {
>  	MV64XXX_I2C_STATE_INVALID,
> @@ -110,6 +133,7 @@ struct mv64xxx_i2c_data {
>  	spinlock_t		lock;
>  	struct i2c_msg		*msg;
>  	struct i2c_adapter	adapter;
> +	int			bridge_enabled;

bool ?

> @@ -528,6 +652,7 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  {
>  	u32 bus_freq, tclk;
>  	int rc = 0;
> +	const char *bridge_status;
>  
>  	/* CLK is mandatory when using DT to describe the i2c bus. We
>  	 * need to know tclk in order to calculate bus clock
> @@ -554,6 +679,15 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
>  	 * So hard code the value to 1 second.
>  	 */
>  	drv_data->adapter.timeout = HZ;
> +
> +	/*
> +	 * Acquire information on Transaction Generator support.
> +	 */
> +	bridge_status = of_get_property(np, "", NULL);

It is not clear to me what this new bridge_status local variable is
doing.

> +	if (of_property_read_bool(np, "i2c,i2c-bridge"))
> +		drv_data->bridge_enabled = 1;
> +	else
> +		drv_data->bridge_enabled = 0;

This could be written directly as:

	drv_data->bridge_enabled = of_property_read_bool(np, "i2c,i2c-bridge");

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
