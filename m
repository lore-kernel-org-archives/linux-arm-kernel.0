From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 5 Aug 2015 12:20:39 +0200
Subject: [PATCH 2/3] thermal: Add Mediatek thermal controller support
In-Reply-To: <CAGS+omAsTBMhfLPs5V68Ou1E5WXnQzZ3_E5+9qCCbAja3dgY-w@mail.gmail.com>
References: <1437465566-16299-1-git-send-email-s.hauer@pengutronix.de>
 <1437465566-16299-3-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omAsTBMhfLPs5V68Ou1E5WXnQzZ3_E5+9qCCbAja3dgY-w@mail.gmail.com>
Message-ID: <20150805102039.GH18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 11:13:22PM +0800, Daniel Kurtz wrote:
> Hi Sascha,
> 
> Review comments inline...
> 
> > + *
> > + * This converts the raw ADC value to mcelsius using the SoC specific
> > + * calibration constants
> > + */
> > +static int raw_to_mcelsius(struct mtk_thermal *mt, u32 raw)
> > +{
> > +       s32 format_1, format_2, format_3, format_4;
> 
> The formula would be easier to follow with better variable names than
> "format_X".
> 
> > +       s32 xtoomt;
> 
> What does "xtoomt" mean?
> 
> > +       s32 gain;
> > +
> > +       raw &= 0xfff;
> > +
> > +       gain = (10000 + mt->adc_ge);
> 
> no outer ()
> 
> > +
> > +       xtoomt = ((((mt->vts + 3350 - mt->adc_oe) * 10000) / 4096) * 10000) /
> > +               gain;
> > +
> > +       format_1 = ((mt->degc_cali * 10) >> 1);
> 
> When doing computations, I think "A / 2" is preferred over "A >> 1".
> Also, no outer ().
> 
> > +       format_2 = (raw - mt->adc_oe);
> > +       format_3 = (((((format_2) * 10000) >> 12) * 10000) / gain) - xtoomt;
> 
> This is just:
>   format_3 = ((((raw - mt->vts - 3350) * 10000) / 4096) * 10000) / gain;
> 
> No wonder mt->adc_oe = 512-512 = 0... it just cancels itself out here, anyway.
> 
> > +       format_3 = format_3 * 15 / 18;
> 
> Of course we should multiply by 15/18!
> What is going on here?  Why this magic 5/6 ratio?
> 
> > +       format_4 = ((format_3 * 100) / (165 + mt->o_slope));
> 
> no outer ()
> 
> > +       format_4 = format_4 - (format_4 << 1);
> 
> Hmm...
>  A = X - 2*X;
> otherwise known as:
>  A = -X;
> 
> > +       return (format_1 + format_4) * 100;
> 
> Or just:
>   return (format_1 - format_4) * 100;

I must admit I took this calculation from the original driver and never
looked at it. Simplifying this further this goes down to:

static int raw_to_mcelsius(struct mtk_thermal *mt, u32 raw)
{
	return mt->calib_b + mt->calib_a * (raw & 0xfff);
}

with calib_a = -123 and calib_b = 465124.

I'll address this and the other comments in v2.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
