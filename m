From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Apr 2010 20:06:33 +0100
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the 16-way PL310
In-Reply-To: <1272653651-11590-2-git-send-email-jason.mcmullan@netronome.com>
References: <1272653651-11590-1-git-send-email-jason.mcmullan@netronome.com>
	<1272653651-11590-2-git-send-email-jason.mcmullan@netronome.com>
Message-ID: <20100430190633.GD1639@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 30, 2010 at 02:54:11PM -0400, Jason S. McMullan wrote:
> @@ -217,10 +217,32 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>  	 * accessing the below registers will fault.
>  	 */
>  	if (!(readl(l2x0_base + L2X0_CTRL) & 1)) {
> +		int ways;
> +		uint32_t cache_id;
>  
>  		/* l2x0 controller is disabled */
> -
> +		cache_id = readl(l2x0_base + L2X0_CACHE_ID);
>  		aux = readl(l2x0_base + L2X0_AUX_CTRL);
> +
> +		/* Determine the number of ways */
> +		switch (cache_id) {
> +		case L2X0_CACHE_ID_PART_L310:
> +			if (aux & (1 << 16))
> +				ways = 16;
> +			else
> +				ways = 8;
> +			break;
> +		case L2X0_CACHE_ID_PART_L210:
> +			ways = (aux >> 13) & 0xf;
> +			break;

One of the things I found myself wishing for with the problems OMAP is
currently having is a means by which the "L2X0 cache controller enabled"
could be more informative about the L2 cache controller.

Maybe it should be "%s cache controller rel%u enabled".  Also note that
the L210 and L220 cache controllers have different cache IDs.
L210 has a 1 in bits 9:6, and L220 is 2 in bits 9:6.

However, as for the above patch, I don't think the above code will work;
you're defining the L2X0_CACHE_ID_PART_L310 / L2X0_CACHE_ID_PART_L210
IDs to refer just to the part number field, but you're not masking off
the rest of the fields in cache_id.
