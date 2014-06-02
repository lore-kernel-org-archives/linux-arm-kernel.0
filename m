From: grant.likely@linaro.org (Grant Likely)
Date: Mon, 02 Jun 2014 17:07:15 +0100
Subject: [PATCH 2/3] i2c: Add pointer dereference protection to
 i2c_match_id()
In-Reply-To: <1401716463-23457-3-git-send-email-lee.jones@linaro.org>
References: <1401716463-23457-1-git-send-email-lee.jones@linaro.org>
 <1401716463-23457-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20140602160715.5E90FC40476@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  2 Jun 2014 14:41:02 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> Here we're providing dereference protection for i2c_match_id(), which
> saves us having to do it each time it's called.  We're also stripping
> out the (now) needless check in i2c_device_match().  This patch paves
> the way for other, similar code trimming.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Seems reasonable.

Acked-by: Grant Likely <grant.likely@linaro.org>

> ---
>  drivers/i2c/i2c-core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2e47641..d0c7180 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -83,6 +83,9 @@ void i2c_transfer_trace_unreg(void)
>  static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
>  						const struct i2c_client *client)
>  {
> +	if (!id)
> +		return NULL;
> +
>  	while (id->name[0]) {
>  		if (strcmp(client->name, id->name) == 0)
>  			return id;
> @@ -108,9 +111,10 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
>  		return 1;
>  
>  	driver = to_i2c_driver(drv);
> -	/* match on an id table if there is one */
> -	if (driver->id_table)
> -		return i2c_match_id(driver->id_table, client) != NULL;
> +
> +	/* Finally an I2C match */
> +	if (i2c_match_id(driver->id_table, client))
> +		return 1;
>  
>  	return 0;
>  }
> -- 
> 1.8.3.2
> 
