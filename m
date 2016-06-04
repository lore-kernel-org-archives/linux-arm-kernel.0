From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 4 Jun 2016 08:19:55 +0200
Subject: [PATCH 03/14] pwm: rockchip: Fix period and duty_cycle
 approximation
In-Reply-To: <20160603200326.GA124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-4-git-send-email-boris.brezillon@free-electrons.com>
 <20160603200326.GA124478@google.com>
Message-ID: <20160604081955.47393878@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jun 2016 13:03:26 -0700
Brian Norris <briannorris@chromium.org> wrote:

> On Fri, Jun 03, 2016 at 10:23:01AM +0200, Boris Brezillon wrote:
> > The current implementation always round down the duty and period
> > values, while it would be better to round them to the closest integer.  
> 
> Agreed. As I noted to you elsewhere, not having this change can cause
> problems where doing a series of pwm_get_state() / modify /
> pwm_apply_state() will propagate rounding errors, which will change the
> period unexpectedly. e.g., I have an expected period of 3.333 us and a
> clk rate of 112.666667 MHz -- the clock frequency doesn't divide evenly,
> so the period (stashed in nanoseconds) shrinks when we convert to the
> register value and back, as follows:
> 
>  pwm_apply_state(): register = period * 112666667 / 1000000000;
>  pwm_get_state(): period = register * 1000000000 / 112666667;
> 
> or in other words:
> 
>  period = period * 112666667 / 1000000000 * 1000000000 / 112666667;
> 
> which yields a sequence like:
> 
>  3333 -> 3328
>  3328 -> 3319
>  3319 -> 3310
>  3310 -> 3301
>  3301 -> 3292
>  3292 -> ... (etc) ...
> 
> With this patch, we'd see instead:
> 
>  period = div_round_closest(period * 112666667, 1000000000) * 1000000000 / 112666667;
> 
> which yields a stable sequence:
> 
>  3333 -> 3337
>  3337 -> 3337
>  3337 -> ... (etc) ...

Woh! Thanks for the detailed explanation. Do you want me to put that in
a comment explaining why we're using DIV_ROUND_CLOSEST_ULL()?


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
