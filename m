From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 16 Oct 2015 23:24:41 -0700
Subject: [PATCH] stm: add configfs dependency
In-Reply-To: <5578991.YxAbTTycJA@wuerfel>
References: <5578991.YxAbTTycJA@wuerfel>
Message-ID: <20151017062441.GA26793@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 12:35:19AM +0200, Arnd Bergmann wrote:
> There are three new stm modules, all of which use configfs for configuration.
> If configfs is not part of the kernel, or is a loadable module while
> the stm driver is builtin, we get a link error like:
> 
> drivers/built-in.o: In function `stp_policy_node_drop':
> drivers/hwtracing/stm/policy.c:232: undefined reference to `config_item_put'
> drivers/built-in.o: In function `stp_policies_make':
> drivers/hwtracing/stm/policy.c:352: undefined reference to `config_group_init_type_name'
> drivers/built-in.o: In function `stp_policy_node_make':
> drivers/hwtracing/stm/policy.c:215: undefined reference to `config_group_init_type_name'
> 
> This adds explicit Kconfig dependencies to ensure configfs is present.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The patches are currently in Greg's char-misc tree, we should have
> this one in the same branch.
> 
> diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
> index 5a59a28cc3da..6df294fff1eb 100644
> --- a/drivers/hwtracing/stm/Kconfig
> +++ b/drivers/hwtracing/stm/Kconfig
> @@ -1,5 +1,6 @@
>  config STM
>  	tristate "System Trace Module devices"
> +	depends on CONFIGFS_FS

It's better to do a select here, like other drivers do, I have a patch
in my queue to do that, I'll queue it up now.

thanks,

greg k-h
