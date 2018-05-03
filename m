From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 3 May 2018 14:40:35 -0600
Subject: [PATCH v2 12/27] coresight: tmc-etr: Allow commandline option to
 override SG use
In-Reply-To: <1525165857-11096-13-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-13-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180503204035.GA15555@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2018 at 10:10:42AM +0100, Suzuki K Poulose wrote:
> The Coresight TMC-ETR SG mode could be unsafe on a platform where
> the ETR is not properly connected to account for READ operations.
> We use a DT node property to indicate if the system is safe.
> This patch also provides a command line parameter to "force"
> the use of SG mode to override the firmware information.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Hi
> 
> This is more of a debug patch for people who may want to
> test their platform without too much of hacking. I am not
> too keen on pushing this patch in.

I am not either nor do I personally need it to test this feature.  We can leave
it in for now (and subsequent version) if you need it but we agree that I won't
queue it to my tree when the time comes.

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
>  drivers/hwtracing/coresight/coresight-tmc.c     | 7 ++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 11fc28e..03b51c3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -675,6 +675,14 @@
>  			Enable/disable the CPU sampling based debugging.
>  			0: default value, disable debugging
>  			1: enable debugging at boot time
> +	coresight_tmc.etr_force_sg
> +			[ARM, ARM64]
> +			Format: <bool>
> +			Force using the TMC ETR builtin scatter-gather mode
> +			even when it may be unsafe to use.
> +			Default : 0, do not force using the builtin SG mode.
> +				  1, Allow using the SG, ignoring the firmware
> +				     provided information.
>  
>  	cpuidle.off=1	[CPU_IDLE]
>  			disable the cpuidle sub-system
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index e38379c..c7bc681 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -20,6 +20,7 @@
>  #include <linux/err.h>
>  #include <linux/fs.h>
>  #include <linux/miscdevice.h>
> +#include <linux/module.h>
>  #include <linux/property.h>
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
> @@ -33,6 +34,8 @@
>  #include "coresight-priv.h"
>  #include "coresight-tmc.h"
>  
> +static bool etr_force_sg;
> +
>  void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  {
>  	/* Ensure formatter, unformatter and hardware fifo are empty */
> @@ -307,7 +310,8 @@ const struct attribute_group *coresight_tmc_groups[] = {
>  
>  static inline bool tmc_etr_can_use_sg(struct tmc_drvdata *drvdata)
>  {
> -	return fwnode_property_present(drvdata->dev->fwnode, "scatter-gather");
> +	return etr_force_sg ||
> +	       fwnode_property_present(drvdata->dev->fwnode, "scatter-gather");
>  }
>  
>  /* Detect and initialise the capabilities of a TMC ETR */
> @@ -482,3 +486,4 @@ static struct amba_driver tmc_driver = {
>  	.id_table	= tmc_ids,
>  };
>  builtin_amba_driver(tmc_driver);
> +module_param(etr_force_sg, bool, 0);
> -- 
> 2.7.4
> 
