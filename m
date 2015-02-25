From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 20:17:42 +0100
Subject: [PATCH v2 2/2] hwrng: iproc-rng200 - Add Broadcom IPROC RNG driver
In-Reply-To: <1424888184-22180-3-git-send-email-sbranden@broadcom.com>
References: <1424888184-22180-3-git-send-email-sbranden@broadcom.com>
Message-ID: <3062825.7b1oYP4yuL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 February 2015 10:16:24 Scott Branden wrote:
> This adds a driver for random number generator present on Broadcom
> IPROC devices.
> 
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Signed-off-by: Scott Branden <sbranden@broadcom.com>

The driver looks reasonable overall, I have just one question about
something that sticks out:

> +	while ((num_remaining > 0) && time_before(jiffies, idle_endtime)) {
...
> +
> +		/* Are there any random numbers available? */
> +		if ((ioread32(rng_base + RNG_FIFO_COUNT_OFFSET) &
> +				RNG_FIFO_COUNT_RNG_FIFO_COUNT_MASK) > 0) {
...
> +		} else {
> +			if (!wait)
> +				/* Cannot wait, return immediately */
> +				return max - num_remaining;
> +
> +			/* Can wait, give others chance to run */
> +			cpu_relax();
> +		}
> +	}
> +

It looks like you do a busy-loop around cpu_relax here if asked to wait.
Is this intentional? I would normally expect either cond_resched() or
some msleep() instead.

	Arnd
