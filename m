From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Tue, 01 Mar 2016 11:04:51 -0500
Subject: [PATCH v5 3/6] watchdog: pnx4008: add support for soft reset
In-Reply-To: <56D51492.4000405@roeck-us.net>
References: <1456767068-14449-1-git-send-email-slemieux.tyco@gmail.com>
 <1456767068-14449-4-git-send-email-slemieux.tyco@gmail.com>
 <56D51492.4000405@roeck-us.net>
Message-ID: <1456848291.12069.7.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-02-29 at 20:03 -0800, Guenter Roeck wrote:
> On 02/29/2016 09:31 AM, Sylvain Lemieux wrote:
> > From: Sylvain Lemieux <slemieux@tycoint.com>
> >
> > Add support for explicit soft reset using the reboot mode.
> >
> > The default reboot mode behavior is unchanged;
> > you can overwrite the default reboot type in the board specific file
> > "DT_MACHINE_START" definition using the "reboot_mode" parameter.
> >
> > Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> > ---
> > Changes from v4 to v5:
> > - no logical change; updated to work with new revision of patch #2.
> >
> > Changes from v3 to v4:
> > - none.
> >
> > Changes from v2 to v3:
> > - no logical change; updated to work with new revision of patch #2.
> >
> > Changes from v1 to v2:
> > - Rename patch title;
> >    was "arm: lpc32xx: restart: add support for soft reset"
> > - Add change to "pnx-4008" driver instead of "mach-lpc32xx".
> > - Use define available in "pnx-4008" when writting to watchdog register.
> >
> >   drivers/watchdog/pnx4008_wdt.c | 13 ++++++++++---
> >   1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
> > index f3be522..e05bfecf 100644
> > --- a/drivers/watchdog/pnx4008_wdt.c
> > +++ b/drivers/watchdog/pnx4008_wdt.c
> > @@ -129,9 +129,16 @@ static int pnx4008_wdt_set_timeout(struct watchdog_device *wdd,
> >   static int pnx4008_restart_handler(struct watchdog_device *wdd,
> >   				   unsigned long mode, void *cmd)
> >   {
> > -	/* Instant assert of RESETOUT_N with pulse length 1mS */
> > -	writel(13000, WDTIM_PULSE(wdt_base));
> > -	writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
> > +	if (mode == (unsigned long)REBOOT_SOFT) {
> 
> Are those typecasts really necessary ?
> 
> Guenter
> 
typecasts are optional; the compare occurred 
between "unsigned long" & "enum reboot_mode" types.

Do you want me to remove them?

Sylvain

> > +		/* Force match output active */
> > +		writel(EXT_MATCH0, WDTIM_EMR(wdt_base));
> > +		/* Internal reset on match output (RESOUT_N not asserted) */
> > +		writel(M_RES1, WDTIM_MCTRL(wdt_base));
> > +	} else {
> > +		/* Instant assert of RESETOUT_N with pulse length 1mS */
> > +		writel(13000, WDTIM_PULSE(wdt_base));
> > +		writel(M_RES2 | RESFRC1 | RESFRC2, WDTIM_MCTRL(wdt_base));
> > +	}
> >
> >   	/* Wait for watchdog to reset system */
> >   	mdelay(1000);
> >
> 
