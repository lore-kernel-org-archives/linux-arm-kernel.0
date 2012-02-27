From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 27 Feb 2012 14:31:08 +0000 (GMT)
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <20120227090447.GQ22562@n2100.arm.linux.org.uk>
Message-ID: <1330353068.81306.YahooMailClassic@web29006.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

> clean-2.6.39-rc7/arch/arm/mach-pxa/hx4700.c???
> 2011-05-11 00:54:10.787247169 +0100
> > > +++
> linux-2.6.39-rc7/arch/arm/mach-pxa/hx4700.c???
> 2011-05-11 20:21:54.026109594 +0100
> > > @@ -120,7 +120,11 @@ static unsigned long
> hx4700_pin_config[]
> > >? ??? GPIO19_SSP2_SCLK,
> > >? ??? GPIO86_SSP2_RXD,
> > >? ??? GPIO87_SSP2_TXD,
> > > -??? GPIO88_GPIO,
> > > +??? MFP_CFG_OUT(GPIO88, AF0,
> KEEP_OUTPUT),??? /* TSC2046_CS */
> > 
> > What you want here is to keep the SPI chip select
> deasserted (high)
> > during suspend, so I think that should be DRIVE_HIGH
> instead.
> 
> And I don't think we allowed folk to use MFP_CFG_xxx()
> macros in their
> board support code.? Is there something wrong with:
> 
> ??? GPIO88_GPIO | MFP_LPM_KEEP_OUTPUT
> 
> ?

Yes there is; the reason for using MFP_CFG_OUT() was to set the direction
of GPIO88 to output.

Currently, all of the GPIO88 definitions in <mach/mfp-pxa27x.h> are
inputs, whereas the hx4700 uses it as an output. I could have added a new
GPIO88 definition to <mach/mfp-pxa27x.h> to support the hx4700 only, but -
based on an earlier experience - I thought that would have been frowned on.

Presumably if MFP_CFG_OUT() is not allowed to be used in board support
code then neither is MFP_DIR_OUT, which is defined in the same file.

Is there another compile-time solution? Or should I just add an
hx4700-specific definition of GPIO88 to <mach/mfp-pxa27x.h> ?

Regards,
Paul
