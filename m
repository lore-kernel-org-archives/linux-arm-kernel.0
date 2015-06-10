From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 14:37:57 -0700
Subject: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for cpu
 domain
In-Reply-To: <1433456946-53296-4-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Thu, 4 Jun 2015 16:29:06 -0600")
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hmw07meh6.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Generally cpus are grouped under a power domain in a SoC. When all cpus
> in the domain are in their power off state, the cpu domain can also be
> powered off. 

How does this relate to a cluster, and why aren't you using that terminolgy?

> Genpd provides the framework for defining cpus as devices
> that are part of a cpu domain.
>
> Introduce support for defining and adding a generic power domain for the
> cpus based on the DT specification of power domain providers and
> consumers.  SoC's that have the cpu domain defined in their DT, can
> setup a genpd with a name and the power_on/power_off callbacks. Calling
> pm_cpu_domain_init() will register the genpd and attach the cpus for
> this domain with the genpd.
>
> CPU_PM notifications for are used to pm_runtime_get_sync() and
> pm_runtime_put_sync() for each cpu.  When all cpus are powered off, the
> last cpu going down would call the genpd->power_off(). Correspondingly,
> the first cpu up would call the genpd->power_on() callback before
> resuming from idle.

Other patches also mention this genpd being useful to gate power to
non-CPU peripherals on the same power rail.  How are those devices to be
added?

Without seeing the DTs and the init code that might call
pm_cpu_domain_init(), it's hard for me to see how this is intended to be
used.  Could you also include a patch that shows how this is initialized
and the DT additions?  Ideally, it should also show how a non-CPU device
would be included.

Kevin
