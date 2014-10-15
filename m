From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 15 Oct 2014 12:49:59 +0200
Subject: [PATCH 2/8] power_supply: sysfs: Use power_supply_*() API for
 accessing function attrs
In-Reply-To: <20141015103217.GB14266@amd>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
 <1413289246-31650-3-git-send-email-k.kozlowski@samsung.com>
 <20141015103217.GB14266@amd>
Message-ID: <1413370199.26771.4.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?ro, 2014-10-15 at 12:32 +0200, Pavel Machek wrote:
> On Tue 2014-10-14 14:20:40, Krzysztof Kozlowski wrote:
> > Replace direct calls to power supply function attributes with wrappers.
> > Wrappers provide safe access access in case of unregistering the power
> > supply (.e.g by removing the driver). Replace:
> >  - get_property -> power_supply_get_property
> >  - set_property -> power_supply_set_property
> >  - property_is_writeable -> power_supply_property_is_writeable
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks for looking at patches.


> > @@ -76,7 +76,7 @@ static ssize_t power_supply_show_property(struct device *dev,
> >  	if (off == POWER_SUPPLY_PROP_TYPE) {
> >  		value.intval = psy->type;
> >  	} else {
> > -		ret = psy->get_property(psy, off, &value);
> > +		ret = power_supply_get_property(psy, off, &value);
> >  
> 
> One thing.. Your power_supply_get_property (and friends) check for psy
> == NULL. Is it neccessary / good idea? As far as I can tell, it should
> not really be NULL...

It is not necessary. I thought it would be a good behavior of such
exported function. You're right that this shouldn't be NULL especially
because previously it was dereferenced.

Other existing power supply exported functions don't check this so maybe
I shouldn't introduce inconsistency.

I'll remove the check and re-spin. I'll found ugly typos in commit
message anyway.

Best regards,
Krzysztof
