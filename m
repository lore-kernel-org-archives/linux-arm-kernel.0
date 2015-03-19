From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 19 Mar 2015 10:07:44 +0800
Subject: [PATCH 2/3] ARM: sun8i: Add SMP support for the Allwinner A23
In-Reply-To: <20150318102939.GP4638@lukather>
References: <1426649042-30547-1-git-send-email-wens@csie.org>
 <1426649042-30547-3-git-send-email-wens@csie.org>
 <20150318102939.GP4638@lukather>
Message-ID: <CAGb2v65qZBPcury1e-DXwmpJOyS97oWFVisGQKEbTZkc+Z60nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 6:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Mar 18, 2015 at 11:24:01AM +0800, Chen-Yu Tsai wrote:
>> The A23 is a dual Cortex-A7. Add the logic to use the IPs used to
>> control the CPU configuration and the CPU power so that we can
>> bring up secondary CPUs at boot.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>
>> We can't use of_io_request_and_map() here, as it will conflict
>> with PRCM, and leave us without a serial console.
>>
>> I think a proper way to solve this would be a syscon device or
>> something like the mfd-simple device posted by Arnd.
>>
>> ---
>>  Documentation/devicetree/bindings/arm/cpus.txt |  1 +
>>  arch/arm/mach-sunxi/platsmp.c                  | 69 ++++++++++++++++++++++++++
>>  2 files changed, 70 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
>> index 8b9e0a95de31..40202d85b132 100644
>> --- a/Documentation/devicetree/bindings/arm/cpus.txt
>> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
>> @@ -188,6 +188,7 @@ nodes to be present and contain the properties described below.
>>                       # On ARM 32-bit systems this property is optional and
>>                         can be one of:
>>                           "allwinner,sun6i-a31"
>> +                         "allwinner,sun8i-a23"
>>                           "arm,psci"
>>                           "brcm,brahma-b15"
>>                           "marvell,armada-375-smp"
>> diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
>> index 587b0468efcc..e8483ec79d67 100644
>> --- a/arch/arm/mach-sunxi/platsmp.c
>> +++ b/arch/arm/mach-sunxi/platsmp.c
>> @@ -121,3 +121,72 @@ static struct smp_operations sun6i_smp_ops __initdata = {
>>       .smp_boot_secondary     = sun6i_smp_boot_secondary,
>>  };
>>  CPU_METHOD_OF_DECLARE(sun6i_a31_smp, "allwinner,sun6i-a31", &sun6i_smp_ops);
>> +
>> +static void __init sun8i_smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +     struct device_node *node;
>> +
>> +     node = of_find_compatible_node(NULL, NULL, "allwinner,sun8i-a23-prcm");
>> +     if (!node) {
>> +             pr_err("Missing A23 PRCM node in the device tree\n");
>> +             return;
>> +     }
>> +
>> +     prcm_membase = of_iomap(node, 0);
>> +     if (!prcm_membase) {
>> +             pr_err("Couldn't map A23 PRCM registers\n");
>> +             return;
>> +     }
>> +
>> +     node = of_find_compatible_node(NULL, NULL,
>> +                                    "allwinner,sun8i-a23-cpuconfig");
>> +     if (!node) {
>> +             pr_err("Missing A23 CPU config node in the device tree\n");
>> +             return;
>> +     }
>> +
>> +     cpucfg_membase = of_iomap(node, 0);
>> +     if (!cpucfg_membase)
>> +             pr_err("Couldn't map A23 CPU config registers\n");
>> +
>> +}
>> +
>> +static int sun8i_smp_boot_secondary(unsigned int cpu,
>> +                                 struct task_struct *idle)
>> +{
>> +     u32 reg;
>> +
>> +     if (!(prcm_membase && cpucfg_membase))
>> +             return -EFAULT;
>> +
>> +     spin_lock(&cpu_lock);
>> +
>> +     /* Set CPU boot address */
>> +     writel(virt_to_phys(secondary_startup),
>> +            cpucfg_membase + CPUCFG_PRIVATE0_REG);
>
> One question I couldn't find any answer to is that does the SMP bit is
> set in secondary_startup?
>
> I couldn't find where it was set, but it still looks like the right
> thing to do, so I would expect the code to do that.

I don't see it either. The sun8i code is just the sun6i code with the
power clamps removed. And sun6i secondary_startup was removed some time
ago in commit 1146b600044d ("ARM: sunxi: fix build for THUMB2_KERNEL").

ChenYu
