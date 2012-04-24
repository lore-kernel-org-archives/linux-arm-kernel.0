From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Apr 2012 09:10:37 +0800
Subject: [PATCH 2/8] clk: mxs: add clock support for imx23
In-Reply-To: <CAJOA=zMjV0juDhnkUuZTbLVh7eby1rDntkfKY2qGJ-2Y9SfmiQ@mail.gmail.com>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
 <1335023840-1394-3-git-send-email-shawn.guo@linaro.org>
 <CAJOA=zPU+-eQTGbXY15Gr==VzNB1JOLkocW4MD+fQBPe77sbdw@mail.gmail.com>
 <20120423235154.GY26306@S2101-09.ap.freescale.net>
 <CAJOA=zMjV0juDhnkUuZTbLVh7eby1rDntkfKY2qGJ-2Y9SfmiQ@mail.gmail.com>
Message-ID: <20120424011035.GA26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 04:59:23PM -0700, Turquette, Mike wrote:
> The error codes were added in for a good reason and should be honored.
> 
> >> > diff --git a/drivers/clk/mxs/clk.h b/drivers/clk/mxs/clk.h
> >> > index deb5c23..fb5937d 100644
> >> > --- a/drivers/clk/mxs/clk.h
> >> > +++ b/drivers/clk/mxs/clk.h
> >> > @@ -12,6 +12,8 @@
> >> > ?#ifndef __MXS_CLK_H
> >> > ?#define __MXS_CLK_H
> >> >
> >> > +#include <linux/clk.h>
> >> > +#include <linux/clkdev.h>
> >> > ?#include <linux/clk-provider.h>
> >> > ?#include <linux/err.h>
> >> > ?#include <linux/io.h>
> >> > @@ -72,4 +74,22 @@ static inline int mxs_clk_wait(void __iomem *reg, u8 shift)
> >> > ? ? ? ?return 0;
> >> > ?}
> >> >
> >> > +static inline int mxs_clk_init_on(char **clks_init_on, int num)
> >> > +{
> >> > + ? ? ? struct clk *clk;
> >> > + ? ? ? int i;
> >> > +
> >> > + ? ? ? for (i = 0; i < num; i++) {
> >> > + ? ? ? ? ? ? ? clk = clk_get_sys(clks_init_on[i], NULL);
> >> > + ? ? ? ? ? ? ? if (IS_ERR(clk)) {
> >> > + ? ? ? ? ? ? ? ? ? ? ? pr_err("%s: failed to get clk %s", __func__,
> >> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?clks_init_on[i]);
> >> > + ? ? ? ? ? ? ? ? ? ? ? return PTR_ERR(clk);
> >> > + ? ? ? ? ? ? ? }
> >> > + ? ? ? ? ? ? ? clk_prepare_enable(clk);
> >> > + ? ? ? }
> >> > +
> >> > + ? ? ? return 0;
> >> > +}
> >>
> >> Any good reason for this code to live in the header as static inline?
> >>
> > It's a small function which is used by both clk-imx23.c and clk-imx28.c.
> >
> >> Do you call this code any time other than at boot? ?Why not __init?
> >>
> > Eh, __init for inline function?
> 
> __init for a non-lined function.  If this code is only called at boot
> then you can move it into a C file and __init it.
> 
> This issue isn't worth blocking the series, but you could just as
> easily put the definition in the clock code for the oldest SoC that
> uses it (imx23 in this case) and declare it in your local clk.h
> 
Ok, if you are strong on this, I would prefer to the current way.
After all, it's a small function and the callers to it have already
been __init.

Should I respin the series to have those registration returns checked?

-- 
Regards,
Shawn
