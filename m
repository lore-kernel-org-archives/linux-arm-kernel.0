From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 17 Apr 2014 00:40:46 +0530
Subject: [PATCH 1/5] ARM: bL_switcher: Don't enable bL switcher on systems
 without CCI
In-Reply-To: <alpine.LFD.2.11.1404111406210.980@knanqh.ubzr>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <1397239311-27717-2-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1404111406210.980@knanqh.ubzr>
Message-ID: <CAM4voanduaJ32ztj6ZDMOPXNd9W6Ttwae_PQ68VGxPKZEsj3kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Fri, Apr 11, 2014 at 11:44 PM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> On Fri, 11 Apr 2014, Abhilash Kesavan wrote:
>
>> From: Andrew Bresticker <abrestic@chromium.org>
>>
>> Do not enable the big.LITTLE switcher on systems that do not have an
>> ARM CCI (cache-coherent interconnect) present.  Since the CCI is used
>> to maintain cache coherency between multiple clusters and peripherals,
>> it is unlikely that a system without CCI would support big.LITTLE.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>
> The b.L switcher depends on MCPM, and it also expects only 2 clusters
> which is evaluated at run time or it bails out.
>
> There might be in theory other ways than the CCI to enforce coherency
> between clusters.  And that should all be encapsulated by the MCPM
> layer.  The switcher module should not be concerned at all by the
> underlying hardware mechanism.
>
> So if the goal is to determine at run time whether or not the switcher
> should be activated in a multi-config kernel, then the criteria should
> be whether or not MCPM is initialized, and not if there is a CCI.

Yes, we have a multi-SoC enabled kernel (with MCPM and BL_SWITCHER
configs enabled); one SoC has a single cluster while the other is a
dual cluster. We wanted a run-time check to prevent bL_switcher from
running on the single cluster one and zeroed in on CCI. But, I get
your point as to why CCI should not be used as a distinguishing factor
for switcher initialization.

For now, I can use the no_bL_switcher parameter to disable it on
certain platforms. However, can you elaborate on the MCPM
initialization check you suggested ?


Regards,
Abhilash
>
>> ---
>>  arch/arm/common/bL_switcher.c |   12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
>> index 5774b6e..c4fec1f 100644
>> --- a/arch/arm/common/bL_switcher.c
>> +++ b/arch/arm/common/bL_switcher.c
>> @@ -33,6 +33,7 @@
>>  #include <linux/sysfs.h>
>>  #include <linux/irqchip/arm-gic.h>
>>  #include <linux/moduleparam.h>
>> +#include <linux/of.h>
>>
>>  #include <asm/smp_plat.h>
>>  #include <asm/cputype.h>
>> @@ -796,6 +797,17 @@ core_param(no_bL_switcher, no_bL_switcher, bool, 0644);
>>  static int __init bL_switcher_init(void)
>>  {
>>       int ret;
>> +     struct device_node *dn;
>> +
>> +     /*
>> +      * We don't want to set up the bL switcher if the machine doesn't
>> +      * support bL, so use the presence of a CCI to indicate whether or
>> +      * not bL is supported on this device.
>> +      */
>> +     dn = of_find_compatible_node(NULL, NULL, "arm,cci-400");
>> +     if (!dn)
>> +             return 0;
>> +     of_node_put(dn);
>>
>>       if (MAX_NR_CLUSTERS != 2) {
>>               pr_err("%s: only dual cluster systems are supported\n", __func__);
>> --
>> 1.7.9.5
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
