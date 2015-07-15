From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 15 Jul 2015 10:45:42 +0200
Subject: [RESEND PATCH 2/2] pinctrl: introduce complex pin description
In-Reply-To: <20150714061359.GC5161@pengutronix.de>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-3-git-send-email-ludovic.desroches@atmel.com>
 <20150714061359.GC5161@pengutronix.de>
Message-ID: <20150715084542.GC14886@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 08:13:59AM +0200, Sascha Hauer wrote:
> On Wed, Jun 10, 2015 at 05:04:57PM +0200, Ludovic Desroches wrote:
> > Using a string to describe a pin in the device tree can be not enough.
> > Some controllers may need extra information to fully describe a pin. It
> > concerns mainly controllers which have a per pin muxing approach which
> > don't fit well the notions of groups and functions.
> > Instead of using a pin name, a 32 bit value is used. The 16 least
> > significant bits are used for the pin number. Other 16 bits can be used to
> > store extra parameters.
> 
> In the Mediatek driver we use 'pinmux' as name for the property
> containing the combined pin number / mux value defines. 'pinmux' better
> describes what it is...
> 

At the moment, I don't mix pin number and pin mux. I mix pin number and
ioset. It allows to check that all the pins belong to the same ioset.

As said previously, I didn't want to mix pin mux and pin conf in the
same node (but it is something I can do, it's not a problem on my side).
If I do it I will have to mux three values: pin number, pin mux value
and pin ioset.

So assuming I do this change, your advice is to add a 'pinmux' property in
addition of 'pins' instead of trying to use it?

> > +
> > +	if (pctldesc->complex_pin_desc)
> > +		ret = of_property_count_u32_elems(np, "pins");
> > +	else
> > +		ret = of_property_count_strings(np, "pins");
> 
> ... and has the advantage that you don't have to pass in a
> complex_pin_desc variable from the driver as the different property
> name inherently carries this information. 'pins' can then stay a
> property containing only strings.
> 
> >  	if (ret < 0) {
> >  		ret = of_property_count_strings(np, "groups");
> >  		if (ret < 0)
> > @@ -297,11 +305,12 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> >  		if (type == PIN_MAP_TYPE_INVALID)
> >  			type = PIN_MAP_TYPE_CONFIGS_GROUP;
> >  		subnode_target_type = "groups";
> > +		pins_prop = false;
> >  	} else {
> >  		if (type == PIN_MAP_TYPE_INVALID)
> >  			type = PIN_MAP_TYPE_CONFIGS_PIN;
> >  	}
> > -	strings_count = ret;
> > +	items_count = ret;
> >  
> >  	ret = of_property_read_string(np, "function", &function);
> >  	if (ret < 0) {
> > @@ -326,17 +335,31 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> >  	if (num_configs)
> >  		reserve++;
> >  
> > -	reserve *= strings_count;
> > +	reserve *= items_count;
> >  
> >  	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
> >  			num_maps, reserve);
> >  	if (ret < 0)
> >  		goto exit;
> >  
> > -	of_property_for_each_string(np, subnode_target_type, prop, group) {
> > +	items_name = kmalloc_array(items_count, sizeof(char *), GFP_KERNEL);
> > +	if (!items_name)
> > +		goto exit;
> > +	if (pctldesc->complex_pin_desc && pins_prop) {
> > +		of_property_for_each_u32(np, subnode_target_type, prop, cur, val) {
> > +			pin_id = val & PINCTRL_PIN_MASK;
> > +			items_name[i++] = pctldesc->pins[pin_id].name;
> > +		}
> 
> I don't like that even though pins have numbers here they are converted
> to strings which the driver later has to search in a list just to
> convert it back into the number. This is quite inefficient.
> 
> I guess this could be optimized later, but it would be nice to have the
> pin number directly in the driver.

I know that is something you don't like but, at the moment, I need a string for
pinctrl_utils_add_map_mux and pinctrl_utils_add_map_configs.


Ludovic
