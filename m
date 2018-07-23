From: megous@megous.com (=?utf-8?Q?Ond=C5=99ej?= Jirman)
Date: Mon, 23 Jul 2018 18:16:34 +0200
Subject: [PATCH v3 0/7] mmc: sunxi: Add runtime PM support
In-Reply-To: <20180720145143.qgvlk2gbegxwwcfs@flea>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
 <20180716171428.ud3zsmeccds545si@core>
 <20180720145143.qgvlk2gbegxwwcfs@flea>
Message-ID: <20180723161634.j7akxttoothslyhi@core>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, Jul 20, 2018 at 04:51:43PM +0200, Maxime Ripard wrote:
> Hi Ondrej,
> 
> On Mon, Jul 16, 2018 at 07:14:28PM +0200, Ond?ej Jirman wrote:
> > On Mon, Apr 16, 2018 at 04:22:58PM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > Since it's introduction, our MMC controller has had its external clocks
> > > running all the time.
> > > 
> > > While that was working great, the power usage and most importantly the EMI
> > > that it generated was pretty bad.
> > > 
> > > Let's implement some runtime_pm hooks with an autosuspend to shut down the
> > > whole block when the MMC is not active.
> > > 
> > > However, some SDIO devices will not probe properly if we keep shutting down
> > > the controller, so the autosuspend is disabled for the SDIO devices.
> > 
> > I've tested your patches on TBS A711 tablet (A83T). I get this in the log:
> > 
> >   sunxi-mmc 1c10000.mmc: fatal err update clk timeout
> > 
> > Interestingly, this only happens after the first boot. If I hard power cycle the
> > tablet (removing/reinserting the battery) the first boot after that, there's no
> > timeout, and WiFi chip connected to the mmc controller works.
> > 
> > Any other reboot (even power cycling via PMIC), it fails with the above error.
> > Maybe there's some unforeseen interaction of runtime PM with mmc-powerseq used
> > for the wifi chip power seuencing? Do you know what's the above error about?
> > I don't know anything about mmc subsystem.
> 
> It's kind of weird. Do you have an oscilloscope available to look at
> the clock signal (and the reset gpio) and see if there's any
> difference of behaviour?

No, I don't. I can try some printks on the kernel side if it toggles the WiFi
reset/power enable gpios differntly.

It looks like something's different on initialization when booting the kernel.
WiFi works fine for extended periods of time after the hard power cycle. But
when rebooting, it fails.

Adding to the weirdness factor may be the fact that WiFi is not connected via
PMIC, so it gets power almost directly from the battery. So kernel may not be
doing the WiFi reset properly on boot (which is fine right after the hard power
cycle, but leaves the WiFi in unknown state on subsequent reboots).

Thank you and regards,
  o.

> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
