From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Oct 2015 12:19:33 +0200
Subject: [PATCH v2 5/6] vfio: platform: use list of registered reset
 function
In-Reply-To: <1445506922-6005-6-git-send-email-eric.auger@linaro.org>
References: <1445506922-6005-1-git-send-email-eric.auger@linaro.org>
 <1445506922-6005-6-git-send-email-eric.auger@linaro.org>
Message-ID: <20554656.kA5nRBgtaJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 October 2015 11:42:01 Eric Auger wrote:
> Remove the static lookup table and use the dynamic list of registered
> reset functions instead. Also load the reset module through its alias.
> The reset struct module pointer is stored in vfio_platform_device.
> 
> We also remove the useless struct device pointer parameter in
> vfio_platform_get_reset.
> 
> This patch fixes the issue related to the usage of __symbol_get, which
> besides from being moot, prevented compilation with CONFIG_MODULES
> disabled.
> 
> Also usage of MODULE_ALIAS makes possible to add a new reset module
> without needing to update the framework. This was suggested by Arnd.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>

Looks good, just small style issues:

> 
> -			}
> +	mutex_lock(&reset_lock);
> +	list_for_each_entry(iter, &reset_list, link) {
> +		if (!strcmp(iter->compat, compat) &&
> +			try_module_get(iter->owner)) {
> +			*module = iter->owner;
> +			mutex_unlock(&reset_lock);
> +			return iter->reset;
>  		}
>  	}
> +
> +	mutex_unlock(&reset_lock);
> +	return NULL;

Better use 'break' to have a single mutex_unlock and return  statement.

> +
>  
>  static void vfio_platform_put_reset(struct vfio_platform_device *vdev)
>  {
> -	if (vdev->reset)
> -		symbol_put_addr(vdev->reset);
> +	if (vdev->reset) {
> +		module_put(vdev->reset_module);
> +		vdev->reset_module = NULL;
> +		vdev->reset = NULL;
> +	}
>  }

This gets called from the remove callback. No need to clear those
struct members immediately before the kfree().

	Arnd
