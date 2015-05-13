From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 13 May 2015 12:20:28 -0700
Subject: [GIT PULL]Hisilicon hip04 soc and D01 board DT updates for v4.2
In-Reply-To: <555217BA.4090109@hisilicon.com>
References: <554CC781.9010705@hisilicon.com> <2096767.GyPuANEUdq@wuerfel>
 <555217BA.4090109@hisilicon.com>
Message-ID: <CANMBJr5JQF1D43bCmV-w9hxemmMQJkvTG+gD98r_H=F6g=9Bqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei/Arnd,

On 12 May 2015 at 08:09, Wei Xu <xuwei5@hisilicon.com> wrote:
>
>
> On 5/12/2015 4:06 PM, Arnd Bergmann wrote:
>> On Friday 08 May 2015 15:26:09 Wei Xu wrote:
>>> ARM: DT: Hisilicon hip04 soc and D01 board updates for 4.2
>>>
>>> - Add hip04 GPIO nodes
>>> - Add NANDC nodes for hip04 and D01 board
>>> - Add hip04 ethernet related nodes
>>>
>>>
>
> Hi Arnd,
>
>> Pulled into next/dt, thanks!

When this was pulled into arm-soc, the kernelci.org bot reported
hip04-d01 boot failures[1]. Before bisecting, I decided to wait a day
and double check the status of -next in case there were needed
dependencies from other trees. However, now there are the same
hip04-d01 boot failures in next-20150513[2]. My robot has bisected[3]
these boot failures down to...

828fcfe3c84ade68ecc3f1ba78baebc1654977f3 is the first bad commit
commit 828fcfe3c84ade68ecc3f1ba78baebc1654977f3
Author: Zhou Wang <wangzhou.bry@gmail.com>
Date:   Wed Mar 25 14:57:45 2015 +0800

    ARM: dts: hip04: add GPIO pieces

    Hisilicon Soc hip04 has four GPIO controllers, each one has 32
    GPIOs and can be configured to be an interrupt controller.The GPIO
    controllers are compatible with the snps,dw-apb-gpio driver.
    This patch add the corresponding device tree nodes.

    Acked-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
    Signed-off-by: Wei Xu <xuwei5@hisilicon.com>

This commit does not revert cleanly from -next, so I reverted all
three commits in this pull request on top of next-20150513 and this
get the hip04-d01 booting again.

>
> Thanks!
>
> Best Regards,
> Wei
>
>>       Arnd
>>
>> .
>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Tyler

[1] http://kernelci.org/boot/all/job/arm-soc/kernel/v4.1-rc3-170-g28837bc3e732/
[2] http://kernelci.org/boot/all/job/next/kernel/next-20150513/
[3] https://ci.linaro.org/view/people/job/tbaker-boot-bisect-bot/28/console
