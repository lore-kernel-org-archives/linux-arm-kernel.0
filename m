From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 20:32:42 +0100
Subject: [linux-sunxi] [PATCH 1/2] clk: sunxi-ng: Support fixed
 post-dividers on MP style clocks
In-Reply-To: <CAGb2v64w7EEYbJug+PQQwM8zXcyoOo8B+zk9MzU8cAW=K=gvEw@mail.gmail.com>
References: <20171204051912.7485-1-wens@csie.org>
 <20171204051912.7485-2-wens@csie.org>
 <b961a1b6-f0e4-68e3-ab77-b0010dab63ff@arm.com>
 <CAGb2v64w7EEYbJug+PQQwM8zXcyoOo8B+zk9MzU8cAW=K=gvEw@mail.gmail.com>
Message-ID: <20171205193242.jsjkw2x6eymdwt5y@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;5002;0c
On Tue, Dec 05, 2017 at 11:01:11AM +0800, Chen-Yu Tsai wrote:
> On Tue, Dec 5, 2017 at 7:18 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> > Hi Chen-Yu,
> >
> > On 04/12/17 05:19, Chen-Yu Tsai wrote:
> >> On the A64, the MMC module clocks are fixed in the new timing mode,
> >> i.e. they do not have a bit to select the mode. These clocks have
> >> a 2x divider somewhere between the clock and the MMC module.
> >>
> >> To be consistent with other SoCs supporting the new timing mode,
> >> we model the 2x divider as a fixed post-divider on the MMC module
> >> clocks.
> >>
> >> To do this, we first add fixed post-divider to the MP style clocks,
> >> which the MMC module clocks are.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu_mp.c | 20 ++++++++++++++++++--
> >>  drivers/clk/sunxi-ng/ccu_mp.h | 24 ++++++++++++++++++++++++
> >>  2 files changed, 42 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
> >> index 688855e7dc8c..5d0af4051737 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_mp.c
> >> +++ b/drivers/clk/sunxi-ng/ccu_mp.c
> >> @@ -50,12 +50,19 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
> >>       unsigned int max_m, max_p;
> >>       unsigned int m, p;
> >>
> >> +     if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
> >> +             rate *= cmp->fixed_post_div;
> >
> > Can't you just initialise fixed_post_div to 1 normally and save the
> > CCU_FEATURE_FIXED_POSTDIV?
> 
> I'll refer to Maxime about this. The feature flag was there from day
> one. We only started to implement support for it later on. I'm not
> sure if there was a reason to add them as feature flags, instead of
> a field that defaults to something (0 even).
> 
> Otherwise it's a reasonable change. And we probably don't have to
> do a wholesale change for the other clocks in one go. Incidentally
> I have a A83T audio series that also adds post-dividers for another
> clock type. I'll wait for a conclusion on this end before posting
> it.

We can definitely remove that feature flag. However, that would also
mean going over all the clocks we define everywhere to set it to 1,
which is going to be cumbersome and likely to introduce some bugs. I
don't really want to tie those two patches to that effort.

I applied both, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/1874050b/attachment.sig>
