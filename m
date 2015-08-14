From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 14 Aug 2015 11:59:31 -0700
Subject: [PATCH 9/9] ARM: smp: Add runtime PM support for CPU hotplug
In-Reply-To: <20150812204326.GM52339@linaro.org> (Lina Iyer's message of "Wed,
 12 Aug 2015 14:43:26 -0600")
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-10-git-send-email-lina.iyer@linaro.org>
 <7hoaicmeuh.fsf@deeprootsystems.com>
 <20150812204326.GM52339@linaro.org>
Message-ID: <7hlhdditm4.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Wed, Aug 12 2015 at 14:28 -0600, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> Enable runtime PM for CPU devices. Do a runtime get of the CPU device
>>> when the CPU is hotplugged in and a runtime put of the CPU device when
>>> the CPU is hotplugged off. When all the CPUs in a domain are hotplugged
>>> off, the domain may also be powered off and cluster_pm_enter/exit()
>>> notifications are be sent out.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>
>>How does the runtiem PM usage with hotplug work with the runtime PM
>>usage in idle?
>>
>>IIUC, when a CPU is hotplugged in, it will always have a usecount of at
>>least 1, right?  and if it's not idle, it will have done a _get() so it
>>will have a usecount of at least 2.   So I'm not quite seeing how the
>>usecount will ever go to zero in idle and allow the domain to power_off.
>>
> When the CPU is online and running, it would have a ref count of 1. Then
> cpuidle would do a _put and the ref count would go to 0 and when coming
> out of idle, cpuidle would get a _get and the ref count will be back at
> 1. Ref count is not incremented when cpuidle is initialized on the CPU.
> So whenever the CPU is running, it would have a ref count of 1.

Ah, OK, that was the part I was missing.

Thanks,

Kevin
