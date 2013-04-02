From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 02 Apr 2013 11:25:13 -0700
Subject: [PATCH] clk: add LP8788 clock driver
In-Reply-To: <A874F61F95741C4A9BA573A70FE3998F82E4A7F3@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E48E3F@DQHE02.ent.ti.com>
 <20130402011236.8177.88731@quantum>
 <A874F61F95741C4A9BA573A70FE3998F82E4A7F3@DQHE02.ent.ti.com>
Message-ID: <20130402182513.8177.59192@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kim, Milo (2013-04-01 19:18:32)
> > Just FYI most folks are simply using a macro to do the above.  E.g:
> > 
> > #define to_lp8788_clk(_hw) container_of(_hw, struct lp8788_clk, hw)
> 
> OK, thanks! Will be fixed in the 2nd patch.
> 
> > > +
> > > +static int lp8788_clk_is_enabled(struct clk_hw *hw)
> > > +{
> > > +       struct lp8788_clk *pclk = to_lp8788_clk(hw);
> > > +
> > > +       /*
> > > +        * Do not use the LP8788 register access here, unsafe locking
> > problem
> > > +        * may occur during loading the driver. So stored varible is
> > prefered.
> > > +        */
> > 
> > What unsafe locking problem?
> 
> If I try to get LP8788 clock status via the remap-i2c here, then locking problem
> occurs.
> The 'enable_lock' is already locked and the MUTEX of REGMAP is used on reading
> a register.
> 
> [    2.692443] -------------------------------------------------------
> [    2.699066] swapper/0/1 is trying to acquire lock:
> [    2.704132]  (&map->mutex){+.+...}, at: [<c0374ecc>] regmap_read+0x34/0x5c
> [    2.711486] 
> [    2.711486] but task is already holding lock:
> [    2.717681]  (enable_lock){......}, at: [<c047a6c8>] clk_disable_unused_subtr
> ee+0x3c/0xb4
> [    2.726379] 
> [    2.726379] which lock already depends on the new lock.
> 
> That's why lp8788_get_clk_status() is used on _probe().
> - Read a register and store the value into local status variable.
> Then local variable is used in .is_enabled().
> 

I think that the new clk reentrancy patch should fix this for you.  Can
you rebase your patch onto the latest clk-next and try using remap-i2c
again?  You can that branch here:
git://git.linaro.org/people/mturquette/linux.git clk-next

> > Also have you looked into using the new .is_prepare callback?  See:
> > https://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commitdif
> > f;h=3d6ee287a3e341c88eafd0b4620b12d640b3736b;hp=30ee400614385ac49f4c9b4
> > bc03d77ff8f07a61e
> 
> Not checked yet, but it looks no caller for this callback at this moment.
> Will this be added inside the clk_prepare()?
> 
> > > +
> > > +       return pclk->enabled;
> > 
> > Why provide a .is_enabled callback when there are no .enable
> > or .disable
> > callbacks?
> 
> LP8788 Clock is always enabled, so it needs to show the clock status.
> However, I think no effect on working the clock operation without is_enabled().
> Can I remove it?
> 

Yes you can remove it.  Since you do not provide a .disabled callback
then clk_disable_unused() will not try to disable your clock.  Do any
drivers call clk_prepare_enable on this clock?

It is also probably a good idea to set the CLK_IGNORE_UNUSED flag on
this clock (in addition to the CLK_IS_ROOT flag that you have already
set).  This way if your .unprepare callback ever does something some day
then you won't get a nasty surprise.

Regards,
Mike

> Thanks,
> Milo
