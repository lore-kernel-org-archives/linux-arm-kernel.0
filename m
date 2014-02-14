From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 14 Feb 2014 12:42:28 +0100
Subject: [PATCH 3/5] i2c: mv64xxx: refactor send_start
In-Reply-To: <1392323793-4125-4-git-send-email-wsa@the-dreams.de>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
 <1392323793-4125-4-git-send-email-wsa@the-dreams.de>
Message-ID: <52FE0124.6090808@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/2014 21:36, Wolfram Sang wrote:
> For start and restart, we are doing the same thing. Let's consolidate
> that.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

With my first tests it continue to work with this change,
but I want to have a closer look on it

Thanks,

Gregory


> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index d52d849..9c37b59 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -419,6 +419,17 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
>  	}
>  }
>  
> +static void mv64xxx_i2c_send_start(struct mv64xxx_i2c_data *drv_data)
> +{
> +	/* Can we offload this msg ? */
> +	if (mv64xxx_i2c_offload_msg(drv_data) < 0) {
> +		/* No, switch to standard path */
> +		mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
> +		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
> +			drv_data->reg_base + drv_data->reg_offsets.control);
> +	}
> +}
> +
>  static void
>  mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>  {
> @@ -435,14 +446,11 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>  
>  		drv_data->msgs++;
>  		drv_data->num_msgs--;
> -		if (mv64xxx_i2c_offload_msg(drv_data) < 0) {
> -			drv_data->cntl_bits |= MV64XXX_I2C_REG_CONTROL_START;
> -			writel(drv_data->cntl_bits,
> -			drv_data->reg_base + drv_data->reg_offsets.control);
> +		// CHECKME: Does it work? Order of writel and prepare_for_io is
> +		// exchanged. Also, do we need to change cntl_bits in drv_data
> +		// with |= MV64XXX_I2C_REG_CONTROL_START?
> +		mv64xxx_i2c_send_start(drv_data);
>  
> -			/* Setup for the next message */
> -			mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
> -		}
>  		if (drv_data->errata_delay)
>  			udelay(5);
>  
> @@ -460,13 +468,7 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>  		break;
>  
>  	case MV64XXX_I2C_ACTION_SEND_START:
> -		/* Can we offload this msg ? */
> -		if (mv64xxx_i2c_offload_msg(drv_data) < 0) {
> -			/* No, switch to standard path */
> -			mv64xxx_i2c_prepare_for_io(drv_data, drv_data->msgs);
> -			writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
> -				drv_data->reg_base + drv_data->reg_offsets.control);
> -		}
> +		mv64xxx_i2c_send_start(drv_data);
>  		break;
>  
>  	case MV64XXX_I2C_ACTION_SEND_ADDR_1:
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
