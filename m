From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 14 Oct 2011 09:37:52 +0800
Subject: [PATCH 2/2] arm/mx5: add device tree support for imx51 babbage
In-Reply-To: <4E970D62.9090403@free.fr>
References: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
	<1317389747-24589-3-git-send-email-shawn.guo@linaro.org>
	<4E970D62.9090403@free.fr>
Message-ID: <20111014013751.GD27048@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 06:10:10PM +0200, Julien Boibessot wrote:
> On 30/09/2011 15:35, Shawn Guo wrote:
> > It adds device tree support for imx51 babbage board.
> >
> cut
> > diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
> > new file mode 100644
> > index 0000000..0878441
> > --- /dev/null
> > +++ b/arch/arm/mach-mx5/imx51-dt.c
> > @@ -0,0 +1,116 @@
> cut
> > +
> > +static void __init imx51_timer_init(void)
> > +{
> > +	mx51_clocks_init(32768, 24000000, 22579200, 0);
> > +}
> From my understanding, if put in arch/arm/mach-mx5/imx51-dt.c, this
> clock initialization will apply to all i.MX51 based platforms.
> Am I right ?
> If so, I think clock init shouldn't be done here because it's platform
> dependant: one might for example choose to use 32k quartz instead of
> 24Mhz external oscillator as clock reference. i.MX51 supports this.
> For example on my board I do:
>     mx51_clocks_init(32768, 32768*1024, 0, 0);
> 
Yes, this is a problem and now it's the time to address it.  For dt
case, these clock frequencies should come from device tree.  I was
trying to keep it as it is until we finalize the clock bindings or the
need of different frequency setup shows up.  Now, the need shows up.

I will add a new function call mx51_clocks_init_dt() with zero parameter
in clock-mx51-mx53.c parsing the clock frequencies from device tree and
the calling into mx51_clocks_init(...) with these frequencies as the
parameters.  The updated patch will come soon.

Thanks for the input.  Glad to see people are actually planning to move
their board setup to DT.

-- 
Regards,
Shawn
