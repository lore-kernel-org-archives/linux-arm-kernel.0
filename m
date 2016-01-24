From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Jan 2016 22:28:46 +0100
Subject: [PATCH 1/2] arm/mach-imx: use endian-safe
 readl/readw/writel/writew
In-Reply-To: <1453651346-12760-1-git-send-email-johannes@sipsolutions.net>
References: <1453651346-12760-1-git-send-email-johannes@sipsolutions.net>
Message-ID: <27961664.oTCXiXao1R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 January 2016 17:02:25 Johannes Berg wrote:
> Instead of __raw_*, use *_relaxed. The conversion was done
> using the following spatch (since that automatically adjusts
> the coding style unlike a simple search&replace).
> 
> @@
> expression E1, E2;
> @@
> -__raw_writel(E1, E2)
> +writel_relaxed(E1, E2)
> @@
> expression E1, E2;
> @@
> -__raw_writew(E1, E2)
> +writew_relaxed(E1, E2)
> @@
> expression E1;
> @@
> -__raw_readl(E1)
> +readl_relaxed(E1)
> @@
> expression E1;
> @@
> -__raw_readw(E1)
> +readw_relaxed(E1)
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> 

(Adding Shawn and Sascha here as well)

The patch looks fine to me, in the sense that we can safely assume
that the behavior won't change for little-endian, and that it is
fixing a bug for big-endian.

I would feel more comfortable with a patch using the non-relaxed()
accessors though, as that can avoid a number of subtle bugs with
I/O ordering.

Unfortunately, there is a nonzero overhead in the extra cache sync
on the Cortex-A9 based platforms (most imx6), so this has to
be done very carefully to avoid performance regressions. It's
probably a good idea to keep the two changes as separate commits,
but I'd also like to get both applied in the same merge window,
as 'readl_relaxed' tends to say "I have proven that I don't need
barriers", while the existing code just screams "I have no idea
about what I'm doing here".

Any other opinions on this?

	Arnd
