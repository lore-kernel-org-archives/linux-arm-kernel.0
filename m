From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Fri, 11 May 2012 14:51:05 +0530
Subject: smp_twd fix for adapting to cpu frequency change
In-Reply-To: <CACRpkdZzAO4hAJKyAoeqnud9LeDG4nSK7y9cLZaEBdVOnq-ocw@mail.gmail.com>
References: <CAPub14_+XXjKyZVh3E8QQjY4sB4gVB=kaApuODptoizqfEUH_Q@mail.gmail.com>
 <CACRpkdZzAO4hAJKyAoeqnud9LeDG4nSK7y9cLZaEBdVOnq-ocw@mail.gmail.com>
Message-ID: <20120511092105.GR30029@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, May 08, 2012 at 07:33:56PM +0800, Linus Walleij wrote:
> Can you test this snippet?
> Thomas: does this look sane?
> 
> >From d40c3c3302a2f89ab973b41b350153c144f6bded Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Tue, 8 May 2012 13:26:43 +0200
> Subject: [PATCH] ARM: smp_twd: reprogram loadvalue for periodic event
> 
> The code to handle frequency transitions of the TWD only
> handle one-shot events. Let's try to account for this by
> checking the state of the event.
> 
> Reported-by: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/kernel/smp_twd.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> index fef42b2..98b27e6 100644
> --- a/arch/arm/kernel/smp_twd.c
> +++ b/arch/arm/kernel/smp_twd.c
> @@ -104,9 +104,17 @@ static void twd_timer_stop(struct clock_event_device *clk)
>   */
>  static void twd_update_frequency(void *data)
>  {
> +       struct clock_event_device *evt = *__this_cpu_ptr(twd_evt);
> +
>         twd_timer_rate = clk_get_rate(twd_clk);
> 
> -       clockevents_update_freq(*__this_cpu_ptr(twd_evt), twd_timer_rate);
> +       /* If we're in periodic mode, just put in a new load value */
> +       if (evt->mode == CLOCK_EVT_MODE_PERIODIC) {
> +               __raw_writel(twd_timer_rate / HZ, twd_base + TWD_TIMER_LOAD);
> +               return;
> +       }
> +
> +       clockevents_update_freq(evt, twd_timer_rate);
>  }
> 
>  static int twd_cpufreq_transition(struct notifier_block *nb,
> -- 

Thanks, it works.

--
regards
Shiraz
