From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 1 May 2018 10:59:07 -0700
Subject: [PATCH] firmware/psci: add support for SYSTEM_RESET2
In-Reply-To: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <ef2f0c7c-eb2d-157d-e215-ced1ce984aa5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2018 07:51 AM, Sudeep Holla wrote:
> PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
> where the semantics are described by the PSCI specification itself as
> well as vendor-specific resets. Currently only system warm reset
> semantics is defined as part of architectural resets by the specification.
> 
> This patch implements support for SYSTEM_RESET2 by making using of
> reboot_mode passed by the reboot infrastructure in the kernel.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/psci.c   | 21 +++++++++++++++++++++
>  include/uapi/linux/psci.h |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index c80ec1d03274..216b1950bbd5 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
> 
>  static u32 psci_cpu_suspend_feature;
> +bool psci_system_reset2_supported;

Should this be static? It does not appear to be used in another
translation unit.

> 
>  static inline bool psci_has_ext_power_state(void)
>  {
> @@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)
> 
>  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>  {
> +	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
> +	    psci_system_reset2_supported)
> +		/*
> +		 * reset_type[31] = 0 (architectural)
> +		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
> +		 * cookie = 0 (ignored by the implementation

Missing closing parenthesis

> +		 */
> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);

-- 
Florian
