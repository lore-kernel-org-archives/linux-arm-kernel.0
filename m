From: pprakash@codeaurora.org (Prakash, Prashanth)
Date: Tue, 26 Apr 2016 09:51:25 -0600
Subject: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
Message-ID: <571F8E7D.4000706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 4/19/2016 6:30 AM, Sudeep Holla wrote:
> +struct acpi_processor_lpi *lpi;
> +int acpi_processor_ffh_lpi_enter(struct acpi_processor_lpi *lpi, int idx)
> +{
> +	int ret;
> +
> +	if (!idx) {
> +		cpu_do_idle();
> +		return idx;
> +	}
> +
> +	/* TODO cpu_pm_{enter,exit} can be done in generic code ? */
> +	ret = cpu_pm_enter();
Can we avoid calling cpu_pm_enter and cpu_pm_exit for retention states as it is not necessary?
May be we can check LPI architecture specific context loss flags prior to calling these.
> +	if (!ret) {
> +		/*
> +		 * Pass idle state index to cpu_suspend which in turn will
> +		 * call the CPU ops suspend protocol with idle index as a
> +		 * parameter.
> +		 */
> +		ret = arm_cpuidle_suspend(idx);
> +
> +		cpu_pm_exit();
same here
> +	}
> +
> +	return ret ? -1 : idx;
> +}
> +

By the way, thanks for posting these patches!

-Prashanth
