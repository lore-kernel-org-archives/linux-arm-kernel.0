From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 6 Feb 2018 11:06:14 -0800
Subject: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
In-Reply-To: <CAD=FV=WcCnQJc25=sKWtOi=ZWi=ium6DVsexuQnsLDL=aJE6-Q@mail.gmail.com>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
 <CAD=FV=WcCnQJc25=sKWtOi=ZWi=ium6DVsexuQnsLDL=aJE6-Q@mail.gmail.com>
Message-ID: <20180206190614.GL9465@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 06 Feb 10:37 PST 2018, Doug Anderson wrote:

> Hi,
> 
> On Fri, Jan 26, 2018 at 2:18 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 01/25, Rajendra Nayak wrote:
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
> >> new file mode 100644
> >> index 000000000000..b97f99e6f4b4
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
> >> @@ -0,0 +1,32 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +&tlmm {
> >
> > I'm not the maintainer, but I find this approach to the pins
> > really annoying. I have to flip to another file to figure out how
> > a board has configured the pins. And we may bring in a bunch of
> > settings that we don't ever use on some board too. Why can't we
> > put the settings in the board file directly?
> 
> I'm not so familiar with how things work with Qualcomm, but in general
> I think putting this in the "board" file is a bad idea.  I'd be OK
> with putting this directly in the SoC file (though it might get
> unwieldy?), but not moving things to the board file as was done with
> v2 of this patch.
> 
> Said another way: nearly board that uses SDM845 that uses UART2 will
> have the same definitions for these pins so we shouldn't be
> duplicating it across every board, right?
> 

We've run into several cases where different boards uses the same
function but requires board specific electrical configuration.

So what we decided was to keep the pinmux in the soc-file (where e.g.
the uart definition is) and then extend it with the board specific
electrical properties (the pinconf), in the board files.

This does come with the complexity of having the pinctrl nodes split in
two places, but the responsibilities of the two parts is clear and we
remove the need for all board files to ensure the appropriate pinmux is
in place.


NB. We did discuss adding "sane defaults" for the pinconf in the soc
dtsi, but we end up spending considerable time debugging issues stemming
from not having the right pinconf; so better make this explicit and say
that the board has to specify it's config.

Regards,
Bjorn
