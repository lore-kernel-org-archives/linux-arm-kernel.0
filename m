From: balbi@ti.com (Felipe Balbi)
Date: Mon, 17 Jan 2011 10:18:45 +0200
Subject: [PATCH 7/7] arm: omap2: clksel: fix compile warning
In-Reply-To: <AANLkTimO_Vt+bjS1rP1AwD9iSqd_cNLAZ+tukveOtneD@mail.gmail.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
	<1295238680-26738-8-git-send-email-balbi@ti.com>
	<AANLkTimO_Vt+bjS1rP1AwD9iSqd_cNLAZ+tukveOtneD@mail.gmail.com>
Message-ID: <20110117081845.GF2812@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 17, 2011 at 01:37:41PM +0530, Varadarajan, Charulatha wrote:
> On Mon, Jan 17, 2011 at 10:01, Felipe Balbi <balbi@ti.com> wrote:
> > Fix the following compile warning:
> > arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fieldval':
> > arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
> > used uninitialized in this function
> >
> > While at that, also add a check to avoid using max_clkr while NULL.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > ?arch/arm/mach-omap2/clkt_clksel.c | ? ?5 ++++-
> > ?1 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
> > index a781cd6..baf0b6b 100644
> > --- a/arch/arm/mach-omap2/clkt_clksel.c
> > +++ b/arch/arm/mach-omap2/clkt_clksel.c
> > @@ -97,7 +97,7 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?u32 *field_val)
> > ?{
> > ? ? ? ?const struct clksel *clks;
> > - ? ? ? const struct clksel_rate *clkr, *max_clkr;
> > + ? ? ? const struct clksel_rate *clkr, *max_clkr = NULL;
> > ? ? ? ?u8 max_div = 0;
> >
> > ? ? ? ?clks = _get_clksel_by_parent(clk, src_clk);
> > @@ -123,6 +123,9 @@ static u8 _get_div_and_fieldval(struct clk *src_clk, struct clk *clk,
> > ? ? ? ? ? ? ? ?}
> > ? ? ? ?}
> >
> > + ? ? ? if (!max_clkr)
> > + ? ? ? ? ? ? ? return 0;
> 
> Would it be more appropriate to move this check after the "if" check
> of max_div==0 and it's warning?
> or add a warning before it returns?

Maybe this return isn't even necessary. max_clkr will be true if max_div
is valid, so they cancel each other.

Tony ?

-- 
balbi
