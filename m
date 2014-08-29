From: msalter@redhat.com (Mark Salter)
Date: Fri, 29 Aug 2014 11:57:50 -0400
Subject: [PATCH 2/2] efi/arm64: use UEFI for system reset
In-Reply-To: <1409324757-12607-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1409324757-12607-1-git-send-email-ard.biesheuvel@linaro.org>
 <1409324757-12607-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1409327870.9919.41.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-08-29 at 17:05 +0200, Ard Biesheuvel wrote:
> If UEFI Runtime Services are available, they are preferred over direct
> PSCI calls or other methods to reset the system.
> 
> For the reset case, we need to hook into machine_restart(), as the
> arm_pm_restart function pointer may be overwritten by modules.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/process.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 1309d64aa926..335a93da5eeb 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c

I get:

  arch/arm64/kernel/process.c: In function ?machine_restart?:
  arch/arm64/kernel/process.c:188:2: error: implicit declaration of function ?efi_reboot?

unless I add

  #include <linux/efi.h>


> @@ -177,6 +177,13 @@ void machine_restart(char *cmd)
>  	local_irq_disable();
>  	smp_send_stop();
>  
> +	/*
> +	 * arm_pm_restart is exported to modules, so the only way to supersede
> +	 * it with efi_reboot() is to call it here.
> +	 */
> +	if (IS_ENABLED(CONFIG_EFI) && efi_enabled(EFI_RUNTIME_SERVICES))
This test isn't necessary.

> +		efi_reboot(REBOOT_WARM, NULL);

Why not pass reboot_mode instead?

> +
>  	/* Now call the architecture specific reboot code. */
>  	if (arm_pm_restart)
>  		arm_pm_restart(reboot_mode, cmd);
