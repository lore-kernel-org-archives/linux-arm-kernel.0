From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 11 Mar 2014 14:15:33 -0600
Subject: [PATCH 1/2] of/irq: Fix irq-mapping in of_irq_parse_raw()
In-Reply-To: <1393944864-28113-1-git-send-email-tharvey@gateworks.com>
References: <1393944864-28113-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20140311201533.GF31835@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 06:54:24AM -0800, Tim Harvey wrote:
> When an interrupt-map contains multiple entries an imap pointer arithmetic
> bug can cause only the first entry to be properly evaluated and causes
> the out_irq parameters to be incorrect depending on the #interrupt-cells
> and #address-cells of the parent interrupt controller.

Tim,

I took a bit closer look at this for you, and I suspect the root fix
is this:

--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -55,7 +55,6 @@ Example:
        intc: interrupt-controller at fff11000 {
                compatible = "arm,cortex-a9-gic";
                #interrupt-cells = <3>;
-               #address-cells = <1>;
                interrupt-controller;
                reg = <0xfff11000 0x1000>,
                      <0xfff10100 0x100>;
(plus the corresponding purge from the .dt files)

It looks like the implementation does follow the OF specification:

 Each mapping entry consists of a 3-tuple of (child-interrupt,
 interrupt-parent, parent-interrupt). The number of cells for the
 child-interrupt specifier is determined by the "#address-cells" and
 "#interrupt-cells"property of this node. The number of cells for the
 parent-interrupt value is determined by the "#address-cells"and
 "#interrupt-cells"property values of this node's
 interrupt-parent.

So by specifying interrupt-cells = 3, address-cells = 1, the GIC is
requiring 4 DWs for its interrupt specifier.

I see no reason why it doesn't have an address-cells = 0 like other
interrupt controllers..

Setting #address-cells to 0 in the GIC node should be functionally
equivalent to your patch below, since newaddrsize will == 0.

Regards,
Jason

> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 9bcf2cf..8829197 100644
> +++ b/drivers/of/irq.c
> @@ -237,11 +237,11 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
>  			/* Check for malformed properties */
>  			if (WARN_ON(newaddrsize + newintsize > MAX_PHANDLE_ARGS))
>  				goto fail;
> -			if (imaplen < (newaddrsize + newintsize))
> +			if (imaplen < newintsize)
>  				goto fail;
>  
> -			imap += newaddrsize + newintsize;
> -			imaplen -= newaddrsize + newintsize;
> +			imap += newintsize;
> +			imaplen -= newintsize;
>  
>  			pr_debug(" -> imaplen=%d\n", imaplen);
>  		}
