From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 28 Mar 2014 15:51:58 -0500
Subject: [PATCH 41/75] ARM: l2c: provide generic hook to intercept writes
 to secure registers
In-Reply-To: <E1WTYXc-0007Fd-8A@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYXc-0007Fd-8A@rmk-PC.arm.linux.org.uk>
Message-ID: <20140328205158.GC28265@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 03:17:56PM +0000, Russell King wrote:
> @@ -60,13 +60,30 @@ static inline void l2c_wait_mask(void __iomem *reg, unsigned long mask)
>  }
>  
>  /*
> + * By default, we write directly to secure registers.  Platforms must
> + * override this if they are running non-secure.
> + */
> +static void l2c_write_sec(unsigned long val, void __iomem *base, unsigned reg)
> +{
> +	if (val == readl_relaxed(base + reg))
> +		return;
> +	if (outer_cache.write_sec)
> +		outer_cache.write_sec(val, reg);
> +	else
> +		writel_relaxed(val, base + reg);
> +}
> +
> +/*
[..]
> @@ -97,7 +114,7 @@ static void l2c_enable(void __iomem *base, u32 aux, unsigned num_lock)
>  
>  	/* Only write the aux register if it needs changing */
>  	if (readl_relaxed(base + L2X0_AUX_CTRL) != aux)

It looks like this conditional can be dropped, since l2c_write_sec is
just going to perform the same check.

> -		writel_relaxed(aux, base + L2X0_AUX_CTRL);
> +		l2c_write_sec(aux, base, L2X0_AUX_CTRL);
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
