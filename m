From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Jan 2017 13:24:26 +0800
Subject: [PATCH v3 3/7] clk: sunxi-ng: Implement multiplier maximum
In-Reply-To: <20170121221309.rf6tpidpipoe2tfj@lukather>
References: <cover.5df5469d9c7a6233e225a875dca513a03b05e871.1484897383.git-series.maxime.ripard@free-electrons.com>
 <8e38914c705c32f3f0daa4a16979cbb9cae5e689.1484897383.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65p9rQv+AQqTVs=wtJbesQNF36YNdeTSSGp=c9SSyjViw@mail.gmail.com>
 <20170121221309.rf6tpidpipoe2tfj@lukather>
Message-ID: <CAGb2v64ANkw1B=o6pSLv_jv_j0+TAsr9F9mUfPXNkL-QKj5HUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 6:13 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Jan 21, 2017 at 09:27:42AM +0800, Chen-Yu Tsai wrote:
>> On Fri, Jan 20, 2017 at 3:29 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  drivers/clk/sunxi-ng/ccu_mult.c | 16 +++++++++++++---
>> >  drivers/clk/sunxi-ng/ccu_mult.h | 10 ++++++----
>> >  drivers/clk/sunxi-ng/ccu_nk.c   |  8 ++++----
>> >  drivers/clk/sunxi-ng/ccu_nkm.c  |  8 ++++----
>> >  drivers/clk/sunxi-ng/ccu_nkmp.c |  8 ++++----
>> >  drivers/clk/sunxi-ng/ccu_nm.c   |  4 ++--
>> >  6 files changed, 33 insertions(+), 21 deletions(-)
>> >
>> > diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
>> > index 8b7ee7baa85b..8724c01171b1 100644
>> > --- a/drivers/clk/sunxi-ng/ccu_mult.c
>> > +++ b/drivers/clk/sunxi-ng/ccu_mult.c
>> > @@ -40,8 +40,13 @@ static unsigned long ccu_mult_round_rate(struct ccu_mux_internal *mux,
>> >         struct ccu_mult *cm = data;
>> >         struct _ccu_mult _cm;
>> >
>> > -       _cm.min = 1;
>> > -       _cm.max = 1 << cm->mult.width;
>> > +       _cm.min = cm->mult.min;
>>
>> This particular line should probably be in a separate patch fixing
>> commit 2beaa601c849 ("clk: sunxi-ng: Implement minimum for multipliers")?
>> It kind of sticks out, and doesn't match the commit message.
>
> Indeed (also because there's no commit message, I'll fix that.)
>
>> > +
>> > +       if (cm->mult.max)
>> > +               _cm.max = cm->mult.max;
>> > +       else
>> > +               _cm.max = (1 << cm->mult.width) + cm->mult.offset - 1;
>> > +
>> >         ccu_mult_find_best(parent_rate, rate, &_cm);
>> >
>> >         return parent_rate * _cm.mult;
>> > @@ -114,7 +119,12 @@ static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
>> >                                                 &parent_rate);
>> >
>> >         _cm.min = cm->mult.min;
>> > -       _cm.max = 1 << cm->mult.width;
>> > +
>> > +       if (cm->mult.max)
>> > +               _cm.max = cm->mult.max;
>> > +       else
>> > +               _cm.max = (1 << cm->mult.width) + cm->mult.offset - 1;
>>
>> The changes look good. Thinking about this more, you might need to
>> adjust the default minimum to account for the offset as well? At
>> the moment it doesn't really affect us, as the offset is either
>> 1 or 0, which means a minimum of 1 is equally good. But leaving
>> a potential error in there doesn't feel right.
>
> I'm not sure we should really care, I'm not aware of any SoC that
> would have such a clock, either in the "old" or "new" ones. I'm not
> sure we should fix that isn't broken.

Indeed. Here's hoping Allwinner doesn't try anything "smart".
What I'm concerned about is that we are leaving gaps in the clk
driver that will make it harder to understand for newcomers.

ChenYu

>> Said change would be against patch 2, so
>>
>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>>
>> for this patch once the first comment is addressed.
>
> I'll do that change and respin the serie, thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
