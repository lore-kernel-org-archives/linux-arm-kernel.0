From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Mar 2016 14:25:23 +0100
Subject: about the input paths in i.MX25 pinmuxing
In-Reply-To: <20160304133303.109baa10@ipc1.ka-ro>
References: <1457085652-4748-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160304133303.109baa10@ipc1.ka-ro>
Message-ID: <20160304132523.GX20323@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 01:33:03PM +0100, Lothar Wa?mann wrote:
> On Fri,  4 Mar 2016 11:00:52 +0100 Uwe Kleine-K?nig wrote:
> > Funny side note: When uart1 is used in dte mode (where RI is an input)
> > the RIIN bit in uart1's USR2 register reflects the input level of
> > MX25_PAD_KPP_ROW3 even if this pad is muxed to a different function.
> > The same seems to hold for some other pads, too.
> > 
> I guess that's not a funny side note, but the expected behaviour when
> the SION bit in the MUX control register is set.
> 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> > 
> > I think the appropriate action for the "funny" side note is that we must
> > introduce dt-properties like
> > 
> > 	fsl,mask-ri;
> > 
> > or something similar (maybe positive logic?) that prevents an uart1 RI irq
> > whenever uart3.CTS toggles.
> > 
> >  arch/arm/boot/dts/imx25-pinfunc.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx25-pinfunc.h b/arch/arm/boot/dts/imx25-pinfunc.h
> > index 848ffa785b63..3c8c5e1bea9e 100644
> > --- a/arch/arm/boot/dts/imx25-pinfunc.h
> > +++ b/arch/arm/boot/dts/imx25-pinfunc.h
> > @@ -453,6 +453,7 @@
> >  
> >  #define MX25_PAD_KPP_ROW3__KPP_ROW3		0x1b4 0x3ac 0x000 0x10 0x000
> >  #define MX25_PAD_KPP_ROW3__CSI_D1		0x1b4 0x3ac 0x48c 0x13 0x002
> > +#define MX25_PAD_KPP_ROW3__UART1_RI		0x1b4 0x3ac 0x000 0x14 0x000
> >  #define MX25_PAD_KPP_ROW3__GPIO_3_0		0x1b4 0x3ac 0x000 0x15 0x000
>                                                                   ^^^^
> Do you still have the side effect, with SION (0x10) cleared?

I thought the SION bit is only responsible for the GPIO function. Still I
tested without the SION bit, but looking at my notes and repeating the
test I noticed my error. I cannot reproduce the issue with SION removed
(from the right pin). Thanks for correcting my insight into the iomuxc.

IMHO we should revisit the decision to always set the SION bit. I'd say this is
worse than not being able to read out the value of an GPIO configured as
output.

Shawn?

Best regards,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
