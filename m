From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 14 Jun 2017 12:27:17 +0000
Subject: [PATCH v7 02/10] staging: fsl-mc: fix macros with possible side
 effects
In-Reply-To: <20170613101225.GA27165@kroah.com>
References: <20170608142855.10455-1-laurentiu.tudor@nxp.com>
 <20170608142855.10455-3-laurentiu.tudor@nxp.com>
 <20170613101225.GA27165@kroah.com>
Message-ID: <59412B9D.10905@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/13/2017 01:12 PM, Greg KH wrote:
> On Thu, Jun 08, 2017 at 05:28:47PM +0300, laurentiu.tudor at nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> Several macros were triggering this checkpatch.pl warning:
>>    "Macro argument reuse '$arg' - possible side-effects?"
>> Fix the warning by avoiding multiple macro argument use.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>
>> Notes:
>>      -v7
>>        -no changes
>>
>>   drivers/staging/fsl-mc/bus/dprc-driver.c      | 10 +++++++---
>>   drivers/staging/fsl-mc/bus/fsl-mc-allocator.c | 11 +++++++----
>>   2 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/staging/fsl-mc/bus/dprc-driver.c
>> index d723c69..39c9a3b 100644
>> --- a/drivers/staging/fsl-mc/bus/dprc-driver.c
>> +++ b/drivers/staging/fsl-mc/bus/dprc-driver.c
>> @@ -21,9 +21,13 @@
>>
>>   #define FSL_MC_DPRC_DRIVER_NAME    "fsl_mc_dprc"
>>
>> -#define FSL_MC_DEVICE_MATCH(_mc_dev, _obj_desc) \
>> -	(strcmp((_mc_dev)->obj_desc.type, (_obj_desc)->type) == 0 && \
>> -	 (_mc_dev)->obj_desc.id == (_obj_desc)->id)
>> +#define FSL_MC_DEVICE_MATCH(_mc_dev, _obj_desc)				\
>> +({									\
>> +	struct fsl_mc_device *__mc_dev = _mc_dev;			\
>> +	struct dprc_obj_desc *__obj_desc = _obj_desc;			\
>> +	(strcmp(__mc_dev->obj_desc.type, __obj_desc->type) == 0 &&	\
>> +	__mc_dev->obj_desc.id == __obj_desc->id);			\
>> +})
>
> Ick, no.  Just make this a real function please.
>
>>
>>   struct dprc_child_objs {
>>   	int child_count;
>> diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
>> index ce07096..d3def40 100644
>> --- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
>> +++ b/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
>> @@ -17,10 +17,13 @@
>>   #include "dpcon-cmd.h"
>>   #include "fsl-mc-private.h"
>>
>> -#define FSL_MC_IS_ALLOCATABLE(_obj_type) \
>> -	(strcmp(_obj_type, "dpbp") == 0 || \
>> -	 strcmp(_obj_type, "dpmcp") == 0 || \
>> -	 strcmp(_obj_type, "dpcon") == 0)
>> +#define FSL_MC_IS_ALLOCATABLE(_obj_type)	\
>> +({						\
>> +	const char *__obj_type = _obj_type;	\
>> +	(strcmp(__obj_type, "dpbp") == 0 ||	\
>> +	 strcmp(__obj_type, "dpmcp") == 0 ||	\
>> +	 strcmp(__obj_type, "dpcon") == 0);	\
>> +})
>
> Same here.  Don't put real logic in a #define, it never makes sense to
> do it and only makes things much harder to debug.
>

Ok, will do. Lets drop this patch and i'll send another one changing all 
these to functions.

---
Thanks & Best Regards, Laurentiu
