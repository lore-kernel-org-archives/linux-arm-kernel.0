From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 2 May 2016 17:33:11 -0700
Subject: [PATCH v2] clk: uniphier: add clock drivers for UniPhier SoCs
In-Reply-To: <CAK7LNASQD4fpi=iDRbX96tSBvYjT_-N8EJnNk1VpuMxBTEnONg@mail.gmail.com>
References: <1451298003-28841-1-git-send-email-yamada.masahiro@socionext.com>
 <20160226000713.GO28849@codeaurora.org>
 <CAK7LNASQD4fpi=iDRbX96tSBvYjT_-N8EJnNk1VpuMxBTEnONg@mail.gmail.com>
Message-ID: <20160503003311.GE3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03, Masahiro Yamada wrote:
> 
> 2016-02-26 9:07 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> > On 12/28, Masahiro Yamada wrote:
> >>
> >> diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
> >> new file mode 100644
> >> index 0000000..7606f27
> >> --- /dev/null
> >> +++ b/drivers/clk/uniphier/Kconfig
> >> @@ -0,0 +1,35 @@
> >> +menuconfig CLK_UNIPHIER
> >> +     bool "Clock drivers for UniPhier SoCs"
> >> +     depends on ARCH_UNIPHIER
> >
> > Can we have COMPILE_TEST here?
> 
> OK.
> But if you recommend to drop "depends on ARCH_UNIPHIER",
> COMPILE_TEST is not necessary.

Right, I wasn't recommending removing the depends on
ARCH_UNIPHIER. Sorry if that wasn't clear.

> 
> 
> >> +     depends on OF
> >> +     default y
> >
> > And then default ARCH_UNIPHIER instead.
> 
> 
> 
> The problem is that CLK_UNIPHIER is not enabled along with
> ARCH_UNIPHIER in "make menuconfig".
> 
> If we use "depends on ARCH_UNIPHIER"
> and we enable ARCH_UNIPHIER from "make menuconfig",
> CLK_UNIPHIER is automatically enabled as well.
> 
> Is the latter more like what we expect?

I'm thinking

	menuconfig CLK_UNIPHIER
		bool "Clock drivers for UniPhier SoCs"
		depends on ARCH_UNIPHIER || COMPILE_TEST
		depends on OF
		default ARCH_UNIPHIER

That way we can build it even if we're not the arch, and it's
defaulted to be built if we have the arch enabled, but it isn't
defaulted to be built if that arch isn't enabled and compile test
is enabled.

> 
> >
> > If possible please don't use clock-names to set up clock
> > hierarchy.
> 
> So, what shall I do instead?
> 
> I am not comfortable with hard-coding the parents' names
> for clock-cascading.
> 
> Maybe, can we support clk registration
> with clk_hw of parents, not names of parents?
> 
> For example, by adding  "struct clk_hw **parents"
> to struct clk_init_data.
> 

Sounds like it isn't possible to avoid clock-names DT property
then. Not a big deal.

We've been trying to figure out some way to register clks without
requiring strings, but so far nothing has really happened. The
clk_hw approach would work, except for the case where some of the
provider's clks rely on another provider's clks that also rely on
the first provider (sort of a spiral of dependencies). In that
case we want to break the provider level loop by letting clks say
something besides clk_hw pointers are parents.

Strings work well here because we have support for clock-names
and string based parent-child descriptions already, but maybe
we'd be better off having some way to say that this clk we're
registering uses provider X's 24th output as its second parent.
It would be good if we avoided tying it to any DT construct
though, because DT isn't the only way clks are registered and
provided to the system.

This is all because we know that forcing driver authors to come
up with globally unique names for clks just doesn't work when it
comes to things like the same clk controller IP instantiated
twice in the hardware and thus the same driver matches both
device instances.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
