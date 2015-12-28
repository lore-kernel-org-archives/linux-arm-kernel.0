From: frowand.list@gmail.com (Frank Rowand)
Date: Mon, 28 Dec 2015 13:01:22 -0800
Subject: [PATCH 1/5] arm: devtree: Set system_rev from DT "/revision"
In-Reply-To: <20151224190237.GA17343@pali>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <1436214373-12969-2-git-send-email-pali.rohar@gmail.com>
 <20151224190237.GA17343@pali>
Message-ID: <5681A322.2090204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding devicetree-spec, and commenting below.

On 12/24/2015 11:02 AM, Pali Roh?r wrote:
> On Monday 06 July 2015 22:26:09 Pali Roh?r wrote:
>> With this patch "/revision" DT entry is used to set global system_rev
>> variable. DT "/revision" is expected to be u32 numeric value.
>>
>> TODO: add documentation
>>
>> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
>> ---
>>  arch/arm/kernel/devtree.c |   12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
>> index 11c54de..7d82749 100644
>> --- a/arch/arm/kernel/devtree.c
>> +++ b/arch/arm/kernel/devtree.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/of_irq.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/smp.h>
>> +#include <linux/libfdt_env.h>
>>  
>>  #include <asm/cputype.h>
>>  #include <asm/setup.h>
>> @@ -26,6 +27,7 @@
>>  #include <asm/smp_plat.h>
>>  #include <asm/mach/arch.h>
>>  #include <asm/mach-types.h>
>> +#include <asm/system_info.h>
>>  
>>  
>>  #ifdef CONFIG_SMP
>> @@ -204,6 +206,8 @@ static const void * __init arch_get_next_mach(const char *const **match)
>>  const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>>  {
>>  	const struct machine_desc *mdesc, *mdesc_best = NULL;
>> +	unsigned long dt_root;
>> +	const u32 *rev;
>>  
>>  #ifdef CONFIG_ARCH_MULTIPLATFORM
>>  	DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
>> @@ -215,17 +219,16 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>>  	if (!dt_phys || !early_init_dt_verify(phys_to_virt(dt_phys)))
>>  		return NULL;
>>  
>> +	dt_root = of_get_flat_dt_root();
>>  	mdesc = of_flat_dt_match_machine(mdesc_best, arch_get_next_mach);
>>  
>>  	if (!mdesc) {
>>  		const char *prop;
>>  		int size;
>> -		unsigned long dt_root;
>>  
>>  		early_print("\nError: unrecognized/unsupported "
>>  			    "device tree compatible list:\n[ ");
>>  
>> -		dt_root = of_get_flat_dt_root();
>>  		prop = of_get_flat_dt_prop(dt_root, "compatible", &size);
>>  		while (size > 0) {
>>  			early_print("'%s' ", prop);
>> @@ -246,5 +249,10 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>>  	/* Change machine number to match the mdesc we're using */
>>  	__machine_arch_type = mdesc->nr;
>>  
>> +	/* Set system revision from DT */
>> +	rev = of_get_flat_dt_prop(dt_root, "revision", NULL);
>> +	if (rev)
>> +		system_rev = fdt32_to_cpu(*rev);
>> +
>>  	return mdesc;
>>  }
> 
> This patch and second one (with subject "[PATCH 2/5] arm: boot: convert
> ATAG_REVISION to DT "/revision" entry") are still needed.
> 
> Are there any objections for them? If not, I will add missing DT
> documentation and will resend them.

Patch 2/5 copies the value from ATAG_REVISION into the fdt "/revision"
property.

If the use of /revision is limited to being a location to hold an ATAG
value to pass to the global variable system_rev, then it would make
sense to just copy directly from the ATAG value into system_rev in the
same board file where you are copying the ATAGs.

-Frank
