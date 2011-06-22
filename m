From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Jun 2011 12:08:49 +0100
Subject: [PATCH v2 4/4] Exynos4 NURI: support for NTC thermistor
In-Reply-To: <BANLkTi=eBAGCADe1MTdtQ4XnBVpHK+uUNA@mail.gmail.com>
References: <20110620103124.GD31864@opensource.wolfsonmicro.com>
	<1308622033-2521-1-git-send-email-myungjoo.ham@samsung.com>
	<1308622033-2521-5-git-send-email-myungjoo.ham@samsung.com>
	<20110621105033.GF22177@opensource.wolfsonmicro.com>
	<BANLkTi=eBAGCADe1MTdtQ4XnBVpHK+uUNA@mail.gmail.com>
Message-ID: <20110622110848.GA18726@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 02:00:37PM +0900, MyungJoo Ham wrote:
> On Tue, Jun 21, 2011 at 7:50 PM, Mark Brown

> >> +#include <linux/platform_data/ntc_thermistor.h>

> > This doesn't appear to be in mainline.

> Right, not just yet. I should've added comment about the patch just
> being applied to "next".

I was actually looking at -next rather than Linus' tree there...

> Should I surround them with "#ifdef CONFIG_NTC_THERMISTOR"?

I guess, or just wait until it gets merged.

> > Why not do this in an initcall or in the device registration? ?This
> > looks like working around a limitation of the ntc_thermistor driver
> > which should be fixed as part of a mainline merge for that.

> Um... I think I can put this away to a common plat-samsung/dev-ntc.c
> as I've seen many S5PC110/S5PV210/Exynos4 devices using NTC attached
> to the CPU's ADC ports.

Yes, but it's not just the location of the code - I was mostly noticing
the fact that it was doing something that's clearly supposed to be a
probe() method in the main read function.  It'd be better if there were
an explicit probe() and corresponding remove() interface.

I also note that this callback based stuff won't work terribly well with
device tree.

> However, I won't be able to put that part into the NTC driver because
> using S3C-ADC is plat-samsung specific method and NTC thermistor
> itself is a general thermistor device not specific to S3C. Maybe, I
> can do so after we've got a common ADC framework.

Yes, we really need to get that ADC stuff sorted soon :(
