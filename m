From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 6 Jul 2018 09:59:15 +0200
Subject: [PATCH] arm64: hikey960: update idle-states
In-Reply-To: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
References: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
Message-ID: <722aed2b-673b-7f17-2337-a7b3442dca56@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2018 08:57, Vincent Guittot wrote:
> Update entry/exit latency and residency time of hikey960 to use more
> realistic figures based on unitary tests done on the platform.
> 
> The complete results (in us) :
>                   big cluster
>                   cluster  CPU
> max entry latency     800  400
> max exit latency     2900  550
> residency  903Mhz    5000 1500
> residency 2363Mhz       0 1500
> 
>                   little cluster
>                   cluster  CPU
> max entry latency     500  400
> max exit latency     1600  650
> residency  533Mhz    8000 4500
> residency 1844Mhz       0 1500
> 
> We can see that the residency time depends of the running OPP which is not
> handled for now. Then we also have to take into account the constraint of
> a residency time shorter than the tick to get full advantage of idle loop
> reordering(tick is stopped if idle duration is higher than tick period).
> Finally the selected residency value are :
>                  big cluster
>                   cluster  CPU
> residency            3700 1500
> 
>                   little cluster
>                   cluster  CPU
> residency            3500 1500
> 
> A simple test with a task waking up every 11,111ms shows improvement:
> - 5% a lowest OPP
> - 22% at highest OPP
> 
> The period has been chosen:
> - to be shorter than old cluster residency time and longer than new
> residency time od cluster off C-state
> - to prevent any sync with tick (4ms) when running tests that can add
> some variances between tests
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Great! Thanks for fixing the values.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
