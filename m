From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 06 Aug 2013 09:32:25 +0200
Subject: [PATCH v10] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51FFDFB7.6080806@wwwdotorg.org>
References: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
 <20130802092823.GA2884@e106331-lin.cambridge.arm.com>
 <1375687936.4000.21.camel@pizza.hi.pengutronix.de>
 <51FFDFB7.6080806@wwwdotorg.org>
Message-ID: <1375774345.4004.25.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 05.08.2013, 11:24 -0600 schrieb Stephen Warren:
> On 08/05/2013 01:32 AM, Philipp Zabel wrote:
> > Am Freitag, den 02.08.2013, 10:28 +0100 schrieb Mark Rutland:
> >> On Thu, Jul 18, 2013 at 10:26:26AM +0100, Philipp Zabel wrote:
> >>> This driver implements a reset controller device that toggle a gpio
> >>> connected to a reset pin of a peripheral IC. The delay between assertion
> >>> and de-assertion of the reset signal can be configured via device tree.
> ...
> >> I think this should look more like the below:
> >>
> >> /* Device with nRESET pin connected to GPIO5_0 */
> >> sii902x at 39 {
> >> 	/* named for the actual input line */
> >> 	nreset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> >> 	/* 
> >> 	 * If there's some configurable property relating to the reset
> >> 	 * line, we can describe it
> >> 	 */
> >> 	vendor,some-optional-reset-gpio-property;
> >> 	...
> >> };
> > 
> > I don't like the arbitrary name, as that makes it difficult to handle
> > this in an automated way. In this case I'd prefer to use 'reset-gpios'
> > and optionally 'reset-gpio-names' analogous to how clocks and interrupts
> > (and resets) are handled.
> 
> Hmm. Just be aware that you can't force existing bindings to be
> retro-actively modified, or you'll break the DT ABI. So, at the very
> least we'd have to allow the existing custom-property-based approach for
> bindings where it's already been used.

Of course we have to continue supporting existing bindings. We could
continue using the GPIO API directly for those cases, or we could add a
function similar to of_get_named_gpio to wrap the GPIO:

	rstc = of_get_named_reset_control(np, "nvidia,phy-reset-gpio", 0);
	reset_control_assert(rstc);
	usleep(1000);
	reset_control_deassert(rstc);

My point is that for new bindings I'd prefer a well known property name
such as reset-gpios and a -names string list (as described
Documentation/devicetree/bindings/resource-names.txt) over ad-hoc
property names such as nreset-gpios, <vendor>-<submodule>-(n)reset,
nrst-gpios etc., both for consistency with existing resource properties
and because it is easier to grep for a single property name than for a
combination of all possible datasheet spellings of "reset".

I'd like
	rstc = reset_control_get(dev, "nreset");
to go look for
	resets = <&src 3>;
	reset-names = "nreset";
or for
	reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
	reset-gpio-names = "nreset";
by default.

regards
Philipp
