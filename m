From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 12 Aug 2013 13:04:44 +0200
Subject: [PATCH v10] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <5203E6B5.1010704@wwwdotorg.org>
References: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
 <20130802092823.GA2884@e106331-lin.cambridge.arm.com>
 <1375687936.4000.21.camel@pizza.hi.pengutronix.de>
 <51FFDFB7.6080806@wwwdotorg.org>
 <1375774345.4004.25.camel@pizza.hi.pengutronix.de>
 <52012B70.7050306@wwwdotorg.org>
 <1375954978.4284.29.camel@pizza.hi.pengutronix.de>
 <5203E6B5.1010704@wwwdotorg.org>
Message-ID: <1376305484.22237.37.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 08.08.2013, 12:43 -0600 schrieb Stephen Warren:
> On 08/08/2013 03:42 AM, Philipp Zabel wrote:
> > Hi Stephen
> > 
> > Am Dienstag, den 06.08.2013, 10:59 -0600 schrieb Stephen Warren:
> >> On 08/06/2013 01:32 AM, Philipp Zabel wrote:
> >>> Am Montag, den 05.08.2013, 11:24 -0600 schrieb Stephen Warren:
> >>>> On 08/05/2013 01:32 AM, Philipp Zabel wrote:
> >>>>> Am Freitag, den 02.08.2013, 10:28 +0100 schrieb Mark Rutland:
> >>>>>> On Thu, Jul 18, 2013 at 10:26:26AM +0100, Philipp Zabel wrote:
> >>>>>>> This driver implements a reset controller device that toggle a gpio
> >>>>>>> connected to a reset pin of a peripheral IC. The delay between assertion
> >>>>>>> and de-assertion of the reset signal can be configured via device tree.
> >>>> ...
> >>>>>> I think this should look more like the below:
> >>>>>>
> >>>>>> /* Device with nRESET pin connected to GPIO5_0 */
> >>>>>> sii902x at 39 {
> >>>>>> 	/* named for the actual input line */
> >>>>>> 	nreset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> >>>>>> 	/* 
> >>>>>> 	 * If there's some configurable property relating to the reset
> >>>>>> 	 * line, we can describe it
> >>>>>> 	 */
> >>>>>> 	vendor,some-optional-reset-gpio-property;
> >>>>>> 	...
> >>>>>> };
> >>>>>
> >>>>> I don't like the arbitrary name, as that makes it difficult to handle
> >>>>> this in an automated way. In this case I'd prefer to use 'reset-gpios'
> >>>>> and optionally 'reset-gpio-names' analogous to how clocks and interrupts
> >>>>> (and resets) are handled.
> >>>>
> >>>> Hmm. Just be aware that you can't force existing bindings to be
> >>>> retro-actively modified, or you'll break the DT ABI. So, at the very
> >>>> least we'd have to allow the existing custom-property-based approach for
> >>>> bindings where it's already been used.
> >>>
> >>> Of course we have to continue supporting existing bindings. We could
> >>> continue using the GPIO API directly for those cases, or we could add a
> >>> function similar to of_get_named_gpio to wrap the GPIO:
> >>>
> >>> 	rstc = of_get_named_reset_control(np, "nvidia,phy-reset-gpio", 0);
> >>> 	reset_control_assert(rstc);
> >>> 	usleep(1000);
> >>> 	reset_control_deassert(rstc);
> >>
> >> Well, you'd need to pass two names into that function; one would be the
> >> name of the legacy property and the other the entry in reset-names or
> >> reset-gpio-names. It's quite unlikely that the same string would be used
> >> in both places.
> > 
> > there is no reset-names here. The legacy properties are only one GPIO
> > per property or addressed by index, currently. I don't want to change
> > that.
> 
> So do you foresee:
> 
> 1) Making zero changes to the existing binding and just keeping the
> various custom stuff that some have
> 
> or
> 
> 2) Migrating existing bindings to the new scheme, and simply
> deprecating, but still allowing, the old custom properties.

Yes, I'd like to deprecate the (<vendor>,)<custom>-gpio binding scheme
for reset gpios, on a case by case basis.

> If (1), then yes, of_get_named_reset_control() would only need one
> parameter, either the name of the existing custom property or the
> reset-names value, depending on whether the binding was old or new.
>
> This might be problematic, since if you pass in "foo" expecting that to
> be a reset-names entry, it would also accidentally allow a property
> named "foo" to provide the information, even though that wasn't defined
> in the binding.

Yes, of_get_named_reset_control() was just an example, to be used for
the legacy case only.

> Equally, if every binding is either-or, you may as well force drivers
> passing the binding to just call different APIs based on their binding
> definition.
> 
> If (2), then you'd need to pass both the legacy property name and
> reset-names value separately, since I imagine those values would be
> different, consider:
> 
> old:
> 
> 	nvidia,phy-reset-gpio = <&gpio 1 0>;
> 
> new:
> 
> 	reset-gpios = <&gpio 1 0>;
> 	reset-names = "phy";

Correct. In this case:

	rstc = of_get_named_reset_control(np, "nvidia,phy-reset-gpio", 0);
	if (IS_ERR(rstc)) {
		ret = PTR_ERR(rstc);
		if (ret == -EPROBE_DEFER)
			return ret;
		rstc = reset_control_get(dev, "phy");
		if (IS_ERR(rstc))
			return PTR_ERR(rstc);
	}

Maybe encapsulate this in a convenience wrapper:

	rstc = reset_control_get_legacy(dev, "phy", "nvidia,phy-reset-gpio");

> > In the majority of cases there will only be one reset per device. In
> > this case, the supplemental names property is not needed. The
> > resets/reset-names binding is using this scheme already, so using the
> > same for reset-gpios improves consistency.
> 
> I think that if there is just a "foo" property, it should always be
> accessed by index into the list, whereas if there are both a foo and
> foo-names property, it should always be accessed by name lookup. This
> makes the lookup order much clearer. There are some unfortunate
> exceptions to this today (regs and interrupts can have names, but those
> aren't used in all cases!), but I'd like to avoid propagating that mistake.

Agreed. Looking up regs and interrupts by index is error-prone if there
are more than one, but surely leaving the -names property out in case
there is only one entry should be fine?

regards
Philipp
