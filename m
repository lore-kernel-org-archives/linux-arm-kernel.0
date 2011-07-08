From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 17:44:13 +0100
Subject: [PATCH] arm: fix oops in sched_clock_poll
In-Reply-To: <1295455641-4791-1-git-send-email-tom.leiming@gmail.com>
References: <1295455641-4791-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20110708164412.GJ4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 12:47:21AM +0800, tom.leiming at gmail.com wrote:
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
>  }

This is the wrong solution.  At this point there must be an update
function.  sched_clock must already be up and running by the time
sched_clock_postinit() is called.
