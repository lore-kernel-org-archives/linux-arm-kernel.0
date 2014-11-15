From: tyler.baker@linaro.org (Tyler Baker)
Date: Sat, 15 Nov 2014 10:42:57 -0800
Subject: exynos5250/arndale: failed to set cpu voltage
In-Reply-To: <CAM4voamPyTpv5TPtN1Z=ZL3Qmy806qFxrAaU0kiqJmV56cyJiw@mail.gmail.com>
References: <CANMBJr4ZgEZDAtdfuLhCXppCGHnHhgmT1aFUi+=kJb2PdkqhGg@mail.gmail.com>
 <CAM4voamPyTpv5TPtN1Z=ZL3Qmy806qFxrAaU0kiqJmV56cyJiw@mail.gmail.com>
Message-ID: <CANMBJr5nLOJ4O=+TLMO9uryH79nBQwQKZu_nmRaPne9DE3GvWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

On 13 November 2014 18:50, Abhilash Kesavan <kesavan.abhilash@gmail.com> wrote:
> Hello Tyler,
>
> On Fri, Nov 14, 2014 at 3:30 AM, Tyler Baker <tyler.baker@linaro.org> wrote:
>> In recent upstream kernels, exynos5420-based arndale boards have been
>
> Boot logs are only for 5250, typo ?

Apologies, this is a typo. Should have been 5250 as you mentioned.

>
>> producing boot-time errors due to the fact they failed to set the cpu
>> voltage. These message flood the serial console even after userspace
>> has been loaded, yielding the console unusable without forcing a lower
>> log level. These errors are produced _only_ with the
>> multi_v7_defconfig and they are _not_ present
>> with exynos_defconfig. Here are some recent boot logs showing the boot errors:
>>
>> mainline/v3.18-rc4-65-g2c54396:
>>     multi_v7_defconfig:
>>         http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc4-65-g2c54396/arm-multi_v7_defconfig/boot-exynos5250-arndale.html
>>     exynos_defconfig:
>>         http://storage.armcloud.us/kernel-ci/mainline/v3.18-rc4-65-g2c54396/arm-exynos_defconfig/boot-exynos5250-arndale.html
>
> From the boot logs it appears that the S5M8767 regulator does not get
> probed with multi_v7_defconfig and you get the following messages:
>
> [    1.147412] deviceless supply vdd_arm not found, using dummy regulator
> [    1.152669] exynos-cpufreq exynos-cpufreq: failed to set cpu
> voltage to 1300000
> [    1.159771] cpufreq: __target_index: Failed to change cpu frequency: -22
>
> Both multi_v7_defconfig and exynos_defconfig have the S5M8767
> regulator enabled. However multi_v7_defconfig does not have the S3C
> I2C controller enabled while exynos_defconfig does.
> Can you re-check after enabling CONFIG_I2C_S3C2410 ?

I have retested my two arndale boards with
multi_v7_defconfg+CONFIG_I2C_S3C2410=y on mainline, next, and arm-soc.
Enabling S3C I2C controller does resolve the issue I have reported
above. It seems reasonable to patch the multi_v7_defconfig to enable
this option by default, thoughts?

>
> Regards,
> Abhilash
>
>>
>> next/next-20141113:
>>     multi_v7_defconfig:
>>         http://storage.armcloud.us/kernel-ci/next/next-20141113/arm-multi_v7_defconfig/boot-exynos5250-arndale.html
>>     exynos_defconfig:
>>         http://storage.armcloud.us/kernel-ci/next/next-20141113/arm-exynos_defconfig/boot-exynos5250-arndale.html
>>
>> arm-soc/v3.18-rc4-185-gbfcf8f9:
>>     multi_v7_defconfig:
>>         http://storage.armcloud.us/kernel-ci/arm-soc/v3.18-rc4-185-gbfcf8f9/arm-multi_v7_defconfig/boot-exynos5250-arndale.html
>>     exynos_defconfig:
>>         http://storage.armcloud.us/kernel-ci/arm-soc/v3.18-rc4-185-gbfcf8f9/arm-exynos_defconfig/boot-exynos5250-arndale.html
>>
>> Cheers,
>>
>> --
>> Tyler Baker
>> Tech Lead, LAVA
>> Linaro.org | Open source software for ARM SoCs
>> Follow Linaro: http://www.facebook.com/pages/Linaro
>> http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Cheers,

-- 
Tyler Baker
Tech Lead, LAVA
Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
