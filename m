From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 12 Oct 2017 10:58:01 +0800
Subject: [PATCH 1/2] drivers: firmware: psci: Add psci_is_available()
In-Reply-To: <1507708982-12336-2-git-send-email-geert+renesas@glider.be>
References: <1507708982-12336-1-git-send-email-geert+renesas@glider.be>
 <1507708982-12336-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20171012105801.0bb643eb@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Oct 2017 10:03:01 +0200 Geert Uytterhoeven wrote:

> PSCI support may be disabled at build time (by configuration) or at
> run-time (PSCI firmware not present).  While CONFIG_ARM_PSCI_FW can be
> used to check for build time enablement, there is currently no simple
> way to check if PSCI is actually available and used.
> 
> Hence add a helper function to check if PSCI is available.
> 
> This is useful for e.g. drivers that are used on platforms with and
> without PSCI.  Such drivers may need to take provisions for proper
> operation when PSCI is used, and/or to implement functionality that is
> usually provided by PSCI.

the psci_ops is a global var, why not check psci_ops.mmnn members
individually in each drivers? check IS_ENABLED(CONFIG_ARM_PSCI_FW) for
building time ennoblement.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/firmware/psci.c | 5 +++++
>  include/linux/psci.h    | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index da469c972b503f83..a3a11e2d8ffffaaa 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -670,6 +670,11 @@ int __init psci_dt_init(void)
>  	return init_fn(np);
>  }
>  
> +bool psci_is_available(void)
> +{
> +	return psci_ops.cpu_off && psci_ops.cpu_on && psci_ops.cpu_suspend;

IIRC, for PSCI 0.1, cpu_suspend is optional, we can't say the PSCI isn't
available if cpu_suspend is missing.

Thanks
