From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jan 2013 22:44:46 +0200
Subject: [PATCH 2/2] drivers: net:ethernet: cpsw: add support for VLAN
In-Reply-To: <1359403945-28585-3-git-send-email-mugunthanvnm@ti.com>
References: <1359403945-28585-1-git-send-email-mugunthanvnm@ti.com>
 <1359403945-28585-3-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20130128204446.GB5509@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 01:42:25AM +0530, Mugunthan V N wrote:
> adding support for VLAN interface for cpsw.
> 
> CPSW VLAN Capability
> * Can filter VLAN packets in Hardware
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>  Documentation/devicetree/bindings/net/cpsw.txt |    2 +
>  drivers/net/ethernet/ti/cpsw.c                 |  108 +++++++++++++++++++++++-
>  include/linux/platform_data/cpsw.h             |    1 +
>  3 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
> index 6ddd028..99696bf 100644
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -24,6 +24,8 @@ Required properties:
>  Optional properties:
>  - ti,hwmods		: Must be "cpgmac0"
>  - no_bd_ram		: Must be 0 or 1
> +- default_vlan		: Specifies Default VLAN for non tagged packets
> +			  ALE processing
>  
>  Note: "ti,hwmods" field is used to fetch the base address and irq
>  resources from TI, omap hwmod data base during device registration.
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index b35e6a7..dee6951 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -32,6 +32,7 @@
>  #include <linux/of.h>
>  #include <linux/of_net.h>
>  #include <linux/of_device.h>
> +#include <linux/if_vlan.h>
>  
>  #include <linux/platform_data/cpsw.h>
>  
> @@ -72,6 +73,11 @@ do {								\
>  		dev_notice(priv->dev, format, ## __VA_ARGS__);	\
>  } while (0)
>  
> +#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)

use IS_ENABLED() instead.

> +#define VLAN_SUPPORT
> +#define CPSW_VLAN_AWARE_MODE
> +#endif
> +
>  #define ALE_ALL_PORTS		0x7
>  
>  #define CPSW_MAJOR_VERSION(reg)		(reg >> 8 & 0x7)
> @@ -118,6 +124,14 @@ do {								\
>  #define TX_PRIORITY_MAPPING	0x33221100
>  #define CPDMA_TX_PRIORITY_MAP	0x76543210
>  
> +#ifdef CPSW_VLAN_AWARE_MODE
> +#define CPSW_VLAN_AWARE		BIT(1)
> +#define CPSW_ALE_VLAN_AWARE	1
> +#else
> +#define CPSW_VLAN_AWARE		0x0
> +#define CPSW_ALE_VLAN_AWARE	0
> +#endif

you should really figure out a way of doing runtime detection for this.
Depending on driver recompilation just to enable/disable VLAN support
will be quite boring.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130128/fb0d3da0/attachment.sig>
