From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 5 Dec 2017 11:01:11 +0800
Subject: [linux-sunxi] [PATCH 1/2] clk: sunxi-ng: Support fixed
 post-dividers on MP style clocks
In-Reply-To: <b961a1b6-f0e4-68e3-ab77-b0010dab63ff@arm.com>
References: <20171204051912.7485-1-wens@csie.org>
 <20171204051912.7485-2-wens@csie.org>
 <b961a1b6-f0e4-68e3-ab77-b0010dab63ff@arm.com>
Message-ID: <CAGb2v64w7EEYbJug+PQQwM8zXcyoOo8B+zk9MzU8cAW=K=gvEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 7:18 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> Hi Chen-Yu,
>
> On 04/12/17 05:19, Chen-Yu Tsai wrote:
>> On the A64, the MMC module clocks are fixed in the new timing mode,
>> i.e. they do not have a bit to select the mode. These clocks have
>> a 2x divider somewhere between the clock and the MMC module.
>>
>> To be consistent with other SoCs supporting the new timing mode,
>> we model the 2x divider as a fixed post-divider on the MMC module
>> clocks.
>>
>> To do this, we first add fixed post-divider to the MP style clocks,
>> which the MMC module clocks are.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/clk/sunxi-ng/ccu_mp.c | 20 ++++++++++++++++++--
>>  drivers/clk/sunxi-ng/ccu_mp.h | 24 ++++++++++++++++++++++++
>>  2 files changed, 42 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
>> index 688855e7dc8c..5d0af4051737 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mp.c
>> +++ b/drivers/clk/sunxi-ng/ccu_mp.c
>> @@ -50,12 +50,19 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
>>       unsigned int max_m, max_p;
>>       unsigned int m, p;
>>
>> +     if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
>> +             rate *= cmp->fixed_post_div;
>
> Can't you just initialise fixed_post_div to 1 normally and save the
> CCU_FEATURE_FIXED_POSTDIV?

I'll refer to Maxime about this. The feature flag was there from day
one. We only started to implement support for it later on. I'm not
sure if there was a reason to add them as feature flags, instead of
a field that defaults to something (0 even).

Otherwise it's a reasonable change. And we probably don't have to
do a wholesale change for the other clocks in one go. Incidentally
I have a A83T audio series that also adds post-dividers for another
clock type. I'll wait for a conclusion on this end before posting
it.

>
>> +
>>       max_m = cmp->m.max ?: 1 << cmp->m.width;
>>       max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
>>
>>       ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
>> +     rate = *parent_rate / p / m;
>> +
>> +     if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
>> +             rate /= cmp->fixed_post_div;
>>
>> -     return *parent_rate / p / m;
>> +     return rate;
>>  }
>>
>>  static void ccu_mp_disable(struct clk_hw *hw)
>> @@ -83,6 +90,7 @@ static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
>>                                       unsigned long parent_rate)
>>  {
>>       struct ccu_mp *cmp = hw_to_ccu_mp(hw);
>> +     unsigned long rate;
>>       unsigned int m, p;
>>       u32 reg;
>>
>> @@ -101,7 +109,11 @@ static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
>>       p = reg >> cmp->p.shift;
>>       p &= (1 << cmp->p.width) - 1;
>>
>> -     return (parent_rate >> p) / m;
>> +     rate = (parent_rate >> p) / m;
>> +     if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
>> +             rate /= cmp->fixed_post_div;
>> +
>> +     return rate;
>>  }
>>
>>  static int ccu_mp_determine_rate(struct clk_hw *hw,
>> @@ -129,6 +141,10 @@ static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
>>       max_m = cmp->m.max ?: 1 << cmp->m.width;
>>       max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
>>
>> +     /* Adjust target rate according to post-dividers */
>> +     if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
>> +             rate = rate * cmp->fixed_post_div;
>> +
>>       ccu_mp_find_best(parent_rate, rate, max_m, max_p, &m, &p);
>>
>>       spin_lock_irqsave(cmp->common.lock, flags);
>> diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
>> index aaef11d747ea..5107635e61de 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mp.h
>> +++ b/drivers/clk/sunxi-ng/ccu_mp.h
>> @@ -33,9 +33,33 @@ struct ccu_mp {
>>       struct ccu_div_internal         m;
>>       struct ccu_div_internal         p;
>>       struct ccu_mux_internal mux;
>> +
>> +     unsigned int            fixed_post_div;
>> +
>>       struct ccu_common       common;
>>  };
>>
>> +#define SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(_struct, _name, _parents, _reg, \
>> +                                        _mshift, _mwidth,            \
>> +                                        _pshift, _pwidth,            \
>> +                                        _muxshift, _muxwidth,        \
>> +                                        _gate, _postdiv, _flags)     \
>> +     struct ccu_mp _struct = {                                       \
>> +             .enable = _gate,                                        \
>> +             .m      = _SUNXI_CCU_DIV(_mshift, _mwidth),             \
>> +             .p      = _SUNXI_CCU_DIV(_pshift, _pwidth),             \
>> +             .mux    = _SUNXI_CCU_MUX(_muxshift, _muxwidth),         \
>> +             .fixed_post_div = _postdiv,                             \
>> +             .common = {                                             \
>> +                     .reg            = _reg,                         \
>> +                     .features       = CCU_FEATURE_FIXED_POSTDIV,    \
>> +                     .hw.init        = CLK_HW_INIT_PARENTS(_name,    \
>> +                                                           _parents, \
>> +                                                           &ccu_mp_ops, \
>> +                                                           _flags),  \
>> +             }                                                       \
>> +     }
>> +
>
> This looks suspiciously like a copy of the macro below. What about you
> define the one below as a special case of this new one above?

Correct. But you can't unset the feature flag. So a copy is needed.

> Should be even more straightforward with defaulting postdiv to 1 and
> loosing the feature flags.

See above about the feature flag.

ChenYu

>
> Cheers,
> Andre.
>
>>  #define SUNXI_CCU_MP_WITH_MUX_GATE(_struct, _name, _parents, _reg,   \
>>                                  _mshift, _mwidth,                    \
>>                                  _pshift, _pwidth,                    \
>>
>
