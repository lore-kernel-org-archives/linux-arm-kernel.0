From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Thu, 7 Dec 2017 14:29:49 +0200
Subject: [PATCH V6 3/7] device property: Introduce a common API to fetch
 device match data
In-Reply-To: <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-4-git-send-email-okaya@codeaurora.org>
Message-ID: <20171207122948.yyl6adb6lnb56gok@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

Thanks for the update.

Just one small comment below.

On Tue, Dec 05, 2017 at 12:04:48PM -0500, Sinan Kaya wrote:
> There is an OF/ACPI function to obtain the driver data. We want to hide
> OF/ACPI details from the device drivers and abstract following the device
> family of functions.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/base/property.c  | 6 ++++++
>  include/linux/fwnode.h   | 4 ++++
>  include/linux/property.h | 2 ++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 7ed99c1..65bf6f2 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1335,3 +1335,9 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  	return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
>  }
>  EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
> +
> +void *device_get_match_data(struct device *dev)
> +{
> +	return fwnode_call_ptr_op(dev_fwnode(dev), get_match_data, dev);
> +}
> +EXPORT_SYMBOL_GPL(device_get_match_data);
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 0c35b6c..ab9aab5 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -15,6 +15,7 @@
>  #include <linux/types.h>
>  
>  struct fwnode_operations;
> +struct device;
>  
>  struct fwnode_handle {
>  	struct fwnode_handle *secondary;
> @@ -66,6 +67,7 @@ struct fwnode_reference_args {
>   *			       endpoint node.
>   * @graph_get_port_parent: Return the parent node of a port node.
>   * @graph_parse_endpoint: Parse endpoint for port and endpoint id.
> + * @get_match_data: Return the driver match data.

Could you arrange the new get_match_data op closer to the other ops that
don't deal with the graphs? Such as device_is_available. As the ops are
dealing generally with fwnodes, I might call this device_get_match_data to
explicitly mention it's for devices.

>   */
>  struct fwnode_operations {
>  	void (*get)(struct fwnode_handle *fwnode);
> @@ -101,6 +103,8 @@ struct fwnode_operations {
>  	(*graph_get_port_parent)(struct fwnode_handle *fwnode);
>  	int (*graph_parse_endpoint)(const struct fwnode_handle *fwnode,
>  				    struct fwnode_endpoint *endpoint);
> +	void *(*get_match_data)(const struct fwnode_handle *fwnode,
> +				struct device *dev);

Same comment about the order here.

>  };
>  
>  #define fwnode_has_op(fwnode, op)				\
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 6bebee1..01fa55b 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -275,6 +275,8 @@ int device_add_properties(struct device *dev,
>  
>  enum dev_dma_attr device_get_dma_attr(struct device *dev);
>  
> +void *device_get_match_data(struct device *dev);
> +
>  int device_get_phy_mode(struct device *dev);
>  
>  void *device_get_mac_address(struct device *dev, char *addr, int alen);

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi
