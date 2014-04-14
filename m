From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 14 Apr 2014 09:13:13 +0200
Subject: [PATCH v2 1/5] pinctrl: pfc: r8a7790: add i2c0 muxing
In-Reply-To: <3524931.MdjU7RgFNq@avalon>
References: <1395773789-17249-1-git-send-email-wsa@the-dreams.de>
 <1395773789-17249-2-git-send-email-wsa@the-dreams.de>
 <3524931.MdjU7RgFNq@avalon>
Message-ID: <20140414071311.GA2993@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 03:00:39PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
> 
> Thank you for the patch.
> 
> On Tuesday 25 March 2014 19:56:25 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> > 
> > Add the muxing for the last missing i2c rcar core. Fix the sorting for
> > SH_PFC_PIN_NAMED while we are here.
> > 
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Forgot to add LinusW to CC. Linus, shall I resend?

> 
> > ---
> > Change since V1:
> > 
> > * sorted SH_PFC_PIN_NAMED pins
> > 
> >  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index c381ae63c508..bcb47d138b02
> > 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > @@ -782,6 +782,7 @@ enum {
> >  	USB1_PWEN_MARK, AUDIO_CLKOUT_D_MARK, USB1_OVC_MARK,
> >  	TCLK1_B_MARK,
> > 
> > +	I2C0_SCL_MARK, I2C0_SDA_MARK,
> >  	I2C3_SCL_MARK, I2C3_SDA_MARK,
> >  	PINMUX_MARK_END,
> >  };
> > @@ -1722,6 +1723,9 @@ static const u16 pinmux_data[] = {
> >  	PINMUX_IPSR_DATA(IP16_7, USB1_OVC),
> >  	PINMUX_IPSR_MODSEL_DATA(IP16_7, TCLK1_B, SEL_TMU1_1),
> > 
> > +	PINMUX_DATA(I2C0_SCL_MARK, FN_SEL_IIC0_1),
> > +	PINMUX_DATA(I2C0_SDA_MARK, FN_SEL_IIC0_1),
> > +
> >  	PINMUX_DATA(I2C3_SCL_MARK, FN_SEL_IICDVFS_1),
> >  	PINMUX_DATA(I2C3_SDA_MARK, FN_SEL_IICDVFS_1),
> >  };
> > @@ -1735,8 +1739,10 @@ static const struct sh_pfc_pin pinmux_pins[] = {
> >  	PINMUX_GPIO_GP_ALL(),
> > 
> >  	/* Pins not associated with a GPIO port */
> > -	SH_PFC_PIN_NAMED(ROW_GROUP_A('J'), 15, AJ15),
> > +	SH_PFC_PIN_NAMED(ROW_GROUP_A('F'), 15, AF15),
> > +	SH_PFC_PIN_NAMED(ROW_GROUP_A('G'), 15, AG15),
> >  	SH_PFC_PIN_NAMED(ROW_GROUP_A('H'), 15, AH15),
> > +	SH_PFC_PIN_NAMED(ROW_GROUP_A('J'), 15, AJ15),
> >  };
> > 
> >  /* - AUDIO CLOCK
> > ------------------------------------------------------------ */ @@ -2054,6
> > +2060,14 @@ static const unsigned int hscif1_ctrl_b_pins[] = { static const
> > unsigned int hscif1_ctrl_b_mux[] = {
> >  	HRTS1_N_B_MARK, HCTS1_N_B_MARK,
> >  };
> > +/* - I2C0
> > ------------------------------------------------------------------- */
> > +static const unsigned int i2c0_pins[] = {
> > +	/* SCL, SDA */
> > +	PIN_A_NUMBER('G', 15), PIN_A_NUMBER('F', 15),
> > +};
> > +static const unsigned int i2c0_mux[] = {
> > +	I2C0_SCL_MARK, I2C0_SDA_MARK,
> > +};
> >  /* - I2C1
> > ------------------------------------------------------------------- */
> > static const unsigned int i2c1_pins[] = {
> >  	/* SCL, SDA */
> > @@ -3626,6 +3640,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] =
> > { SH_PFC_PIN_GROUP(hscif1_data_b),
> >  	SH_PFC_PIN_GROUP(hscif1_clk_b),
> >  	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
> > +	SH_PFC_PIN_GROUP(i2c0),
> >  	SH_PFC_PIN_GROUP(i2c1),
> >  	SH_PFC_PIN_GROUP(i2c1_b),
> >  	SH_PFC_PIN_GROUP(i2c1_c),
> > @@ -3895,6 +3910,10 @@ static const char * const hscif1_groups[] = {
> >  	"hscif1_ctrl_b",
> >  };
> > 
> > +static const char * const i2c0_groups[] = {
> > +	"i2c0",
> > +};
> > +
> >  static const char * const i2c1_groups[] = {
> >  	"i2c1",
> >  	"i2c1_b",
> > @@ -4203,6 +4222,7 @@ static const struct sh_pfc_function pinmux_functions[]
> > = { SH_PFC_FUNCTION(eth),
> >  	SH_PFC_FUNCTION(hscif0),
> >  	SH_PFC_FUNCTION(hscif1),
> > +	SH_PFC_FUNCTION(i2c0),
> >  	SH_PFC_FUNCTION(i2c1),
> >  	SH_PFC_FUNCTION(i2c2),
> >  	SH_PFC_FUNCTION(i2c3),
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140414/3a65e117/attachment.sig>
