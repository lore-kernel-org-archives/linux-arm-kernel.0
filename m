From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 17 Mar 2018 11:11:06 -0500
Subject: [PATCH v2] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
In-Reply-To: <20180317133445.772733ac@why.wild-wind.fr.eu.org>
References: <1521124287-25009-1-git-send-email-shankerd@codeaurora.org>
 <20180317133445.772733ac@why.wild-wind.fr.eu.org>
Message-ID: <dccddaa7-6331-961d-a77f-15dc15cd8850@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/17/2018 08:34 AM, Marc Zyngier wrote:
> On Thu, 15 Mar 2018 09:31:27 -0500
> Shanker Donthineni <shankerd@codeaurora.org> wrote:
> 
>> The definition of the GICR_CTLR.RWP control bit was expanded to indicate
>> status of changing GICR_CTLR.EnableLPI from 1 to 0 is being in progress
>> or completed. Software must observe GICR_CTLR.RWP==0 after clearing
>> GICR_CTLR.EnableLPI from 1 to 0 and before writing GICR_PENDBASER and/or
>> GICR_PROPBASER, otherwise behavior is UNPREDICTABLE.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>> Changes since v1:
>>   -Moved LPI disable code to a seperate function as Marc suggested.
>>   -Mark's suggestion to use readl_relaxed_poll_timeout() helper functions.
>>   
>>  drivers/irqchip/irq-gic-v3-its.c   | 66 ++++++++++++++++++++++++++++++--------
>>  include/linux/irqchip/arm-gic-v3.h |  1 +
>>  2 files changed, 53 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 1d3056f..cba71a7 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -33,6 +33,8 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/percpu.h>
>>  #include <linux/slab.h>
>> +#include <linux/time64.h>
>> +#include <linux/iopoll.h>
>>  
>>  #include <linux/irqchip.h>
>>  #include <linux/irqchip/arm-gic-v3.h>
>> @@ -1875,16 +1877,6 @@ static void its_cpu_init_lpis(void)
>>  		gic_data_rdist()->pend_page = pend_page;
>>  	}
>>  
>> -	/* Disable LPIs */
>> -	val = readl_relaxed(rbase + GICR_CTLR);
>> -	val &= ~GICR_CTLR_ENABLE_LPIS;
>> -	writel_relaxed(val, rbase + GICR_CTLR);
>> -
>> -	/*
>> -	 * Make sure any change to the table is observable by the GIC.
>> -	 */
>> -	dsb(sy);
>> -
>>  	/* set PROPBASE */
>>  	val = (page_to_phys(gic_rdists->prop_page) |
>>  	       GICR_PROPBASER_InnerShareable |
>> @@ -3288,13 +3280,59 @@ static bool gic_rdists_supports_plpis(void)
>>  	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
>>  }
>>  
>> +static int redist_disable_lpis(void)
>> +{
>> +	void __iomem *rbase = gic_data_rdist_rd_base();
>> +	u64 val;
>> +	int ret;
>> +
>> +	if (!gic_rdists_supports_plpis()) {
>> +		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
>> +		return -ENXIO;
>> +	}
>> +
>> +	val = readl_relaxed(rbase + GICR_CTLR);
>> +	if (!(val & GICR_CTLR_ENABLE_LPIS))
>> +		return 0;
>> +
>> +	/* Disable LPIs */
>> +	val &= ~GICR_CTLR_ENABLE_LPIS;
>> +	writel_relaxed(val, rbase + GICR_CTLR);
>> +
>> +	/* Make sure any change to GICR_CTLR is observable by the GIC */
>> +	dsb(sy);
>> +
>> +	/* Wait for GICR_CTLR.GICR_CTLR_ENABLE_LPIS==0 or timeout */
>> +	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
>> +					 !(val & GICR_CTLR_ENABLE_LPIS), 1,
>> +					 USEC_PER_SEC);
> 
> Why do you need to poll on EnableLPIs? It is supposed to be immediately
> written. It seems to me that the sequence should be:
> 

Agree we don't need to poll EnableLPIs here. I'll remove.

> - Check EnableLPis
> - If set to 1, scream about bootloader being braindead
> - Write EnableLPIs to 0
> - Read back EnableLpis:
> - If still set 1, bail out, we're doomed. Scream about the HW being
>   braindead
> - Poll RWP
> - If timeout, bail out, the HW has locked up. Scream again.
> 
> I think this should cover the whole thing. An alternative would be to
> place the poll between the write and read-back, but that doesn't change
> anything.
> 

I'll prefer your second approach. Please comment on the below change before
I post v3.

static int redist_disable_lpis(void)
{
        void __iomem *rbase = gic_data_rdist_rd_base();
        u64 val;
        int ret;

        if (!gic_rdists_supports_plpis()) {
                pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
                return -ENXIO;
        }

        if (!(readl(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS))
                return 0;

        pr_warn("CPU%d: Trying to disable LPIs\n", smp_processor_id());
        val &= ~GICR_CTLR_ENABLE_LPIS;
        writel_relaxed(val, rbase + GICR_CTLR);

        /* Make sure any change to GICR_CTLR is observable by the GIC */
        dsb(sy);

        /**
         * Software must observe RWP==0 after clearing GICR_CTLR.EnableLPIs
         * from 1 to 0 before programming GICR_PEND{PROP}BASER registers.
         * Bail out the driver probe() in case of timeout.
         */
        ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
                                                !(val & GICR_CTLR_RWP), 1,
                                                USEC_PER_SEC);
        if (ret) {
                pr_err("CPU%d: EnableLPIs not observed\n", smp_processor_id());
                return ret;
        }
 
        /**
         * After it has been written to 1, it is IMPLEMENTATION DEFINED whether
         * the bit GICR_CTLR.EnableLPI becomes RES1 or can be cleared to 0.
         * Bail out the driver probe() on systems where it's RES1.
         */
        if (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS) {
                pr_err("CPU%d: Failed to disable LPIs\n", smp_processor_id());
                return -EPERM;
        }

        return 0;
}
 
>> +	if (ret) {
>> +		pr_err("CPU%d: Failed to disable LPIs\n", smp_processor_id());
>> +		return -EBUSY;
>> +	}
>> +
>> +	/* Wait for GICR_CTLR.RWP==0 or timeout */
>> +	ret = readl_relaxed_poll_timeout_atomic(rbase + GICR_CTLR, val,
>> +					 !(val & GICR_CTLR_RWP), 1,
>> +					 USEC_PER_SEC);
>> +	if (ret) {
>> +		pr_err("CPU%d: Failed to observe RWP==0 after enabling LPIs\n",
>> +		       smp_processor_id());
>> +		return -EBUSY;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  int its_cpu_init(void)
>>  {
>> +	int ret;
>> +
>>  	if (!list_empty(&its_nodes)) {
> 
> nit: move 'ret' here.
> 
>> -		if (!gic_rdists_supports_plpis()) {
>> -			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
>> -			return -ENXIO;
>> -		}
>> +		ret = redist_disable_lpis();
>> +		if (ret)
>> +			return ret;
>> +
>>  		its_cpu_init_lpis();
>>  		its_cpu_init_collection();
>>  	}
>> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
>> index c00c4c33..4d5fb60 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -106,6 +106,7 @@
>>  #define GICR_PIDR2			GICD_PIDR2
>>  
>>  #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
>> +#define GICR_CTLR_RWP			(1UL << 3)
>>  
>>  #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
>>  
> 
> Thanks,
> 
> 	M.
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
