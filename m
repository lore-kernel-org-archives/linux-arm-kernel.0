From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 20 Feb 2014 09:43:37 +0100
Subject: [PATCH v3 14/15] charger: max14577: Configure battery-dependent
 settings from DTS
In-Reply-To: <20140220063031.GC2498@jenny-desktop>
References: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
 <1392627950-26927-15-git-send-email-k.kozlowski@samsung.com>
 <20140220063031.GC2498@jenny-desktop>
Message-ID: <1392885817.3648.8.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-20 at 12:00 +0530, Jenny Tc wrote:
> On Mon, Feb 17, 2014 at 10:05:49AM +0100, Krzysztof Kozlowski wrote:
> > +static inline int max14577_init_eoc(struct max14577_charger *chg,
> > +		unsigned int uamp)
> > +{
> > +	unsigned int current_bits = 0xf;
> > +	u8 reg_data;
> > +
> > +	switch (chg->maxim_core->dev_type) {
> > +	case MAXIM_DEVICE_TYPE_MAX77836:
> > +		if (uamp < 5000)
> > +			return -EINVAL; /* Requested current is too low */
> > +
> > +		if (uamp == 7500)
> > +			current_bits = 0x0;
> 
> if (uamp <= 7500) ?

(uamp < 7500) will be mapped to 5000 uA (0x1) so it will be OK. It is
safer to use lower current. The register description looks like:
0000 - 7.5 mA
0001 -  5 mA
0010 - 10 mA
0011 - 15 mA
...
1010 - 50 mA
1011 - 60 mA
1111 - 100 mA

However for value between <7501, 9999> this function will return 0x1
(5000 uA) which is not perfect. Better is to return 0x0 (7500 uA).
I'll fix this in next version of patch.


> 
> > +	/* Initialize Overvoltage-Protection Threshold */
> > +	switch (chg->pdata->ovp_uvolt) {
> > +	case 7500000:
> > +		reg_data = 0x0;
> > +		break;
> > +	case 6000000:
> > +	case 6500000:
> > +	case 7000000:
> > +		reg_data = 0x1 + (chg->pdata->ovp_uvolt - 6000000) / 500000;
> > +		break;
> 
> Is it battery OVP or charger source OVP? If it's battery OVP, then  minimum
> level as 6V seems to be unsafe even for 4.4V batteries.

It is on charger (input). Anyway only these 4 values are supported (6.0,
6.5, 7.0, 7.5 volts).


Best regards,
Krzysztof
