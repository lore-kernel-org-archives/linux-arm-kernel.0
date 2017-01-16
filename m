From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Jan 2017 15:58:36 +0800
Subject: [PATCH v1 3/3] reset: zx2967: add reset controller driver for
 ZTE's zx2967 family
In-Reply-To: <1484377530-30635-3-git-send-email-baoyou.xie@linaro.org>
References: <1484377530-30635-1-git-send-email-baoyou.xie@linaro.org>
 <1484377530-30635-3-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170116075835.GB11600@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2017 at 03:05:30PM +0800, Baoyou Xie wrote:
> +static int zx2967_reset_assert(struct reset_controller_dev *rcdev,
> +			   unsigned long id)
> +{
> +	struct zx2967_reset *reset = NULL;
> +	int bank = id / 32;
> +	int offset = id % 32;
> +	unsigned int reg;

u32 is probably better for register value.

> +	unsigned long flags;
> +
> +	reset = container_of(rcdev, struct zx2967_reset, rcdev);
> +
> +	spin_lock_irqsave(&reset->lock, flags);
> +
> +	reg = readl(reset->reg_base + (bank * 4));
> +	writel(reg & ~BIT(offset), reset->reg_base + (bank * 4));
> +	reg = readl(reset->reg_base + (bank * 4));

Is this read on the register is necessary?  If so, we should probably
have a comment for that.

> +
> +	spin_unlock_irqrestore(&reset->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int zx2967_reset_deassert(struct reset_controller_dev *rcdev,
> +			     unsigned long id)

Please indent the line right after parentheses.

> +{
> +	struct zx2967_reset *reset = NULL;
> +	int bank = id / 32;
> +	int offset = id % 32;
> +	unsigned int reg;
> +	unsigned long flags;
> +
> +	reset = container_of(rcdev, struct zx2967_reset, rcdev);
> +
> +	spin_lock_irqsave(&reset->lock, flags);
> +
> +	reg = readl(reset->reg_base + (bank * 4));
> +	writel(reg | BIT(offset), reset->reg_base + (bank * 4));
> +	reg = readl(reset->reg_base + (bank * 4));
> +
> +	spin_unlock_irqrestore(&reset->lock, flags);
> +
> +	return 0;
> +}

Only difference between these two functions is only one line.  Should we
consolidate them a bit?

Shawn
