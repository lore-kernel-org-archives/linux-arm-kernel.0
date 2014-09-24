From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 24 Sep 2014 22:27:17 +0200
Subject: [PATCH] clk: rockchip: add initcall to set clk defaults after
 syscons are available
In-Reply-To: <CAD=FV=V5ZBAVEV=-BK7MEWO2KLUqQ4L6ZXrxkGA=AsKxY3mq9w@mail.gmail.com>
References: <1566610.B4NH8lpaoI@diego>
 <CAD=FV=V5ZBAVEV=-BK7MEWO2KLUqQ4L6ZXrxkGA=AsKxY3mq9w@mail.gmail.com>
Message-ID: <1913186.v9VZxj5m8a@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 24. September 2014, 13:21:57 schrieb Doug Anderson:
> Hi,
> 
> On Thu, Aug 7, 2014 at 5:57 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > PLLs on Rockchip platforms report their locking state in an external
> > register situated in the "General Register Files" which is provided
> > through a syscon device.
> > 
> > When the initial clk init runs, this syscon is of course not yet
> > available, making it impossible to set PLLs to other frequencies
> > through the assigned-rate property of the clock-controller node.
> > 
> > Syscon devices are initialized through a postcore initcall, so add an
> > arch_initcall to rerun the rockchip specific clock initalization when
> > the GRF is available.
> > 
> > As the clock init already runs two times (through of_clk_add_provider
> > and of_clk_init), a third time shouldn't hurt to much and in the best
> > case wouldn't change any settings at all.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/clk/rockchip/clk.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> 
> My current understanding is that this patch is on hold pending
> <https://patchwork.kernel.org/patch/4945531/> (AKA mfd: syscon:
> Decouple syscon interface from platform devices).  If that patch lands
> then we can drop this one.

correct.

I've tested v5 this evening and apart from the debugfs issue I reported there, 
the whole assigned-clocks init worked really nice.


Heiko
