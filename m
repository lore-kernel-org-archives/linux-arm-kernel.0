From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 22 Jul 2013 21:42:31 +0200
Subject: [PATCH 2/4] clk: exynos-audss: allow input clocks to be specified
 in device tree
In-Reply-To: <20130722181530.7598.73318@quantum>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
 <1610421.OFFn8rqlxt@amdc1227> <20130722181530.7598.73318@quantum>
Message-ID: <5824726.DGbrnrmYE0@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 of July 2013 11:15:30 Mike Turquette wrote:
> Quoting Tomasz Figa (2013-07-22 09:28:47)
> 
> > Hi Padmavathi, Andrew,
> > 
> > On Wednesday 10 of July 2013 17:41:51 Padmavathi Venna wrote:
> > > From: Andrew Bresticker <abrestic@chromium.org>
> > > 
> > > This allows the input clocks to the Exynos AudioSS block to be
> > > specified via device-tree bindings.  Default names will be used
> > > when an input clock is not given.  This will be useful when adding
> > > support for the Exynos5420 where the audio bus clock is called
> > > "sclk_maudio0" instead of "sclk_audio0".
> > > 
> > > Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> > > Reviewed-on: https://gerrit.chromium.org/gerrit/57833
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > ---
> > > 
> > >  .../devicetree/bindings/clock/clk-exynos-audss.txt |   31
> > > 
> > > ++++++++++++++++++- drivers/clk/samsung/clk-exynos-audss.c          
> > >   |> > 
> > >   28 +++++++++++++++-- 2 files changed, 53 insertions(+), 6
> > >   deletions(-)
> > 
> > Well, this is basically how it should be done, but in current state of
> > clock core I can see a problem: can we really rely on the order of
> > clock initialization? I mean, we can't defer initialization of
> > particular clock controller until all external clocks it needs are
> > available, because there is no probing involved here.
> 
> The clock core allows registering clocks even if their parents are not
> yet registered. I test this path with some dummy clocks every so often
> to make sure the re-parenting operation are completed successfully after
> the parents eventually are registered.

Sure it does, but this patch is about something different. It adds device 
tree based lookup (of_clk_get_by_name()) of external clocks (as opposed to 
existing lookup by name), which will fail if provider pointed by phandle 
is not registered yet.

> This feature was not used in practice until recently with the advent of
> multiple clock controllers getting registered and DT description of
> clocks / clock controllers that may be "out of order". If you find any
> bugs please let me know ;-)

I will send you a bunch of patches sorting out issues I found in 
clk_set_rate() path, but give me some time to prepare them :).

As for multiple clock controllers, this is going to be funny. I have 
discussed this a bit with Sylwester and we managed to find some design 
issues that I think must be solved:

a) What about multiple controllers with identical clock names? Imagine two 
PMICs that can also generate 32 KHz clocks, both having them named 
"clk32k". Am I right saying that this won't work with current code?

b) What are the rules of using clock-output-names property (and what 
should be used in non-DT case)? I can imagine using it to assign platform-
specific names of clock outputs of extra clock controllers (this would 
help in the above case of "clk32k"), but currently it seems like it is 
optional to use it in clock drivers and the meaning is provider-specific.

Best regards,
Tomasz
