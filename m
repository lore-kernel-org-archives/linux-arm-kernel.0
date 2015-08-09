From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 9 Aug 2015 14:34:30 +0200
Subject: [PATCH v2 13/22] i2c: core: Probe i2c master devices on demand
In-Reply-To: <1438089593-7696-14-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438089593-7696-14-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150809123430.GB1521@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 03:19:44PM +0200, Tomeu Vizoso wrote:
> When looking up an i2c master through its firmware node, probe it if it
> hasn't already.
> 
> The goal is to reduce deferred probes to a minimum, as it makes it very
> cumbersome to find out why a device failed to probe, and can introduce
> very big delays in when a critical device is probed.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

What is the status of this series? The boot time reduction sounds great.

> ---
> 
> Changes in v2: None
> 
>  drivers/i2c/i2c-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index e6d4935161e4..5520b413e3db 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1353,6 +1353,8 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
>  {
>  	struct device *dev;
>  
> +	fwnode_ensure_device(&node->fwnode);

TBH, the function name doesn't tell me a lot. It ensures what?

> +
>  	dev = bus_find_device(&i2c_bus_type, NULL, node,
>  					 of_dev_node_match);
>  	if (!dev)
> -- 
> 2.4.3
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150809/1949a188/attachment.sig>
