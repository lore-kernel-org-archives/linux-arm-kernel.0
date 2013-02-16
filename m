From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 16 Feb 2013 20:52:20 +0100
Subject: [PATCH] i2c: Remove unneeded xxx_set_drvdata(..., NULL) calls
In-Reply-To: <1360970315-32116-1-git-send-email-dianders@chromium.org>
References: <1360953682-25066-1-git-send-email-dianders@chromium.org>
 <1360970315-32116-1-git-send-email-dianders@chromium.org>
Message-ID: <20130216205220.0a4f871c@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013 15:18:35 -0800, Doug Anderson wrote:
> There is simply no reason to be manually setting the private driver
> data to NULL in the remove/fail to probe cases.  This is just extra
> cruft code that can be removed.
> 
> A few notes:
> * Nothing relies on drvdata being set to NULL.
> * The __device_release_driver() function eventually calls
>   dev_set_drvdata(dev, NULL) anyway, so there's no need to do it
>   twice.

I had not noticed this change. Very good news!

> * I verified that there were no cases where xxx_get_drvdata() was
>   being called in these drivers and checking for / relying on the NULL
>   return value.
> 
> This could be cleaned up kernel-wide but for now just take the baby
> step and remove from the i2c subsystem.
> 
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> (...)

For i2c-taos-evm:

Reviewed-by: Jean Delvare <khali@linux-fr.org>

Also a note:

> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -595,7 +595,7 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>  	result = i2c_add_adapter(&i2c->adap);
>  	if (result < 0) {
>  		dev_err(i2c->dev, "failed to add adapter\n");
> -		goto fail_add;
> +		goto out;
>  	}
>  	dev_info(i2c->dev, "version %s\n", DRV_VERSION);
>  
> @@ -603,8 +603,6 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -fail_add:
> -	platform_set_drvdata(pdev, NULL);
>  out:
>  	return result;
>  };

There no longer is any point in this error path, all gotos in this
function could be changed to returns (in a separate patch, obviously.)

-- 
Jean Delvare
