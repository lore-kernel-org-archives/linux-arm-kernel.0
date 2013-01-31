From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 31 Jan 2013 08:23:39 +0000
Subject: [alsa-devel] [PATCH 1/2] ASoC: tlv320aic3x: Convert mic bias to
 a supply widget
In-Reply-To: <510A250E.4000706@ti.com>
References: <1359552155-17426-1-git-send-email-gururaja.hebbar@ti.com>
 <510A250E.4000706@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB59E6F@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 13:32:22, Ujfalusi, Peter wrote:
> On 01/30/2013 02:22 PM, Hebbar Gururaja wrote:
> > @@ -1493,6 +1544,28 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
> >  			aic3x->setup = ai3x_setup;
> >  		}
> >  
> > +		if (!of_property_read_u32(np, "ai3x-micbias-vg", &value)) {
> > +			switch (value) {
> > +			case 1 :
> > +				aic3x->micbias_vg = AIC3X_MICBIAS_2_0V;
> > +				break;
> > +			case 2 :
> > +				aic3x->micbias_vg = AIC3X_MICBIAS_2_5V;
> > +				break;
> > +			case 3 :
> > +				aic3x->micbias_vg = AIC3X_MICBIAS_AVDDV;
> > +				break;
> > +			default :
> > +				aic3x->micbias_vg = AIC3X_MICBIAS_OFF;
> > +				dev_err(&i2c->dev, "Unsuitable MicBias voltage "
> > +							"found in DT\n");
> > +			}
> > +		} else {
> > +			dev_warn(&i2c->dev, "No MicBias voltage found in DT - "
> > +							"using default\n");
> 
> Since "ai3x-micbias-vg" property is optional I don't think it is appropriate
> to print anything here. If you really want a note about this it should be
> dev_info().

Ok. I will remove this warning.


> 
> > +			aic3x->micbias_vg = AIC3X_MICBIAS_OFF;
> > +		}
> > +
> >  	} else {
> >  		aic3x->gpio_reset = -1;
> >  	}
> > diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
> > index 6db3c41..e521ac3 100644
> > --- a/sound/soc/codecs/tlv320aic3x.h
> > +++ b/sound/soc/codecs/tlv320aic3x.h
> > @@ -238,6 +238,10 @@
> >  /* Default input volume */
> >  #define DEFAULT_GAIN    0x20
> >  
> > +/* MICBIAS Control Register */
> > +#define MICBIAS_LEVEL_SHIFT	(6)
> > +#define MICBIAS_LEVEL_MASK	(3 << 6)
> > +
> >  /* headset detection / button API */
> >  
> >  /* The AIC3x supports detection of stereo headsets (GND + left + right signal)
> > 
> 
> 
> -- 
> P?ter
> 


Regards, 
Gururaja
