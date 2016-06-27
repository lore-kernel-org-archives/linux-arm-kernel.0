From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Jun 2016 16:33:15 +0200
Subject: [PATCH v6 5/5] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
In-Reply-To: <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-6-git-send-email-sudeep.holla@arm.com>
Message-ID: <5771392B.3080002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2016 04:48 PM, Sudeep Holla wrote:
> Now that ACPI processor idle driver supports LPI(Low Power Idle), lets
> enable ACPI_PROCESSOR_IDLE for ARM64 too.
>
> This patch just removes the IA64 and X86 dependency on ACPI_PROCESSOR_IDLE
>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Hi Sudeep,

now that ACPI processor supports ARM64 did you check the 
CPUIDLE_DRIVER_STATE_START trick in the code and its derivative ?

I deleted the patch 2/5 but there is a place where:

if (max_cstate=0)
	max_cstate=1;

Probably this is because the POLL state is inserted, so there is always 
an idle state. But for ARM, that is not the case.

Also, there are some places where the idle state index begins to 1. I 
think it should be 0 for ARM.

>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1358fb7d7a68..d74275c0f374 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -238,7 +238,7 @@ config ACPI_CPPC_LIB
>   config ACPI_PROCESSOR
>   	tristate "Processor"
>   	depends on X86 || IA64 || ARM64
> -	select ACPI_PROCESSOR_IDLE if X86 || IA64
> +	select ACPI_PROCESSOR_IDLE
>   	select ACPI_CPU_FREQ_PSS if X86 || IA64
>   	default y
>   	help
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
