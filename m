From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 21 Jan 2015 18:44:05 +0000
Subject: [PATCH v2] drm/i2c: tda998x: Set the CEC I2C address based on
 the slave I2C address.
In-Reply-To: <545C835D.1050008@arm.com>
References: <545C835D.1050008@arm.com>
Message-ID: <20150121184405.GI10762@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 08:31:25AM +0000, Andrew Jackson wrote:
> The I2C address for the TDA9989 and TDA19989 is fixed at 0x34
> but the two LSBs of the TDA19988's address are set by two configuration
> pins on the chip.  Irrespective of the chip, the associated CEC
> peripheral's I2C address is based upon the main I2C address.
> 
> This patch avoids any special handling required to support
> systems that contain multiple TDA19988 devices on the same
> I2C bus.
> 
> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

Hi Andrew,

What is the status of this patch? Is it going to be pulled by anyone?

Best regards,
Liviu

> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index d476279..eeab17a 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1255,6 +1255,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
>  	struct device_node *np = client->dev.of_node;
>  	u32 video;
>  	int rev_lo, rev_hi, ret;
> +	unsigned short cec_addr;
>  
>  	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(2) | VIP_CNTRL_0_SWAP_B(3);
>  	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
> @@ -1262,7 +1263,9 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
>  
>  	priv->current_page = 0xff;
>  	priv->hdmi = client;
> -	priv->cec = i2c_new_dummy(client->adapter, 0x34);
> +	/* CEC I2C address bound to TDA998x I2C addr by configuration pins */
> +	cec_addr = 0x34 + (client->addr & 0x03);
> +	priv->cec = i2c_new_dummy(client->adapter, cec_addr);
>  	if (!priv->cec)
>  		return -ENODEV;
>  
> -- 
> 1.7.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
