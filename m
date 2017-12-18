From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Mon, 18 Dec 2017 10:41:27 +0100
Subject: [PATCH v3 05/11] thermal: armada: Add support for Armada AP806
In-Reply-To: <87y3m5o9h4.fsf@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-6-miquel.raynal@free-electrons.com>
 <87y3m5o9h4.fsf@free-electrons.com>
Message-ID: <20171218104127.65017555@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gregory & Baruch,

On Thu, 14 Dec 2017 12:05:43 +0100
Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:


> > @@ -184,9 +214,9 @@ static int armada_get_temp(struct
> > thermal_zone_device *thermal, div = priv->data->coef_div;
> >  
> >  	if (priv->data->inverted)
> > -		*temp = ((m * reg) - b) / div;
> > +		*temp = ((m * sample) - b) / div;
> >  	else
> > -		*temp = (b - (m * reg)) / div;
> > +		*temp = (b - (m * sample)) / div;
> >  	return 0;
> >  }
> >  
> > @@ -237,6 +267,19 @@ static const struct armada_thermal_data
> > armada380_data = { .inverted = true,
> >  };
> >  
> > +static const struct armada_thermal_data armada_ap806_data = {
> > +	.is_valid = armada_is_valid,
> > +	.init_sensor = armada_ap806_init_sensor,
> > +	.is_valid_bit = BIT(16),
> > +	.temp_shift = 0,
> > +	.temp_mask = 0x3ff,
> > +	.coef_b = -150000,  
> 
> Don't you expect any side effect by storing a negative value in a
> unsigned variable?

That is a fair question, I did not spot that.

As other values are really close to 2^32 I don't know what is the best
option for us in this case. Should I:
- don't care?
- use signed values? (dangerous IMHO)
- use a union with a signed and an unsigned value? (problem moved to
  ->get_temp())

Thanks for your input.
Miqu?l
