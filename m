From: tnowicki@caviumnetworks.com (Tomasz Nowicki)
Date: Thu, 6 Sep 2018 10:55:33 +0200
Subject: [PATCH 1/1] coresight: etm4x: Configure EL2 exception level when
 kernel is running in HYP
In-Reply-To: <20180905203436.GA16793@xps15>
References: <20180904142034.19116-1-tnowicki@caviumnetworks.com>
 <20180905203436.GA16793@xps15>
Message-ID: <43b83d91-8cec-9926-5856-a4a5655711cb@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On 05.09.2018 22:34, Mathieu Poirier wrote:
> Hi Tomasz,
> 
> On Tue, Sep 04, 2018 at 04:20:34PM +0200, Tomasz Nowicki wrote:
>> For non-VHE systems host kernel runs at EL1 and jumps to EL2 whenever
>> hypervisor code should be executed. In this case ETM4x driver must
>> restrict configuration to EL1 when it setups kernel tracing.
>> However, there is no separate hypervisor privilege level when VHE
>> is enabled, the host kernel runs at EL2.
>>
>> This patch fixes configuration of TRCACATRn register for VHE systems
>> so that ETM_EXLEVEL_NS_HYP bit is used instead of ETM_EXLEVEL_NS_OS
>> to on/off kernel tracing. At the same time, it moves common code
>> to new helper.
>>
>> Signed-off-by: Tomasz Nowicki <tnowicki@caviumnetworks.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.c | 39 ++++++++++---------
>>   1 file changed, 20 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>> index f79b0ea85d76..5f495c942f99 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <asm/sections.h>
>>   #include <asm/local.h>
>> +#include <asm/virt.h>
>>
>>   #include "coresight-etm4x.h"
>>   #include "coresight-etm-perf.h"
>> @@ -606,7 +607,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
>>        config->vinst_ctrl |= BIT(0);
>>   }
>>
>> -static u64 etm4_get_access_type(struct etmv4_config *config)
>> +static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>>   {
>>        u64 access_type = 0;
>>
>> @@ -617,17 +618,27 @@ static u64 etm4_get_access_type(struct etmv4_config *config)
>>         *   Bit[13] Exception level 1 - OS
>>         *   Bit[14] Exception level 2 - Hypervisor
>>         *   Bit[15] Never implemented
>> -      *
>> -      * Always stay away from hypervisor mode.
>>         */
>> -     access_type = ETM_EXLEVEL_NS_HYP;
>>
> 
> Extra space
> 
>> -     if (config->mode & ETM_MODE_EXCL_KERN)
>> -             access_type |= ETM_EXLEVEL_NS_OS;
>> +     if (!is_kernel_in_hyp_mode()) {
>> +             /* Stay away from hypervisor mode for non-VHE */
>> +             access_type =  ETM_EXLEVEL_NS_HYP;
>> +             if (config->mode & ETM_MODE_EXCL_KERN)
>> +                     access_type |= ETM_EXLEVEL_NS_OS;
>> +     } else if (config->mode & ETM_MODE_EXCL_KERN) {
>> +             access_type = ETM_EXLEVEL_NS_HYP;
>> +     }
>>
>>        if (config->mode & ETM_MODE_EXCL_USER)
>>                access_type |= ETM_EXLEVEL_NS_APP;
>>
>> +     return access_type;
>> +}
>> +
>> +static u64 etm4_get_access_type(struct etmv4_config *config)
>> +{
>> +     u64 access_type = etm4_get_ns_access_type(config);
>> +
>>        /*
>>         * EXLEVEL_S, bits[11:8], don't trace anything happening
>>         * in secure state.
>> @@ -881,20 +892,10 @@ void etm4_config_trace_mode(struct etmv4_config *config)
>>
>>        addr_acc = config->addr_acc[ETM_DEFAULT_ADDR_COMP];
>>        /* clear default config */
>> -     addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS);
>> +     addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS |
>> +                     ETM_EXLEVEL_NS_HYP);
> 
> Indentation problems
> 
>>
>> -     /*
>> -      * EXLEVEL_NS, bits[15:12]
>> -      * The Exception levels are:
>> -      *   Bit[12] Exception level 0 - Application
>> -      *   Bit[13] Exception level 1 - OS
>> -      *   Bit[14] Exception level 2 - Hypervisor
>> -      *   Bit[15] Never implemented
>> -      */
>> -     if (mode & ETM_MODE_EXCL_KERN)
>> -             addr_acc |= ETM_EXLEVEL_NS_OS;
>> -     else
>> -             addr_acc |= ETM_EXLEVEL_NS_APP;
>> +     addr_acc |= etm4_get_ns_access_type(config);
>>
>>        config->addr_acc[ETM_DEFAULT_ADDR_COMP] = addr_acc;
>>        config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] = addr_acc;
> 
> I tested your patch on my side and it didn't break kernel space decoding.
> 
> Since it would have taken longer to ask you to respin than to make the changes
> myself, I applied your patch with the above modifications.
> 

Thank you for comments and corresponding fixes in the patch.

Tomasz
