From: phil@raspberrypi.org (Phil Elwell)
Date: Fri, 14 Sep 2018 11:26:55 +0100
Subject: [PATCH 1/2] staging/vc04_services: Derive g_cache_line_size
In-Reply-To: <107b707e-1f8c-1305-2582-0a131011758d@i2se.com>
References: <1536770554-107314-1-git-send-email-phil@raspberrypi.org>
 <1536770554-107314-2-git-send-email-phil@raspberrypi.org>
 <107b707e-1f8c-1305-2582-0a131011758d@i2se.com>
Message-ID: <2f836805-79dc-adee-e2b7-21c45781afff@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 14/09/2018 11:11, Stefan Wahren wrote:
> Hi Phil,
> 
> Am 12.09.2018 um 18:42 schrieb Phil Elwell:
>> The ARM coprocessor registers include dcache line size, but there is no
>> function to expose this value. Rather than create a new one, use the
>> read_cpuid_id function to derive the correct value, which is 32 for
>> BCM2835 and 64 for BCM2836/7.
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> ---
>>  .../interface/vchiq_arm/vchiq_2835_arm.c           | 24 +++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> index e767209..3537f60 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>> @@ -42,6 +42,7 @@
>>  #include <linux/uaccess.h>
>>  #include <linux/mm.h>
>>  #include <linux/of.h>
>> +#include <asm/cputype.h>
>>  #include <soc/bcm2835/raspberrypi-firmware.h>
>>  
>>  #define TOTAL_SLOTS (VCHIQ_SLOT_ZERO_SLOTS + 2 * 32)
>> @@ -81,13 +82,15 @@ static void __iomem *g_regs;
>>   * VPU firmware, which determines the required alignment of the
>>   * offsets/sizes in pagelists.
>>   *
>> - * Modern VPU firmware looks for a DT "cache-line-size" property in
>> - * the VCHIQ node and will overwrite it with the actual L2 cache size,
>> + * Previous VPU firmware looked for a DT "cache-line-size" property in
>> + * the VCHIQ node and would overwrite it with the actual L2 cache size,
>>   * which the kernel must then respect.  That property was rejected
>> - * upstream, so we have to use the VPU firmware's compatibility value
>> - * of 32.
>> + * upstream, so we now rely on both sides to "do the right thing" independently
>> + * of the other. To improve backwards compatibility, this new behaviour is
>> + * signalled to the firmware by the use of a corrected "reg" property on the
>> + * relevant Device Tree node.
>>   */
>> -static unsigned int g_cache_line_size = 32;
>> +static unsigned int g_cache_line_size;
>>  static unsigned int g_fragments_size;
>>  static char *g_fragments_base;
>>  static char *g_free_fragments;
>> @@ -127,6 +130,17 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
>>  	if (err < 0)
>>  		return err;
>>  
>> +	/*
>> +	 * The tempting L1_CACHE_BYTES macro doesn't work in the case of
>> +	 * a kernel built with bcm2835_defconfig running on a BCM2836/7
>> +	 * processor, hence the need for a runtime check. The dcache line size
>> +	 * is encoded in one of the coprocessor registers, but there is no
>> +	 * convenient way to access it short of embedded assembler, hence
>> +	 * the use of read_cpuid_id(). The following test evaluates to true
>> +	 * on a BCM2835 showing that it is ARMv6-ish, whereas
>> +	 * cpu_architecture() will indicate that it is an ARMv7.
>> +	 */
>> +	g_cache_line_size = ((read_cpuid_id() & 0x7f000) == 0x7b000) ? 32 : 64;
> 
> is there a chance to use ARM_CPU_PART_ARM1176 or something else instead
> of this magic numbers?

One could. It's a trade-off between specific and human-readable vs. generic and less-so,
and possibly moot given the next question.

> Sorry, i cannot remember the whole discussion but why we can use
> different compatible here instead of using ARM specific stuff.
> 
> compatible = "brcm,bcm2836-vchiq", "brcm,bcm2835-vchiq"; // for BCM2836/7
> 
> compatible = "brcm,bcm2835"; // only for BCM2835

It wasn't an option you raised in the offline discussion. Assuming you meant
"brcm,bcm2835-vchiq", I suppose you could think of it as being a different type
of device if that is more acceptable.

>>  	g_fragments_size = 2 * g_cache_line_size;
>>  
>>  	/* Allocate space for the channels in coherent memory */
