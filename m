From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 May 2017 18:11:59 +0100
Subject: [PATCH] arm64: dts: marvell: mcbin: add sdhci
In-Reply-To: <CAPv3WKeK9Z_1dGvBnc=NJrD7+nZOgf60iCNvvTkFGcP7GSyt=Q@mail.gmail.com>
References: <E1dAcn4-0004z2-Fl@rmk-PC.armlinux.org.uk>
 <CAPv3WKf4GcOc7g-2yMCjGN4HrftDL0Ro6jHErQL8-zSH-tC10w@mail.gmail.com>
 <CAPv3WKeK9Z_1dGvBnc=NJrD7+nZOgf60iCNvvTkFGcP7GSyt=Q@mail.gmail.com>
Message-ID: <20170516171159.GH22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 05:42:19PM +0200, Marcin Wojtas wrote:
> Re-send in plain text.
> 
> 2017-05-16 17:40 GMT+02:00 Marcin Wojtas <mw@semihalf.com>:
> > Russel,
> >
> > 2017-05-16 15:45 GMT+02:00 Russell King <rmk+kernel@armlinux.org.uk>:
> >>
> >> Add sdhci support for MACCHIATOBin boards.  This uses the AP806 SDHCI
> >> for eMMC and CP110 master for the SD card slot.
> >>
> >> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >> ---
> >>
> >> This version labels up the uSD connector, adds the vqmmc regulator for
> >> the uSD (the regulator itself already present in the DT), and supports
> >> the card detect signal.
> >>
> >> For eMMC, this version adds the vqmmc regulator, which again is already
> >> present in the DT, marks it as not supporting SD or SDIO, and also
> >> includes "slow mode" since testing with previous versions of the driver
> >> have shown that selecting faster speeds results in errors.
> >>
> >>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts |   23
> >> ++++++++++++++++++++++
> >>  1 file changed, 23 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> >> b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> >> index cc167e05941a..60111ed3234a 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> >> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> >> @@ -95,6 +95,21 @@
> >>         status = "okay";
> >>  };
> >>
> >> +&ap_sdhci0 {
> >> +       bus-width = <8>;
> >> +       /*
> >> +        * Not stable in HS modes - phy needs "more calibration", so add
> >> +        * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
> >> +        */
> >> +       marvell,xenon-phy-slow-mode;
> >
> >
> > FYI, this property is by default present in armada-ap806.dtsi.

Yes, it may be, it's unclear (at least to me) whether this is a board
problem or a SoC problem.  Given that it's at the SoC layer, it suggests
there's a SoC/driver problem that needs resolving.

However, given that the board is tested only in non-HS mode at the
moment, having the property in place is the sensible thing, even though
the SoC level currently has the property.  If we can prove that the
board is capable of HS modes, then I'd be happy to remove it, but not
before.  It could be that even if the SoC level is capable of HS modes,
the board may not support them.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
