From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 20 Sep 2014 14:23:19 +0200
Subject: [PATCH v5 06/11] i2c: core: Convert to
 dev_pm_domain_attach|detach()
In-Reply-To: <1411151264-16245-7-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-7-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140920122318.GC3850@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 08:27:39PM +0200, Ulf Hansson wrote:
> Previously only the ACPI PM domain was supported by the i2c bus.
> 
> Let's convert to the common attach/detach functions for PM domains,
> which currently means we are extending the support to include the
> generic PM domain as well.
> 
> Cc: linux-i2c at vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

Looks good to me, but I'd like to give Mika a chance to look at it,
since he does ACPI with I2C. Adding to CC.

> ---
>  drivers/i2c/i2c-core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 632057a..3cd8f11 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -279,10 +279,13 @@ static int i2c_device_probe(struct device *dev)
>  	if (status < 0)
>  		return status;
>  
> -	acpi_dev_pm_attach(&client->dev, true);
> -	status = driver->probe(client, i2c_match_id(driver->id_table, client));
> -	if (status)
> -		acpi_dev_pm_detach(&client->dev, true);
> +	status = dev_pm_domain_attach(&client->dev, true);
> +	if (status != -EPROBE_DEFER) {
> +		status = driver->probe(client, i2c_match_id(driver->id_table,
> +					client));

Very minor: I think it is more readable to keep this in one line.

> +		if (status)
> +			dev_pm_domain_detach(&client->dev, true);
> +	}
>  
>  	return status;
>  }
> @@ -302,7 +305,7 @@ static int i2c_device_remove(struct device *dev)
>  		status = driver->remove(client);
>  	}
>  
> -	acpi_dev_pm_detach(&client->dev, true);
> +	dev_pm_domain_detach(&client->dev, true);
>  	return status;
>  }
>  
> -- 
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140920/d5eb39c5/attachment.sig>
