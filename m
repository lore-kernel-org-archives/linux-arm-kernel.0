From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Sep 2016 07:27:28 -0700
Subject: Regression in next with "mfd: twl6040: The chip does not support
 bulk access"
In-Reply-To: <8b8a49cd-ca7b-4580-58ba-3e05d933853e@ti.com>
References: <20160922180718.kmttyt26t56fa3kp@atomide.com>
 <139a8c7b-8cfe-fa21-634a-4551511f0cea@ti.com>
 <8b8a49cd-ca7b-4580-58ba-3e05d933853e@ti.com>
Message-ID: <20160923142727.ysj3or2ltlhk5r72@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160923 03:20]:
> On 09/23/16 10:20, Peter Ujfalusi wrote:
> > On 09/22/16 21:07, Tony Lindgren wrote:
> >> Hi,
> >>
> >> Looks like commit 7a17e47f6403 ("mfd: twl6040: The chip does not
> >> support bulk access") breaks at least omap4-duovero.
> > 
> > That's odd. I see no such errors on omap4 PandaBoard-ES nor on omap5 uEVM.
> > The IRQ status is one register so even in bulk access it is one read. So the
> > use_single_rw should have no effect on the access.
> > 
> > The only time when regmap would try to use bulk access to twl6040 is when we
> > execute regcache_sync() on it after resuming the chip and this would fail at
> > the first time when it tries to restore more than one consecutive registers.
> > 
> > I just tested things on next-20160915 and I see no errors at all.
> 
> Retested on next-20160923 and I see no issue on Panda-ES or omap5-uevm.
> 
> My guess is that you receive an interrupt from twl6040 while the chip is
> powered down, the regmap is set to cache only. But this has nothing to do with
> the bulk or non bulk access... Looking at the commit logs and git blame I see
> no recent change in the driver(s) for twl6040 which changed the way it loads
> and/or powers up/down.

OK yeah this is another one caused by "softirq: fix tasklet_kill() and
its users".

Thanks,

Tony
