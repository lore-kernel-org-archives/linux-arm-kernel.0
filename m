From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 Jan 2018 11:03:14 +0100
Subject: [PATCH v2 1/3] drm/sun4i: hdmi: Check for unset best_parent in
 sun4i_tmds_determine_rate
In-Reply-To: <CANwerB3SKX=H-mhQZ0mLaLXmPiohVwoF+8dbWMhq9Fw7eJA4AA@mail.gmail.com>
References: <20171226111227.4526-1-net147@gmail.com>
 <20171226111227.4526-2-net147@gmail.com>
 <20180104195650.vmbooz3pwjy77wt7@flea.lan>
 <CANwerB3SKX=H-mhQZ0mLaLXmPiohVwoF+8dbWMhq9Fw7eJA4AA@mail.gmail.com>
Message-ID: <20180105100314.3j5zm4ushv4tfky5@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 05, 2018 at 09:44:39AM +1100, Jonathan Liu wrote:
> Hi Maxime,
> 
> On 5 January 2018 at 06:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Dec 26, 2017 at 10:12:25PM +1100, Jonathan Liu wrote:
> >> We should check if the best match has been set before comparing it.
> >>
> >> Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> >> Signed-off-by: Jonathan Liu <net147@gmail.com>
> >> ---
> >>  drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> >> index dc332ea56f6c..4d235e5ea31c 100644
> >> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> >> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
> >> @@ -102,7 +102,7 @@ static int sun4i_tmds_determine_rate(struct clk_hw *hw,
> >>                                       goto out;
> >>                               }
> >>
> >> -                             if (abs(rate - rounded / i) <
> >> +                             if (!best_parent || abs(rate - rounded / i) <
> >
> > Why is that causing any issue?
> >
> > If best_parent is set to 0...
> >
> >>                                   abs(rate - best_parent / best_div)) {
> >
> > ... the value returned here is going to be rate, which is going to be
> > higher than the first part of the comparison meaning ...
> >
> >>                                       best_parent = rounded;
> >
> > ... that best_parent is going to be set there.
> 
> Consider the following:
> rate = 83500000
> rounded = ideal * 2
> 
> It is possible that if "rounded = clk_hw_round_rate(parent, ideal)"
> gives high enough values that the condition "abs(rate - rounded / i) <
> abs(rate - best_parent / best_div)" is never met.
> 
> Then you can end up with:
> req->rate = 0
> req->best_parent_rate = 0
> req->best_parent_hw = ...
> 
> Also, the sun4i_tmds_calc_divider function has a similar check.

Ok. That explanation must be part of your commit log, or at least
which problem you're trying to address and in which situation it will
trigger.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180105/04291b5f/attachment.sig>
