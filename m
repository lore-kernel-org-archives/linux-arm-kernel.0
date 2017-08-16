From: alex.g@adaptrum.com (Alexandru Gagniuc)
Date: Wed, 16 Aug 2017 14:00:59 -0700
Subject: [PATCH v3 5/5] reset: simple: read back to make sure changes are
 applied
In-Reply-To: <20170816094701.30678-6-p.zabel@pengutronix.de>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
 <20170816094701.30678-6-p.zabel@pengutronix.de>
Message-ID: <561b4eb5-98be-f844-57cb-b5ce5962258f@adaptrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/16/2017 02:47 AM, Philipp Zabel wrote:
> Read back the register after setting or clearing a reset bit to make
> sure that the changes are applied to the reset controller hardware.

> Theoretically, this avoids the write to stay stuck in a store buffer

Is there hardware where this has been observed to happen, or is this 
purely theoretical? It would be nice to have a "this is needed on 
hardware XYZ because ABC, and doesn't affect other hardware" comment in 
the source.

> during the delay of an assert-delay-deassert sequence, and makes sure
> that the reset really is asserted for the specified duration.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/reset-simple.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index 13e7d5559acc9..d98a7e7d802d1 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -39,17 +39,20 @@ static int reset_simple_set(struct reset_controller_dev *rcdev,
>  	int reg_width = sizeof(u32);
>  	int bank = id / (reg_width * BITS_PER_BYTE);
>  	int offset = id % (reg_width * BITS_PER_BYTE);
> +	void __iomem *addr = data->membase + (bank * reg_width);
>  	unsigned long flags;
>  	u32 reg;
>
>  	spin_lock_irqsave(&data->lock, flags);
>
> -	reg = readl(data->membase + (bank * reg_width));
> +	reg = readl(addr);
>  	if (assert ^ data->active_low)
>  		reg |= BIT(offset);
>  	else
>  		reg &= ~BIT(offset);
> -	writel(reg, data->membase + (bank * reg_width));
> +	writel(reg, addr);
> +	/* Read back to make sure the write doesn't linger in a store buffer */
> +	readl(addr);

You're not using the returned value to check that the reset was actually 
set. This seems a very arbitrary readback workaround, which gives no 
indication if it actually succeeded or not.

Also the set() is now asymmetrical to clear(). In cases when releasing 
reset on a HW block that is about to have IO performed on it, one would 
want to make sure the reset is actually deasserted before doing any IO.

Alex

>
>  	spin_unlock_irqrestore(&data->lock, flags);
>
>
