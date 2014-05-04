From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Sun, 4 May 2014 20:47:41 +0530
Subject: [PATCH v2 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM
 bindings
In-Reply-To: <5363DBD0.2060903@gmail.com>
References: <1399007180-20680-1-git-send-email-sachin.kamat@linaro.org>
 <5363DBD0.2060903@gmail.com>
Message-ID: <CAK9yfHzNijGLuikqPLUTxk52jF2P7Yugqn7oGQbyrHCJidKNqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 2 May 2014 23:24, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Sachin,
>
> The whole series looks quite good,

Thanks :)

>but I have one concern about support for
> Universal C210 board. Please see my comment inline.
>
>
> On 02.05.2014 07:06, Sachin Kamat wrote:
>>
>> Instead of hardcoding the SYSRAM details for each SoC,
>> pass this information through device tree (DT) and make
>> the code SoC agnostic. Generic SRAM bindings are used
>> for achieving this.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>> This patch is based on linux next (next-20140501) on top of
>> my Kconfig consolidation patch
>> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/28642
>>
>> Changes since v1:
>> Type and presence of sram nodes is SoC/board dependent. V1 mandated the
>> presence of both the nodes and used to return an error if one of the
>> nodes was absent and thus fail the boot altogether. Removed this
>> dependency.
>>
>> Tested on 4210/4412 Origen, 5250/5420 Arndale and SMDK5420 boards.
>> ---
>>   arch/arm/Kconfig                                |    1 +
>>   arch/arm/boot/dts/exynos4210-universal_c210.dts |   17 ++++++
>>   arch/arm/boot/dts/exynos4210.dtsi               |   18 +++++++
>>   arch/arm/boot/dts/exynos4x12.dtsi               |   18 +++++++
>>   arch/arm/boot/dts/exynos5250.dtsi               |   18 +++++++
>>   arch/arm/boot/dts/exynos5420.dtsi               |   18 +++++++
>>   arch/arm/mach-exynos/common.h                   |    1 +
>>   arch/arm/mach-exynos/exynos.c                   |   64
>> -----------------------
>>   arch/arm/mach-exynos/firmware.c                 |    8 ++-
>>   arch/arm/mach-exynos/include/mach/map.h         |    7 ---
>>   arch/arm/mach-exynos/platsmp.c                  |   33 ++++++++++--
>>   11 files changed, 128 insertions(+), 75 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index a6aaaad19b1a..f66ea9453df9 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -855,6 +855,7 @@ config ARCH_EXYNOS
>>         select S5P_DEV_MFC
>>         select SAMSUNG_DMADEV
>>         select SPARSE_IRQ
>> +       select SRAM
>>         select USE_OF
>>         help
>>           Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
>> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> index 63e34b24b04f..8d4de5c0d0c7 100644
>> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
>> @@ -28,6 +28,23 @@
>>                 bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5
>> rw rootwait earlyprintk panic=5 maxcpus=1";
>>         };
>>
>> +       sram at 02020000 {
>> +               status = "disabled";
>
>
> Here you just disable just the top level node of non-secure SYSRAM, but the
> sub-nodes are still present and enabled.

I was under the impression that disabling parent node would also
disable the sub-nodes.
I will disable all of them in this case.

>
>
>> +       };
>> +
>> +       sram at 02025000 {
>> +               compatible = "mmio-sram";
>> +               reg = <0x02025000 0x1000>;
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges = <0 0x02025000 0x1000>;
>> +
>> +               smp-sram at 0 {
>> +                       compatible = "samsung,exynos4210-sram";
>> +                       reg = <0x0 0x1000>;
>> +               };
>> +       };
>> +
>>         mct at 10050000 {
>>                 compatible = "none";
>>         };
>
>
> [snip]
>
>
>> diff --git a/arch/arm/mach-exynos/platsmp.c
>> b/arch/arm/mach-exynos/platsmp.c
>> index 03e5e9f94705..0aac03204f9f 100644
>> --- a/arch/arm/mach-exynos/platsmp.c
>> +++ b/arch/arm/mach-exynos/platsmp.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/jiffies.h>
>>   #include <linux/smp.h>
>>   #include <linux/io.h>
>> +#include <linux/of_address.h>
>>
>>   #include <asm/cacheflush.h>
>>   #include <asm/smp_plat.h>
>> @@ -33,11 +34,33 @@
>>
>>   extern void exynos4_secondary_startup(void);
>>
>> +static void __iomem *sram_base_addr;
>> +void __iomem *sram_ns_base_addr;
>> +
>> +static void __init exynos_smp_prepare_sram(void)
>> +{
>> +       struct device_node *node;
>> +
>> +       node = of_find_compatible_node(NULL, NULL,
>> "samsung,exynos4210-sram");
>
>
> Now here you don't check whether the node is "okay", so on Universal C210 it
> will pick just the first node with this compatible string,

Right. Missed that one.

>
> I think you should be using for_each_compatible_node() here, then check if
> the node is "okay" using of_devicE_is_available() and only then use this
> node to map the SYSRAM.

OK.

>
>
>> +       if (node) {
>> +               sram_base_addr = of_iomap(node, 0);
>> +               if (!sram_base_addr)
>> +                       pr_err("Secondary CPU boot address not found\n");
>> +       }
>> +
>> +       node = of_find_compatible_node(NULL, NULL,
>> "samsung,exynos4210-sram-ns");
>
>
> Same here.

OK.

>
>
>> +       if (node) {
>> +               sram_ns_base_addr = of_iomap(node, 0);
>> +               if (!sram_ns_base_addr)
>> +                       pr_err("Secondary CPU boot address not found\n");
>> +       }
>> +}
>> +
>>   static inline void __iomem *cpu_boot_reg_base(void)
>>   {
>>         if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
>>                 return S5P_INFORM5;
>> -       return S5P_VA_SYSRAM;
>> +       return sram_base_addr;
>>   }
>>
>>   static inline void __iomem *cpu_boot_reg(int cpu)
>> @@ -147,7 +170,8 @@ static int exynos_boot_secondary(unsigned int cpu,
>> struct task_struct *idle)
>>                  * and fall back to boot register if it fails.
>>                  */
>>                 if (call_firmware_op(set_cpu_boot_addr, phys_cpu,
>> boot_addr))
>> -                       __raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
>> +                       if (cpu_boot_reg_base())
>
>
> When can this condition be not met?

