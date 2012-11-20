From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Nov 2012 04:49:00 +0000
Subject: [PATCH 3/4] i2c-s3c2410: use exponential back off while
 polling for bus idle
In-Reply-To: <1352981613-2098-4-git-send-email-ch.naveen@samsung.com>
References: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
 <1352981613-2098-4-git-send-email-ch.naveen@samsung.com>
Message-ID: <20121120044859.GA10154@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 05:43:32PM +0530, Naveen Krishna Chatradhi wrote:

> +	iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> +	delay = 1;
> +	while ((iicstat & S3C2410_IICSTAT_START) &&
> +	       ktime_us_delta(now, start) < S3C2410_IDLE_TIMEOUT) {
> +		usleep_range(delay, 2 * delay);
> +		if (delay < S3C2410_IDLE_TIMEOUT / 10)
> +			delay <<= 1;
> +		now = ktime_get();
> +		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> +	}

> -	/* first, try busy waiting briefly */
> -	do {
> -		cpu_relax();
> -		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> -	} while ((iicstat & S3C2410_IICSTAT_START) && --spins);

On the hardware I was using when I wrote the original code here we were
hitting 1-2 spins often enough to be interesting - starting off with a
direct busy wait was definitely useful when doing large batches of I/O,
especially compared to sleeps which might cause us to schedule.

> -	/* if that timed out sleep */
> -	if (!spins) {
> -		msleep(1);
> -		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> -	}

It seems like it'd be better to do the exponential backoff bit here
instead of removing the busy wait completely.
