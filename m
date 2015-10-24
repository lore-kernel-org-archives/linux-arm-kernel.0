From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Sun, 25 Oct 2015 01:58:15 +0200
Subject: [PATCH 0/3] ARM: dts: Enable Exynos RNG module
In-Reply-To: <562581BD.3070609@samsung.com>
References: <1445230834-32689-1-git-send-email-k.kozlowski@samsung.com>
 <56251627.4050908@math.uni-bielefeld.de> <562581BD.3070609@samsung.com>
Message-ID: <562C1B17.3080303@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,


Krzysztof Kozlowski wrote:
> On 20.10.2015 01:11, Tobias Jakobi wrote:
>> Hello Krzysztof,
>>
>> I can confirm that this also works on a Odroid-X2, so I guess it's safe
>> to enable the PRNG for all Exynos4412-based Odroid devices.
> 
> Sure, I can send a patch for that. I can test it later also on Odroid-U3.
Thanks already!



>> Any chance that you might also take a look at the other hwcrypto stuff
>> on the SoC ('samsung,exynos4210-secss' compatible)?
> 
> What do you mean? The s5p-sss driver already supports Device Tree.
The driver supports DT, but it doesn't really work.

I'm using the following DT entry to let the driver probe correctly:
https://github.com/tobiasjakobi/linux-odroid/commit/82c00cddb5cbf89fad994784c28c8125beae8e13

But the crypto self-test fails on boot:
alg: skcipher: encryption failed on test 1 for ecb-aes-s5p: ret=22


Another problems is that SSS and PRNG can't be used at the same time,
since they both use common hardware resources (I think it was IO).


With best wishes,
Tobias


> Best regards,
> Krzysztof
> 
>>
>> With best wishes,
>> Tobias
>>
>>
>> Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>>
>>> The patchset adds necessary clock from Security SubSystem (SSS)
>>> and enables the PRNG module of Exynos for Trats2 board.
>>>
>>> The first patch (clock) is required for other ones so please
>>> take everything in one step.
>>>
>>> The actual Device Tree support (and compatible) was sent in separate
>>> patch:
>>>  - https://patchwork.kernel.org/patch/7432891/
>>>  - http://marc.info/?l=linux-crypto-vger&m=144522952725052&w=2
>>>
>>> The device can be tested (after applying both patchsets) with:
>>> $ echo exynos > /sys/class/misc/hw_random/rng_current
>>> $ dd if=/dev/hwrng of=/dev/null bs=1 count=16
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>> Krzysztof Kozlowski (3):
>>>   clk: samsung: exynos4: Add SSS gate clock
>>>   ARM: dts: Add PRNG module for exynos4
>>>   ARM: dts: Enable PRNG module on exynos4412-trats2
>>>
>>>  arch/arm/boot/dts/exynos4.dtsi          | 8 ++++++++
>>>  arch/arm/boot/dts/exynos4412-trats2.dts | 4 ++++
>>>  drivers/clk/samsung/clk-exynos4.c       | 1 +
>>>  include/dt-bindings/clock/exynos4.h     | 1 +
>>>  4 files changed, 14 insertions(+)
>>>
>>
>>
> 
