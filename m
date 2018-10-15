From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 15 Oct 2018 19:07:59 +0200
Subject: [PATCH] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
In-Reply-To: <20181013160810.88481.14237@resonance>
References: <1539425086-10997-1-git-send-email-christianshewitt@gmail.com>
 <20181013160810.88481.14237@resonance>
Message-ID: <ed6a889eeec4e2809f0840c9e8188b5e4b24fa76.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-10-13 at 18:08 +0200, Michael Turquette wrote:
> Quoting Christian Hewitt (2018-10-13 12:04:46)
> > On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
> > with reboot; e.g. a ~60 second delay between issuing reboot and the
> > board power cycling (and in some OS configurations reboot will fail
> > and require manual power cycling).
> > 
> > Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
> > meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
> > Co-Processor seems to depend on FCLK_DIV3 being operational.
> > 
> > Bisect gives 'commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
> > meson: add fdiv clock gates") between 4.16 and 4.16-rc1 as the first
> > bad commit. This added support for the missing clock gates before the
> > fixed PLL fixed dividers (FCLK_DIVx) and the clock framework which
> > disabled all the unused fixed dividers, thus it disabled a critical
> > clock path for the SCPI Co-Processor.
> > 
> > This change simply sets the FCLK_DIV3 gate as critical to ensure
> > nothing can disable it.
> 
> I'm a bit skeptical of this. If FCLK_DIV3 is gated at run-time, there is
> no side effect other than long and/or failed reboot?
> 
> Seems like someone should be managing this clock, and simply leaving it
> on all the time isn't necessarily the right approach. Any chance that
> you can dig into this behavior to better understand it?
> 
> It's easy to solve issues by leaving clocks on all the time, but this
> becomes a problem later on when trying to tune a device for power.

Hi Mike,

I totally agree with you and, in perfect a world, I would prefer not to use this
CLK_IS_CRITICAL at all. It looks like a cheap fix for:

"this is required, I don't for what but it is, so please leave it on"

The problem is this issue is a regression. We added a few gates to better model
the clock tree a while ago. Before, those those clock were left enabled by the
bootloader.

Now that linux turn them off, we are learning a few things about what the FWs
are doing behind our backs.

Among the 5 clocks which got a new gates, only 2 needs to back the old way using
CLK_IS_CRITICAL, so this is still an improvement.

> 
> Also, if this commit really is the right fix, it should include a
> comment for FCLK_DIV3 stating why the CLK_IS_CRITICAL flag was set,
> which may be helpful later on to know if it is safe to remove it. Same
> is true for FCLK_DIV2 in c987ac6f1f088663b6dad39281071aeb31d450a8.

+1 There should be FIXME notice in the driver explaining why we put that flag in
the first place, so we can remove it as soon as a driver properly handle this
clock.

Christian, is Ok if I amend your patch, or do you prefer to post a v2 ?
Mike, with explained, is this change OK with you ?

> 
> Regards,
> Mike
> 
> > 
> > Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> > ---
> >  drivers/clk/meson/gxbb.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
> > index 86d3ae5..4c8925d 100644
> > --- a/drivers/clk/meson/gxbb.c
> > +++ b/drivers/clk/meson/gxbb.c
> > @@ -509,6 +509,7 @@ static struct clk_fixed_factor gxbb_fclk_div3_div = {
> >                 .ops = &clk_fixed_factor_ops,
> >                 .parent_names = (const char *[]){ "fixed_pll" },
> >                 .num_parents = 1,
> > +               .flags = CLK_IS_CRITICAL,
> >         },
> >  };
> >  
> > -- 
> > 2.7.4
