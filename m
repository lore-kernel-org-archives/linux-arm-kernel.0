From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 20 Dec 2017 12:28:27 +0100
Subject: next/master boot: 270 boots: 35 failed, 213 passed with 20
 offline, 2 untried/unknown (next-20171207)
In-Reply-To: <20171219200523.GE7997@codeaurora.org>
References: <5a29d4c7.4fabdf0a.716d7.8485@mx.google.com>
 <20171208122007.GB7606@sirena.org.uk> <20171208122703.GC7606@sirena.org.uk>
 <CGME20171208123350epcas3p2da09a6b41fb4ee626860fe5ac698e265@epcas3p2.samsung.com>
 <CAJKOXPcfgXTzacEYyPFV=UJYdKz9v86pEjbjaWJ_7BYhdNafqA@mail.gmail.com>
 <7ad6d330-d277-85ae-b891-cb76367461ce@samsung.com>
 <20171208165943.GC4283@codeaurora.org>
 <11a4d79d-73a5-5e98-c83f-f5e47bcfcdf2@samsung.com>
 <20171219200523.GE7997@codeaurora.org>
Message-ID: <247c28e9-ea21-3a94-cb51-d0435c9e371e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 2017-12-19 21:05, Stephen Boyd wrote:
> On 12/11, Marek Szyprowski wrote:
>> On 2017-12-08 17:59, Stephen Boyd wrote:
>>> On 12/08, Marek Szyprowski wrote:
>>>> On 2017-12-08 13:33, Krzysztof Kozlowski wrote:
>>>>> On Fri, Dec 8, 2017 at 1:27 PM, Mark Brown <broonie@kernel.org> wrote:
>>>>>> On Fri, Dec 08, 2017 at 12:20:07PM +0000, Mark Brown wrote:
>>>>>>> On Thu, Dec 07, 2017 at 03:54:47PM -0800, kernelci.org bot wrote:
>>>>>>>
>>>>>>> Today's -next failed to boot on peach-pi:
>>>>>>>
>>>>>>>>      exynos_defconfig:
>>>>>>>>          exynos5800-peach-pi:
>>>>>>>>              lab-collabora: new failure (last pass: next-20171205)
>>>>>>> with details at https://kernelci.org/boot/id/5a2a2e7859b5141bc2afa17c/
>>>>>>> (including logs and comparisons with other boots, the last good boot was
>>>>>>> Wednesday).  It looks like it hangs somewhere late on in boot, the last
>>>>>>> output on the console is:
>>>>>>>
>>>>>>> [    4.827139] smsc95xx 3-1.1:1.0 eth0: register 'smsc95xx' at usb-xhci-hcd.3.auto-1.1, smsc95xx USB 2.0 Ethernet, 94:eb:2c:00:03:c0
>>>>>>> [    5.781037] dma-pl330 3880000.adma: Loaded driver for PL330 DMAC-241330
>>>>>>> [    5.786247] dma-pl330 3880000.adma:        DBUFF-4x8bytes Num_Chans-6 Num_Peri-16 Num_Events-6
>>>>>>> [    5.819200] dma-pl330 3880000.adma: PM domain MAU will not be powered off
>>>>>>> [   64.529228] random: crng init done
>>>>>>>
>>>>>>> and there's failures earlier to instantiate the display.
>>>>>> I just noticed that further up the log there's a lockdep splat with a
>>>>>> conflict between the genpd and clock API locking - an ABBA issue with
>>>>>> genpd->mlock and the clock API prepare_lock.
>>>>> +Cc Marek Szyprowski,
>>>>>
>>>>> The lockdep issue and display failures (including regulator warning)
>>>>> were present for some time. They also appear in boot log for
>>>>> next-20171206 (https://storage.kernelci.org/next/master/next-20171206/arm/exynos_defconfig/lab-collabora/boot-exynos5800-peach-pi.html).
>>>>> The difference is that 20171208 hangs on "random: crng init done"
>>>>> which did not appear before at all.
>>> I haven't looked at the lockdep splat yet, but is that happening
>>> because of runtime PM usage by the clk framework?
>> This is a false positive. The deplock doesn't distinguish each
>> domain instance.
>> Only some instances of exynos power domains use clocks (as an old
>> workaround of
>> the lack possibility to integrate proper clock rate/topology
>> restoration after
>> power off/on cycle in the clock provider driver).
>>
>> Those clock controllers, which implements runtime pm, are assigned to power
>> domain, which doesn't touch clocks at all.
>>
>> I still have no idea how to fix the code to make deplock happy.
>>
> Right. Once lockdep complains lockdep turns itself off, so we
> lose the ability to detect other problems. Even if it's a false
> positive, it's a potential problem on some device so it's
> concerning that runtime PM usage from clk framework has created
> this potential problem.
>
> Is it possible to remove the clk operations from the exynos power
> domains? You say it's to deal with the lack of rate/topology
> restoration so maybe it can be changed.

Yes, it can be changed. Those rate/topology restoration should be done
in exynos5420 clk driver, which should also implement runtime PM.
However there is still one issue to be resolved. Current runtime
PM / generic power domains bindings doesn't allow to assign a device
(clock controller in this case) to more than one power domain. To
get it working we would need to have a clock controller object
(subdevice?) for each power domain.

Such approach has been already rejected by You in the initial Exynos4
clock controller runtime PM patches.

Exynos4 case could have been modeled in a different, frankly speaking
a bit more close to real hardware details. Exynos4 ISP clocks
registers (that part which is in fact under power domain) are in
separate address space region, so this in the end has been modeled
as separate clock controller, which was easily assigned to respective
power domain.

Exynos5420/5422 (also partially Exynos5250) is much more problematic,
because registers of all clocks are mixed together and MUXes which
loose state after power domain suspend are in common register
(SRC_TOP3). It cannot be modeled with multiple clock controllers, one
per each power domain.

> That will at least allow
> lockdep to continue working here and detect the "real" deadlock
> here. Otherwise, do we need to revert runtime PM for clk
> framework and back out all the Samsung changes on top of that? If
> we need to do that, we need to do it soon.

I would like to avoid this if possible.

> We'll need to think about how to resolve the cross-subsystem
> locking problem regardless. We definitely want to have genpd be
> able to do CCF things, and CCF to use runtime PM and genpds too.
> It seems that we have a classic AB-BA deadlock potential between
> the clk prepare lock and the genpd domain mutex. Both frameworks
> are holding a mutex across the operations of their providers
> (either clk_ops or genpd power_on/off) so we can't have the CCF
> call genpd things and genpd call CCF things or lockdep will
> complain.

One thing to notice is locking granularity. CCF have a single,
common mutex with non-standard semantic (thread re-entrant), while
genpd has a standard per object mutex.

Changing CCF to use per-clock mutex instead of global prepare lock
will probably solve the possible dead-lock, but it will not make
deplock happy, because deplock doesn't distinguish object instances.

> I was worried about runtime PM usage by CCF causing
> this problem, but I missed that genpd was behind runtime PM so I
> didn't consider the locks in that part of the chain. Ugh.
>
> Maybe we can have runtime PM things done outside of the prepare
> lock in CCF, that way we aren't holding any locks that genpd may
> need to use. That would fix the problem, but would expose us to
> clk tree topology changes happening while we enable runtime PM
> for clks. It would be great if we could drop all framework level
> locks when we call into provider drivers. I'm not sure how to do
> that yet, but that's probably the end goal.
>
> Anyway, this needs some thought to figure out how to redesign the
> CCF locking scheme so this problem doesn't exist.

CCF locking scheme already suffers from the other issues, like long
waiting on common prepare lock and possible AB-BA deadlocks, which
were mentioned in the "clk: Add per-controller locks to fix
deadlocks" thread: https://lkml.org/lkml/2016/8/16/442

I thought the we will be able to continue that work, but sadly there
were other more urgent issue to resolve first.

After some more thoughts about that patchset, it should be quite easy
to switch to per-clock mutexes (instead of per-controller/per-provider).
This would however not solve all the discussed issues.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
