From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Sep 2013 16:13:29 +0300
Subject: [PATCH 2/5] clocksource: Add Allwinner SoCs HS timers driver
In-Reply-To: <52437062.5040705@elopez.com.ar>
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1380117790-19390-3-git-send-email-maxime.ripard@free-electrons.com>
 <52437062.5040705@elopez.com.ar>
Message-ID: <20130926131329.GQ2954@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 08:23:14PM -0300, Emilio L?pez wrote:
> El 25/09/13 11:03, Maxime Ripard escribi?:
> >Most of the Allwinner SoCs (at this time, all but the A10) also have a
> >High Speed timers that are not using the 24MHz oscillator as a source
> >but rather the AHB clock running much faster.
> >
> >The IP is slightly different between the A10s/A13 and the one used in
> >the A20/A31, since the latter have 4 timers available, while the former
> >have only 2 of them.
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> 
> [...]
> 
> >+static void __init sun5i_timer_init(struct device_node *node)
> >+{
> >+	unsigned long rate;
> >+	struct clk *clk;
> >+	int ret, irq;
> >+	u32 val;
> >+
> >+	timer_base = of_iomap(node, 0);
> >+	if (!timer_base)
> >+		panic("Can't map registers");
> >+
> >+	irq = irq_of_parse_and_map(node, 0);
> >+	if (irq <= 0)
> >+		panic("Can't parse IRQ");
> >+
> >+	clk = of_clk_get(node, 0);
> >+	if (IS_ERR(clk))
> >+		panic("Can't get timer clock");
> 
> I'm not familiar with clocksources, but does this have to be as
> fatal as it is considering the kernel also supports the slower sun4i
> timer?

Hmmm, I don't know, one might choose to enable only this timer, in that
case that would make sense to panic, since it would be the only timer in
that case.

> Also, would any special considerations be needed when adjusting the
> ahb clock? A future cpufreq driver will most likely need to.

While this will be needed at some point, I don't really see how to
handle that properly. The clock framework doesn't seem to have any
callback when it comes to reconfiguring a clock that a device might
use.

This will also creates trouble for IPs such as the I2C that have to
setup internal dividers, and use clk_get_rate to do so.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130926/31e586c1/attachment.sig>
