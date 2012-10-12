From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 11 Oct 2012 21:51:14 -0700
Subject: [PATCH] ARM:IMX6Q:use pll2_pfd2_396m as the enfc_sel's parent
In-Reply-To: <20120919134426.GA2450@S2101-09.ap.freescale.net>
References: <1347261476-9799-1-git-send-email-b32955@freescale.com>
 <20120919053348.GH6460@S2100-06.ap.freescale.net>
 <20120919073130.GX6180@pengutronix.de>
 <20120919134426.GA2450@S2101-09.ap.freescale.net>
Message-ID: <CAPtuhTi=WZDHNySaCuuCiqp6PBHHhY8BPAFmU55qMpT4WpsPMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 6:44 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Sep 19, 2012 at 09:31:30AM +0200, Sascha Hauer wrote:
>> On Wed, Sep 19, 2012 at 01:33:50PM +0800, Shawn Guo wrote:
>> > On Mon, Sep 10, 2012 at 03:17:56PM +0800, Huang Shijie wrote:
>> > > The gpmi-nand driver can support the ONFI nand chip's EDO (extra data out)
>> > > mode in the asynchrounous mode. In the asynchrounous mode 5, the gpmi
>> > > needs 100MHz clock for the IO. But with the pll2_pfd0_352m, we can not
>> > > get the 100MHz clock.
>> > >
>> > > So choose pll2_pfd2_396m as enfc_sel's parent.
>> > >
>> > > Signed-off-by: Huang Shijie <b32955@freescale.com>
>> >
>> > Applied, thanks.
>> >
>> > But we really expect that clock framework can get improved to have such
>> > case handled in clk_set_rate() call.
>>
>> How do you want to archieve that?
>
> Actually, I'm relying on Mike for that, as he said a patch for that
> is under hacking [1].
>

Hmm, I need to re-prioritize rebasing this patch...

>> It would be possible to teach the
>> clock framework to iterate over the possible parents and see what gives
>> the best result, but how do we teach the clock framework that there are
>> other constraints, like for example 'use this clock in low power mode
>> and that one otherwise'?
>>
> I have no idea, and I'm not even sure Mike's patch will address such
> constraints.  Mike?
>

I'm not sure about the "low power clock configuration" case, but I
have some local code for the OMAP clock port which is in a "clk-sets"
branch.  This code looks at requested clock rates and matches them to
a table which affects many clocks.  Essentially the idea is that an
operating point (OPP) is a combination of both voltage for a rail and
a snapshot of clock configuration for many clocks in a subtree.
Instead of relying on the algorithmic methods for programming a clock
rate (such as in the clk-divider.c implementation or the many
platform-specific PLL .set_rate implementations) this implementation
uses a limited set of predefined allowed clock rates and somewhat
simplifies the concept of programming many clocks for predefined
use-cases.  Unfortunately the code is in terrible shape and not ready
for public review, but I will prioritize it.  This code goes along
nicely with my next crack at solving the generic DVFS problem.

This approach might help the "low power clock configuration" case, but
time will only tell.  I will take into consideration not only a table
listing valid frequencies, but also valid parents which should help
your case.

Regards,
Mike

> Shawn
>
>> We have a similar problem with the IPU: When the LDB is used, the IPU
>> pixel clock has to be switched to the LDB clock, even if other clocks
>> would result in a more accurate frequency.
>>
>> That's a topic for a long long discussion, I think even longer than it
>> took to introduce the clock framework ;)
>>
>
> [1] http://thread.gmane.org/gmane.linux.ports.tegra/6196/focus=6198
