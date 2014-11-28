From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 28 Nov 2014 10:09:44 +0100
Subject: [PATCH v4 2/7] regulator: dt-bindings: Document the ena-gpios
 property
In-Reply-To: <20141127183058.GB7712@sirena.org.uk>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-3-git-send-email-k.kozlowski@samsung.com>
 <20141127183058.GB7712@sirena.org.uk>
Message-ID: <1417165784.18249.15.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-11-27 at 18:30 +0000, Mark Brown wrote:
> On Thu, Nov 27, 2014 at 12:20:48PM +0100, Krzysztof Kozlowski wrote:
> 
> > +- ena-gpios: GPIO to use for enable control. Actual implementation depends
> > +  on regulator driver. The bindings documentation for given driver describes
> > +  which regulator actually supports it.
> > +- ena-gpio-open-drain: GPIO is open drain type.
> 
> I'm relly not a big fan of adding a fixed name property here with no
> override capability, it means that the naming won't reflect the specific
> regulator design so closely and in practice for many of the PMICs the
> GPIO control can do rather more than just control enables and supports
> reprogramming.  The latter case where we've got a signal which can
> sometimes be simply and enable but sometimes more makes it especially
> worrying to have the property always be there, it's something that might
> work in some configurations but could easily be broken if we try to
> exploit more advanced functionality (things also triggering other
> configuration changes at the same time).

I understand your concerns here however I didn't want to overengineer
this. Is the same GPIO (on more complex PMICs) used in different
contexts? Like enable control and something more in the same time?

For example the S5M8767 uses different GPIOs for:
1. enable control - one GPIO per regulator,
2. voltage selection (DVS) - 3 GPIOs total,
so there is no benefit in merging this into one common regulator code.

> Factoring out the code is good but it seems better to have it be
> something which drivers can control, for example by having them
> explicitly specify a property name to use or perhaps a flag to enable
> the default name.

Something like:
 struct regulator_desc desc {
 	.name		= "LDO1
 	.of_match	= of_match_ptr("LDO1"),
 	.regulators_node = of_match_ptr("voltage-regulators"),
 	.ops		= &max77686_ldo_ops,
+	.of_ena_gpio	= of_match_ptr("ena-gpios"),
 ...
 }
?


> We also need an invert option.

This is parsed from gpio specifier in DTS: the flags from
include/dt-bindings/gpio/gpio.h.

Thank you for feedback,
Krzysztof
