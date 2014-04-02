From: monstr@monstr.eu (Michal Simek)
Date: Wed, 02 Apr 2014 14:15:37 +0200
Subject: [PATCH 06/10] ARM: EXYNOS: Add support for mapping PMU base
 address via DT
In-Reply-To: <533BF905.6070701@samsung.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1396425058-4012-7-git-send-email-pankaj.dubey@samsung.com>
 <533BF905.6070701@samsung.com>
Message-ID: <533BFF69.1060701@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2014 01:48 PM, Sylwester Nawrocki wrote:
> On 02/04/14 09:50, Pankaj Dubey wrote:
>> From: Young-Gun Jang <yg1004.jang@samsung.com>
>>
>> Add support for mapping Exynos Power Management Unit (PMU) base address
>> from device tree. Code will use existing samsung pmu binding information.
>> This patch also adds "get_exynos_pmubase" a helper function to return mapped base
>> address to various other files under "mach-exynos".
>>
>> Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  arch/arm/mach-exynos/common.h |    2 ++
>>  arch/arm/mach-exynos/exynos.c |   44 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>
> [...]
>>  #endif /* __ARCH_ARM_MACH_EXYNOS_COMMON_H */
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index a5e1349..a5127fb 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -35,6 +35,8 @@
>>  #define L2_AUX_VAL 0x7C470001
>>  #define L2_AUX_MASK 0xC200ffff
>>  
>> +static void __iomem *exynos_pmu_base __initdata;
>> +
>>  static struct map_desc exynos4_iodesc[] __initdata = {
>>  	{
>>  		.virtual	= (unsigned long)S3C_VA_SYS,
>> @@ -245,6 +247,47 @@ void __init exynos_init_late(void)
>>  	exynos_pm_init();
>>  }
>>  
>> +static char const *exynos_dt_pmu_match[] __initconst = {
>> +	"samsung,exynos4210-pmu",
>> +	"samsung,exynos4212-pmu",
>> +	"samsung,exynos4412-pmu",
>> +	"samsung,exynos5250-pmu",
>> +	NULL
>> +};
>> +
>> +static int __init exynos_fdt_map_pmu(unsigned long node,
>> +		const char *uname, int depth, void *data)
>> +{
>> +	struct map_desc iodesc;
>> +	__be32 *reg;
>> +	unsigned long len;
>> +
>> +	if (of_flat_dt_match(node, exynos_dt_pmu_match)) {
>> +		phys_addr_t phys_addr;
>> +		reg = of_get_flat_dt_prop(node, "reg", &len);
>> +		if (reg == NULL || len != (sizeof(unsigned long) * 2))
>> +			return 0;
>> +
>> +		phys_addr = be32_to_cpu(reg[0]);
>> +		iodesc.pfn = __phys_to_pfn(phys_addr);
>> +		iodesc.length = be32_to_cpu(reg[1]) - 1;
>> +		iodesc.virtual = (unsigned long)S5P_VA_PMU;
>> +		iodesc.type = MT_DEVICE;
>> +		iotable_init(&iodesc, 1);
> 
> Are you sure...you need this in addition to ioremap() below ?
> Can't you just use the Linux syscon API ?
> There were some patches posted for syscon to make it available in earlier
> system initialization stage: https://lkml.org/lkml/2014/2/19/218

I haven't finished this yet. I have to look at it again.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140402/cb3ab19d/attachment.sig>
