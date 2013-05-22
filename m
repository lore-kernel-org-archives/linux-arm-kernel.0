From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 22 May 2013 10:19:12 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBpb211eC1teDUxOiBBbHdheXMgZGVmaW5lIFBV?=
 =?UTF-8?B?RSBmb3IgcGlucyB1c2VkIGFzIEdQSU8=?=
In-Reply-To: <20130521192430.GU32299@pengutronix.de>
References: <1369124845-19244-1-git-send-email-shc_work@mail.ru>
 <20130521192430.GU32299@pengutronix.de>
Message-ID: <1369203552.559574351@f389.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, May 21, 2013 at 12:27:25PM +0400, Alexander Shiyan wrote:
> > This patch adds a PUE bit for pins which used as GPIO. This allow
> > to use the GPIOs correctly as inputs when source is open-drain with
> > external pullup resistor (IRQ open-drain outputs for example).
> 
> I don't understand. If there's an external pullup why do you want to
> turn on the internal one?

It is just switch off keeper circuit.

Some pads not have internal pullup, probably this is affected only for such pins.
This is example of this issue:
Used pad MX51_PAD_DISPB2_SER_CLK__GPIO3_7, (GPIO3.7 = 71).
External pullup resistor is used.

gpio_direction output 71 1
gpio_direction_input 71
gpio_get_value 71; echo $?
1
gpio_direction output 71 0
gpio_direction_input 71
gpio_get_value 71; echo $?
0

So, we cannot get "1" here anymore if only pullup is used for this pad. The pad is keep last logic state...
The second solution for this is disable PKE, i am not sure which solution is the best...

> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/mach-imx/iomux-mx51.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-imx/iomux-mx51.h b/arch/arm/mach-imx/iomux-mx51.h
> > index 75bbcc4..7dc187c 100644
> > --- a/arch/arm/mach-imx/iomux-mx51.h
> > +++ b/arch/arm/mach-imx/iomux-mx51.h
> > @@ -34,7 +34,8 @@
> >  #define MX51_SDHCI_PAD_CTRL	(PAD_CTL_PKE | PAD_CTL_DSE_HIGH | \
> >  				PAD_CTL_PUS_47K_UP | PAD_CTL_PUE | \
> >  				PAD_CTL_SRE_FAST | PAD_CTL_DVS)
> > -#define MX51_GPIO_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | PAD_CTL_SRE_FAST)
> > +#define MX51_GPIO_PAD_CTRL	(PAD_CTL_DSE_HIGH | PAD_CTL_PKE | \
> > +				PAD_CTL_PUE | PAD_CTL_SRE_FAST)
> >  
> >  #define MX51_PAD_CTRL_2		(PAD_CTL_PKE | PAD_CTL_HYS)
> >  #define MX51_PAD_CTRL_3		(PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
> > -- 

---
