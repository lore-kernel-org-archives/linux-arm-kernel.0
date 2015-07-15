From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 15 Jul 2015 15:52:11 +0200
Subject: [RESEND PATCH 2/2] pinctrl: introduce complex pin description
In-Reply-To: <20150715100525.GE5161@pengutronix.de>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-3-git-send-email-ludovic.desroches@atmel.com>
 <20150714061359.GC5161@pengutronix.de>
 <20150715084542.GC14886@odux.rfo.atmel.com>
 <20150715100525.GE5161@pengutronix.de>
Message-ID: <20150715135211.GE14886@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 12:05:25PM +0200, Sascha Hauer wrote:
> On Wed, Jul 15, 2015 at 10:45:42AM +0200, Ludovic Desroches wrote:
> > On Tue, Jul 14, 2015 at 08:13:59AM +0200, Sascha Hauer wrote:
> > > On Wed, Jun 10, 2015 at 05:04:57PM +0200, Ludovic Desroches wrote:
> > > > Using a string to describe a pin in the device tree can be not enough.
> > > > Some controllers may need extra information to fully describe a pin. It
> > > > concerns mainly controllers which have a per pin muxing approach which
> > > > don't fit well the notions of groups and functions.
> > > > Instead of using a pin name, a 32 bit value is used. The 16 least
> > > > significant bits are used for the pin number. Other 16 bits can be used to
> > > > store extra parameters.
> > > 
> > > In the Mediatek driver we use 'pinmux' as name for the property
> > > containing the combined pin number / mux value defines. 'pinmux' better
> > > describes what it is...
> > > 
> > 
> > At the moment, I don't mix pin number and pin mux. I mix pin number and
> > ioset. It allows to check that all the pins belong to the same ioset.
> > 
> > As said previously, I didn't want to mix pin mux and pin conf in the
> > same node (but it is something I can do, it's not a problem on my side).
> > If I do it I will have to mux three values: pin number, pin mux value
> > and pin ioset.
> > 
> > So assuming I do this change, your advice is to add a 'pinmux' property in
> > addition of 'pins' instead of trying to use it?
> 
> My advise is to not enslave your code to this ioset concept. The only
> effect of introducing this concept is one single warning in the log:

My code is not totally enslaved to the ioset concept. The group_defs
node is not only for ioset, it is also to have comprehensive group
names when consultind sysfs. I don't know how I can achieve this if I
remove group_defs... Maybe with the parent node name?

> 
> 	dev_warn(&pdev->dev,
> 		"/!\\ pins from group %s are not using the same ioset /!\\\n",
> 		group->name);
> 
> There are *no* decisions made in the driver upon the ioset, only the
> above warning is printed.
> 
> I can easily find examples in which a device needs some functional pins
> and some additional GPIOs, be it for card detection or something else,
> and this *will* work, regardless of which ioset the pins are in. Why
> should a ioset concept limit me in this way that everything works except
> I have to suppress or ignore the warning in the log or split the pinmux
> node up to two different nodes?
> 
> The only thing that won't work (or at least you don't want to guarantee
> that it works), is to mix functional pins from the upper left corner of
> the SoC with pins from the lower right corner to form a single MMC/SD
> controller. Yes, you shouldn't do that. I may or may not work, but that
> is nothing this particular SoC introduces, it's like this on many other
> SoCs, perhaps even including earlier Atmel SoCs. Still, me as the guy
> writing board support have to support the way the hardware is designed,
> and if a board designer chooses to use pins from different iosets for a
> single device I'll support it that way, no matter if a warning is shown
> or not. If the users of this board are annoyed by the above warning
> you'll probably receive a patch dropping it soon. Then the ioset concept
> has completely vanished, but still the device trees are written like
> that.
> 

We know that mixing pins from several iosets should work for most of our
devices but it won't be the case for some such as SDHCI, ISI. Yes,
it is only a warning which can be easily removed. The goal of this
warning was to ease support. We often have the kernel logs but no
knowledge about the hardware. We could easily spot this mistake.

> So, yes, my advice is to drop the ioset concept completely. If you still
> insist on it then you can encode the ioset number in the pinmux define.
> Only the lower 16bit are defined as the pin number, you can use the
> upper 16bit like you want. You can encode the muxing in bits 16-23 and the
> ioset in bits 24-31.

It was exactly what I wanted to do. Every one could use the bits 31-16
to store data they need.

> 
> > > > +	if (pctldesc->complex_pin_desc && pins_prop) {
> > > > +		of_property_for_each_u32(np, subnode_target_type, prop, cur, val) {
> > > > +			pin_id = val & PINCTRL_PIN_MASK;
> > > > +			items_name[i++] = pctldesc->pins[pin_id].name;
> > > > +		}
> > > 
> > > I don't like that even though pins have numbers here they are converted
> > > to strings which the driver later has to search in a list just to
> > > convert it back into the number. This is quite inefficient.
> > > 
> > > I guess this could be optimized later, but it would be nice to have the
> > > pin number directly in the driver.
> > 
> > I know that is something you don't like but, at the moment, I need a string for
> > pinctrl_utils_add_map_mux and pinctrl_utils_add_map_configs.
> 
> Yeah, I am fine with it. This can be fixed later. I am more concerned
> about the device tree bindings than about the actual implementation. The
> implementation can far more easy be changed than the bindings.

Using mediatek bindings is not an issue. My remaining concern is about
groups, I would like to avoid 'a pin is a group'.


Regards

Ludovic
