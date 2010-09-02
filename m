From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Sep 2010 19:57:21 +0200
Subject: [PATCH 1/6] spi-imx: add CSPI and eCSPI support for i.MX51 MCU
In-Reply-To: <20100902172908.GD2464@tarshish>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<20100902145357.GL14214@pengutronix.de>
	<19583.48828.125104.712979@ipc1.ka-ro>
	<20100902172908.GD2464@tarshish>
Message-ID: <20100902175720.GU14214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Sep 02, 2010 at 08:29:09PM +0300, Baruch Siach wrote:
> Hi Lothar,
> 
> On Thu, Sep 02, 2010 at 05:11:56PM +0200, Lothar Wa?mann wrote:
> > > > -	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35()) {
> > > > +	/* i.MX51 has two eCSPI and one CSPI controllers, eCSPI controllers are
> > > > +	 * not compatible with existing SPI controllers on other i.MX platforms,
> > > > +	 * while CSPI controller is 100% compatible with the one on the i.MX35.
> > > > +	 * We set the platform device id to 2 for this CSPI at i.MX51 board init
> > > > +	 * level to distinguish it from two eCSPI controllers.
> > > > +	 */
> > > This comment is missing in Sascha's driver.  I like it.
> > > BTW, I'd like to make use of platform ids in this driver.  This would
> > > make this ugly "on imx51 id2 is a cspi" distinction unnecessary.
> > > 
> > > > +	if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35() ||
> > > > +	    (cpu_is_mx51() && (pdev->id == 2))) {
> > I'd prefer a flag in the platform_data that tells the driver to act as
> > an eCSPI driver. This way the information about eCSPI or not would be
> > where it belongs (in the arch specific code).
> 
> But this also increases the size of driver code, since the compiler can 
> resolve cpu_is_* at compile time, and drop the dead code. Maybe an is_ecspi 
> macro will make the above code clearer.
If you ask me the cleanest approach is using platform ids.  That is the
devices on mx51 could be called:

	imx51-ecspi.0
	imx51-ecspi.1
	imx51-cspi.0

I don't know what the implications on driver code size is, but I can
imagine that if done carefully the driver doesn't need to be bigger.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
