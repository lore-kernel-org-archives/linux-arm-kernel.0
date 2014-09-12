From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Sep 2014 09:59:52 +0200
Subject: [PATCH] clk: don't use __initconst for non-const arrays
In-Reply-To: <CAKv+Gu9LubyPHoYJsRfRoqgONAApb3nEoXAxUa9g6tecP=McOw@mail.gmail.com>
References: <1410469471-31027-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140911220445.GQ3755@pengutronix.de>
 <CAKv+Gu9LubyPHoYJsRfRoqgONAApb3nEoXAxUa9g6tecP=McOw@mail.gmail.com>
Message-ID: <20140912075952.GR3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ard,

On Fri, Sep 12, 2014 at 09:42:29AM +0200, Ard Biesheuvel wrote:
> On 12 September 2014 00:04, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > Hello,
> >
> > On Thu, Sep 11, 2014 at 11:04:31PM +0200, Uwe Kleine-K?nig wrote:
> >>  /* Mux parent lists. */
> >> -static const char *fin_pll_p[] __initconst = {
> >> +static const char *fin_pll_p[] __initdata = {
> >>       "xxti",
> >>       "xusbxti"
> >>  };
> > As discussed with Tomasz on irc: The sad thing here is that for this
> > array only 8 bytes are freed when .init.rodata is thrown away (that is
> > two pointers). The actual data---5 + 8 bytes + maybe aligning---isn't
> > freed though.
> >
> > We wondered if there is a nice and easy way to throw away the
> > characters, too.
> >
> > The only way I currently see is:
> >
> >         const char xxti[] __initconst = "xxti";
> >         ...
> >
> >         static const char *fin_pll_p[] __initdata = {
> >                 xxti,
> >                 ...
> >         };
> >
> > but this definitively doesn't qualify as "nice and easy". Is there an
> > alternative?
> >
> 
> What about doing
> 
> static const char fin_pll_p[][8] __initconst = {
>      "xxti",
>      "xusbxti"
> };
This results in the strings being moved to .init.rodata and so they are
discarded. But it also results in:

	drivers/clk/samsung/clk-s5pv210.c:412:2: warning: initialization from incompatible pointer type [enabled by default]
	  MUX_F(FIN_PLL, "fin_pll", fin_pll_p, OM_STAT, 0, 1,
	  ^
	drivers/clk/samsung/clk-s5pv210.c:412:2: warning: (near initialization for 'early_mux_clks[0].parent_names') [enabled by default]

That's because early_mux_clks[0].parent_names is of type const char **
while fin_pll_p as suggested doesn't provide an array of pointers to the
start of the contained strings.
I don't see a way to fix that unless we fix the maximal clock name
length globally and so waste much memory.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
