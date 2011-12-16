From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 16 Dec 2011 15:25:53 -0800
Subject: [RFC V2 5/8] ARM i.MX: clk: add generic support of gate2b
In-Reply-To: <1323854638-3455-6-git-send-email-richard.zhao@linaro.org>
References: <1323854638-3455-1-git-send-email-richard.zhao@linaro.org>
 <1323854638-3455-6-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAPtuhTity_fnmi2ezvWgo0iGqjeT9BTjZLnFjhE1cSPKAA+oHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 1:23 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> +static int clk_gate2b_enable(struct clk *clk)
> +{
> + ? ? ? struct clk_gate2b *gate2b = to_clk_gate2b(clk);
> + ? ? ? unsigned long flags;
> + ? ? ? u32 reg;
> +
> + ? ? ? if (gate2b->lock)
> + ? ? ? ? ? ? ? spin_lock_irqsave(gate2b->lock, flags);

Are their bits in this register used by other clocks which aren't
protected by the enable_lock spinlock?

> +int clk_gate2b_set_val(struct clk *clk, int en, int dis)
> +{
> + ? ? ? struct clk_gate2b *gate2b = to_clk_gate2b(clk);
> + ? ? ? unsigned long flags;
> + ? ? ? u32 reg, val;
> +
> + ? ? ? en &= 0x3;
> + ? ? ? dis &= 0x3;
> +
> + ? ? ? if (gate2b->lock)
> + ? ? ? ? ? ? ? spin_lock_irqsave(gate2b->lock, flags);
> +
> + ? ? ? reg = __raw_readl(gate2b->reg);
> + ? ? ? val = (reg >> gate2b->shift) & 0x3;
> + ? ? ? reg &= ~(0x3 << gate2b->shift);
> + ? ? ? if (val == gate2b->val_en && val != en)
> + ? ? ? ? ? ? ? reg |= en << gate2b->shift;
> + ? ? ? else if (val == gate2b->val_dis && val != dis)
> + ? ? ? ? ? ? ? reg |= dis << gate2b->shift;
> + ? ? ? __raw_writel(reg, gate2b->reg);
> + ? ? ? gate2b->val_en = en;
> + ? ? ? gate2b->val_dis = dis;
> +
> + ? ? ? if (gate2b->lock)
> + ? ? ? ? ? ? ? spin_unlock_irqrestore(gate2b->lock, flags);
> +
> + ? ? ? return 0;
> +}
> +EXPORT_SYMBOL_GPL(clk_gate2b_set_val);

Who calls clk_gate2b_set_val, and why?

Regards,
Mike
