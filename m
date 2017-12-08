From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 08 Dec 2017 14:27:48 +0100
Subject: next/master boot: 270 boots: 35 failed, 213 passed with 20
 offline, 2 untried/unknown (next-20171207)
In-Reply-To: <CAJKOXPcfgXTzacEYyPFV=UJYdKz9v86pEjbjaWJ_7BYhdNafqA@mail.gmail.com>
References: <5a29d4c7.4fabdf0a.716d7.8485@mx.google.com>
 <20171208122007.GB7606@sirena.org.uk> <20171208122703.GC7606@sirena.org.uk>
 <CGME20171208123350epcas3p2da09a6b41fb4ee626860fe5ac698e265@epcas3p2.samsung.com>
 <CAJKOXPcfgXTzacEYyPFV=UJYdKz9v86pEjbjaWJ_7BYhdNafqA@mail.gmail.com>
Message-ID: <7ad6d330-d277-85ae-b891-cb76367461ce@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2017-12-08 13:33, Krzysztof Kozlowski wrote:
> On Fri, Dec 8, 2017 at 1:27 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Fri, Dec 08, 2017 at 12:20:07PM +0000, Mark Brown wrote:
>>> On Thu, Dec 07, 2017 at 03:54:47PM -0800, kernelci.org bot wrote:
>>>
>>> Today's -next failed to boot on peach-pi:
>>>
>>>>      exynos_defconfig:
>>>>          exynos5800-peach-pi:
>>>>              lab-collabora: new failure (last pass: next-20171205)
>>> with details at https://kernelci.org/boot/id/5a2a2e7859b5141bc2afa17c/
>>> (including logs and comparisons with other boots, the last good boot was
>>> Wednesday).  It looks like it hangs somewhere late on in boot, the last
>>> output on the console is:
>>>
>>> [    4.827139] smsc95xx 3-1.1:1.0 eth0: register 'smsc95xx' at usb-xhci-hcd.3.auto-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:2c:00:03:c0
>>> [    5.781037] dma-pl330 3880000.adma: Loaded driver for PL330 DMAC-241330
>>> [    5.786247] dma-pl330 3880000.adma:        DBUFF-4x8bytes Num_Chans-6 Num_Peri-16 Num_Events-6
>>> [    5.819200] dma-pl330 3880000.adma: PM domain MAU will not be powered off
>>> [   64.529228] random: crng init done
>>>
>>> and there's failures earlier to instantiate the display.
>> I just noticed that further up the log there's a lockdep splat with a
>> conflict between the genpd and clock API locking - an ABBA issue with
>> genpd->mlock and the clock API prepare_lock.
> +Cc Marek Szyprowski,
>
> The lockdep issue and display failures (including regulator warning)
> were present for some time. They also appear in boot log for
> next-20171206 (https://storage.kernelci.org/next/master/next-20171206/arm/exynos_defconfig/lab-collabora/boot-exynos5800-peach-pi.html).
> The difference is that 20171208 hangs on "random: crng init done"
> which did not appear before at all.

"random: crng init done" happens about a minute after boot, so if board
boots correctly to system prompt before that time, there will be no such
message.


> The only recent changes in samsung-soc tree which could affect Exynos5800 is
>   - ARM: dts: exynos: Add audio power domain support to Exynos542x SoCs
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=next/dt&id=528832d4c01a2b400775df95fe8d363cf4c5230f
>   - ARM: dts: exynos: Add CPU perf counters to Exynos54xx boards
> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/commit/?h=next/dt&id=c4f2fc00defc65950dfabce7a4c70cd2a289111d
>
> But both of them were present in next for few days so they should hit
> 20171206 as well.
>
> Maybe the issue comes from different subsystem?

The only change that has been recently merged and is related to the
hardware available on peach-pit is this patch:

https://www.spinics.net/lists/linux-samsung-soc/msg61232.html

It probably changed the order of driver initialization, but I have no
idea what causes the deadlock (from the "random:" message I see that
kernel is somehow still operational).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
