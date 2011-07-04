From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 4 Jul 2011 11:28:05 +0200
Subject: [PATCH 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
In-Reply-To: <20110704084324.GE10245@S2100-06.ap.freescale.net>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
	<1309679760-22796-2-git-send-email-shawn.guo@linaro.org>
	<20110703211007.GB13742@ponder.secretlab.ca>
	<20110704021923.GA10245@S2100-06.ap.freescale.net>
	<20110704073320.GB4338@pengutronix.de>
	<20110704084324.GE10245@S2100-06.ap.freescale.net>
Message-ID: <20110704092805.GH4338@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Mon, Jul 04, 2011 at 04:43:25PM +0800, Shawn Guo wrote:
> On Mon, Jul 04, 2011 at 09:33:20AM +0200, Uwe Kleine-K?nig wrote:
> > On Mon, Jul 04, 2011 at 10:19:25AM +0800, Shawn Guo wrote:
> > > > > +static struct platform_device_id imx_uart_devtype[] = {
> > > > > +	{
> > > > > +		.name = "imx1-uart",
> > > > > +		.driver_data = IMX1_UART,
> > > > > +	}, {
> > > > > +		.name = "imx-uart",
> > > > > +		.driver_data = IMX2_UART,
> > It feels strange to introduce IMX2 today meaning
> > i.MX{21,25,27,31,35,50,51,53}. I didn't check the changes in detail, but
> > if the only relevant change is that the UTS register is at a different
> 
> No, it's not the only relevant change.  The patch also changes a couple of
> 'if (!cpu_is_imx1())' to 'if (IS_IMX2_UART())'.
> 
> The 'IMX2' in 'IMX2_UART' does not necessarily mean i.MX{21,25,27,
> 31,35,50,51,53}.  It actually means i.MX{21,25,27,31,35,50,51,53} all
> have the same UART block which was firstly introduced on IMX2.
This is ugly. IMHO something like imx_uart_v2 would be much better.
For a driver that supports all i.MX generations

	if (IS_IMX2_UART())

is simply misleading. Even if you had documented at the definition
of imx_uart_type (and/or IS_IMX2_UART) that IMX2_UART means everything
currently known but MX1, just looking at the if condition yields wrong
expectations.

	if (cpu_is_imx1())

is much better (in this aspect). (At least until Freescale comes up with
a new SOC in the mx1 family that includes a completely new UART block
:-)

With

	if (somehow_get_current_driver_data() & SOME_FLAG)
		do_the(things, that, "are only needed with SOME_FLAG");

you can have both, even local understandable code and no dependency on
the cpu_is_... stuff.

> It's actually a change respecting the existing code, which defines
> MX2_ONEMS for all imx except imx1.
IMHO that's a bad excuse. Take it the other way 'round: You can do
better than the existing code (and even fix it on the go if you're
motivated).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
