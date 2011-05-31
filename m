From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 31 May 2011 18:30:12 +0800
Subject: [PATCH 2/4] ARM: mxc: migrate mach-mx5 gpio driver to gpio-mxc
In-Reply-To: <201105311026.11947.arnd@arndb.de>
References: <1306767139-24763-1-git-send-email-shawn.guo@linaro.org>
	<20110531001634.GB3411@quad.lixom.net>
	<20110531024729.GB31928@S2100-06.ap.freescale.net>
	<201105311026.11947.arnd@arndb.de>
Message-ID: <20110531103011.GB32096@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 10:26:11AM +0200, Arnd Bergmann wrote:
> On Tuesday 31 May 2011, Shawn Guo wrote:
> > > The above tables are pretty crazy, and they only get worse later in the series
> > > when the other SoCs are added. Is it really worth it to have a common initcall
> > > entry for the various SoCs here?
> > > 
> > This common initcall seems a good place to concentrate the gpio device
> > registration.  It's easy to look at the common/different things among
> > these SoCs.  The only problem you reminded me is the scanning of the
> > long cpu_is_mx list.  It can be optimized a little bit by sorting the
> > list from the latest (most used) SoC to the oldest (least used) one,
> > and breaking out the scanning immediately when hitting one.
> 
> No, better make them separate functions.
> 
> > > It'd seem cleaner to me to just call the registration function for the
> > > family you're running from in per-family-init code such as where it was
> > > removed above (irq init, which makes some sense since the gpios provide
> > > interrupt sources as well).
> > > 
> > I just gave it a test, and it's not working at all.  (too early
> > to register device in irq init?)
> 
> Just open-code the mxc_add_mxc_gpio() by moving the individual calls to
> mxc_add_gpio() into the respective callers. Having a global
> mxc_add_mxc_gpio() function that does something different for each
> caller seems entirely pointless to me.
> 
Right now, mxc_add_mxc_gpio() is a postcore_initcall.  Moving
individual mxc_add_gpio() call into irq_init function does not work.
And I need to find a proper caller for each SoC to call mxc_add_gpio
to register gpio devices.

-- 
Regards,
Shawn
