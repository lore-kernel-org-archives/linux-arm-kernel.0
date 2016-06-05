From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 5 Jun 2016 18:00:39 +0800
Subject: [linux-sunxi] Re: [PATCH RFC 1/2] clk: sunxi-ng: Add the A83T and
 A80 PLL clocks
In-Reply-To: <20160603131641.2c4c3266fe02718f341e8e12@free.fr>
References: <cover.1464680865.git.moinejf@free.fr>
 <bbf3cefa47323660ead5ebdafe63f382fea06f39.1464680865.git.moinejf@free.fr>
 <CAGb2v65sqhxEzxwRJ2fBfN_3F9bwKHreQ2JA4o=kZ5GZiMd=aQ@mail.gmail.com>
 <20160603131641.2c4c3266fe02718f341e8e12@free.fr>
Message-ID: <CAGb2v64LFDa4-E6yxjpGA6Y2YNCACajy_QXzF1feiwWnd=BvwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 3, 2016 at 7:16 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> Hi Wens,
>
> Thanks for the review.
>
> On Fri, 3 Jun 2016 14:53:24 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
>> On Tue, May 31, 2016 at 3:26 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
>> > The A83T and A80 SoCs have unique settings of their PLL clocks.
>> >
>> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
>> > ---
>> >  drivers/clk/sunxi-ng/ccu_ndmp.c | 247 ++++++++++++++++++++++++++++++++++++++++
>> >  drivers/clk/sunxi-ng/ccu_ndmp.h |  45 ++++++++
>> >  2 files changed, 292 insertions(+)
>> >  create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.c
>> >  create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.h
>> >
>> > diff --git a/drivers/clk/sunxi-ng/ccu_ndmp.c b/drivers/clk/sunxi-ng/ccu_ndmp.c
>> > new file mode 100644
>> > index 0000000..079b155
>> > --- /dev/null
>> > +++ b/drivers/clk/sunxi-ng/ccu_ndmp.c
>> > @@ -0,0 +1,247 @@
>> > +/*
>> > + * PLL clocks of sun8iw6 (A83T) and sun9iw1 (A80)
>> > + *
>> > + * Copyright (c) 2016 Jean-Francois Moine <moinejf@free.fr>
>> > + *
>> > + * This program is free software; you can redistribute it and/or
>> > + * modify it under the terms of the GNU General Public License as
>> > + * published by the Free Software Foundation; either version 2 of
>> > + * the License, or (at your option) any later version.
>> > + *
>> > + * The clock rates are computed as:
>> > + *     rate = parent_rate / d1 * n / d2 / m >> p
>> > + */
>> > +
>> > +#include <linux/clk-provider.h>
>> > +#include <linux/rational.h>
>> > +#include <linux/iopoll.h>
>> > +
>> > +#include "ccu_gate.h"
>> > +#include "ccu_ndmp.h"
>         [snip]
>> > +/* d1 and d2 may be only 1 or 2 */
>> > +static int ccu_ndmp_get_fact(struct ccu_ndmp *ndmp,
>> > +                       unsigned long rate, unsigned long prate,
>> > +                       int *p_n, int *p_d1, int *p_d2, int *p_m, int *p_p)
>> > +{
>> > +       int n, d1, d2, m, p, d;
>> > +       unsigned long t;
>> > +
>> > +       /* m implies only n, d1, d2 and m (pll-audio) */
>> > +       /* Setting d1=1 and d2=2 keeps n and m small enough
>> > +        *      with error < 5/10000 */
>> > +       /* As only 2 rates are used, this could be simplified:
>>
>> Best not simplify generic code to specific use cases.
>
> Well, the Allwinner's audio PLL clocks always ask for these 2 rates only.
> Anyway, this is just a comment.
>
>> > +        *      22579200Hz => n = 32, m = 17
>> > +        *      24576000Hz => n = 43, m = 21
>> > +        */
>> > +       if (ndmp->m.shift) {
>>
>> shift could be 0. Testing against width is better.
>> Same for the other functions.
>
> Yes. I fixed this already, with some other bugs.
>
>> > +               long unsigned int lun, lum;
>>
>>                   unsigned long, to match other places.
>>
>> > +
>> > +               d1 = 0 + 1;
>> > +               d2 = 1 + 1;
>> > +               t = prate / 2;
>> > +               rational_best_approximation(rate, t,
>> > +                                       1 << ndmp->n.width,
>> > +                                       1 << ndmp->m.width,
>> > +                                       &lun, &lum);
>> > +               if (lum == 0)
>> > +                       return -EINVAL;
>> > +               n = lun;
>> > +               m = lum;
>> > +               p = 0;
>> > +
>> > +       /* no d1 implies n alone (pll-cxcpux) */
>>
>> Pretending these don't have a p factor does not make it disappear.
>>
>> > +       } else if (!ndmp->d1.shift) {
>> > +               d1 = d2 = 0 + 1;
>>
>> If you say they aren't there, why do you still need to set them.
>>
>> > +               n = rate / prate;
>> > +               m = 1;
>> > +               p = 0;
>>
>> A note about why p isn't used would be nice. Like:
>>
>>     P should only be used for rates under 288 MHz.
>>
>> from the manual.
>
> Yes.
>
>> > +
>> > +       /* p implies only n, d1 and p (pll-videox) */
>> > +       } else if (ndmp->m.shift) {
>>
>>                            ^ p?
>
> Yes. Already fixed.
>
>> > +               d2 = 0 + 1;
>> > +               d = 2 + ndmp->p.width;
>> > +               n = rate / (prate / (1 << d));
>> > +               if (n < 12) {
>> > +                       n *= 2;
>> > +                       d++;
>> > +               }
>> > +               while (n >= 12 * 2 && !(n & 1)) {
>> > +                       n /= 2;
>> > +                       if (--d == 0)
>> > +                               break;
>> > +               }
>> > +               if (d <= 1) {
>> > +                       d1 = d + 1;
>> > +                       p = 0;
>> > +               } else {
>> > +                       d1 = 1 + 1;
>> > +                       p = d - 1;
>> > +               }
>> > +               m = 1;
>> > +
>> > +       /* only n, d1 and d2 (other plls) */
>> > +       } else {
>> > +               t = prate / 4;
>> > +               n = rate / t;
>> > +               if (n < 12) {
>> > +                       n *= 4;
>> > +                       d1 = d2 = 0 + 1;
>> > +               } else if (n >= 12 * 2 && !(n & 1)) {
>> > +                       if (n >= 12 * 4 && !(n % 4)) {
>> > +                               n /= 4;
>> > +                               d1 = d2 = 0 + 1;
>> > +                       } else {
>> > +                               n /= 2;
>> > +                               d1 = 0 + 1;
>> > +                               d2 = 1 + 1;
>> > +                       }
>> > +               } else {
>> > +                       d1 = d2 = 1 + 1;
>> > +               }
>> > +               if (n > (1 << ndmp->n.width))
>> > +                       return -EINVAL;
>> > +               m = 1;
>> > +               p = 0;
>> > +       }
>> > +
>> > +       if (n < 12 || n > (1 << ndmp->n.width))
>> > +               return -EINVAL;
>> > +
>> > +       *p_n = n;
>> > +       *p_d1 = d1;
>> > +       *p_d2 = d2;
>> > +       *p_m = m;
>> > +       *p_p = p;
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +static long ccu_ndmp_round_rate(struct clk_hw *hw, unsigned long rate,
>> > +                             unsigned long *parent_rate)
>> > +{
>> > +       struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
>> > +       int n, d1, d2, m, p, ret;
>> > +
>> > +       ret = ccu_ndmp_get_fact(ndmp, rate, *parent_rate,
>> > +                               &n, &d1, &d2, &m, &p);
>> > +       if (!ret)
>> > +               return 0;
>> > +
>> > +       return *parent_rate / d1 * n / d2 / m >> p;
>>
>> A warning should be put at the top of ccu_ndmp_get_fact stating the code
>> should not lazily skip initializing factors it doesn't use. Or just
>> initialize them in this function beforehand. The contract between these
>> 2 functions could be made clearer.
>
> You are right.
>
>> > +}
>> > +
>> > +static int ccu_ndmp_set_rate(struct clk_hw *hw, unsigned long rate,
>> > +                          unsigned long parent_rate)
>> > +{
>> > +       struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
>> > +       unsigned long flags;
>> > +       int n, d1, d2, m, p, ret;
>> > +       u32 reg;
>> > +
>> > +       ret = ccu_ndmp_get_fact(ndmp, rate, parent_rate,
>> > +                               &n, &d1, &d2, &m, &p);
>> > +       if (!ret)
>> > +               return ret;
>> > +       if (!(ndmp->common.features & CCU_FEATURE_N0))
>>
>> I do not remember seeing this in Maxime's original code. Did I
>> miss something?
>
> There are a lot of bugs to be fixed in Maxime's code, and he did not
> yet submit a new version. As we don't know how he will introduce the
> 'n' shift (start from 0 or 1 - in the A80/A83T PLL clocks, only the
> pll-ddr starts from 1), I added this feature flag.
>
>> > +               n--;
>> > +
>> > +       spin_lock_irqsave(ndmp->common.lock, flags);
>> > +
>> > +       reg = readl(ndmp->common.base + ndmp->common.reg) &
>> > +               ~((((1 << ndmp->n.width) - 1) << ndmp->n.shift) |
>> > +                 (((1 << ndmp->d1.width) - 1) << ndmp->d1.shift) |
>> > +                 (((1 << ndmp->d2.width) - 1) << ndmp->d2.shift) |
>> > +                 (((1 << ndmp->m.width) - 1) << ndmp->m.shift) |
>> > +                 (((1 << ndmp->p.width) - 1) << ndmp->p.shift));
>> > +
>> > +       writel(reg | (n << ndmp->n.shift) |
>> > +                       ((d1 - 1) << ndmp->d1.shift) |
>> > +                       ((d2 - 1) << ndmp->d2.shift) |
>> > +                       ((m - 1) << ndmp->m.shift) |
>> > +                       (p << ndmp->p.shift),
>> > +              ndmp->common.base + ndmp->common.reg);
>> > +
>> > +       spin_unlock_irqrestore(ndmp->common.lock, flags);
>> > +
>> > +       WARN_ON(readl_relaxed_poll_timeout(ndmp->common.base + ndmp->reg_lock,
>> > +                                          reg, !(reg & ndmp->lock), 50, 500));
>>
>> Maybe a feature flag to test for this separate PLL lock register?
>
> All PLLs have a lock bit.
> But, if some clocks would have no lock, a feature flag would not be
> needed: testing the lock bit (ndmp->lock) would do the job (and that is
> the case for all the feature flags in Maxime's original code).
>
>> Regards
>> ChenYu
>>
>> > +
>> > +       return 0;
>> > +}
>         [snip]
>
> BTW, I also found some bugs in the A83T clocks. Do you want I submit a
> new version?

I've not reviewed that patch yet. If you say you found bugs, I'll wait
for v2 to review.

Thanks
ChenYu
