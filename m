From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 14 Nov 2013 10:07:05 +0100
Subject: [PATCH] clocksource: sirf/marco+prima2: drop usage of
 CLOCK_TICK_RATE
In-Reply-To: <5283DA74.9080402@linaro.org>
References: <1384201236-8689-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <5283DA74.9080402@linaro.org>
Message-ID: <20131114090705.GX14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 09:00:52PM +0100, Daniel Lezcano wrote:
> On 11/11/2013 09:20 PM, Uwe Kleine-K?nig wrote:
> >As CSR SiRF is converted to multi platform CLOCK_TICK_RATE is a dummy
> >value that seems to match the right value is used.
> >(arch/arm/mach-prima2/include/mach/timex.h which defined CLOCK_TICK_RATE
> >to 1000000 was removed in commit cf82e0e (ARM: sirf: enable
> >multiplatform support); marco used the same file.)
> >
> >To not depend on that dummy value use a local #define instead.
> 
> I don't get this patch. It is to fix a compilation error ?
No, the problem is that CLOCK_TICK_RATE used to be defined in a platform
specific header <mach/timex.h>. For the ARM multiplatform stuff, this
was dropped and now all multiplatform kernels use 1000000. For some
platform (like SiRF) this happens to be correct, but actually it's pure
luck. Further down the road I'd like to drop defining CLOCK_TICK_RATE
for all platforms, so this is a preparing patch. But even independant
from that it feels wrong to use a dummy value that was only introduced
to prevent compile breakage.

Would this change log be better:

	Since CSR SiRF was converted to multi platform in cf82e0e (ARM:
	sirf: enable multiplatform support) the symbol CLOCK_TICK_RATE
	isn't the platform specific definition any more, but a global
	dummy value. There was no harm introduced in cf82e0e because the
	global value happens to match the old platform specific one,
	still this dummy value isn't intended to be used and will
	hopefully disappear soon, so introduce a local #define and use
	that instead.

So it's not urgent, but would be a nice cleanup for 3.14-rc1.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
