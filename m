From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 22 Jul 2015 00:14:19 +0200
Subject: [PATCH] clk: rockchip: Fix PLL bandwidth
In-Reply-To: <55AEB6AE.2070006@codeaurora.org>
References: <1437511283-14216-1-git-send-email-dianders@chromium.org>
 <55AEB6AE.2070006@codeaurora.org>
Message-ID: <3846129.lKetE2zB83@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 21. Juli 2015, 14:16:30 schrieb Stephen Boyd:
> On 07/21/2015 01:41 PM, Douglas Anderson wrote:
> > In the TRM we see that BWADJ is "a 12-bit bus that selects the values
> > 
> > 1-4096 for the bandwidth divider (NB)":
> >   NB = BWADJ[11:0] + 1
> > 
> > The recommended setting of NB: NB = NF / 2.
> > 
> > So:
> >    NB = NF / 2
> >    BWADJ[11:0] + 1 = NF / 2
> >    BWADJ[11:0] = NF / 2 - 1
> > 
> > Right now, we have:
> > 
> > {                                               \
> > 
> >          .rate   = _rate##U,                     \
> >          .nr = _nr,                              \
> >          .nf = _nf,                              \
> >          .no = _no,                              \
> >          .bwadj = (_nf >> 1),                    \
> > 
> > }
> > 
> > That means we set bwadj to NF / 2, not NF / 2 - 1
> > 
> > All of this is a bit confusing because we specify "NR" (the 1-based
> > value), "NF" (the 1-based value), "NO" (the 1-based value), but
> > "BWADJ" (the 0-based value) instead of "NB" (the 1-based value).
> > 
> > Let's change to working with "NB" and fix the off by one error.  This
> > may affect PLL jitter in a small way (hopefully for the better).
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> There's no Fixes tag or stable Cc so I take it this isn't fixing any
> manifesting regression, more of a visual inspection bug find?

Looks like it ... i.e. all Rockchip SoCs I have (rk3066, rk3188, rk3288, 
rk3368) run fine for me with the off-by-one setting till now.
