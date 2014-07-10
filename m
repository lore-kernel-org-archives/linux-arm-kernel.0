From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 10 Jul 2014 13:06:44 +0200
Subject: [PATCH v3 07/12] sched: test the cpu's capacity in wake affine
In-Reply-To: <1404144343-18720-8-git-send-email-vincent.guittot@linaro.org>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-8-git-send-email-vincent.guittot@linaro.org>
Message-ID: <20140710110644.GX3935@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 06:05:38PM +0200, Vincent Guittot wrote:
> Currently the task always wakes affine on this_cpu if the latter is idle.
> Before waking up the task on this_cpu, we check that this_cpu capacity is not
> significantly reduced because of RT tasks or irq activity.
> 
> Use case where the number of irq and/or the time spent under irq is important
> will take benefit of this because the task that is woken up by irq or softirq
> will not use the same CPU than irq (and softirq) but a idle one which share
> its cache.

The above, doesn't seem to explain:

> +	} else if (!(sd->flags & SD_SHARE_PKG_RESOURCES)) {
> +		this_eff_load = 0;
> +	}
> +
> +	balanced = this_eff_load <= prev_eff_load;

this. Why would you unconditionally allow wake_affine across cache
domains?
