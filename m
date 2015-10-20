From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Oct 2015 16:40:47 +0200
Subject: [PATCH v6 1/5] clk: Add a basic multiplier clock
In-Reply-To: <20151020134343.20687.16333@quantum>
References: <1445326609-6314-1-git-send-email-maxime.ripard@free-electrons.com>
 <1445326609-6314-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151020134343.20687.16333@quantum>
Message-ID: <20151020144047.GA10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, Oct 20, 2015 at 06:43:43AM -0700, Michael Turquette wrote:
> Hi Maxime,
> 
> Quoting Maxime Ripard (2015-10-20 00:36:45)
> > +struct clk *clk_register_multiplier(struct device *dev, const char *name,
> > +                                   const char *parent_name,
> > +                                   unsigned long flags,
> > +                                   void __iomem *reg, u8 shift, u8 width,
> > +                                   u8 clk_mult_flags, spinlock_t *lock)
> > +{
> 
> Patch looks good in general. However this is a good opportunity to stop
> the madness around the registration functions in these basic clock
> types.
> 
> clk_register is really all that we need since we've had struct
> clk_init_data for a while. Initializing a multiplier should be as simple
> as:
> 
> 	struct clk_multiplier clk_foo = {
> 		.hw.init = &(struct clk_init_data){
> 			.name = "foo",
> 			.parent_names = (const char *[]){
> 				"bar",
> 			},
> 			.num_parents = 1;
> 			.ops = &clk_multiplier_ops,
> 		},
> 		.reg = 0xd34db33f,
> 		.shift = 1,
> 		.width = 2,
> 	};
> 
> 	clk_register(dev, &clk_foo.hw);
> 
> This is nice since it turns these basic clocks into even more of a
> library and less of a poor mans driver.
> 
> (I really hope the above works. I did not test it)
> 
> Is it possible you can convert to using this method, and if it is
> correct for you then just remove clk_multiplier_register altogether? (In
> fact you might not use the registration function at all since you use
> the composite clock...)

This chunk of code has been here since v2, which has been first posted
in May, two and half kernel releases ago.

In the meantime, we had a full-blown DMA driver and a quite unusual
ASoC driver merged. For some reason, this is the only piece of the
audio support that is missing for us, while at the same time it's the
most trivial.

If that's the only issue you have with this patch, I'm fine with
sending a subsequent patch this week. But I'd be really unhappy with
sending yet another version for a single change, while you had 5
monthes to review it, and we discussed it several times on IRC and
face to face.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/e18b1520/attachment.sig>
