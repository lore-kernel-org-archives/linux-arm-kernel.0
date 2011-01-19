From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 16:56:02 +0000
Subject: [PATCH] arm: fix oops in sched_clock_poll
In-Reply-To: <1295455641-4791-1-git-send-email-tom.leiming@gmail.com>
References: <1295455641-4791-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20110119165602.GA6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 12:47:21AM +0800, tom.leiming at gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> The patch fixes one oops in sched_clock_poll, tested on
> beagle xm, follows the oops message:

> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
> index 9a46370..782dd08 100644
> --- a/arch/arm/kernel/sched_clock.c
> +++ b/arch/arm/kernel/sched_clock.c
> @@ -21,7 +21,9 @@ static void (*sched_clock_update_fn)(void);
>  static void sched_clock_poll(unsigned long wrap_ticks)
>  {
>  	mod_timer(&sched_clock_timer, round_jiffies(jiffies + wrap_ticks));
> -	sched_clock_update_fn();
> +
> +	if (sched_clock_update_fn)
> +		sched_clock_update_fn();

It's called here because it's supposed to be initialized by the time this
function is called.  Please ensure that is the case.

If not, please make sure it is the case, otherwise you'll have a screwed
sched_clock (the timer won't catch the first wrap.)
