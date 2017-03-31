From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Fri, 31 Mar 2017 11:31:54 +0530
Subject: [PATCH v9 12/12] ARM: EXYNOS: refactor of mach-exynos to use
 chipid information
In-Reply-To: <CAK8P3a2oK1MvWe4B-4r2Rt7Q87juNJd3MsetN8-OeDYhBmKyUg@mail.gmail.com>
References: <CGME20170330131444epcas5p45051cf7e6ec7a993c2c9f84254b89a19@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-13-git-send-email-pankaj.dubey@samsung.com>
 <CAK8P3a2oK1MvWe4B-4r2Rt7Q87juNJd3MsetN8-OeDYhBmKyUg@mail.gmail.com>
Message-ID: <69ac19c2-76de-d614-492b-ccdc83d01d81@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 30 March 2017 07:31 PM, Arnd Bergmann wrote:
> On Thu, Mar 30, 2017 at 3:17 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> 
>>   * register the standard cpu IO areas
>>   */
>> -static void __init exynos_map_io(void)
>> +static int __init exynos_fdt_map_scu(unsigned long node, const char *uname,
>> +               int depth, void *data)
>>  {
>> -       if (soc_is_exynos4())
>> -               iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
>> +       if (!of_flat_dt_is_compatible(node, "samsung,exynos4210") &&
>> +                       !of_flat_dt_is_compatible(node, "samsung,exynos4212") &&
>> +                       !of_flat_dt_is_compatible(node, "samsung,exynos4412"))
>> +               return 0;
>> +
>> +       iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
>> +       return 1;
>>  }
> 
> This seems really overcomplicated. From what I can tell, this is only needed
> to find the SCU address, but there are better ways to do that, either by
> looking up the SCU in the DT at the time you actually need it,
> or by calling scu_a9_get_base().

Indeed it's complicated and ugly, for the same reason I attempted to
clean-up this part for Exynos SoC in patch series [1], which was
accepted by Samsung maintainer Krzysztof and later during pull request
rejected by ARM maintainers [2]

[1]: https://www.spinics.net/lists/arm-kernel/msg540498.html
[2]: http://lkml.iu.edu/hypermail/linux/kernel/1612.0/01508.html

Given the argument we can't adopt getting base address of SCU completely
via DT without breaking OLD dtbs at some point, difficult to simplify
these stuffs.

Please guide which is the best way to handle such stuffs.

In fact I made another attempt [3] to cleanup this SCU related stuffs
for other ARM based platforms, but we could not arrive on some consensus
at that time. I will try to attempt it again soon.

[3]: http://www.spinics.net/lists/arm-kernel/msg542351.html

Thanks,
Pankaj Dubey

> 
>       Arnd
> 
> 
> 
