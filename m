From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Sep 2016 08:39:52 +0200
Subject: iomux-mx3.h: possible macro precedence issue
In-Reply-To: <1474438379.15981.1.camel@perches.com>
References: <1474401744.1954.55.camel@perches.com>
 <20160921060609.5efuaa2sdsti2j5g@pengutronix.de>
 <1474438379.15981.1.camel@perches.com>
Message-ID: <20160921063952.gloauhp76uuuibx6@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joe,

On Tue, Sep 20, 2016 at 11:12:59PM -0700, Joe Perches wrote:
> > > -#define MX31_PIN_DTR_DTE1__DTR_DTE2	IOMUX_MODE(MX31_PIN_DTR_DTE1, IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE)
> > > +#define MX31_PIN_DTR_DTE1__DTR_DTE2	IOMUX_MODE(MX31_PIN_DTR_DTE1, (IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE))
> > > [...]
> > > -#define IOMUX_MODE(pin, mode) (pin | mode << IOMUX_MODE_SHIFT)
> > > +#define IOMUX_MODE(pin, mode) ((pin) | ((mode) << IOMUX_MODE_SHIFT))
> >
> > Joe, do you create a proper patch?
> 
> I just don't have the hardware and don't know what was intended
> by the existing code.  It does appear to be a defect though.

I don't have that hardware either, but fixing this with just checking
the hardware manual is good enough.

The current definition makes MX31_PIN_DTR_DTE1__DTR_DTE2:

	  MX31_PIN_DTR_DTE1__DTR_DTE2
	= IOMUX_MODE(MX31_PIN_DTR_DTE1, IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE)
	= (MX31_PIN_DTR_DTE1 | IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE << IOMUX_MODE_SHIFT)
	= (IOMUX_PIN(44, 109) | (4 << 4) | 0 << 17)
	= (0x586d | 0x40)
	= 0x586d

while the expected value is

	  (MX31_PIN_DTR_DTE1 | (IOMUX_OCONFIG_ALT3 | IOMUX_ICONFIG_NONE) << IOMUX_MODE_SHIFT)
	= (IOMUX_PIN(44, 109) | ((4 << 4) | 0) << 17)
	= (0x586d | 0x800000)
	= 0x80586d

The effect is that the input is routed nowhere (which is the case also
with the issue fixed) and output is controlled by the GPIO module
instead of the UART and so the pin doesn't operate as handshaking
signal. (Assuming I interpreted everything correctly which I'm not sure
given that I didn't touch i.MX31 for long and it's different that the
other i.MX SoCs.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
