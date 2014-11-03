From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 03 Nov 2014 13:07:02 +0100
Subject: [PATCH 6/8] regulator: max77686: Add external GPIO control
In-Reply-To: <20141031103217.GJ18557@sirena.org.uk>
References: <1414422226-10948-7-git-send-email-k.kozlowski@samsung.com>
 <544EA4FA.6040704@collabora.co.uk> <1414486356.24949.19.camel@AMDC1943>
 <1414498308.24949.32.camel@AMDC1943> <1414579362.18868.11.camel@AMDC1943>
 <5450C63B.3000602@collabora.co.uk>
 <CAAVeFuLncbkNLGxEAj90yMmugRDNjtjeGoV_QYTMDZ7NVMJCmg@mail.gmail.com>
 <1414681386.26703.6.camel@AMDC1943>
 <CAAVeFuJo1wTyxOo4FEZM3=GTejuSHi+mnr=QV6HUeV5mAOCmqg@mail.gmail.com>
 <1414741898.20071.8.camel@AMDC1943> <20141031103217.GJ18557@sirena.org.uk>
Message-ID: <1415016422.4241.28.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pi?, 2014-10-31 at 10:32 +0000, Mark Brown wrote:
> On Fri, Oct 31, 2014 at 08:51:38AM +0100, Krzysztof Kozlowski wrote:
> 
> > However new DT style parsing (regulator_of_get_init_data()) does the
> > basic parsing stuff and this removes a lot of code from driver. The
> > driver no longer parses all regulaotrs but the regulator core does it.
> > Unfortunately regulator core does not parse custom bindings (like such
> > GPIOs) so I would have to iterate once again through all regulators just
> > to find "gpios" property.
> 
> We could always add a callback for the driver to handle any custom
> properties...  one of the advantages of an OS like Linux is that we can
> improve the core code.

I thought about this - adding a callback, called on each child in
regulator_of_get_init_data(). However the reason behind this callback is
to parse GPIO and set config.ena_gpio. However in that context the
regulator_config is const so the callback cannot change it. Unless it
casts it to non-const... which isn't what we want I think.

So now I wonder whether adding generic bindings for ena_gpio make sense.
These would look like bindings for fixed-regulator (with "ena-" prefix).
Unfortunately this would duplicate a little the ena_gpio in
regulator_config... but to me it seems more appropriate.

What do you think about adding generic bindings for ena_gpio?

Best regards,
Krzysztof
