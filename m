From: weo@reccoware.de (Wolfgang Ocker)
Date: Tue, 06 Dec 2016 16:54:04 +0100
Subject: [PATCH] serial: mxs-auart: support CMSPAR termios cflag
In-Reply-To: <546f7a46-df39-778f-e148-75862f426ff2@i2se.com>
References: <546f7a46-df39-778f-e148-75862f426ff2@i2se.com>
Message-ID: <1481039644.3856.3.camel@reccoware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-12-06 at 14:36 +0100, Stefan Wahren wrote:
> Hi Wolfgang,
> 
> > --- a/drivers/tty/serial/mxs-auart.c
> > +++ b/drivers/tty/serial/mxs-auart.c
> > @@ -95,6 +95,7 @@
> > ?#define AUART_LINECTRL_BAUD_DIVFRAC_SHIFT	8
> > ?#define AUART_LINECTRL_BAUD_DIVFRAC_MASK	0x00003f00
> > ?#define AUART_LINECTRL_BAUD_DIVFRAC(v)		(((v) & 0x3f) << 8)
> > +#define AUART_LINECTRL_SPS			(1 << 7)
> > ?#define AUART_LINECTRL_WLEN_MASK		0x00000060
> > ?#define AUART_LINECTRL_WLEN(v)			(((v) & 0x3) << 5)
> > ?#define AUART_LINECTRL_FEN			(1 << 4)
> > @@ -1010,10 +1011,12 @@ static void mxs_auart_settermios(struct uart_port
> > *u,
> > 	ctrl |= AUART_LINECTRL_WLEN(bm);
> > 
> > 	/* parity */
> > -	if (cflag & PARENB) {
> > +	if (cflag & (PARENB|CMSPAR)) {
> 
> does it make sense to enable stick parity in case parity is disabled?
> 
> The i.MX28 reference manual doesn't describe this case explicit.

Thanks Stefan for the hint. I think it's okay on the hardware side since the
PEN bit is always set and therefore it can not happen that SPS is set but not
PEN.

But on the termios side it makes sense to require PARENB to be set in c_cflag
if CMSPAR is requested.

So I will provide an updated patch soon.

Wolfgang
