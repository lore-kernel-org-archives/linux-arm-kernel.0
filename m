From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Sep 2012 14:37:38 +0000
Subject: Implement devicetree support for AB8500 Btemp
In-Reply-To: <5051E02B.5040703@stericsson.com>
References: <CAB4BAktQz5MY_AHHWUAhRp7HtEzC3v8uFbP0enx1b7ibJLoZ4Q@mail.gmail.com>
 <201209121536.56346.arnd@arndb.de> <5051E02B.5040703@stericsson.com>
Message-ID: <201209131437.38666.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 September 2012, Rajanikanth HV wrote:
> On Wednesday 12 September 2012 09:06 PM, Arnd Bergmann wrote:> > 
> > If this is true, I don't understand what makes the 'supplied-to'
> > properties you list in the device tree binding board specific. Are
> > they not always done the same way? If so, you could just leave them
> > out.
> Precisely 'supplied-to' is not board specific, it was maintained as
> platform_data which i migrated to dt-node. It is meant to establish
> dependency across bm drivers based on power_supply property and
> runtime battery attributes.
> Basically, 'supplied-to' provides a way of exporting change in
> power_supply_property and runtime batter characteristics so that other
> bm devs shall make use or refer the updated values.
> Ref: external_power_changed(...) call back api.
> Note: all the bm drivers handles subset of power_supply property and
>       battery attributes,
>       ref: include/linux/power_supply.h and get_property(...) call back
>       api across bm drivers.

Ok, so you want to just remove the property from the device tree,
or do you want to establish a different method to specify these
connections?

> > What does indeed seem to be needed is a place to identify the battery
> > type, but it's not clear if the btemp device is the best place for
> > that (maybe it is). 
> I am not clear whether you are trying to correlate battery-type with
> supplied-to. however, battery type is identified based on the
> resistance value measured at batctrl pin which is expected to be in the
> allowable limit of ab8500 device. This resistance limit varies across
> battery types. This happens in btemp driver.

I wasn't correlating them. I just mentioned that unlike the supplied-to
property, the battery type property does seem to belong into the device
tree.

> For this, I would suggest you give a list of
> > possible batteries and require a property such as
> > 
> >  st-ericsson,battery-type: A string identifier for the type of battery,
> > 			   which impacts how an operating system interpret
> > 			   the sensor readings. Possible values include:
> > 	* "none"	-- no battery connected
> > 	* "li-ion-9100" -- Type 9100 Li-ION battery
> > 	* <add any others that apply here>
> Can do this, not precisely as "st-ericsson,battery-type", it will be as
> battery-type = [unknown|NiMH|LION|...|]], reason being
> allowable battery type is based on technology, as you can see the
> possible types as:
> POWER_SUPPLY_TECHNOLOGY_UNKNOWN = 0,
>         POWER_SUPPLY_TECHNOLOGY_NiMH,
>         POWER_SUPPLY_TECHNOLOGY_LION,
>         POWER_SUPPLY_TECHNOLOGY_LIPO,
>         POWER_SUPPLY_TECHNOLOGY_LiFe,
>         POWER_SUPPLY_TECHNOLOGY_NiCd,
>         POWER_SUPPLY_TECHNOLOGY_LiMn
> Ref: include/linux/power_supply.h
> Note: doing this will impact my of_probe(...), may slightly bloat the
> code.

Ok.

If you want to make the battery type a generic property, it's probably
best to start a separate binding document for this in
Documentation/devicetree/bindings/power-supply/common.txt
and document a string for each of these.

If we expect the property to be needed only for ab8500, please use
a vendor prefix like 'stericsson,'.

	Arnd
