From: dianders@google.com (Doug Anderson)
Date: Mon, 9 Jun 2014 13:35:10 -0700
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <7hoay1rfp4.fsf@paris.lan>
References: <CAD=FV=UX90hgyojW3k_kpT=mt8eX9=AyHr+AGjhK=MrE1hHbUA@mail.gmail.com>
 <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <7hoay1rfp4.fsf@paris.lan>
Message-ID: <CAD=FV=XCLHXFfyG8Dd+LsdwstsTicZNDjV8Wv3JeQpTBFOF2bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin and Nicolas,

On Mon, Jun 9, 2014 at 1:27 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
>
>> On Sat, 7 Jun 2014, Abhilash Kesavan wrote:
>>
>>> Hi Nicolas,
>>>
>>> The first man of the incoming cluster enables its snoops via the
>>> power_up_setup function. During secondary boot-up, this does not occur
>>> for the boot cluster. Hence, I enable the snoops for the boot cluster
>>> as a one-time setup from the u-boot prompt. After secondary boot-up
>>> there is no modification that I do.
>>
>> OK that's good.
>>
>>> Where should this be ideally done ?
>>
>> If I remember correctly, the CCI can be safely activated only when the
>> cache is disabled.  So that means the CCI should ideally be turned on
>> for the boot cluster (and *only* for the boot CPU) by the bootloader.
>>
>> Now... If you _really_ prefer to do it from the kernel to avoid
>> difficulties with bootloader updates, then it should be possible to do
>> it from the kernel by temporarily turning the cache off.  This is not a
>> small thing but the MCPM infrastructure can be leveraged.  Here's what I
>> tried on a TC2 which might just work for you as well:
>
> FWIW, I dropped the u-boot hack I was using to enable CCI and tested
> this patch (with a cut/paste of the TC2 specific stuff into
> mach-exynos/mcpm-exynos.c) along with Doug's patch[1] and
> and confirm that all 8 cores boot up on the Chromebook2 using linux-next.
>
> Kevin
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262440.html

Agreed.  Nicolas's patch <https://patchwork.kernel.org/patch/4315711/>
plus the copy/paste to exynos made things boot for me, too.

-Doug

---

Reference of the copy/paste to exynos (though gmail is munging my tabs):

diff --git a/arch/arm/mach-exynos/mcpm-exynos.c
b/arch/arm/mach-exynos/mcpm-exynos.c
index ace0ed6..218b9ff 100644
--- a/arch/arm/mach-exynos/mcpm-exynos.c
+++ b/arch/arm/mach-exynos/mcpm-exynos.c
@@ -295,6 +295,25 @@ static const struct of_device_id exynos_dt_mcpm_match[] = {
        {},
 };

+int mcpm_loopback(void (*cache_disable)(void));
+static void exynos_cache_down(void)
+{
+       pr_warn("exynos: disabling cache\n");
+       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A15) {
+               /*
+                * On the Cortex-A15 we need to disable
+                * L2 prefetching before flushing the cache.
+                */
+               asm volatile(
+               "mcr    p15, 1, %0, c15, c0, 3 \n\t"
+               "isb    \n\t"
+               "dsb    "
+               : : "r" (0x400) );
+       }
+       v7_exit_coherency_flush(all);
+       cci_disable_port_by_cpu(read_cpuid_mpidr());
+}
+
 static int __init exynos_mcpm_init(void)
 {
        struct device_node *node;
@@ -336,6 +355,7 @@ static int __init exynos_mcpm_init(void)
                iounmap(ns_sram_base_addr);
                return ret;
        }
+       BUG_ON(mcpm_loopback(exynos_cache_down) != 0);

        mcpm_smp_set_ops();
