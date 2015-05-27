From: robh@kernel.org (Rob Herring)
Date: Wed, 27 May 2015 11:46:47 -0500
Subject: [PATCHv3 11/12] ARM: migrate to common PSCI client code
In-Reply-To: <1432648350-5454-12-git-send-email-mark.rutland@arm.com>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
 <1432648350-5454-12-git-send-email-mark.rutland@arm.com>
Message-ID: <CAL_JsqJG=k=z5+p55YVzmdFBjcGSX2t3ct337kYRd6c5HG5H3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 8:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Now that the common PSCI client code has been factored out to
> drivers/firmware, and made safe for 32-bit use, move the 32-bit ARM code
> over to it. This results in a moderate reduction of duplicated lines,
> and will prevent further duplication as the PSCI client code is updated
> for PSCI 1.0 and beyond.
>
> The two legacy platform users of the PSCI invocation code are updated to
> account for interface changes. In both cases the power state parameter
> is changed to an opaque u32 token in preparation for PSCI 1.0 power
> state changes.

[...]

> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index 231fba0..6050a14 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -28,8 +28,8 @@
>  #include <linux/reboot.h>
>  #include <linux/amba/bus.h>
>  #include <linux/platform_device.h>
> +#include <linux/psci.h>
>
> -#include <asm/psci.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
> index 7f2bd85..014e96d 100644
> --- a/arch/arm/mach-highbank/pm.c
> +++ b/arch/arm/mach-highbank/pm.c
> @@ -16,18 +16,14 @@
>
>  #include <linux/cpu_pm.h>
>  #include <linux/init.h>
> +#include <linux/psci.h>
>  #include <linux/suspend.h>
>
>  #include <asm/suspend.h>
> -#include <asm/psci.h>
>
>  static int highbank_suspend_finish(unsigned long val)
>  {
> -       const struct psci_power_state ps = {
> -               .type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
> -               .affinity_level = 1,
> -       };
> -
> +       u32 ps = 0x01010000; /* Aff1 power down */

Why not just pass directly instead of sticking in a variable first.

>         return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
>  }
>
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
> index 9445e6c..d010da8f 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -25,15 +25,14 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/platform_device.h>
> +#include <linux/psci.h>
> +
>  #include <asm/cpuidle.h>
>  #include <asm/suspend.h>
> -#include <asm/psci.h>
>
>  static int calxeda_idle_finish(unsigned long val)
>  {
> -       const struct psci_power_state ps = {
> -               .type = PSCI_POWER_STATE_TYPE_POWER_DOWN,
> -       };
> +       u32 ps = 0x00010000; /* Aff0 power down */

ditto.

>         return psci_ops.cpu_suspend(ps, __pa(cpu_resume));
>  }
>
> --
> 1.9.1
>
