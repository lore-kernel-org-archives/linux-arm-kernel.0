From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 4 Jul 2011 15:41:12 +0200
Subject: [BUGFIX][PATCH] fix the parent of i2c[12]_clk
In-Reply-To: <BANLkTi=hBamK2JE1KykAJQWiyrhC8qPB_g@mail.gmail.com>
References: <1309525326-4762-1-git-send-email-LW@KARO-electronics.de>
	<BANLkTi=hBamK2JE1KykAJQWiyrhC8qPB_g@mail.gmail.com>
Message-ID: <19985.49912.927038.73866@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam writes:
> On Fri, Jul 1, 2011 at 10:02 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> > The clock from which the I2C timing is derived is the ipg_perclk not ipg_clk.
> >
> > I2C bus frequency was too low by a factor of ~8 due to the clock divider
> > calculation being based on 66.5MHz IPG clock while the bus actually
> > uses 8MHz ipg_perclk.
> >
> > Kernel version: 3.0.0-rc2 branch 'imx-for-next' of git://git.pengutronix.de/git/imx/linux-2.6
> >
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> > ?arch/arm/mach-mx5/clock-mx51-mx53.c | ? ?4 ++--
> > ?1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
> > index 699b0d2..fe977d0 100644
> > --- a/arch/arm/mach-mx5/clock-mx51-mx53.c
> > +++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
> > @@ -1282,9 +1282,9 @@ DEFINE_CLOCK(pwm2_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG8_OFFSET,
> >
> > ?/* I2C */
> > ?DEFINE_CLOCK(i2c1_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG9_OFFSET,
> > - ? ? ? NULL, NULL, &ipg_clk, NULL);
> > + ? ? ? NULL, NULL, &ipg_perclk, NULL);
> > ?DEFINE_CLOCK(i2c2_clk, 1, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG10_OFFSET,
> > - ? ? ? NULL, NULL, &ipg_clk, NULL);
> > + ? ? ? NULL, NULL, &ipg_perclk, NULL);
> > ?DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
> > ? ? ? ?NULL, NULL, &ipg_clk, NULL);
> > ?DEFINE_CLOCK(i2c3_mx53_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
> 
> Shouldn't i2c3_mx53_clk have the same change applied?
> 
You are right. I'll resend the patch.

Actually also the HSI2C clock is incomplete. The IPG clock only drives
the IP bus interface. The serial clock is derived from either of the
PLLs or the LP_APM clock.

But since Freescale discourages the use of the HS-I2C controller on
the i.MX51 (which AFAIK currently is the only processor that
implements it) in the Processor Reference Manual[*], I doubt that it
makes sense to implement the clock logic for it at all for now.


[*]
| 39.1      Introduction
[...]
|                                                  NOTE
|               Due to limited functionality, Freescale does not recommend users
|               incorporate the HS-I2C module in future designs. For details on the
|               limitations, refer to the MX51 IC Errata. Users should consider using the
|               two standard I2C modules, which have no errata.

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
