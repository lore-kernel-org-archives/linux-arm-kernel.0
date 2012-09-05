From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Sep 2012 16:23:53 -0700
Subject: [PATCH RESEND 2/4] can: c_can: Add d_can raminit support
In-Reply-To: <1346843564-25343-3-git-send-email-anilkumar@ti.com>
References: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
 <1346843564-25343-3-git-send-email-anilkumar@ti.com>
Message-ID: <20120905232353.GK1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* AnilKumar Ch <anilkumar@ti.com> [120905 04:14]:
> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM,
> which holds all the message objects during transmission or
> receiving of data. This initialization/de-initialization should
> be done in synchronous with D_CAN clock.

Sounds like you should just implement runtime PM calls in the driver
and let the lower level code take care of this for you along with the
clocks etc.

> @@ -1071,6 +1077,8 @@ static int c_can_open(struct net_device *dev)
>  	struct c_can_priv *priv = netdev_priv(dev);
>  
>  	c_can_pm_runtime_get_sync(priv);
> +	/* Initialize DCAN RAM */
> +	c_can_reset_ram(priv, true);
>  
>  	/* open the can device */
>  	err = open_candev(dev);
> @@ -1099,6 +1107,8 @@ static int c_can_open(struct net_device *dev)
>  exit_irq_fail:
>  	close_candev(dev);
>  exit_open_fail:
> +	/* De-Initialize DCAN RAM */
> +	c_can_reset_ram(priv, false);
>  	c_can_pm_runtime_put_sync(priv);
>  	return err;
>  }

Oh your already have pm_runtime here, OK so yeah let's let the omap/am33xx
hwmod code do this for you. No changes to this driver needed then?

Tony
