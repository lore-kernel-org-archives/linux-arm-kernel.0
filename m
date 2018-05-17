From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 May 2018 14:43:47 -0700
Subject: [PATCH 2/4] omap2: clockdomain: Inroduce cpu_pm notifiers for
 context save/restore
In-Reply-To: <1526483821-25585-3-git-send-email-j-keerthy@ti.com>
References: <1526483821-25585-1-git-send-email-j-keerthy@ti.com>
 <1526483821-25585-3-git-send-email-j-keerthy@ti.com>
Message-ID: <20180517214347.GR98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [180516 15:21]:
> Inroduce cpu_pm notifiers for context save/restore. This will be
> needed for am43xx family in case of rtc only mode with ddr in
> self-refresh.
...
> +static int cpu_notifier(struct notifier_block *nb, unsigned long cmd, void *v)
> +{
> +	switch (cmd) {
> +	case CPU_CLUSTER_PM_ENTER:
> +		if (enable_off_mode)
> +			clkdm_save_context();
> +		break;
> +	case CPU_CLUSTER_PM_EXIT:
> +		if (enable_off_mode)
> +			clkdm_restore_context();
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}

Can you do this too only on suspend instead of the cpu notifier?
If you need to call this eventually from cpuidle also then yeah
the notifier makes sense.

Regards,

Tony
