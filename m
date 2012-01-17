From: aneesh@ti.com (Aneesh V)
Date: Tue, 17 Jan 2012 19:24:56 +0530
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled
 by uBoot)?
In-Reply-To: <20120117134143.GF11475@arm.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
 <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com> <20120117134143.GF11475@arm.com>
Message-ID: <4F157DB0.4020202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 January 2012 07:11 PM, Catalin Marinas wrote:
> On Tue, Jan 17, 2012 at 12:27:25PM +0000, Aneesh V wrote:
>> Hi Catalin,
>>
>> On Tuesday 17 January 2012 05:41 PM, Catalin Marinas wrote:
>>> On Tue, Jan 17, 2012 at 08:54:44AM +0000, Joe Woodward wrote:
>>>> So, is the upshot of this that the kernel isn't going to be in a
>>>> position to enable the L2/outer cache on OMAP3 (due to the need for
>>>> hacky/unmaintainable code)?
>>>>
>>>> Hence the bootloader/uBoot had better leave it enabled...
>>>
>>> It could but the Linux decompressor needs to be aware and either flush
>>> the L2 (more difficult as it doesn't have all the device information) or
>>
>> Cortex-A8 is aware of L2$ and can flush it, isn't it?
>
> As I said to Santosh, I only had the outer cache in mind (e.g. PL310).
> There is no extra configuration needed in the kernel decompressor in
> this case.
>
>>> set the page table attributes to outer non-cacheable (TEX[2:0] = 0b100).
>>
>> If the above is right, this is not needed right?
>
> Correct, since L2 is inner cache.
>
>>> The latter may still not work if there are stale L2 cache lines left by
>>> U-Boot (and that's always possible unless U-Boot also uses outer
>>> non-cacheable memory attributes).
>>
>> U-Boot flushes the caches before disabling it. On top of it, it does an
>> invalidate after the disabling the caches to cover some corner case.
>> So, it's guaranteed that there won't be any stale entries in L2 after
>> U-Boot.
>>
>> So, we could as well leave L2$ enabled (and invalidated) and caches
>> disabled globally after U-Boot.
>
> Yes.
>
>> But I thought enabling L2$ again in kernel is the cleaner solution.
>
> Why? It gets enabled via SCTLR.M together with L1.

Well, technically I don't see any issue. But after all, it's a
bootloader dependency that could be avoided. We could not blame U-Boot
or any other bootloader for disabling L2$ given [1]

[1] http://www.arm.linux.org.uk/developer/booting.php#5
