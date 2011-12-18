From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun, 18 Dec 2011 16:06:21 +0800
Subject: [RFC V2 5/8] ARM i.MX: clk: add generic support of gate2b
In-Reply-To: <CAPtuhTity_fnmi2ezvWgo0iGqjeT9BTjZLnFjhE1cSPKAA+oHw@mail.gmail.com>
References: <1323854638-3455-1-git-send-email-richard.zhao@linaro.org>
 <1323854638-3455-6-git-send-email-richard.zhao@linaro.org>
 <CAPtuhTity_fnmi2ezvWgo0iGqjeT9BTjZLnFjhE1cSPKAA+oHw@mail.gmail.com>
Message-ID: <20111218080619.GB1705@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 03:25:53PM -0800, Mike Turquette wrote:
> On Wed, Dec 14, 2011 at 1:23 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > +static int clk_gate2b_enable(struct clk *clk)
> > +{
> > + ? ? ? struct clk_gate2b *gate2b = to_clk_gate2b(clk);
> > + ? ? ? unsigned long flags;
> > + ? ? ? u32 reg;
> > +
> > + ? ? ? if (gate2b->lock)
> > + ? ? ? ? ? ? ? spin_lock_irqsave(gate2b->lock, flags);
> 
> Are their bits in this register used by other clocks which aren't
> protected by the enable_lock spinlock?
For now, no. If I remove the lock, it'll limit the gate2b usage.
> 
> > +int clk_gate2b_set_val(struct clk *clk, int en, int dis)
> > +{
> > + ? ? ? struct clk_gate2b *gate2b = to_clk_gate2b(clk);
> > + ? ? ? unsigned long flags;
> > + ? ? ? u32 reg, val;
> > +
> > + ? ? ? en &= 0x3;
> > + ? ? ? dis &= 0x3;
> > +
> > + ? ? ? if (gate2b->lock)
> > + ? ? ? ? ? ? ? spin_lock_irqsave(gate2b->lock, flags);
> > +
> > + ? ? ? reg = __raw_readl(gate2b->reg);
> > + ? ? ? val = (reg >> gate2b->shift) & 0x3;
> > + ? ? ? reg &= ~(0x3 << gate2b->shift);
> > + ? ? ? if (val == gate2b->val_en && val != en)
> > + ? ? ? ? ? ? ? reg |= en << gate2b->shift;
> > + ? ? ? else if (val == gate2b->val_dis && val != dis)
> > + ? ? ? ? ? ? ? reg |= dis << gate2b->shift;
> > + ? ? ? __raw_writel(reg, gate2b->reg);
> > + ? ? ? gate2b->val_en = en;
> > + ? ? ? gate2b->val_dis = dis;
> > +
> > + ? ? ? if (gate2b->lock)
> > + ? ? ? ? ? ? ? spin_unlock_irqrestore(gate2b->lock, flags);
> > +
> > + ? ? ? return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(clk_gate2b_set_val);
> 
> Who calls clk_gate2b_set_val, and why?
It's an interface for busfreq. When I enable a gate2b, I may want it to be
active when cpu is running but disabled when wfi. I may also want it to be
active all the time, if some dma device also need it.
So the value I set for enable/disable change at runtime.

Thanks
Richard
> 
> Regards,
> Mike
