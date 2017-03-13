From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 13 Mar 2017 16:55:12 +0100
Subject: [PATCH V5 2/9] drivers: cpu: Setup CPU devices to do runtime PM
In-Reply-To: <1488573695-106680-3-git-send-email-lina.iyer@linaro.org>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
 <1488573695-106680-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAPDyKFq6NP9uKPQJ7y6w9a3u071L-4e3e4hPaS8nuhnexKnJbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2017 at 21:41, Lina Iyer <lina.iyer@linaro.org> wrote:
> CPU devices just like any other device, can do runtime PM. However, CPU
> devices may only do runtime only when IRQs are disabled. The devices
> must be set as IRQ safe.
>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/cpu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 2c3b359..77451ad 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -18,6 +18,7 @@
>  #include <linux/cpufeature.h>
>  #include <linux/tick.h>
>  #include <linux/pm_qos.h>
> +#include <linux/pm_runtime.h>
>
>  #include "base.h"
>
> @@ -345,6 +346,19 @@ static int cpu_uevent(struct device *dev, struct kobj_uevent_env *env)
>  }
>  #endif
>
> +#ifdef CONFIG_PM
> +static void cpu_runtime_pm_init(struct device *dev)
> +{
> +       pm_runtime_irq_safe(dev);
> +       pm_runtime_enable(dev);
> +       if (cpu_online(dev->id))
> +               pm_runtime_set_active(dev);

You shouldn't change the runtime PM status of the device when runtime
PM is enabled. Instead do that before you call pm_runtime_enable().

> +}
> +#else
> +static void cpu_runtime_pm_init(struct device *dev)

There is no need for a stub function, as the runtime PM API already
provides stubs for when CONFIG_PM is unset.

> +{ }
> +#endif
> +
>  /*
>   * register_cpu - Setup a sysfs device for a CPU.
>   * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
> @@ -379,6 +393,7 @@ int register_cpu(struct cpu *cpu, int num)
>         register_cpu_under_node(num, cpu_to_node(num));
>         dev_pm_qos_expose_latency_limit(&cpu->dev, 0);
>
> +       cpu_runtime_pm_init(&cpu->dev);
>         return 0;
>  }
>
> --
> 2.7.4
>

Kind regards
Uffe
