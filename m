From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 14 Nov 2013 12:38:26 -0600
Subject: [PATCH v2 3/4] ARM: imx51: use clock defines in DTS files
In-Reply-To: <1384423816-10834-3-git-send-email-l.stach@pengutronix.de>
References: <1384423816-10834-1-git-send-email-l.stach@pengutronix.de>
 <1384423816-10834-3-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAHCPf3ugZkZ9cegVNh0xVqAUB6w6t_gbd8JYGx7HLHF0ttxK-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 4:10 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> For better readablitity and no need to look up numbers
> in the documentation anymore.
> +                       clocks = <&clks IMX5_CLK_CPU_PODF>;

The patch reinforces trading off device tree size (because for some
reason, someone decided device trees should be totally abstract and
not actually describe devices) for huge swaths of static
initialization code.. and another include to support "readable trees"
to work around the actual binding for i.MX clocks sucking shouldn't go
any further than to ease a transition to a fully tree-specified clock
infrastructure where every clock passed to every device is an actual
phandle to an actual defined clock (and not to a provider with an
arbitrary index derived from the
order-in-which-we-remembered-this-clock-exists).

The aforementioned transition doesn't get eased at all by this patch,
and implies significant churn later on when (not if) it occurs.

Let's put this down in stone now and forever; if you need to use
preprocessor macros like this to make device trees "more readable",
then your binding might actually be totally busted.

Also, no matter what, please use macro arguments and stringification
if you can reduce code size by doing it.

Wouldn't

#define IMX5_CLK_cpu_podf  24
#define IMX5_CLK_fec_gate  42

#define CLK_P(prov, id)  prov IMX5_CLK_##id
#define CLK_I(id) clk[IMX5_CLK_##id]

In DT:

clocks = <CLK_P(&clks, fec_gate)>
clocks = <CLK_P(&clks, cpu_podf)>

And then in the driver code:

clk_register_clkdev(CLK_I(fec_gate), NULL, "imx25-fec.0");

You could even do:

#define CLK_R(id, con, name) clk_register_clkdev(CLK_I(id), con, name)
:
CLK_R(fec_gate, NULL, "imx25-fec.0");

For example? OMAP does this, but it'll go away... Go the whole hog if
you're going to do it.

Thanks,
Matt Sealey <neko@bakuhatsu.net>
