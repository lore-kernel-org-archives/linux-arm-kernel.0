From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 30 Jan 2017 10:57:55 +0100
Subject: [PATCH v2 0/8] Pad retentions support for Exynos5433
In-Reply-To: <20170127194612.44dmadsqw6vv5f23@kozik-lap>
References: <CGME20170126083401eucas1p20b4794fe46ccf2189bf734f0d8e3c536@eucas1p2.samsung.com>
 <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
 <20170127194612.44dmadsqw6vv5f23@kozik-lap>
Message-ID: <b4f3b89b-17a5-e780-c17f-c67df72b9004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2017-01-27 20:46, Krzysztof Kozlowski wrote:
> On Thu, Jan 26, 2017 at 09:33:46AM +0100, Marek Szyprowski wrote:
>> This patchset is a first step to add support for all power domains on
>> Exynos5433 SoCs. This patchset contains patches for Exynos pin control
>> driver and Exynos LPASS MFD driver, which are needed to make the
>> platform ready for adding power domains support.
>>
>> Patches in this patchset depends on each other. They are order in such a
>> way to make the changes bisectable.
>>
>> Patch #3 has runtime dependency on #1.
>> Patch #5 has runtime dependency on #3.
>> Patch #6 has runtime dependency on #4.
>>
>> This patchset also directly depends on the "Move pad retention control to
>> Exynos pin controller driver" patchset:
>> https://www.spinics.net/lists/arm-kernel/msg556074.html
>>
>> Patches have been generated on top of linux-next from 25th January 2017.
>>
>> This is a part of a larger task, which goal is to add support for power
>> domains on Exynos5433 SoCs / TM2 boards. All patches needed to get it
>> working have been pushed to the following git repo:
>> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.10-next-tm2-pd
>>
> I tried your branch above on Odroid U3 and it fails to boot.
> next-20170125 works fine. exynos_defconfig, booting from microSD.
>
> Board hangs (silently) on:
> [    2.283437] usb 1-3: new high-speed USB device number 3 using exynos-ehci
> [    2.473786] usb 1-3: New USB device found, idVendor=0424, idProduct=3503
> [    2.474856] usb 1-3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    2.482656] hub 1-3:1.0: USB hub found
> [    2.486017] hub 1-3:1.0: 3 ports detected
> [   55.037205] random: crng init done
>
> Full log attached.

Huh... Reproduced. This is another reincarnation of the prepare_mutex in 
clock's
core related deadlock, now caused by Exynos Audio Subsystem clock's 
driver, Exynos
I2S driver and Samsung SDHCI driver.

It looks that this issue becomes even more problematic now and urgently 
needs
a proper fix, because it gets really hard to make more workarounds 
everywhere else.
For now I will probably drop Exynos AudioSS patch from this series and 
send a revert
for commit 9b41da80e09128574f09bed8dc5a5fc6f72a8239 ("ASoC: samsung: 
i2s: Provide
I2S device for registered clocks"), which has to wait until the deadlock 
gets proper
generic fix.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
