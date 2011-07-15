From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 16 Jul 2011 00:17:13 +0900
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <20110715151104.GE1840@S2100-06.ap.freescale.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110715151104.GE1840@S2100-06.ap.freescale.net>
Message-ID: <20110715151706.GD11154@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 11:11:06PM +0800, Shawn Guo wrote:

> Currently, soc-core requires machine driver register snd_soc_dai_link
> with proper codec, cpu_dai and platform device name coded, so that it
> can match/bind dai link.  It works for existing non-dt devices probe,
> because they can have static device id assigned by platform code to
> map the actual hardware instance.

There's existing device tree code for PowerPC which seems to figure this
out by doing a DT lookup in the machine driver which appears to be sane
enough.  If we can't look up a struct device via the device tree we'd
seem to have a fairly serious problem as struct devices are how we talk
about devices at runtime in general.

To be honest I've not paid too much attention to the device tree code
people are currently using since discussion around it has always
involved repeatedly going over all the reasons why we actually need
machine drivers and that gets tedious after a while.

> Actually, I found matching cpu_dai using name does not scale in imx-ssi
> case even for non-dt probe.  imx provides some flexibility on the
> connection between codec and ssi.  With proper audmux configuration,
> codec can be connected to either ssi.0 or ssi.1 for given board design.
> That said even for given board, .cpu_dai_name can be dynamic.  This is
> something the current soc-core matching/binding approach hates to see.

This isn't a scalability thing and it's not related to binding, it's
because the AUXMUX isn't properly represented as a driver.  It probably
wants to be moved over to use the soc-dsp stuff Liam's doing at the
minute.  Currently we don't tell the core about the AUDMUX at all so
it's unreasonable to expect it to do anything except a static route.
