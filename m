From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 17 May 2013 11:51:51 +0200
Subject: [PATCH 9/9] I2C: mv64xxx: fix race between FSM/interrupt and
 process context
In-Reply-To: <E1Ud4xE-0004KB-2T@rmk-PC.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4xE-0004KB-2T@rmk-PC.arm.linux.org.uk>
Message-ID: <20130517095149.GI17056@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> @@ -271,12 +273,25 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>  {
>  	switch(drv_data->action) {
>  	case MV64XXX_I2C_ACTION_SEND_RESTART:
> +		/* We should only get here if we have further messages */
> +		BUG_ON(drv_data->num_msgs == 0);
> +

...

> @@ -453,16 +463,20 @@ static int
>  mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  {
>  	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
> -	int	i, rc;
> +	int rc, ret = num;
>  
> -	for (i = 0; i < num; i++) {
> -		rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i],
> -						i == 0, i + 1 == num);
> -		if (rc < 0)
> -			return rc;
> -	}
> +	BUG_ON(drv_data->msgs != NULL);

Can't we handle this more gracefully than to halt the kernel? Like
WARN_ON and resetting the controller or disabling the bus or...
