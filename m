From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 15 Jun 2015 11:43:53 -0700
Subject: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for cpu
 domain
In-Reply-To: <20150611145649.GC1103@linaro.org> (Lina Iyer's message of "Thu,
 11 Jun 2015 08:56:49 -0600")
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
 <7hmw07meh6.fsf@deeprootsystems.com>
 <20150611145649.GC1103@linaro.org>
Message-ID: <7hioao6cd2.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> On Wed, Jun 10 2015 at 15:38 -0600, Kevin Hilman wrote:
>>Lina Iyer <lina.iyer@linaro.org> writes:
>>
>>> Generally cpus are grouped under a power domain in a SoC. When all cpus
>>> in the domain are in their power off state, the cpu domain can also be
>>> powered off.
>>
>>How does this relate to a cluster, and why aren't you using that terminolgy?
>>
>>> Genpd provides the framework for defining cpus as devices
>>> that are part of a cpu domain.
>>>
>>> Introduce support for defining and adding a generic power domain for the
>>> cpus based on the DT specification of power domain providers and
>>> consumers.  SoC's that have the cpu domain defined in their DT, can
>>> setup a genpd with a name and the power_on/power_off callbacks. Calling
>>> pm_cpu_domain_init() will register the genpd and attach the cpus for
>>> this domain with the genpd.
>>>
>>> CPU_PM notifications for are used to pm_runtime_get_sync() and
>>> pm_runtime_put_sync() for each cpu.  When all cpus are powered off, the
>>> last cpu going down would call the genpd->power_off(). Correspondingly,
>>> the first cpu up would call the genpd->power_on() callback before
>>> resuming from idle.
>>
>>Other patches also mention this genpd being useful to gate power to
>>non-CPU peripherals on the same power rail.  How are those devices to be
>>added?
>>
> I am not investigating DT nodes to figure out which node is a consumer
> for this domain provider. That could be a good way to do it, but
> practically speaking, there may be platform dependencies and specifics
> that may need to be met, before the device can be added to the CPU
> genpd.
>
> So that is not generalized here. I didn't see a better way to do that,
> generically. Do you have ideas on that?
>
> The platform is the owner of the genpd and therefore can add those
> non-cpu devices to the genpd as and when appropritate.

I'm pretty sure the generic code will already add devices to genpds if
the genpd is using the of_genpd_* stuff.  That is why I'm wondering why
the extra stuff for CPUs is needed.

> In this regard, I also have a question, who initializes the genpd. My
> assumption is that CPUs will get probed before most other devices and
> therefore the domain provider could be initialized by this file. But, I
> could be wrong here.

Initializing it in this driver seems OK to me.

Kevin
