From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Mar 2014 16:08:36 +0000
Subject: [PATCH] i2c: mv64xxx: Fix compilation breakage
In-Reply-To: <1394204370-22979-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1394204370-22979-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140307160836.GM21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 03:59:30PM +0100, Maxime Ripard wrote:
> @@ -900,7 +902,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  exit_free_irq:
>  	free_irq(drv_data->irq, drv_data);
>  exit_reset:
> -	if (pd->dev.of_node && !IS_ERR(drv_data->rstc))
> +	if (pd->dev.of_node && IS_ENABLED(CONFIG_RESET_CONTROLLER) &&
> +	    !IS_ERR(drv_data->rstc))
>  		reset_control_assert(drv_data->rstc);

Another question is... why do we need to check pd->dev.of_node here?
If CONFIG_RESET_CONTROLLER is set, we always try to get the reset
controller node, so drv_data->rstc is either going to be a valid
pointer, or it's going to be an error pointer - neither
reset_control_get() nor devm_reset_control_get return NULL.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
