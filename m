From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Sun, 21 Nov 2010 20:18:39 -0800
Subject: [PATCH 3/9] ARM: pxa: support pxa95x
In-Reply-To: <AANLkTikCkbqaVBvtWi1H2n800RnCBkx3MqnZ2R26arbt@mail.gmail.com>
References: <1289991823-24677-1-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-2-git-send-email-haojian.zhuang@marvell.com>
	<1289991823-24677-3-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTinT6Xex-17Vgrq5p1dZ+L-FLRE0uPASs74yMQOH@mail.gmail.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C0598749B6F@SC-VEXCH1.marvell.com>
	<AANLkTikCkbqaVBvtWi1H2n800RnCBkx3MqnZ2R26arbt@mail.gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C059ABECB61@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>Sent: 2010?11?22? 9:08 AM
>To: Haojian Zhuang
>Cc: linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCH 3/9] ARM: pxa: support pxa95x
>
>On Fri, Nov 19, 2010 at 5:16 PM, Haojian Zhuang <hzhuang1@marvell.com> wrote:
>>
>>
>>>-----Original Message-----
>>>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>>>Sent: 2010?11?19? 4:45 PM
>>>To: Haojian Zhuang
>>>Cc: linux-arm-kernel at lists.infradead.org
>>>Subject: Re: [PATCH 3/9] ARM: pxa: support pxa95x
>>>
>>>On Wed, Nov 17, 2010 at 7:03 PM, Haojian Zhuang
>>><haojian.zhuang@marvell.com> wrote:
>>>> The core of PXA955 is PJ4. Add new PJ4 support. And add new macro
>>>> CONFIG_PXA95x.
>>>>
>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>>>> Cc: Eric Miao <eric.y.miao@gmail.com>
>>>> ---
>>>> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? | ? 12 +-
>>>> ?arch/arm/mach-pxa/Makefile ? ? ? ? ? ? ? ?| ? ?1 +
>>>> ?arch/arm/mach-pxa/clock.h ? ? ? ? ? ? ? ? | ? 20 ++
>>>> ?arch/arm/mach-pxa/devices.c ? ? ? ? ? ? ? | ?267 +++++++++---------
>>>> ?arch/arm/mach-pxa/generic.c ? ? ? ? ? ? ? | ? ?8 +-
>>>> ?arch/arm/mach-pxa/generic.h ? ? ? ? ? ? ? | ? ?3 +-
>>>> ?arch/arm/mach-pxa/include/mach/hardware.h | ? 34 ++-
>>>> ?arch/arm/mach-pxa/include/mach/irqs.h ? ? | ? ?1 +
>>>> ?arch/arm/mach-pxa/pxa3xx.c ? ? ? ? ? ? ? ?| ? ?9 -
>>>> ?arch/arm/mach-pxa/pxa930.c ? ? ? ? ? ? ? ?| ? ?2 +-
>>>> ?arch/arm/mach-pxa/pxa95x.c ? ? ? ? ? ? ? ?| ?437
>>>+++++++++++++++++++++++++++++
>>>> ?arch/arm/mm/Kconfig ? ? ? ? ? ? ? ? ? ? ? | ? ?6 +
>>>> ?arch/arm/plat-pxa/Makefile ? ? ? ? ? ? ? ?| ? ?1 +
>>>> ?arch/arm/plat-pxa/include/plat/mfp.h ? ? ?| ? ?4 +-
>>>> ?14 files changed, 643 insertions(+), 162 deletions(-)
>>>> ?create mode 100644 arch/arm/mach-pxa/pxa95x.c
>>>>
>>>> +void __init pxa95x_init_irq(void)
>>>> +{
>>>
>>>No enabling of CP6 is needed for pxa95x?
>>>
>> Yes, PXA95x can't support to access interrupt registers via co-processors.
>>
>>>> + ? ? ? pxa_init_irq(96, NULL);
>>>> + ? ? ? pxa_init_ext_wakeup_irq(NULL);
>>>> + ? ? ? pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
>>>> +}
>>>> +
>>>> +
>>>> +static int __init pxa95x_init(void)
>>>> +{
>>>> + ? ? ? int ret = 0;
>>>> +
>>>> + ? ? ? if (cpu_is_pxa95x()) {
>>>> + ? ? ? ? ? ? ? mfp_init_base(io_p2v(MFPR_BASE));
>>>> + ? ? ? ? ? ? ? mfp_init_addr(pxa95x_mfp_addr_map);
>>>> +
>>>> + ? ? ? ? ? ? ? reset_status = ARSR;
>>>> +
>>>> + ? ? ? ? ? ? ? /*
>>>> + ? ? ? ? ? ? ? ?* clear RDH bit every time after reset
>>>> + ? ? ? ? ? ? ? ?*
>>>> + ? ? ? ? ? ? ? ?* Note: the last 3 bits DxS are write-1-to-clear so carefully
>>>> + ? ? ? ? ? ? ? ?* preserve them here in case they will be referenced later
>>>> + ? ? ? ? ? ? ? ?*/
>>>> + ? ? ? ? ? ? ? ASCR &= ~(ASCR_RDH | ASCR_D1S | ASCR_D2S | ASCR_D3S);
>>>> +
>>>> + ? ? ? ? ? ? ? clkdev_add_table(pxa95x_clkregs, ARRAY_SIZE(pxa95x_clkregs));
>>>> +
>>>> + ? ? ? ? ? ? ? if ((ret = pxa_init_dma(IRQ_DMA, 32)))
>>>> + ? ? ? ? ? ? ? ? ? ? ? return ret;
>>>> +
>>>
>>>No need to register pxa3xx_sysdev[]? My understanding is the IRQ/MFP/GPIO
>>>subsystems are just same.
>>>
>> I don't want to support PM feature now. So I remove them in current patch.
>>
>>>> + ? ? ? ? ? ? ? ret = platform_add_devices(devices, ARRAY_SIZE(devices));
>>>> + ? ? ? }
>>>> +
>>>> + ? ? ? return ret;
>>>> +}
>>>
>>>I'm afraid the above duplicates most part of pxa3xx.c, the only subtle
>>>difference
>>>is the missing of pxa3xx_init_pm(), which is due to the difference of the power
>>>management. Instead of duplicating so much code, another better way out is:
>>>
>>>1) remove pxa3xx_init_pm() from pxa3xx_init()
>>>2) remove pxa3xx_init() from postcore_init()
>>>3) change pxa3xx_init() to pxa3xx_common_init()
>>>4) in pxa300_init() and pxa320_init(), call pxa3xx_common_init() as
>>>well as pxa3xx_init_pm()
>>>5) in pxa95x_init(), call pxa3xx_common_init() and pxa95x's specific
>>>pm initialization
>>> ?(e.g. pxa95x_init_pm)
>>>
>> The name of pxa3xx_init() and pxa3xx_common_init() is very confusion.
>
>I know it's a bit confusing. But they are sharing the same code, and it's
>only a matter of naming issue. Like many drivers we have, they are called
>'pxa2xx-*' but actually able to support pxa3xx, pxa9xx and even pxa168.
>
>> PXA95x is based on ARMv7. I don't prefer to compile it with PXA3xx in one image now.
>Actually I failed to compile them together.
>>
>
>Nah, it's not a hard requirement to build them together. It's about reducing
>code duplication.
>
>My idea would be to separate clock and pm into separate files, making them
>more self-contained driver-like, instead of hardcoding them into pxa3xx.c.
>So in the end, the pxa95x_init() will be something like below:
>
>static int __init pxa95x_init(void)
>{
>	if (cpu_is_pxa95x()) {
>		pxa_init_dma(IRQ_DMA, 32);
>		pxa3xx_init_pm();
>		pxa3xx_init_clock();
>		clkdev_add_table(ARRAY_AND_SIZE(pxa95x_clkregs));
>
>		for_each(p, pxa95x_sysdevs)
>			sysdev_register(p);
>
>		platform_add_devices(ARRAY_AND_SIZE(pxa95x_devices));
>	}
>}
>
>So it reads like pxa95x is using the same subsystem as pxa3xx PM
>and clock, and if there are any subtle differences to handle, we can
>just change the API, and let know the difference through parameters,
>just like pxa_init_dma().
>
>Let me know if you think this is better and acceptable.

I don't agree invoking pxa3xx_init_pm() and pxa3xx_init_clock() in pxa95x.c. It's based on two reasons of naming confusion and force building pxa3xx.c for pxa95x.

If we want to share code, I suggest to move the sharing code into generic.c. So pxa95x.c will call xsc3_init_pm()/xsc3_init_clock() or common_init_pm()/common_init_clock(). What's your opinion?

Now we move PXA300/PXA310/PXA320/PXA930/PXA935 into pxa3xx family. So we shouldn't invoke pxa3xx_xxx() functions in other family. Otherwise, it's hard to be understood and maintained.

Thanks
Haojian
