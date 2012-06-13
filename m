From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 13 Jun 2012 10:50:59 +0200
Subject: [RFC 1/4] ARM: topology: Add arch_scale_freq_power function
In-Reply-To: <1339502524-10265-2-git-send-email-vincent.guittot@linaro.org>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-2-git-send-email-vincent.guittot@linaro.org>
Message-ID: <CAORVsuWGE3=8DWRMG0Fq2+CGt9i7__JnfUnOAjbZgGcvhfVK5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vincent,

On Tue, Jun 12, 2012 at 2:02 PM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> Add infrastructure to be able to modify the cpu_power of each core
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> ?arch/arm/include/asm/topology.h | ? ?2 ++
> ?arch/arm/kernel/topology.c ? ? ?| ? 36 +++++++++++++++++++++++++++++++++++-
> ?2 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 58b8b84..78e4c85 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -27,11 +27,13 @@ void init_cpu_topology(void);
> ?void store_cpu_topology(unsigned int cpuid);
> ?const struct cpumask *cpu_coregroup_mask(int cpu);
>
> +void set_power_scale(unsigned int cpu, unsigned long power);
> ?#else
>
> ?static inline void init_cpu_topology(void) { }
> ?static inline void store_cpu_topology(unsigned int cpuid) { }
>
> +static inline void set_power_scale(unsigned int cpu, unsigned long power) { }
> ?#endif
>
> ?#include <asm-generic/topology.h>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 8200dea..00301a7 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -22,6 +22,35 @@
> ?#include <asm/cputype.h>
> ?#include <asm/topology.h>
>
> +/*
> + * cpu power scale management
> + */
> +
> +/*
> + * cpu power table
> + * This per cpu data structure describes the relative capacity of each core.
> + * On a heteregenous system, cores don't have the same computation capacity
> + * and we reflect that difference in the cpu_power field so the scheduler can
> + * take this difference into account for load balance. A per cpu structure is
> + * preferred because each cpu is mainly using its own cpu_power even it's not
> + * always true because of nohz_idle_balance
The end of the comment is unclear IMO; Can you give more details on
the relation between cpu_power and nohz_idle_balance?

Regards,
Jean
