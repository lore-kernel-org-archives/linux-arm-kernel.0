From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Jun 2017 10:06:50 +0200
Subject: [PATCH] arm: aspeed: Add Aspeed board file with clocksource
 devicetree fixup
In-Reply-To: <1497012772.23335.12.camel@aj.id.au>
References: <CAK8P3a0EaqwmAMRWn--29e4Kt6zJA9kHL2dpj=7Uabn5hANxOA@mail.gmail.com>
 <20170609073037.21871-1-andrew@aj.id.au>
 <CAK8P3a23XpDQhnM=j8FBS8NGck2ZfaAotVo191NEOttP2GDCYA@mail.gmail.com>
 <1497012772.23335.12.camel@aj.id.au>
Message-ID: <CACRpkdYqoa0+h6FkP_aJL=DTGysOFZVke0Sf-MCuT81y-zH3AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 2:52 PM, Andrew Jeffery <andrew@aj.id.au> wrote:

> So the fttmr010 bindings describe the clocks and clock-names properties
> as optional (a little confusingly, "Optionally required properties").

We should remove that. The timer frequency is strictly required.

> I guess keeping in mind the bindings describe the hardware and not the
> driver this might be reasonable, but the driver fails init if they're
> not present. arch/arm/boot/dts/moxart.dtsi doesn't specify clock-names
> either so I would have thought systems based on it would also fail.

It was added in
commit f46b563f2f270e451b2e1cee78573508cc1de256
"ARM: dts: augment Moxa and Aspeed DTS for FTTMR010"

Moxart only uses DT for boot, and Jonas controls all deployments of the
mainline kernel.

> Regardless, if it's the case that Moxa systems now fail to init the
> clocksource then the Aspeed-specific init_time() solution is even less
> attractive. moxart.dtsi dates back to December 2013 ("448e7edefa92 ARM:
> moxart: add MOXA ART SoC device tree files").

Moxart is deploying the DTBs with the kernel, they go hand-in-hand.
Backward compatibility with old DTBs here would just be an academic
exercise.

> The old binding is less of a problem for Aspeed systems as we don't yet
> have a clk driver upstream. Joel only recently added fixed-clock nodes
> in 4.12 so Aspeed systems could boot without DTS modifications.

The mentioned commit also adds the clocks to Aspeed AFAICT, is there
any problem in the real world, like did I miss some Aspeed platform?

Patching around drivers to make old DTBs work is something we should
only do when there are wide deployments for common users, such as people
buying products with a DTB inside them. Until such devices are shipped,
I consider the DT bindings still in flux.

Yours,
Linus Walleij
