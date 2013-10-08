From: robherring2@gmail.com (Rob Herring)
Date: Tue, 08 Oct 2013 08:07:20 -0500
Subject: [PATCH] VEXPRESS: Fix VEXPRESS implicit declarations dependence
 errors.
In-Reply-To: <1381228895-24814-1-git-send-email-csmanjuvijay@gmail.com>
References: <1381228895-24814-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <52540388.8090709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 05:41 AM, Majunath Goudar wrote:
> This patch adds a of_find_node_by_phandle() and of_get_next_parent()
> function declaration dependence on"#ifdef CONFIG_OF" in "include/linux/of.h"
> else part return inline dummy implementations (returning NULL). Without
> this patch,build system can lead to issues. This was discovered during
> randconfig testing,in which VEXPRESS_CONFIG was enabled w/o CONFIG_OF
> being enabled,leading to the following error:

What is blocking making VExpress DT only?

The subject should reflect the subsystem you are changing and the
description is missing spaces at a minimum.

Rob

> 
> CC      drivers/mfd/vexpress-config.o
> drivers/mfd/vexpress-config.c: In function ?__vexpress_config_func_get?:
> drivers/mfd/vexpress-config.c:117:4: error: implicit declaration of function
> ?of_find_node_by_phandle? [-Werror=implicit-function-declaration]
>     bridge_node = of_find_node_by_phandle(
>     ^
> drivers/mfd/vexpress-config.c:117:16: warning: assignment makes pointer from
> integer without a cast [enabled by default]
>     bridge_node = of_find_node_by_phandle(
> 
> Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  include/linux/of.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f95aee3..968787d 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -340,6 +340,15 @@ int of_device_is_stdout_path(struct device_node *dn);
>  
>  #else /* CONFIG_OF */
>  
> +static inline struct device_node *of_find_node_by_phandle(phandle handle)
> +{
> +	return NULL;
> +}
> +static inline struct device_node *of_get_next_parent(struct device_node *node)
> +{
> +	return NULL;
> +}
> +
>  static inline const char* of_node_full_name(struct device_node *np)
>  {
>  	return "<no-node>";
> 
