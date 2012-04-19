From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 19 Apr 2012 09:52:06 +0200
Subject: [PATCH 23/40] ARM i.MX: Add common clock support for 2bit gate
In-Reply-To: <CALZhoSTTTuwSEv8snhMpuTqU_L5DC3zRW97ePazLqS9SfdZAPA@mail.gmail.com>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-24-git-send-email-s.hauer@pengutronix.de>
 <20120419070032.GA22773@b20223-02.ap.freescale.net>
 <CALZhoSTTTuwSEv8snhMpuTqU_L5DC3zRW97ePazLqS9SfdZAPA@mail.gmail.com>
Message-ID: <20120419075206.GA4016@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 03:26:53PM +0800, Lei Wen wrote:
> On Thu, Apr 19, 2012 at 3:00 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Tue, Apr 10, 2012 at 03:45:36PM +0200, Sascha Hauer wrote:
> > [snip]
> >> +struct clk *clk_register_gate2(struct device *dev, const char *name,
> >> + ? ? ? ? ? ? const char *parent_name, unsigned long flags,
> >> + ? ? ? ? ? ? void __iomem *reg, u8 bit_idx,
> >> + ? ? ? ? ? ? u8 clk_gate2_flags, spinlock_t *lock)
> >> +{
> >> + ? ? struct clk_gate *gate;
> >> + ? ? struct clk *clk;
> >> +
> >> + ? ? gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
> >> +
> >> + ? ? if (!gate) {
> >> + ? ? ? ? ? ? pr_err("%s: could not allocate gated clk\n", __func__);
> >> + ? ? ? ? ? ? return NULL;
> >> + ? ? }
> >> +
> >> + ? ? /* struct clk_gate assignments */
> >> + ? ? gate->reg = reg;
> >> + ? ? gate->bit_idx = bit_idx;
> >> + ? ? gate->flags = clk_gate2_flags;
> >> + ? ? gate->lock = lock;
> >> +
> >> + ? ? if (parent_name) {
> >> + ? ? ? ? ? ? gate->parent[0] = kstrdup(parent_name, GFP_KERNEL);
> >> + ? ? ? ? ? ? if (!gate->parent[0])
> >> + ? ? ? ? ? ? ? ? ? ? goto out;
> >> + ? ? }
> >> +
> >> + ? ? clk = clk_register(dev, name,
> >> + ? ? ? ? ? ? ? ? ? ? &clk_gate2_ops, &gate->hw,
> >> + ? ? ? ? ? ? ? ? ? ? gate->parent,
> >> + ? ? ? ? ? ? ? ? ? ? (parent_name ? 1 : 0),
> >> + ? ? ? ? ? ? ? ? ? ? flags);
> > Why do you re-use struct clk_gate while you don't use clk_gate_ops?
> > It doesn't follow object oriented thought. struct clk_gate may change
> > according to clk_gate_ops changes.
> >
> > Thanks
> > Richard
> >
> >
> >
> 
> Why not expend original clk-gate.c to allow set more than one bit a
> time to gate that clock?
> At least in my platform, some clock need 12bit to get its gate mode,
> which means that module
> has more than one clock concurrently up to work, and only a part of
> that group work cannot lead
> to a correct working mode. This also means those bits need to turn
> on/off at the same time.

I would also need a double gate, one reg to enable and one to disable,
both or-ing the same bitmask. I think this can be addressed in the
flags but what about a union to store the different regs, widths, shifts?

thanks,
Domenico
