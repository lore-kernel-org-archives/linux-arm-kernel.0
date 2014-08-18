From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:27:33 +0100
Subject: [PATCH v2 08/18] ARM64 / ACPI: Get the enable method for SMP
 initialization in ACPI way
In-Reply-To: <1407166105-17675-9-git-send-email-hanjun.guo@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <1407166105-17675-9-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140818142733.GT20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 04:28:15PM +0100, Hanjun Guo wrote:
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index e877967..022f4ad 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -14,6 +14,27 @@
>  
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> +/*
> + * ACPI 5.1 only has two explicit methods to
> + * boot up SMP, PSCI and Parking protocol,
> + * but the Parking protocol is only defined
> + * for ARMv7 now, so make PSCI as the only
> + * way for the SMP boot protocol before some
> + * updates for the ACPI spec or the Parking
> + * protocol spec.
> + *
> + * This enum is intend to make the boot method
> + * scalable when above updates are happended,
> + * which NOT means to support all of them.
> + */
> +enum acpi_smp_boot_protocol {
> +	ACPI_SMP_BOOT_PSCI,
> +	ACPI_SMP_BOOT_PARKING_PROTOCOL,
> +	ACPI_SMP_BOOT_PROTOCOL_MAX
> +};
> +
> +enum acpi_smp_boot_protocol smp_boot_protocol(void);

Since this is not a static function and ACPI-specific, could you prefix
it with something like acpi (or arm64_acpi_ unless it gets too long)?

> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index d62d12f..05bc314 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -16,11 +16,13 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#include <asm/cpu_ops.h>
> -#include <asm/smp_plat.h>
>  #include <linux/errno.h>
>  #include <linux/of.h>
>  #include <linux/string.h>
> +#include <linux/acpi.h>
> +
> +#include <asm/cpu_ops.h>
> +#include <asm/smp_plat.h>
>  
>  extern const struct cpu_operations smp_spin_table_ops;
>  extern const struct cpu_operations cpu_psci_ops;
> @@ -49,12 +51,44 @@ static const struct cpu_operations * __init cpu_get_ops(const char *name)
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_ACPI
> +/*
> + * Get a cpu's boot method in the ACPI way.
> + */
> +static char * __init acpi_get_cpu_boot_method(void)
> +{
> +	/*
> +	 * For ACPI 5.1, only two kind of methods are provided,
> +	 * Parking protocol and PSCI, but Parking protocol is
> +	 * specified for ARMv7 only, so make PSCI as the only method
> +	 * for SMP initialization before the ACPI spec or Parking
> +	 * protocol spec is updated.
> +	 */
> +	switch (smp_boot_protocol()) {
> +	case ACPI_SMP_BOOT_PSCI:
> +		return "psci";
> +	case ACPI_SMP_BOOT_PARKING_PROTOCOL:
> +	default:
> +		return NULL;
> +	}
> +}

Actually, do we even need to define smp_boot_protocol()? Is it used
anywhere else apart from this patch (I still haven't gone through all
patches)?

> +#else
> +static inline char * __init acpi_get_cpu_boot_method(void) { return NULL; }
> +#endif
> +
>  /*
> - * Read a cpu's enable method from the device tree and record it in cpu_ops.
> + * Read a cpu's enable method and record it in cpu_ops.
>   */
>  int __init cpu_read_ops(struct device_node *dn, int cpu)
>  {
> -	const char *enable_method = of_get_property(dn, "enable-method", NULL);
> +	const char *enable_method;
> +
> +	if (!acpi_disabled) {
> +		enable_method = acpi_get_cpu_boot_method();
> +		goto get_ops;

Are we always guaranteed an enable_method here? You should have an
if/else of ACPI vs DT and keep the if (!enable_method) check for both
cases.

-- 
Catalin
