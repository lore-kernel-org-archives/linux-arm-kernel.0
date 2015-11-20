From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 19 Nov 2015 16:03:58 -0800
Subject: [PATCH RFC 18/27] drivers: cpu-pd: Add PM Domain governor for CPUs
In-Reply-To: <1447799871-56374-19-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Tue, 17 Nov 2015 15:37:42 -0700")
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-19-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hbnapsfip.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> A PM domain comprising of CPUs may be powered off when all the CPUs in
> the domain are powered down. Powering down a CPU domain is generally a
> expensive operation and therefore the power performance trade offs
> should be considered. The time between the last CPU powering down and
> the first CPU powering up in a domain, is the time available for the
> domain to sleep. Ideally, the sleep time of the domain should fulfill
> the residency requirement of the domains' idle state.
>
> To do this effectively, read the time before the wakeup of the cluster's
> CPUs and ensure that the domain's idle state sleep time guarantees the
> QoS requirements of each of the CPU, the PM QoS CPU_DMA_LATENCY and the
> state's residency.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

[...]

> +static bool cpu_stop_ok(struct device *dev)
> +{
> +	return true;
> +}
> +
> +struct dev_power_governor cpu_pd_gov = {
> +	.power_down_ok = cpu_pd_down_ok,
> +	.stop_ok = cpu_stop_ok,
> +};

If stop_ok is unconditionally true, it should probably just be removed
(IOW cpu_pd_gov->stop_ok == NULL), and that will avoid an unnecessary
function call.

Kevin
