From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Apr 2011 10:01:59 +0100
Subject: [PATCH 01/10] Add a common struct clk
In-Reply-To: <BANLkTim5qh_G9t9ucFu8OUzYGceszth1wg@mail.gmail.com>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-2-git-send-email-s.hauer@pengutronix.de>
	<BANLkTim5qh_G9t9ucFu8OUzYGceszth1wg@mail.gmail.com>
Message-ID: <20110430090159.GA22821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2011 at 10:06:18AM +0200, Linus Walleij wrote:
> 2011/4/15 Sascha Hauer <s.hauer@pengutronix.de>:
> > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> > We currently have ~21 definitions of struct clk in the ARM architecture,
> > each defined on a per-platform basis. This makes it difficult to define
> > platform- (or architecture-) independent clock sources without making
> > assumptions about struct clk, and impossible to compile two
> > platforms with different struct clks into a single image.
> 
> Sorry for this late comment, maybe already adressed:
> 
> > +int clk_enable(struct clk *clk)
> > +{
> > + ? ? ? unsigned long flags;
> > + ? ? ? int ret = 0;
> > +
> > + ? ? ? WARN_ON(clk->prepare_count == 0);
> > +
> > + ? ? ? spin_lock_irqsave(&clk->enable_lock, flags);
> > + ? ? ? if (clk->enable_count == 0 && clk->ops->enable)
> > + ? ? ? ? ? ? ? ret = clk->ops->enable(clk);
> 
> Here the spinlock is held requiring the clock implementation to
> be non-sleeping, something that has been discussed at no end,
> without addressing that eternal debate, please just drop the
> spinlock during the ->enable() call, what is it protecting during
> that time anyway...

clk->enable_count and two concurrent enables passing each other (eg,
while one enable is in progress, another enable may pass it unless
the spinlock is held.)

That's not going to change; we decided that the enable call shall be
non-sleeping for everything.  That's why we introduced the prepare
call for the sleeping part of the problem.
