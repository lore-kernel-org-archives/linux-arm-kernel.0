From: timur@freescale.com (Timur Tabi)
Date: Thu, 8 Mar 2012 14:13:04 -0600
Subject: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver compilable on
 ARM/IMX
In-Reply-To: <1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F5912D0.2090800@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> +static DEFINE_SPINLOCK(ssi_reg_lock);
> +static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ssi_reg_lock, flags);
> +	val = readl(addr);
> +	val = (val & ~clear) | set;
> +	writel(val, addr);
> +	spin_unlock_irqrestore(&ssi_reg_lock, flags);
> +}
> +#endif

I think this spinlock is the wrong approach.  The problem with
read-modify-write is on the function level, not the register level.

-- 
Timur Tabi
Linux kernel developer at Freescale
