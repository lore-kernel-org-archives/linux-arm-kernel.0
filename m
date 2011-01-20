From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Jan 2011 17:21:48 +0100
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
	speed-up boot
In-Reply-To: <4D385155.4050301@gmail.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
	<4D385155.4050301@gmail.com>
Message-ID: <AANLkTin00ULesF4vnCUEQh6A_CLyTrUAwWxk2NN01y5v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/20 Rob Herring <robherring2@gmail.com>:
> On 01/20/2011 03:42 AM, Santosh Shilimkar wrote:
>>
>> On some architectures, secondary cores shares clock with primiary
>> core and hence scale together. Hence secondary core lpj calibration
>> is not necessary and can be skipped to save considerable time.
>>
>> This can speed up the secondary cpu boot and hotplug cpu online
>> paths.
>>
>> Discussion thread:
>> ? ? ? ?http://www.spinics.net/lists/arm-kernel/msg111124.html
>>
>
> There's already one way to do this with pre-calculated lpj.
>
> Also, this isn't multi-platform friendly.

It can be made to be, then -
skip all Kconfig business (more elegant like this anyway):

static inline int skip_secondary_calibrate(void)
{
    return machine_is_u8500() ||
        machine_is_svp8500v1() ||
        machine_is_svp8500v2() ||
        machine_is_svp5500() ||
        machine_is_b5500() ||
        machine_is_s5500() ||
        machine_is_omap4_panda();
}

Hm if this multi-platform stuff is desirable we probably need
a runtime arch_is_omap4(), arch_is_u8500() etc so this machine
list doesn't grow ridiculously long, but ftm this will work.

Yours,
Linus Walleij
