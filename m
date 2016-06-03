From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 3 Jun 2016 14:42:12 +0800
Subject: [PATCH 15/16] clk: sunxi-ng: Add H3 clocks
In-Reply-To: <20160601191932.GD4908@lukather>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-16-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v67RUCZfFaXnM2LxomV5DBSVApXHHs0noiNEbReOh_3W9w@mail.gmail.com>
 <20160601191932.GD4908@lukather>
Message-ID: <CAGb2v66JDrEDLmTKS6CLojuKzd7W15GcPd7O+hKRkrdT7E7UQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 2, 2016 at 3:19 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Tue, May 31, 2016 at 12:15:28AM +0800, Chen-Yu Tsai wrote:
>> On Mon, May 9, 2016 at 4:01 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Add the list of clocks and resets found in the H3 CCU.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  drivers/clk/sunxi-ng/Makefile        |   2 +
>> >  drivers/clk/sunxi-ng/ccu-sun8i-h3.c  | 757 +++++++++++++++++++++++++++++++++++
>> >  include/dt-bindings/clock/sun8i-h3.h | 162 ++++++++
>> >  include/dt-bindings/reset/sun8i-h3.h | 103 +++++
>> >  4 files changed, 1024 insertions(+)
>> >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> >  create mode 100644 include/dt-bindings/clock/sun8i-h3.h
>> >  create mode 100644 include/dt-bindings/reset/sun8i-h3.h
>> >
>> > diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
>> > index c794f57b6fb1..67ff6a92f124 100644
>> > --- a/drivers/clk/sunxi-ng/Makefile
>> > +++ b/drivers/clk/sunxi-ng/Makefile
>> > @@ -13,3 +13,5 @@ obj-y += ccu_nkmp.o
>> >  obj-y += ccu_nm.o
>> >  obj-y += ccu_p.o
>> >  obj-y += ccu_phase.o
>> > +
>> > +obj-y += ccu-sun8i-h3.o
>> > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> > new file mode 100644
>> > index 000000000000..5ce699e95c32
>> > --- /dev/null
>> > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> > @@ -0,0 +1,757 @@
>> > +/*
>> > + * Copyright (c) 2016 Maxime Ripard. All rights reserved.
>> > + *
>> > + * This software is licensed under the terms of the GNU General Public
>> > + * License version 2, as published by the Free Software Foundation, and
>> > + * may be copied, distributed, and modified under those terms.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + */
>> > +
>> > +#include <linux/clk-provider.h>
>> > +
>> > +#include <dt-bindings/clock/sun8i-h3.h>
>> > +#include <dt-bindings/reset/sun8i-h3.h>
>> > +
>> > +#include "ccu_common.h"
>> > +#include "ccu_reset.h"
>> > +
>> > +#include "ccu_div_table.h"
>> > +#include "ccu_factor.h"
>> > +#include "ccu_fixed_factor.h"
>> > +#include "ccu_gate.h"
>> > +#include "ccu_m.h"
>> > +#include "ccu_mp.h"
>> > +#include "ccu_nk.h"
>> > +#include "ccu_nkm.h"
>> > +#include "ccu_nkmp.h"
>> > +#include "ccu_nm.h"
>> > +#include "ccu_p.h"
>> > +#include "ccu_phase.h"
>> > +
>> > +static struct ccu_nkmp pll_cpux_clk = {
>> > +       .enable         = BIT(31),
>> > +       .lock           = BIT(28),
>> > +
>> > +       .m              = SUNXI_CLK_FACTOR(0, 2),
>> > +       .k              = SUNXI_CLK_FACTOR(4, 2),
>> > +       .n              = SUNXI_CLK_FACTOR(8, 5),
>> > +       .p              = SUNXI_CLK_FACTOR(16, 2),
>>
>> We should find a way to specify a table for p.
>
> A table for P? Why?
>
>> > +
>> > +       .common         = {
>> > +               .reg            = 0x000,
>> > +               .features       = CCU_FEATURE_GATE | CCU_FEATURE_LOCK,
>> > +               .hw.init        = SUNXI_HW_INIT("pll-cpux",
>> > +                                               "osc24M",
>>
>> osc24M is an outside reference. Shouldn't we use put it in a "clocks"
>> property in the DT, and use of_clk_get_parent_name()?
>>
>> osc24M can be controlled from the PRCM on other chips. I suspect the
>> same with the H3. osc32k might also be from the PRCM.
>
> I was discussing exactly this the other day with Mike. He has a bunch
> of patches to address exactly that issue. He plans on posting it and
> merge it by 4.8. Until then, we should rely on the hardcoded clock
> string like it's done there, and we should obviously add the clocks in
> the DT node for when we will actually use them.

OK. Let's wait and see.

>
>> > +                                               &ccu_nkmp_ops,
>> > +                                               0),
>> > +       },
>> > +};
>> > +

[...]

>> > +static struct ccu_nkm pll_ddr_clk = {
>> > +       .enable         = BIT(31),
>> > +       .lock           = BIT(28),
>> > +
>> > +       .n              = SUNXI_CLK_FACTOR(8, 5),
>> > +       .k              = SUNXI_CLK_FACTOR(4, 2),
>> > +       .m              = SUNXI_CLK_FACTOR(0, 2),
>>
>> We need a special "update" bit (bit 20) for this clock, otherwise changes
>> don't really take effect.
>
> Yeah, I know, but I feel like it's a feature here, since Linux should
> never modify that clock anyway.
>
> I can add a comment though.

Maybe we should do a read-only variant, or a feature flag?

[...]

Thanks
ChenYu
