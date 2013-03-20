From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 19 Mar 2013 17:16:09 -0700
Subject: [PATCH] clk: divider: Use DIV_ROUND_CLOSEST
In-Reply-To: <2e77dfe8-8d4f-4b77-bf1b-831ad1572c23@VA3EHSMHS046.ehs.local>
References: <2e77dfe8-8d4f-4b77-bf1b-831ad1572c23@VA3EHSMHS046.ehs.local>
Message-ID: <20130320001609.8663.21043@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Soren Brinkmann (2013-01-29 17:25:44)
> Use the DIV_ROUND_CLOSEST macro to calculate divider values and minimize
> rounding errors.
> 
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> Hi,
> 
> I just came across this behavior:
> I'm using the clk-divider as cpuclock which can be scaled through cpufreq.
> During boot I create an opp table which in this case holds the frequencies [MHz]
> 666, 333 and 222. To make sure those are actually valid frequencies I call
> clk_round_rate().
> I added a debug line in clk-divider.c:clk_divider_bestdiv() before the return
> in line 163 giving me:
>         prate:1333333320, rate:333333330, div:4
> for adding the 333 MHz operating point.
> 
> In the running system this gives me:
> zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_available_frequencies 
> 222222 333333 666666 
> zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_cur_freq 
>  666666
> 
>  So far, so good. But now, let's scale the frequency:
> zynq:/sys/devices/system/cpu/cpu0/cpufreq # echo 333333 > scaling_setspeed 
> zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_cur_freq
>  266666
> 
> And the corresponding debug line:
>         prate:1333333320, rate:333333000, div:5
> 
> So, with DIV_ROUND_UP an actual divider of 4.00000396 becomes 5, resulting in a
> huge error.
> 

Soren,

Thanks for the patch, and apologies for it getting lost for so long.  I
think that your issue is more about policy.  E.g. should we round the
divider up or round the divider down?  The correct answer will vary from
platform to platform and the clk.h api doesn't specify how
clk_round_rate should round, other than it must specify a rate that the
clock can actually run at.

Unless everyone can agree that DIV_ROUND_CLOSEST gives them what they
want I'm more inclined to make this behavior a flag specific to struct
clk-divider.  E.g. CLK_DIVIDER_ROUND_CLOSEST.

Care to take a crack at that approach?

Regards,
Mike

>         Regards,
>         S?ren
> 
>  drivers/clk/clk-divider.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index a9204c6..32e1b6a 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -157,7 +157,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
>  
>         if (!(__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT)) {
>                 parent_rate = *best_parent_rate;
> -               bestdiv = DIV_ROUND_UP(parent_rate, rate);
> +               bestdiv = DIV_ROUND_CLOSEST(parent_rate, rate);
>                 bestdiv = bestdiv == 0 ? 1 : bestdiv;
>                 bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
>                 return bestdiv;
> @@ -207,7 +207,7 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>         unsigned long flags = 0;
>         u32 val;
>  
> -       div = parent_rate / rate;
> +       div = DIV_ROUND_CLOSEST(parent_rate, rate);
>         value = _get_val(divider, div);
>  
>         if (value > div_mask(divider))
> -- 
> 1.8.1.2
