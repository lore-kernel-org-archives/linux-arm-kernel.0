From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Feb 2012 09:04:47 +0000
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <1330253653.3673.8.camel@flow>
References: <E1QKFPN-0003xV-Sf@outmx07.plus.net> <1330253653.3673.8.camel@flow>
Message-ID: <20120227090447.GQ22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 11:54:13AM +0100, Philipp Zabel wrote:
> Am Mittwoch, den 11.05.2011, 19:49 +0000 schrieb Paul Parsons:
> > Basic suspend/resume is fixed by ensuring that the PGSR registers are set correctly before sleep mode is entered. In particular four of the active low resets need to be driven high while in sleep mode, otherwise the unit resets itself instead of suspending. Another problem was that the PCFR_GPROD bit is apparently set by the HTC bootloader; this caused GPIO reset (i.e. the reset button) to fail immediately after returning from sleep mode.
> > 
> > Driver-specific bugs still remain. In particular the mmc driver does not resume properly after returning from sleep mode, thus preventing sleep mode from being entered a second time.
> > 
> > Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> > ---
> > --- clean-2.6.39-rc7/arch/arm/mach-pxa/hx4700.c	2011-05-11 00:54:10.787247169 +0100
> > +++ linux-2.6.39-rc7/arch/arm/mach-pxa/hx4700.c	2011-05-11 20:21:54.026109594 +0100
> > @@ -120,7 +120,11 @@ static unsigned long hx4700_pin_config[]
> >  	GPIO19_SSP2_SCLK,
> >  	GPIO86_SSP2_RXD,
> >  	GPIO87_SSP2_TXD,
> > -	GPIO88_GPIO,
> > +	MFP_CFG_OUT(GPIO88, AF0, KEEP_OUTPUT),	/* TSC2046_CS */
> 
> What you want here is to keep the SPI chip select deasserted (high)
> during suspend, so I think that should be DRIVE_HIGH instead.

And I don't think we allowed folk to use MFP_CFG_xxx() macros in their
board support code.  Is there something wrong with:

	GPIO88_GPIO | MFP_LPM_KEEP_OUTPUT

?
