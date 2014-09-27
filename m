From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Sep 2014 15:23:05 +0800
Subject: [PATCH 1/7] clk: sunxi: Add post clk divider for factor clocks
In-Reply-To: <20140927070708.GY15315@lukather>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-2-git-send-email-wens@csie.org>
 <54145822.4020607@elopez.com.ar> <20140916155711.GF2166@lukather>
 <CAGb2v64o-7La6Sd_WVDrPQC0DUTqXZPZoG7u=OpXb+xRB1tcog@mail.gmail.com>
 <20140927070708.GY15315@lukather>
Message-ID: <CAGb2v64W7SSvTHgY_qT8D04EHpzZG5BSPKkh1RGxdh7=2=igsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 3:07 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Sep 24, 2014 at 11:35:58PM +0800, Chen-Yu Tsai wrote:
>> Hi Maxime, Emilio,
>>
>> On Tue, Sep 16, 2014 at 11:57 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi Emilio,
>> >
>> > On Sat, Sep 13, 2014 at 11:43:46AM -0300, Emilio L?pez wrote:
>> >> Hi,
>> >>
>> >> El 06/09/14 a las 07:47, Chen-Yu Tsai escibi?:
>> >> >Some factor clocks, mostly PLLs, have an extra fixed divider just before
>> >> >the clock output. Add an option to the factor clk driver config data to
>> >> >specify this divider.
>> >> >
>> >> >Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> >> >---
>> >> >  drivers/clk/sunxi/clk-factors.c | 3 +++
>> >> >  drivers/clk/sunxi/clk-factors.h | 1 +
>> >> >  2 files changed, 4 insertions(+)
>> >> >
>> >> >diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
>> >> >index 2057c8a..435111d 100644
>> >> >--- a/drivers/clk/sunxi/clk-factors.c
>> >> >+++ b/drivers/clk/sunxi/clk-factors.c
>> >> >@@ -64,6 +64,9 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>> >> >     /* Calculate the rate */
>> >> >     rate = (parent_rate * (n + config->n_start) * (k + 1) >> p) / (m + 1);
>> >> >
>> >> >+    if (config->post_div)
>> >> >+            rate /= config->post_div;
>> >> >+
>> >> >     return rate;
>> >> >  }
>> >> >
>> >> >diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
>> >> >index d2d0efa..ce70c65 100644
>> >> >--- a/drivers/clk/sunxi/clk-factors.h
>> >> >+++ b/drivers/clk/sunxi/clk-factors.h
>> >> >@@ -16,6 +16,7 @@ struct clk_factors_config {
>> >> >     u8 pshift;
>> >> >     u8 pwidth;
>> >> >     u8 n_start;
>> >> >+    u8 post_div;
>> >> >  };
>> >> >
>> >> >  struct clk_factors {
>> >> >
>> >>
>> >> For the record, I liked your solution on[1] more, as it's in line
>> >> with what we're doing on the other sunxi platforms, instead of
>> >> adding features in factors to cover for some cases. But it's your
>> >> and Maxime's call, as I haven't written any of the sun6i code so
>> >> far.
>> >
>> > No, you still wrote most of the clock support, so your opinion is
>> > always valuable (and valued).
>> >
>> > Thing is, unlike what was done in the sun4i driver where there was a
>> > "real" technical issue that was preventing us from using only
>> > fixed-factor, we're not in such a case in sun6i (and later,
>> > apparently).
>> >
>> > PLL6 has only one output, which is then directly multiplied by
>> > fixed-factors, without any (pre|post)-dividers for any of them.
>> >
>> > That means that following what you did for the sun4i would just
>> > register 3 "dumbs" fixed-factors, that we couldn't reference from DT,
>> > or through a cryptic index (which is not even documented in our
>> > bindings).
>> >
>> > I'd be fine either way, I just prefer the solution that has less code
>> > and is more explicit.
>>
>> What's the verdict on this series?
>
> If Emilio prefers to have a single clock node, fine. But please update
> the DT bindings documentation.

OK. Then this series needs a bit of work. I'll pick the orignal
divs clocks patch from patchwork (as I didn't keep one) and fix
up the DT.


ChenYu
