From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 29 Jul 2014 04:12:51 +0200
Subject: [PATCH 19/35] arm: omap: irq: drop ti,intc-size support
In-Reply-To: <1406582183-696-20-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-20-git-send-email-balbi@ti.com>
Message-ID: <20140729021251.GA4421@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 28, 2014 at 04:16:07PM -0500, Felipe Balbi wrote:
> we don't need that anymore since specific
> devices are passing correct compatible flags.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/irq.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 7a4ead3..e70c26e 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -313,9 +313,6 @@ static int __init intc_of_init(struct device_node *node,
>  	if (of_device_is_compatible(node, "ti,am33xx-intc"))
>  		nr_irq = 128;
>  
> -	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
> -		pr_warn("unable to get intc-size, default to %d\n", nr_irq);
> -

keeping this code would avoid breaking the DT API. I suggest to
change it to something like the following:

if (!of_property_read_u32(...))
    dev_warn(dev, "ti,intc-size is deprecated, please update your DT file");

Apart from that the Documentation [0] should be updated (add
deprecation notice for ti,intc-size and add new compatible values)
and maybe moved to [1] (where other SoCs put their irq controller
binding docs).

[0] Documentation/devicetree/bindings/arm/omap/intc.txt
[1] Documentation/devicetree/bindings/interrupt-controller/

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/ba474f43/attachment.sig>
