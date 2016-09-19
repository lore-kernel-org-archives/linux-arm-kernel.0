From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 19 Sep 2016 23:36:18 +0800
Subject: [PATCH 4/4] drm/sun4i: dotclock: Round to closest clock rate
In-Reply-To: <20160918191648.GJ17518@lukather>
References: <20160915151402.15992-1-wens@csie.org>
 <20160915151402.15992-5-wens@csie.org>
 <20160918191648.GJ17518@lukather>
Message-ID: <CAGb2v65Lj2YSwGv=VtrT1NC+guXwMvh7J3c36_vk+5c1vAXhcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 3:16 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Sep 15, 2016 at 11:14:02PM +0800, Chen-Yu Tsai wrote:
>> With display pixel clocks we want to have the closest possible clock
>> rate, to minimize timing and refresh rate skews. Whether the actual
>> clock rate is higher or lower than the requested rate is less important.
>>
>> Also check candidates against the requested rate, rather than the
>> ideal parent rate, the varying dividers also influence the difference
>> between the requested rate and the rounded rate.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/gpu/drm/sun4i/sun4i_dotclock.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> index 3eb99784f371..d401156490f3 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> @@ -90,7 +90,8 @@ static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
>>                       goto out;
>>               }
>>
>> -             if ((rounded < ideal) && (rounded > best_parent)) {
>> +             if (abs(rate - rounded / i) <
>> +                 abs(rate - best_parent / best_div)) {
>
> I'm not sure what you're trying to do here. Why is the divider involved?

Say you want the dotclock at X, so you try Y = 6 ~ 127 for the divider.
Now you're asking the CCF to round (X*Y).

In the original code, you were comparing the result of rounding (X * Y).

                if ((rounded < ideal) && (rounded > best_parent)) {
                        best_parent = rounded;
                        best_div = i;
                }

where ideal = X * Y (i in the code). Given the divider increases in
the loop, you are actually not closing in on the best divider, but the
highest divider that doesn't give a higher rate than the ideal rate.

Including the divider makes it compare the actual dot clock frequency
if a given divider was used.

Does this makes sense? Explaining this kind of makes my head spin...

Regards
ChenYu

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
