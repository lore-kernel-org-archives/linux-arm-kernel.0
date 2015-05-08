From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 May 2015 11:53:37 +0200
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <2157778.UqGYDaOCUX@diego>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <20150508065318.GA5690@codeaurora.org>
 <20150508081355.GB6325@pengutronix.de> <2157778.UqGYDaOCUX@diego>
Message-ID: <20150508095337.GC6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 11:30:19AM +0200, Heiko St?bner wrote:
> Am Freitag, 8. Mai 2015, 10:13:55 schrieb Sascha Hauer:
> > On Thu, May 07, 2015 at 11:53:18PM -0700, Stephen Boyd wrote:
> > > On 05/07, Kevin Hilman wrote:
> > > > On Thu, May 7, 2015 at 2:03 PM, Stephen Boyd <sboyd@codeaurora.org> 
> wrote:
> > > > > On 05/07/15 08:17, Kevin Hilman wrote:
> > > > >> On Fri, May 1, 2015 at 4:40 PM, Stephen Boyd <sboyd@codeaurora.org> 
> wrote:
> > > > >>> On 05/01/15 15:07, Heiko St?bner wrote:
> > > > >>>> Am Freitag, 1. Mai 2015, 13:52:47 schrieb Stephen Boyd:
> > > > >>>>>> Instead I guess we could hook it less deep into clk_get_sys, like
> > > > >>>>>> in the
> > > > >>>>>> following patch?
> > > > >>>>> 
> > > > >>>>> It looks like it will work at least, but still I'd prefer to keep
> > > > >>>>> the
> > > > >>>>> orphan check contained to clk.c. How about this compile tested
> > > > >>>>> only patch?
> > > > >>>> 
> > > > >>>> I gave this a spin on my rk3288-firefly board. It still boots, the
> > > > >>>> clock tree looks the same and it also still defers nicely in the
> > > > >>>> scenario I needed it for. The implementation also looks nice - and
> > > > >>>> of course much more compact than my check in two places :-) . I
> > > > >>>> don't know if you want to put this as follow-up on top or fold it
> > > > >>>> into the original orphan-check, so in any case
> > > > >>>> 
> > > > >>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > > >>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > > >>> 
> > > > >>> Thanks. I'm leaning towards tossing your patch 2/2 and replacing it
> > > > >>> with
> > > > >>> my patch and a note that it's based on an earlier patch from you.
> > > > >> 
> > > > >> It appears this has landed in linux-next in the form of 882667c1fcf1
> > > > >> clk: prevent orphan clocks from being used.  A bunch of boot failures
> > > > >> for sunxi in today's linux-next[1] were bisected down to that patch.
> > > > >> 
> > > > >> I confirmed that reverting that commit on top of next/master gets
> > > > >> sunxi booting again.
> > > > > 
> > > > > Thanks for the report. I've removed the two clk orphan patches from
> > > > > clk-next. Would it be possible to try with next-20150507 and
> > > > > clk_ignore_unused on the command line?
> > > > 
> > > > That doesn't help.  I tried on cubieboard2 and bananapi.
> > > 
> > > Thanks for trying.
> > > 
> > > > > Also we can try to see if
> > > > > critical clocks aren't being forced on by applying this patch and
> > > > > looking for clk_get() failures
> > > > 
> > > > From cubieboard2, there's a few that look rather important:
> > > > 
> > > > [    0.000000] Additional per-CPU info printed with stalls.
> > > > [    0.000000] Build-time adjustment of leaf fanout to 32.
> > > > [    0.000000] RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=2.
> > > > [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32,
> > > > nr_cpu_ids=2
> > > > [    0.000000] NR_IRQS:16 nr_irqs:16 16
> > > > [    0.000000] clk: couldn't get parent clock 0 for /clocks/ahb at 01c20054
> > > > [    0.000000] Failed to enable critical clock cpu
> > > > [    0.000000] Failed to enable critical clock pll5_ddr
> > > > [    0.000000] Failed to enable critical clock ahb_sdram
> > > > [    0.000000] Architected cp15 timer(s) running at 24.00MHz (virt).
> > > 
> > > Ok. So it seems we need to come up with some solution to the
> > > "critical clocks" problem that doesn't require the individual
> > > clock drivers to call clk_prepare_enable().
> > 
> > I'm getting more and more unsure if we can really handle the complexity
> > we get by allowing to register orphaned clocks. On one hand we can't
> > handle the orphaned clocks properly when we do a clk_prepare/enable on
> > them, on the other hand we run into trouble when we forbid to
> > prepare/enable them. The fact that clocks can become orphans by
> > reparenting them makes it even more complicated.
> > Maybe allowing orphans is something that has to be revisited.
> 
> hmm, I don't see it this drastic. I was expecting a lot more fallout from 
> changing the behaviour of orphaned clocks over all arches using the CCF.
> 
> From the kernelci-boards only the Sunxi-ones seem to have been affected at all 
> and also only because they need a "regulator-always-on" equivalent in the CCF, 
> which currently hijacks prepare/enable inside the clock driver to achive this.

Mediatek has the same case. Here we needs some clock to stay always on and
these clocks get registered before the PLLs they depend on. This means
they can't be enabled right after registration.

Keeping the prepare/enable count correct and syncing the software state
with the hardware state is made quite complicated with orphaned clocks
and I suspect more bugs here. Even now it's hard to move in the
clock framework without breaking other stuff, this won't get easier with
more bug fixes.

So I think asking what allowing orphaned clocks really buys us is valid.
Of course we would need to find a way to get the initialisation order
straight which will probably cause some pain.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
