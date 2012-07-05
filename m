From: robherring2@gmail.com (Rob Herring)
Date: Thu, 05 Jul 2012 09:57:17 -0500
Subject: [PATCH] of: address: Don't fail a lookup just because a node
 has no reg property
In-Reply-To: <1341498754-30445-1-git-send-email-lee.jones@linaro.org>
References: <1341498754-30445-1-git-send-email-lee.jones@linaro.org>
Message-ID: <4FF5AB4D.6090500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2012 09:32 AM, Lee Jones wrote:
> Sometimes it doesn't make any sense for a node to have an address.
> In this case device lookup will always be unsuccessful because we
> currently assume every node will have a reg property. This patch
> changes the semantics so that the resource address and the lookup
> address will only be compared if one exists.
> 
> Things like AUXDATA() rely on of_dev_lookup to return the lookup
> entry of a particular device in order to do things like apply
> platform_data to a device. However, this is currently broken for
> nodes which do not have a reg property, meaning that platform_data
> can not be passed in those cases.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Rob Herring <rob.herring@calxeda.com>

Do you have something dependent on this or want me to apply?

Rob

>  drivers/of/platform.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 343ad29..9600480 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -317,10 +317,9 @@ static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *l
>  	for(; lookup->compatible != NULL; lookup++) {
>  		if (!of_device_is_compatible(np, lookup->compatible))
>  			continue;
> -		if (of_address_to_resource(np, 0, &res))
> -			continue;
> -		if (res.start != lookup->phys_addr)
> -			continue;
> +		if (!of_address_to_resource(np, 0, &res))
> +			if (res.start != lookup->phys_addr)
> +				continue;
>  		pr_debug("%s: devname=%s\n", np->full_name, lookup->name);
>  		return lookup;
>  	}
> 
