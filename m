From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 6 Feb 2014 17:51:17 -0700
Subject: [PATCH 10/21] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <1391730137-14814-11-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-11-git-send-email-andrew@lunn.ch>
Message-ID: <20140207005117.GA16263@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 12:42:06AM +0100, Andrew Lunn wrote:
  
> +#define L2_WRITETHROUGH_KIRKWOOD	0x00000010

BIT(x)?

> +#ifdef CONFIG_OF
> +static const struct of_device_id feroceon_ids[] __initconst = {
> +	{ .compatible = "marvell,feroceon-kirkwood"},
> +	{}
> +}

How about following the naming convention from l2x0:

"marvell,kirkwood-cache"
"marvell,feroceon-cache"

> +	if (writethrough) {
> +		writel(readl(base) | L2_WRITETHROUGH_KIRKWOOD, base);
> +		feroceon_l2_init(1);
> +	} else {
> +		writel(readl(base) & ~L2_WRITETHROUGH_KIRKWOOD, base);
> +	feroceon_l2_init(0);

This should only happen for "marvell,kirkwood-cache" - it is very
kirkwood specific.. Someday mv78xx0 will have a different bit of code.

Maybe pass -1 to feroceon_l2_init and don't print the writethrough
type at all for the "marvell,feroceon-cache" case?

Regards,
Jason
