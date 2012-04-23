From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 23 Apr 2012 16:59:23 -0700
Subject: [PATCH 2/8] clk: mxs: add clock support for imx23
In-Reply-To: <20120423235154.GY26306@S2101-09.ap.freescale.net>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
 <1335023840-1394-3-git-send-email-shawn.guo@linaro.org>
 <CAJOA=zPU+-eQTGbXY15Gr==VzNB1JOLkocW4MD+fQBPe77sbdw@mail.gmail.com>
 <20120423235154.GY26306@S2101-09.ap.freescale.net>
Message-ID: <CAJOA=zMjV0juDhnkUuZTbLVh7eby1rDntkfKY2qGJ-2Y9SfmiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 4:51 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Mon, Apr 23, 2012 at 04:07:13PM -0700, Turquette, Mike wrote:
>> On Sat, Apr 21, 2012 at 8:57 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > Add imx23 clock support based on common clk framework.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> > ---
>> ...
>> > +int __init mx23_clocks_init(void)
>> > +{
>> > + ? ? ? struct clk *clk;
>> > + ? ? ? int ret;
>> > +
>> > + ? ? ? clk_misc_init();
>> > +
>> > + ? ? ? mxs_clk_fixed("ref_xtal", 24000000);
>>
>> There is no error checking at all?
>>
> Right now, the only possible reason that the registration function could
> fail is -ENOMEM. ?I thought it's not worth checking tens of function
> returns for the same error which is unlikely to happen.
>
> But if you're strong on this, I can add a check.

The error codes were added in for a good reason and should be honored.

>> > diff --git a/drivers/clk/mxs/clk.h b/drivers/clk/mxs/clk.h
>> > index deb5c23..fb5937d 100644
>> > --- a/drivers/clk/mxs/clk.h
>> > +++ b/drivers/clk/mxs/clk.h
>> > @@ -12,6 +12,8 @@
>> > ?#ifndef __MXS_CLK_H
>> > ?#define __MXS_CLK_H
>> >
>> > +#include <linux/clk.h>
>> > +#include <linux/clkdev.h>
>> > ?#include <linux/clk-provider.h>
>> > ?#include <linux/err.h>
>> > ?#include <linux/io.h>
>> > @@ -72,4 +74,22 @@ static inline int mxs_clk_wait(void __iomem *reg, u8 shift)
>> > ? ? ? ?return 0;
>> > ?}
>> >
>> > +static inline int mxs_clk_init_on(char **clks_init_on, int num)
>> > +{
>> > + ? ? ? struct clk *clk;
>> > + ? ? ? int i;
>> > +
>> > + ? ? ? for (i = 0; i < num; i++) {
>> > + ? ? ? ? ? ? ? clk = clk_get_sys(clks_init_on[i], NULL);
>> > + ? ? ? ? ? ? ? if (IS_ERR(clk)) {
>> > + ? ? ? ? ? ? ? ? ? ? ? pr_err("%s: failed to get clk %s", __func__,
>> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?clks_init_on[i]);
>> > + ? ? ? ? ? ? ? ? ? ? ? return PTR_ERR(clk);
>> > + ? ? ? ? ? ? ? }
>> > + ? ? ? ? ? ? ? clk_prepare_enable(clk);
>> > + ? ? ? }
>> > +
>> > + ? ? ? return 0;
>> > +}
>>
>> Any good reason for this code to live in the header as static inline?
>>
> It's a small function which is used by both clk-imx23.c and clk-imx28.c.
>
>> Do you call this code any time other than at boot? ?Why not __init?
>>
> Eh, __init for inline function?

__init for a non-lined function.  If this code is only called at boot
then you can move it into a C file and __init it.

This issue isn't worth blocking the series, but you could just as
easily put the definition in the clock code for the oldest SoC that
uses it (imx23 in this case) and declare it in your local clk.h

Regards,
Mike
