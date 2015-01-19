From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 19 Jan 2015 08:28:08 -0800
Subject: [PATCH v3 2/4] clk: mediatek: Add initial common clock support for
 Mediatek SoCs.
In-Reply-To: <1420685701.27952.44.camel@mtksdaap41>
References: <1420601123-25859-1-git-send-email-jamesjj.liao@mediatek.com>
 <1420601123-25859-3-git-send-email-jamesjj.liao@mediatek.com>
 <CABuKBeLQkTBYWkBWAYXjYudMAza+1zueRSqGFPd+480p1rYNwg@mail.gmail.com>
 <1420685701.27952.44.camel@mtksdaap41>
Message-ID: <20150119162808.22722.33140@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting James Liao (2015-01-07 18:55:01)
> Hi Matthias,
> 
> On Wed, 2015-01-07 at 18:22 +0100, Matthias Brugger wrote:
> > 2015-01-07 4:25 GMT+01:00 James Liao <jamesjj.liao@mediatek.com>:
> > > +
> > > +static void cg_set_mask(struct mtk_clk_gate *cg, u32 mask)
> > 
> > Please add mtk_ prefix to all functions generic for the mediatek SoCs.
> 
> OK.
> 
> > 
> > > +       if (cg->flags & CLK_GATE_NO_SETCLR_REG) {
> > 
> > Is the CLK_GATE_NO_SETCLR_REG ever used?
> > As far as I can see, in this patch set it is not.
> 
> No, this flag is not used in this patch. I'll remove it or add clocks
> which use this flag in next patch.
> 
> > > +
> > > +       if (cg->flags & CLK_GATE_INVERSE)
> > > +               cg_set_mask(cg, mask);
> > > +       else
> > > +               cg_clr_mask(cg, mask);
> > > +
> > > +       mtk_clk_unlock(flags);
> > > +
> > > +       return 0;
> > > +}
> > 
> > Actually we should use CLK_GATE_SET_TO_DISABLE instead of inventing a
> > new bit, right?
> 
> CLK_GATE_SET_TO_DISABLE is used by struct clk_gate, which is different
> from struct mtk_clk_gate. Should we use the same constant in these 2
> different implementation? If yes, how do we avoid bit conflict between
> clk_gate and mtk_clk_gate if we both add more flags in the future?

I think that CLK_GATE_INVERSE is fine. This clock gate implementation is
sufficiently different from the simple drivers/clk/clk-gate.c
implementation (e.g. separate registers for setting bits, clearing bits
and getting status).

Regards,
Mike

> 
> 
> > > +       pr_debug("%s(): %d, %s, bit[%d]\n",
> > > +               __func__, r, __clk_get_name(hw->clk), (int)cg->bit);
> > 
> > Same here. Please review all debug messages.
> 
> OK, I'll remove them in next patch.
> 
> 
> > > +
> > > +#define CLK_DEBUG              0
> > > +#define DUMMY_REG_TEST         0
> > 
> > This defines are not used, delete them.
> 
> OK.
> 
> > > +
> > > +extern spinlock_t *get_mtk_clk_lock(void);
> > > +
> > > +#define mtk_clk_lock(flags)    spin_lock_irqsave(get_mtk_clk_lock(), flags)
> > > +#define mtk_clk_unlock(flags)  \
> > > +       spin_unlock_irqrestore(get_mtk_clk_lock(), flags)
> > 
> > Please use the spinlock directly without this akward defines.
> 
> Do you mean we should export clk_ops_lock (from clk-mtk.c) directly
> instead of get_mtk_clk_lock()? Or simply remove mtk_clk_lock/unlock()?
> 
> 
> Best regards,
> 
> James
> 
> 
> 
