From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 19:53:05 +0800
Subject: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux subsystem
In-Reply-To: <7FE21149F4667147B645348EC60578850567C3@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-5-git-send-email-b29396@freescale.com>
 <20111214211152.GM27267@pengutronix.de>
 <CACRpkdYHtgx3Qgx4QRdgOahQXjvSWE_iogWCZjaYQ-VnyS62uQ@mail.gmail.com>
 <20111215070505.GA22541@S2101-09.ap.freescale.net>
 <CACRpkdbN26q1_d4tPkJp4f4_KdvoEEk9uCCRyOfEU97DOWAnEw@mail.gmail.com>
 <7FE21149F4667147B645348EC60578850564C5@039-SN2MPN1-013.039d.mgd.msft.net>
 <20111215093319.GO27267@pengutronix.de>
 <20111215112140.GA10522@S2101-09.ap.freescale.net>
 <7FE21149F4667147B645348EC60578850567C3@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20111215115300.GB10522@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 07:28:18PM +0800, Dong Aisheng-B29396 wrote:
> > -----Original Message-----
> > From: Guo Shawn-R65073
> > Sent: Thursday, December 15, 2011 7:22 PM
> > To: Sascha Hauer
> > Cc: Dong Aisheng-B29396; Linus Walleij; Guo Shawn-R65073;
> > linus.walleij at stericsson.com; linux-kernel at vger.kernel.org;
> > rob.herring at calxeda.com; grant.likely at secretlab.ca; linux-arm-
> > kernel at lists.infradead.org; kernel at pengutronix.de
> > Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux
> > subsystem
> > Importance: High
> > 
> > On Thu, Dec 15, 2011 at 10:33:19AM +0100, Sascha Hauer wrote:
> > > On Thu, Dec 15, 2011 at 08:59:28AM +0000, Dong Aisheng-B29396 wrote:
> > > > > -----Original Message-----
> > > > > From: Linus Walleij [mailto:linus.walleij at linaro.org]
> > > > > Sent: Thursday, December 15, 2011 4:27 PM
> > > > > To: Guo Shawn-R65073
> > > > > Cc: Sascha Hauer; Dong Aisheng-B29396;
> > > > > linus.walleij at stericsson.com; linux-kernel at vger.kernel.org;
> > > > > rob.herring at calxeda.com; grant.likely at secretlab.ca;
> > > > > linux-arm-kernel at lists.infradead.org;
> > > > > kernel at pengutronix.de
> > > > > Subject: Re: [RFC PATCH v2 4/4] mmc: sdhci-esdhc-imx: using pinmux
> > > > > subsystem
> > > > > Importance: High
> > > > >
> > > > > On Thu, Dec 15, 2011 at 8:05 AM, Shawn Guo
> > > > > <shawn.guo@freescale.com>
> > > > > wrote:
> > > > > >[Me]
> > > > > >> So if you want to do this for i.MX you need something like
> > > > > >> selectable dummy pinmuxes, i.e. pinmux_get() to return
> > > > > >> something that just say "OK" to everything like the dummy
> > regulators.
> > > > > >>
> > > > > >> Shall I try to create something like that?
> > > > > >>
> > > > > > Isn't the empty functions defined in
> > > > > > include/linux/pinctrl/pinmux.h for this purpose?
> > > > >
> > > > > No, these are for compiling it *out*, dummy pinmuxes would be if
> > > > > you compile it *in*, but don't find an apropriate pinmux, you
> > > > > still get something that does nothing and still works.
> > > > >
> > > > > Dummy regulators work exactly this way.
> > > > >
> > > >
> > > > I did not read the dummy regulator code too much.
> > > > But does it mean that the dummy regulator or dummy pinmux will also
> > > > hide the Real errors since it will always get a available one?
> > 
> > What do you mean 'real error'?  When driver calls pimnux api on a
> > platform with real pinmux support, the error is error.  When driver calls
> > pinmux api on a platform support with dummy pinmux, it's totally error
> > free, as the pinmux core will ensure all the pinmux_* calls always return
> > success.
> > 
> My understanding is that pinmux_get will return an error if no proper pinmux
> Found without dummy pinmux. That's a real error.
> But with dummy pinmux, if no proper pinmux found, the pinctrl core may check
> If dummy pinmux is supported, if supported, it will fakely success with returning
> a dummy pinmux. Then real error is hiden.
> This is due to for supporting one single image, the dummy pinmux may also be enabled
> For platforms like mx6q with real pinmux.
> 
Got your point.  So your concern is about the fake success when dummy
pinmux comes to play rather than 'fake error'.  I'm not concerned about
that case much, since we will know the failure with a simple debug/info
message in the pinmux core, saying 'I do not find any available pinmux,
and I'm falling into the dummy pinmux'.  When you see this message
imx6q, you know something goes wrong.

-- 
Regards,
Shawn
