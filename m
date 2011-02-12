From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Feb 2011 14:46:17 +0000
Subject: [RFC PATCH 1/3] ARM: Add cpu power management notifiers
In-Reply-To: <1297373487-23902-2-git-send-email-ccross@android.com>
References: <1297373487-23902-1-git-send-email-ccross@android.com>
	<1297373487-23902-2-git-send-email-ccross@android.com>
Message-ID: <20110212144617.GJ15616@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 01:31:25PM -0800, Colin Cross wrote:
> +int cpu_pm_enter(void)
> +{
> +	int nr_calls;
> +	int ret;
> +
> +	spin_lock(&idle_notifier_lock);
> +	ret = __idle_notify(CPU_PM_ENTER, -1, &nr_calls);
> +	if (ret) {
> +		__idle_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
> +		spin_unlock(&idle_notifier_lock);
> +		return ret;
> +	}
> +	spin_unlock(&idle_notifier_lock);
> +
> +	return 0;

Wouldn't:

	spin_lock(&idle_notifier_lock);
	ret = __idle_notify(CPU_PM_ENTER, -1, &nr_calls);
	if (ret)
		__idle_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
	spin_unlock(&idle_notifier_lock);

	return ret;

be easier reading?