I experimented with various combinations of node presence/absence in dts files
and in one such case if we do not have the sram-ns node present (on
arndale-octa),
the system just hung at boot time (as base address was null) and this
check became
necessary.

>
>
>> +                               __raw_writel(boot_addr,
>> cpu_boot_reg(phys_cpu));
>>
>>                 call_firmware_op(cpu_boot, phys_cpu);
>>
>> @@ -205,6 +229,8 @@ static void __init exynos_smp_prepare_cpus(unsigned
>> int max_cpus)
>>         if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
>>                 scu_enable(scu_base_addr());
>>
>> +       exynos_smp_prepare_sram();
>> +
>>         /*
>>          * Write the address of secondary startup into the
>>          * system-wide flags register. The boot monitor waits
>> @@ -222,7 +248,8 @@ static void __init exynos_smp_prepare_cpus(unsigned
>> int max_cpus)
>>                 boot_addr = virt_to_phys(exynos4_secondary_startup);
>>
>>                 if (call_firmware_op(set_cpu_boot_addr, phys_cpu,
>> boot_addr))
>> -                       __raw_writel(boot_addr, cpu_boot_reg(phys_cpu));
>> +                       if (cpu_boot_reg_base())
>
>
> Ditto.

ditto.

Thanks for your review. Will update the same in v3.

-- 
With warm regards,
Sachin
