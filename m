From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 17 Jan 2012 13:40:54 +0100
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <4F15692D.4070100@ti.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
 <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
Message-ID: <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 1:27 PM, Aneesh V <aneesh@ti.com> wrote:
> Hi Catalin,
>
>
> On Tuesday 17 January 2012 05:41 PM, Catalin Marinas wrote:
>>
>> On Tue, Jan 17, 2012 at 08:54:44AM +0000, Joe Woodward wrote:
>>>
>>> So, is the upshot of this that the kernel isn't going to be in a
>>> position to enable the L2/outer cache on OMAP3 (due to the need for
>>> hacky/unmaintainable code)?
>>>
>>> Hence the bootloader/uBoot had better leave it enabled...
>>
>>
>> It could but the Linux decompressor needs to be aware and either flush
>> the L2 (more difficult as it doesn't have all the device information) or
>
>
> Cortex-A8 is aware of L2$ and can flush it, isn't it?
>
>
>> set the page table attributes to outer non-cacheable (TEX[2:0] = 0b100).
>
>
> If the above is right, this is not needed right?
>
Well the L2 can be configured as inner or outer, so above
alone won't work.

Boot-loader disabling L2 cache ( all caches)  is still right thing
and that's what kernel expect.

Since the early kernel code can't be patches for A8, may be
delaying L2 enabled would work.

But then on A15, we are back to square one since there is no
control to turn ON/OFF l2 cache. On A15 infact there are other
CP15 registers which needs to be set before MMU is enabled to
have best configuration.

So the need of this early hook is pretty much there. May be separate
CPU setup code for such cases is a possible way to go.

Basically the problem needs to be sorted out, because I already
see this is needed for A15 as well

Regards
Santosh
