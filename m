From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 12 Jun 2017 16:45:25 +0200
Subject: [PATCH 1/6] drivers base/arch_topology: prepare cpufreq policy
 notifier for frequency-invariant load-tracking support
In-Reply-To: <20170608075513.12475-2-dietmar.eggemann@arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-2-dietmar.eggemann@arm.com>
Message-ID: <CAKfTPtBGG_8gd6v-p=PSg+PfoLtEF8c6vP=g48gG5ubKhQUFzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> This patch prepares the actual implementation of the frequency-invariant
> load-tracking support provided in the next patch ("drivers
> base/arch_topology: frequency-invariant load-tracking support").
>
> The maximum supported frequency of a cpu (policy->cpuinfo.max_freq) has
> to be retrieved for frequency-invariant load-tracking.
>
> This can be achieved by coding this functionality into the existing
> cpufreq policy notifier (init_cpu_capacity_notifier) which is currently
> only used for setting up dt-based cpu capacities (cpu node property
> capacity-dmips-mhz).
>
> But frequency-invariant load-tracking has to work whether cpu capacity
> dt-parsing succeeded or not.
>
> Change init_cpu_capacity_notifier in such a way that even if the parsing
> of the cpu capacity information failed the notifier is called for each
> cpufreq policy to be able to set the maximum supported frequency.
>
> The exit condition in register_cpufreq_notifier() now only tests for
> !acpi_disabled because for frequency invariance the cpufreq policy
> notifier has to be enabled even if u32 *raw_capacity is NULL which
> occurs when there is no capacity-dmips-mhz property in the dt file or
> when the allocation for raw_capacity[cpu] has failed.
>
> The continue statement in init_cpu_capacity_callback() makes sure that
> we don't go on calculating capacity_scale in case the capacity parsing
> failed. It should be a break rather a continue here but the next patch
> introduces code to set the per-cpu variable max_freq in this
> for_each_cpu loop before the check if cap_parsing_failed so it has to
> be a continue.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
