From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Sep 2010 13:07:02 +0100
Subject: [PATCH] regulator: Add support samsung power domain
In-Reply-To: <007b01cb565d$db4376d0$91ca6470$%szyprowski@samsung.com>
References: <1284717532-9992-1-git-send-email-kgene.kim@samsung.com>
	<20100917113050.GA4322@rakim.wolfsonmicro.main>
	<007b01cb565d$db4376d0$91ca6470$%szyprowski@samsung.com>
Message-ID: <20100917120702.GB4322@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 17, 2010 at 01:45:36PM +0200, Marek Szyprowski wrote:

> The approach with merging power domains with clocks have some disadvantages.
> In some cases the clock gating and power gating should be distinguished.

This is not what I suggested.  I suggested using runtime PM instead of
the regulator API to manage blocks.

> Just assume an IP like a video codec. It has it's own internal state machine.
> It gets reset when the ip is power gated, but it is preserved during clock
> gating. The driver might want to do a clock gating when it is waiting for a
> new frame to decode, but should do power gating only when the device has

There's nothing stopping the drivers enabling and disabling the clocks
for themselves while they're active, all the rumtime PM stuff I've seen
for this does is ensure that the clocks are enabled and disabled when
the device is enabled and disabled.  This matches what you're saying
above - clearly, if the device is power gated there's no need to provide
a clock for it - and with aggressive runtime PM it's pretty much exactly
what a lot of devices end up needing.

> been closed. Having a set of fake clocks just for power gating imho doesn't
> look good.

Who said use the clock API?
