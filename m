From: mturquette@ti.com (Turquette, Mike)
Date: Wed, 4 Apr 2012 11:07:44 -0700
Subject: [PATCH] clk: Update comment for clk_round_rate()
In-Reply-To: <CAOh2x=nTSvOrJa2uB2zTvYh1SUO2YpEpnLcL189itJ=_e+MPog@mail.gmail.com>
References: <CAOh2x=nTSvOrJa2uB2zTvYh1SUO2YpEpnLcL189itJ=_e+MPog@mail.gmail.com>
Message-ID: <CAJOA=zOPn0FcwO0McSb8-18h7LiJndRD2nmCCvxUEEm+fakvKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 10:27 AM, viresh kumar <viresh.linux@gmail.com> wrote:
> From: Viresh Kumar <viresh.kumar@st.com>
>
> clk_round_rate() must not provide rate greater than requested rate, as hardware
> may not work at it. This wasn't clear from documentation of clk_round_rate().
>
> This patch updates documentation for this.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>
> Mike,
>
> I don't know if this holds true for common clock framework or not?
> But it looks more logical to me and this is how it was implemented for SPEAr.

The common clk framework doesn't enforce any policy like this, nor do
I think it should.  The clk framework is far from complete and I
wouldn't be surprised if we see folks who want their rounded rate to
represent a minimum value (instead of a maximum as your patch states).
 This might be achieved later on by a platform-specific or
framework-wide flag, similar to how CPUfreq does it today
(CPUFREQ_RELATION_L and CPUFREQ_RELATION_H).

Thank you for submitting the patch, but for now it's a NACK.

Regards,
Mike

>
> ?drivers/clk/clk.c ? | ? ?6 +++---
> ?include/linux/clk.h | ? ?3 ++-
> ?2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9cf6f59..2f58455 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -603,9 +603,9 @@ unsigned long __clk_round_rate(struct clk *clk,
> unsigned long rate)
> ?* @clk: the clk for which we are rounding a rate
> ?* @rate: the rate which is to be rounded
> ?*
> - * Takes in a rate as input and rounds it to a rate that the clk can actually
> - * use which is then returned. ?If clk doesn't support round_rate operation
> - * then the parent rate is returned.
> + * Takes in a rate as input and rounds it to a rate <= input rate that the clk
> + * can actually use which is then returned. ?If clk doesn't support round_rate
> + * operation then the parent rate is returned.
> ?*/
> ?long clk_round_rate(struct clk *clk, unsigned long rate)
> ?{
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index b025272..19d31ef 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -213,7 +213,8 @@ void clk_put(struct clk *clk);
>
>
> ?/**
> - * clk_round_rate - adjust a rate to the exact rate a clock can provide
> + * clk_round_rate - adjust a rate to the exact rate a clock can provide. Output
> + * ? ? ? ? ? ? ? ? clock rate should be <= requested rate
> ?* @clk: clock source
> ?* @rate: desired clock rate in Hz
> ?*
> --
> 1.7.9
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
