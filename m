From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Mar 2018 17:19:51 +0000
Subject: [PATCH v6 06/25] timer: Export next wakeup time of a CPU
In-Reply-To: <1521046715-30683-7-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-7-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20180314171950.yn5spehwzuc5nttu@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 05:58:16PM +0100, Ulf Hansson wrote:
> @@ -132,6 +133,15 @@ static inline ktime_t tick_nohz_get_sleep_length(void)
>  {
>  	return NSEC_PER_SEC / HZ;
>  }
> +
> +static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
> +{
> +	ktime_t len = NSEC_PER_SEC/HZ;
> +
> +	/* Next wake up is the tick period, assume it starts now */
> +	return ktime_add(len, ktime_get());
> +}

Thsi could be marginally simpler as:

static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
{
	/* Next wake up is the tick period, assume it starts now */
	return ktime_add(tick_nohz_get_sleep_length(), ktime_get());
}

Thanks,
Mark.
