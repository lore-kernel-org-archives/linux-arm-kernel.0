From: gdavis@mvista.com (George G. Davis)
Date: Fri, 5 Feb 2010 01:01:54 -0500
Subject: [PATCH 2/5] arm/oprofile: reserve the PMU when starting
In-Reply-To: <1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
References: <1263471256-3739-1-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-2-git-send-email-jamie.iles@picochip.com>
	<1263471256-3739-3-git-send-email-jamie.iles@picochip.com>
Message-ID: <20100205060153.GA21979@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 14, 2010 at 12:14:13PM +0000, Jamie Iles wrote:
> Make sure that we have access to the performance counters and
> that they aren't being used by perf events or anything else.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jean Pihet <jpihet@mvista.com>
> Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
> ---
>  arch/arm/oprofile/op_model_arm11_core.c |    4 +-
>  arch/arm/oprofile/op_model_arm11_core.h |    4 +-
>  arch/arm/oprofile/op_model_mpcore.c     |   42 ++++++++++++++++--------------
>  arch/arm/oprofile/op_model_v6.c         |   30 ++++++++++++++--------
>  arch/arm/oprofile/op_model_v7.c         |   30 ++++++++++++++--------
>  arch/arm/oprofile/op_model_v7.h         |    4 +-
>  arch/arm/oprofile/op_model_xscale.c     |   35 ++++++++++++++-----------
>  7 files changed, 85 insertions(+), 64 deletions(-)

// CUT

> diff --git a/arch/arm/oprofile/op_model_mpcore.c b/arch/arm/oprofile/op_model_mpcore.c
> index 4ce0f98..f73ce87 100644
> --- a/arch/arm/oprofile/op_model_mpcore.c
> +++ b/arch/arm/oprofile/op_model_mpcore.c
> @@ -32,6 +32,7 @@
>  /* #define DEBUG */
>  #include <linux/types.h>
>  #include <linux/errno.h>
> +#include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/oprofile.h>
>  #include <linux/interrupt.h>
> @@ -43,6 +44,7 @@
>  #include <mach/hardware.h>
>  #include <mach/board-eb.h>
>  #include <asm/system.h>
> +#include <asm/pmu.h>
>  
>  #include "op_counter.h"
>  #include "op_arm_model.h"
> @@ -58,6 +60,7 @@
>   * Bitmask of used SCU counters
>   */
>  static unsigned int scu_em_used;
> +static const struct pmu_irqs *pmu_irqs;
>  
>  /*
>   * 2 helper fns take a counter number from 0-7 (not the userspace-visible counter number)
> @@ -225,33 +228,40 @@ static int em_setup_ctrs(void)
>  	return 0;
>  }
>  
> -static int arm11_irqs[] = {
> -	[0]	= IRQ_EB11MP_PMU_CPU0,
> -	[1]	= IRQ_EB11MP_PMU_CPU1,
> -	[2]	= IRQ_EB11MP_PMU_CPU2,
> -	[3]	= IRQ_EB11MP_PMU_CPU3
> -};
> -
>  static int em_start(void)
>  {
>  	int ret;
>  
> -	ret = arm11_request_interrupts(arm11_irqs, ARRAY_SIZE(arm11_irqs));
> +	pmu_irqs = reserve_pmu();
> +	if (IS_ERR(pmu_irqs)) {
> +		ret = PTR_ERR(pmu_irqs);
> +		goto out;
> +	}
> +
> +	ret = arm11_request_interrupts(pmu_irqs->irqs, pmu_irqs->num_irqs);
>  	if (ret == 0) {
>  		em_call_function(arm11_start_pmu);
>  
>  		ret = scu_start();
> -		if (ret)
> -			arm11_release_interrupts(arm11_irqs, ARRAY_SIZE(arm11_irqs));
> +		if (ret) {
> +			arm11_release_interrupts(pmu_irqs->irqs,
> +						 pmu_irqs->num_irqs);
> +		} else {
> +			release_pmu(pmu_irqs);
> +			pmu_irqs = NULL;
> +		}
>  	}
> +
> +out:
>  	return ret;
>  }

The "} else {" clause above broke OProfile on ARM11 MPCore.  Here's a
trivial fix tested on ARM Ltd. RealView EB ARM11 MPCore:
