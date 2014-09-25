From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 25 Sep 2014 15:50:20 -0700
Subject: [PATCH v3 1/8] clk: rockchip: change pll rate without a
 clk-notifier
In-Reply-To: <1802092.5yu3PTGUzO@diego>
References: <1410991974-12235-1-git-send-email-heiko@sntech.de>
 <1410991974-12235-2-git-send-email-heiko@sntech.de>
 <CAD=FV=VjU7E4TpPHv5Md=zLEig=zCTG8twx8L9+5hdLuERDUAw@mail.gmail.com>
 <1802092.5yu3PTGUzO@diego>
Message-ID: <20140925225020.19023.20029@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2014-09-17 16:13:42)
> Am Mittwoch, 17. September 2014, 15:46:08 schrieb Doug Anderson:
> > Heiko,
> > 
> > On Wed, Sep 17, 2014 at 3:12 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > > From: Doug Anderson <dianders@chromium.org>
> > > 
> > > The Rockchip PLL code switches into slow mode (AKA bypass more AKA
> > > 24MHz mode) before actually changing the PLL.  This keeps anyone from
> > > using the PLL while it's changing.  However, in all known Rockchip
> > > SoCs nobody should ever see the 24MHz when changing the PLL supplying
> > > the armclk because we should reparent children to an alternate
> > > (faster than 24MHz) PLL.
> > > 
> > > One problem is that the code to switch to an alternate parent was
> > > running in PRE_RATE_CHANGE.  ...and the code to switch to slow mode
> > > was _also_ running in PRE_RATE_CHANGE.  That meant there was no real
> > > guarantee that we would switch to an alternate parent before switching
> > > to 24MHz mode.
> > > 
> > > Let's move the switch to "slow mode" straight into
> > > rockchip_rk3066_pll_set_rate().  That means we're guaranteed that the
> > > 24MHz is really a last-resort.
> > > 
> > > Note that without this change on real systems we were the code to
> > > switch to an alternate parent at 24MHz.  In some older versions of
> > > that code we'd appy a (temporary) / 5 to the 24MHz causing us to run
> > > at 4.8MHz.  That wasn't enough to service USB interrupts in some cases
> > > and could lead to a system hang.
> > > 
> > > Signed-off-by: Doug Anderson <dianders@chromium.org>
> > > Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > > 
> > >  drivers/clk/rockchip/clk-pll.c | 63
> > >  +++++++++--------------------------------- 1 file changed, 13
> > >  insertions(+), 50 deletions(-)
> > 
> > Thanks for adding my patch to your series (with the proper commit
> > message)!  I think you need your SoB on the patch too.  Andrew Morton
> > pointed to the docs in another patch I was involved in.  Specifically,
> > you were "on the patch delivery".  See Documentation/SubmittingPatches
> > section 12 (and 13).
> 
> ok ... Mike can you add the
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> to the patch, or do you want a respin [if no other issue appears]

I can add it, but do you plan to spin another version of this series
with the changes to the comments?

Regards,
Mike

> 
> 
> Heiko
