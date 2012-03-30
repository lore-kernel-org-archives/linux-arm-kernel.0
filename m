From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 30 Mar 2012 11:50:24 +0200
Subject: [PATCH 03/17] ARM: mark const init data with __initconst instead
 of __initdata
In-Reply-To: <20120330061134.GD3254@S2101-09.ap.freescale.net>
References: <20120329211131.GA31250@pengutronix.de>
 <1333055554-31300-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120330061134.GD3254@S2101-09.ap.freescale.net>
Message-ID: <20120330095024.GS15647@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Fri, Mar 30, 2012 at 02:11:36PM +0800, Shawn Guo wrote:
> On Thu, Mar 29, 2012 at 11:12:20PM +0200, Uwe Kleine-K?nig wrote:
> ...
> > diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
> > index 5cca573..7e00748 100644
> > --- a/arch/arm/mach-imx/imx51-dt.c
> > +++ b/arch/arm/mach-imx/imx51-dt.c
> > @@ -102,7 +102,7 @@ static struct sys_timer imx51_timer = {
> >  	.init = imx51_timer_init,
> >  };
> >  
> > -static const char *imx51_dt_board_compat[] __initdata = {
> > +static const char *imx51_dt_board_compat[] __initconst = {
> >  	"fsl,imx51-babbage",
> >  	"fsl,imx51",
> >  	NULL
> 
>   CC      arch/arm/mach-imx/imx51-dt.o
> arch/arm/mach-imx/imx51-dt.c:105:20: error: imx51_dt_board_compat causes a section type conflict
> make[2]: *** [arch/arm/mach-imx/imx51-dt.o] Error 1
> 
> I do not understand why though.
that's because the strings are constant, but the array is not. The fix
is:

-static const char *imx51_dt_board_compat[] __initconst = {
+static const char *const imx51_dt_board_compat[] __initconst = {

or keeping __initdata.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
