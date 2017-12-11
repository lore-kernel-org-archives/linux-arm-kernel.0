From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 11 Dec 2017 11:43:19 +0100
Subject: next/master boot: 270 boots: 35 failed, 213 passed with 20
 offline, 2 untried/unknown (next-20171207)
In-Reply-To: <11a4d79d-73a5-5e98-c83f-f5e47bcfcdf2@samsung.com>
References: <5a29d4c7.4fabdf0a.716d7.8485@mx.google.com>
 <20171208122007.GB7606@sirena.org.uk> <20171208122703.GC7606@sirena.org.uk>
 <CGME20171208123350epcas3p2da09a6b41fb4ee626860fe5ac698e265@epcas3p2.samsung.com>
 <CAJKOXPcfgXTzacEYyPFV=UJYdKz9v86pEjbjaWJ_7BYhdNafqA@mail.gmail.com>
 <7ad6d330-d277-85ae-b891-cb76367461ce@samsung.com>
 <20171208165943.GC4283@codeaurora.org>
 <11a4d79d-73a5-5e98-c83f-f5e47bcfcdf2@samsung.com>
Message-ID: <b46b554a-eab0-6167-3fb2-484cd1f11ffd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

Do you have a bit of spare time for Exynos kernel development? Could you 
investigate why Peach-Pi(t) Chromebooks fails to boot with recent 
kernels? If I remember correctly, you had access to those boards.

The failure itself seems to be caused by the following patch: 
https://patchwork.kernel.org/patch/10067711/ which got merged as 
510353a63796 to v4.15-rc3 and fixed the boot issue on Snow Chromebook 
(Exynos 5250 based).
However I don't see any path how it might deadlock and cause boot 
failure on Exynos 5420/5800 Chromebooks. I don't have access to Peach 
Chromebooks to reproduce and our Snow works fine.

Here are some logs:
v4.15-rc3 failure:
https://storage.kernelci.org/mainline/master/v4.15-rc3/arm/exynos_defconfig/lab-collabora/boot-exynos5800-peach-pi.html
next-20171207 first next failure:
https://storage.kernelci.org/next/master/next-20171207/arm/exynos_defconfig/lab-collabora/boot-exynos5800-peach-pi.html

Here is a report on the first boot failure in linux-next:

On 2017-12-11 10:28, Marek Szyprowski wrote:
> Hi Stephen,
>
> On 2017-12-08 17:59, Stephen Boyd wrote:
>> On 12/08, Marek Szyprowski wrote:
>>> On 2017-12-08 13:33, Krzysztof Kozlowski wrote:
>>>> On Fri, Dec 8, 2017 at 1:27 PM, Mark Brown <broonie@kernel.org> wrote:
>>>>> On Fri, Dec 08, 2017 at 12:20:07PM +0000, Mark Brown wrote:
>>>>>> On Thu, Dec 07, 2017 at 03:54:47PM -0800, kernelci.org bot wrote:
>>>>>>
>>>>>> Today's -next failed to boot on peach-pi:
>>>>>>
>>>>>>> ???? exynos_defconfig:
>>>>>>> ???????? exynos5800-peach-pi:
>>>>>>> ???????????? lab-collabora: new failure (last pass: next-20171205)
>>>>>> with details at 
>>>>>> https://kernelci.org/boot/id/5a2a2e7859b5141bc2afa17c/
>>>>>> (including logs and comparisons with other boots, the last good 
>>>>>> boot was
>>>>>> Wednesday).? It looks like it hangs somewhere late on in boot, 
>>>>>> the last
>>>>>> output on the console is:
>>>>>>
>>>>>> [??? 4.827139] smsc95xx 3-1.1:1.0 eth0: register 'smsc95xx' at 
>>>>>> usb-xhci-hcd.3.auto-1.1, smsc95xx USB 2.0 Ethernet, 
>>>>>> 94:eb:2c:00:03:c0
>>>>>> [??? 5.781037] dma-pl330 3880000.adma: Loaded driver for PL330 
>>>>>> DMAC-241330
>>>>>> [??? 5.786247] dma-pl330 3880000.adma: DBUFF-4x8bytes Num_Chans-6 
>>>>>> Num_Peri-16 Num_Events-6
>>>>>> [??? 5.819200] dma-pl330 3880000.adma: PM domain MAU will not be 
>>>>>> powered off
>>>>>> [?? 64.529228] random: crng init done
>>>>>>
>>>>>> and there's failures earlier to instantiate the display.
>>>>> I just noticed that further up the log there's a lockdep splat with a
>>>>> conflict between the genpd and clock API locking - an ABBA issue with
>>>>> genpd->mlock and the clock API prepare_lock.
>>>> +Cc Marek Szyprowski,
>>>>
>>>> The lockdep issue and display failures (including regulator warning)
>>>> were present for some time. They also appear in boot log for
>>>> next-20171206 
>>>> (https://storage.kernelci.org/next/master/next-20171206/arm/exynos_defconfig/lab-collabora/boot-exynos5800-peach-pi.html).
>>>> The difference is that 20171208 hangs on "random: crng init done"
>>>> which did not appear before at all.
>> I haven't looked at the lockdep splat yet, but is that happening
>> because of runtime PM usage by the clk framework?
>
> This is a false positive. The deplock doesn't distinguish each domain 
> instance.
> Only some instances of exynos power domains use clocks (as an old 
> workaround of
> the lack possibility to integrate proper clock rate/topology 
> restoration after
> power off/on cycle in the clock provider driver).
>
> Those clock controllers, which implements runtime pm, are assigned to 
> power
> domain, which doesn't touch clocks at all.
>
> I still have no idea how to fix the code to make deplock happy.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
