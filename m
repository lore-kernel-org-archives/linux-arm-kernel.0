From: will.deacon@arm.com (Will Deacon)
Date: Mon, 2 Nov 2015 11:55:39 +0000
Subject: [PATCH v6 2/6] drivers: psci: replace psci firmware calls
In-Reply-To: <1446106888-8983-3-git-send-email-jens.wiklander@linaro.org>
References: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
 <1446106888-8983-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20151102115539.GC29657@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 09:21:24AM +0100, Jens Wiklander wrote:
> Switch to use a generic interface for issuing SMC/HVC based on ARM SMC
> Calling Convention. Removes now the now unused psci-call.S.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  arch/arm/kernel/Makefile      |  1 -
>  arch/arm/kernel/psci-call.S   | 31 -------------------------------
>  arch/arm64/kernel/Makefile    |  2 +-
>  arch/arm64/kernel/psci-call.S | 28 ----------------------------
>  drivers/firmware/psci.c       | 21 +++++++++++++++++++--
>  5 files changed, 20 insertions(+), 63 deletions(-)
>  delete mode 100644 arch/arm/kernel/psci-call.S
>  delete mode 100644 arch/arm64/kernel/psci-call.S

[...]

> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 42700f0..53c9606 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -19,6 +19,7 @@
>  #include <linux/pm.h>
>  #include <linux/printk.h>
>  #include <linux/psci.h>
> +#include <linux/arm-smccc.h>
>  #include <linux/reboot.h>
>  
>  #include <uapi/linux/psci.h>
> @@ -56,8 +57,6 @@ struct psci_operations psci_ops;
>  
>  typedef unsigned long (psci_fn)(unsigned long, unsigned long,
>  				unsigned long, unsigned long);
> -asmlinkage psci_fn __invoke_psci_fn_hvc;
> -asmlinkage psci_fn __invoke_psci_fn_smc;
>  static psci_fn *invoke_psci_fn;
>  
>  enum psci_function {
> @@ -70,6 +69,24 @@ enum psci_function {
>  
>  static u32 psci_function_id[PSCI_FN_MAX];
>  
> +static unsigned long __invoke_psci_fn_hvc(unsigned long a0, unsigned long a1,
> +			unsigned long a2, unsigned long a3)

Minor comment, but could we keep these argument names the same as before
please?

> +{
> +	struct smccc_res res;
> +
> +	smccc_hvc(a0, a1, a2, a3, 0, 0, 0, 0, &res);

It's slightly tempting to use varargs instead of the '0' argument padding,
but that will probably make the asm code unmanageable.

Will
