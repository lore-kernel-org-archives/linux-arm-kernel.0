From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 29 Jul 2014 04:20:20 +0200
Subject: [PATCH 13/35] arm: omap: irq: call set_handle_irq() from
 intc_of_init
In-Reply-To: <1406582183-696-14-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-14-git-send-email-balbi@ti.com>
Message-ID: <20140729022019.GB4421@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 28, 2014 at 04:16:01PM -0500, Felipe Balbi wrote:
> this will let us drop .handle_irq and .init_irq fields
> from our generic machine_descs.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/irq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index e6997c5..e452411 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -314,6 +314,8 @@ static int __init intc_of_init(struct device_node *node,
>  
>  	omap_init_irq(res.start, nr_irq, of_node_get(node));
>  
> +	set_handle_irq(omap2_intc_handle_irq);
> +
>  	return 0;
>  }
>

if you respin the patchset you may want to call omap_intc_handle_irq
directly. It makes the review of the patchset less confusing.

(I was wondering why omap3 can call omap2_intc_handle_irq until I
noticed, that your previous changes made both functions simple
wrapper functions for omap_intc_handle_irq)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/8e57e75d/attachment.sig>
