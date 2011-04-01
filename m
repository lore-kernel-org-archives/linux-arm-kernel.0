From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 1 Apr 2011 14:47:31 +0800
Subject: [PATCH 3/9] ARM: mmp: remove redundant macro definition in mfp
In-Reply-To: <25B60CDC2F704E4E9D88FFD52780CB4C05CEEB84CC@SC-VEXCH1.marvell.com>
References: <1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTi=4vK_626Wv5DE_F1j7tqy-ZxEJr1NitgA13GOo@mail.gmail.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C05CEEB84B9@SC-VEXCH1.marvell.com>
	<AANLkTinszj2qgwg6HNbmdjp+c8WhKj1Zz=YPO6FJMzy7@mail.gmail.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C05CEEB84CC@SC-VEXCH1.marvell.com>
Message-ID: <AANLkTinj_tjNpiTwgGGQsd=-oQB+WfCUFdHcJM7gaW3U@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2011 at 1:45 PM, Haojian Zhuang <hzhuang1@marvell.com> wrote:
>
>
>>-----Original Message-----
>>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>>Sent: 2011?4?1? 1:31 PM
>>To: Haojian Zhuang
>>Cc: linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org
>>Subject: Re: [PATCH 3/9] ARM: mmp: remove redundant macro definition in
>>mfp
>>
>>On Fri, Apr 1, 2011 at 1:09 PM, Haojian Zhuang <hzhuang1@marvell.com>
>>wrote:
>>>
>>>
>>>>-----Original Message-----
>>>>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>>>>Sent: 2011?4?1? 12:51 PM
>>>>To: Haojian Zhuang
>>>>Cc: linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org
>>>>Subject: Re: [PATCH 3/9] ARM: mmp: remove redundant macro definition
>>in
>>>>mfp
>>>>
>>>>On Fri, Apr 1, 2011 at 10:39 AM, Haojian Zhuang
>>>><haojian.zhuang@marvell.com> wrote:
>>>>> There're two layers in MFP implementation. One is MFP layer that is
>>>>logical
>>>>> pin setting. And the other is MFPR layer that is physical register
>>>>setting.
>>>>>
>>>>> MFP drive setting is different between PXA168 and PXA910. But the
>>>>difference
>>>>> was stored in logical layer, not physical layer. And some
>>unnecessary
>>>>macro
>>>>> definition were added for ARCH_MMP.
>>>>
>>>>The implementation is indeed a bit complicated, yet I don't see the
>>>>change here is necessary so far.
>>>>
>>>>The MFPR bit definitions for pxa168/910 and mmp2 are basically
>>>>following the pxa3xx's.
>>>>
>>>>And definitions like DRIVE_SLOW, DRIVE_VERY_SLOW are really
>>>>pxa168/910, mmp2 specific. And it's no equivalent to DS01X, DS02X
>>>>..., which is more pxa3xx specific.
>>>>
>>>>BTW, does the existing code cause any bug/limitation?
>>>>
>>> Yes, there's some limitation in existing code since it's for pxa3xx.
>>For example, driver strength is bit[12..10] in PXA3xx. In
>>PXA955/910/MMP2, it's bit[12..11]. In PXA168, it's bit[11..10].
>>
>>This can be covered by definitions of DRIVE_SLOW, DRIVE_FAST, and
>>it's transparent to the API usage.
>>
> But driver strength are different in logical layer for different SoCs. Actually it's hard reading and caused some error before.
> As my understanding, difference can only exists in physical layer. Logical layer should keep consistent.
>

The problem is, the drive strength is already defined differently across
SoCs. Like we defined:

_DRIVE_{VERY_SLOW, SLOW, MEDIUM, FAST} for MMP series
_DS{01X,02X,03X,...08X, 10X, 13X} for pxa3xx

And there is no such thing for pxa2xx.

>>> And there's no sleep mode in PXA168.
>>
>>Thus there will be no MFP_LPM_* usage in pxa168 board file.
>>
> It was touched in mfpr_lpm. Since LPM_INPUT is used by default. Those bits should not be touched if no requirement. I can use MFPR_FLOAT by default, so no_lpm can be avoided.

Yes please.

>
>>> Sleep mode bit is different in PXA910.
>>
>>Example, like?
>>
> Bit 7 should be always on in PXA910.

Can we solve this in mfp-pxa910.h by defining a pxa910 specific MFP_CFG()
macro?

>>>
>>>>>
>>>>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>>>>> ---
>>>>> ?arch/arm/mach-mmp/include/mach/mfp-mmp2.h ? | ? ?7 +----
>>>>> ?arch/arm/mach-mmp/include/mach/mfp-pxa168.h | ? ?7 +----
>>>>> ?arch/arm/mach-mmp/include/mach/mfp-pxa910.h | ? ?7 +----
>>>>> ?arch/arm/mach-mmp/include/mach/mfp.h ? ? ? ?| ? 34 ----------------
>>--
>>>>---------
>>>>> ?arch/arm/mach-mmp/mmp2.c ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
>>>>> ?arch/arm/mach-mmp/pxa168.c ? ? ? ? ? ? ? ? ?| ? ?2 +-
>>>>> ?arch/arm/mach-mmp/pxa910.c ? ? ? ? ? ? ? ? ?| ? ?2 +-
>>>>> ?arch/arm/plat-pxa/include/plat/mfp.h ? ? ? ?| ? ?4 +++
>>>>> ?arch/arm/plat-pxa/mfp.c ? ? ? ? ? ? ? ? ? ? | ? 22 +++++++++++++++-
>>>>> ?9 files changed, 30 insertions(+), 57 deletions(-)
>>>>> ?delete mode 100644 arch/arm/mach-mmp/include/mach/mfp.h
>>>>>
>>>>> diff --git a/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
>>>>b/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
>>>>> index 4ad3862..c66eaea 100644
>>>>> --- a/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
>>>>> +++ b/arch/arm/mach-mmp/include/mach/mfp-mmp2.h
>>>>> @@ -1,12 +1,7 @@
>>>>> ?#ifndef __ASM_MACH_MFP_MMP2_H
>>>>> ?#define __ASM_MACH_MFP_MMP2_H
>>>>>
>>>>> -#include <mach/mfp.h>
>>>>> -
>>>>> -#define MFP_DRIVE_VERY_SLOW ? ?(0x0 << 13)
>>>>> -#define MFP_DRIVE_SLOW ? ? ? ? (0x2 << 13)
>>>>> -#define MFP_DRIVE_MEDIUM ? ? ? (0x4 << 13)
>>>>> -#define MFP_DRIVE_FAST ? ? ? ? (0x6 << 13)
>>>>> +#include <plat/mfp.h>
>>>>>
>>>>> ?/* GPIO */
>>>>> ?#define GPIO0_GPIO ? ? MFP_CFG(GPIO0, AF0)
>>>>> diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
>>>>b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
>>>>> index 4621067..4aadbea 100644
>>>>> --- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
>>>>> +++ b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
>>>>> @@ -1,12 +1,7 @@
>>>>> ?#ifndef __ASM_MACH_MFP_PXA168_H
>>>>> ?#define __ASM_MACH_MFP_PXA168_H
>>>>>
>>>>> -#include <mach/mfp.h>
>>>>> -
>>>>> -#define MFP_DRIVE_VERY_SLOW ? ?(0x0 << 13)
>>>>> -#define MFP_DRIVE_SLOW ? ? ? ? (0x1 << 13)
>>>>> -#define MFP_DRIVE_MEDIUM ? ? ? (0x2 << 13)
>>>>> -#define MFP_DRIVE_FAST ? ? ? ? (0x3 << 13)
>>>>> +#include <plat/mfp.h>
>>>>>
>>>>> ?/* GPIO */
>>>>> ?#define GPIO0_GPIO ? ? ? ? ? ? MFP_CFG(GPIO0, AF5)
>>>>> diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
>>>>b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
>>>>> index fbd7ee8..f5d33be 100644
>>>>> --- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
>>>>> +++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
>>>>> @@ -1,12 +1,7 @@
>>>>> ?#ifndef __ASM_MACH_MFP_PXA910_H
>>>>> ?#define __ASM_MACH_MFP_PXA910_H
>>>>>
>>>>> -#include <mach/mfp.h>
>>>>> -
>>>>> -#define MFP_DRIVE_VERY_SLOW ? ?(0x0 << 13)
>>>>> -#define MFP_DRIVE_SLOW ? ? ? ? (0x2 << 13)
>>>>> -#define MFP_DRIVE_MEDIUM ? ? ? (0x4 << 13)
>>>>> -#define MFP_DRIVE_FAST ? ? ? ? (0x6 << 13)
>>>>> +#include <plat/mfp.h>
>>>>>
>>>>> ?/* UART2 */
>>>>> ?#define GPIO47_UART2_RXD ? ? ? MFP_CFG(GPIO47, AF6)
>>>>> diff --git a/arch/arm/mach-mmp/include/mach/mfp.h b/arch/arm/mach-
>>>>mmp/include/mach/mfp.h
>>>>> deleted file mode 100644
>>>>> index 62e510e..0000000
>>>>> --- a/arch/arm/mach-mmp/include/mach/mfp.h
>>>>> +++ /dev/null
>>>>> @@ -1,34 +0,0 @@
>>>>> -#ifndef __ASM_MACH_MFP_H
>>>>> -#define __ASM_MACH_MFP_H
>>>>> -
>>>>> -#include <plat/mfp.h>
>>>>> -
>>>>> -/*
>>>>> - * NOTE: the MFPR register bit definitions on PXA168 processor
>>lines
>>>>are a
>>>>> - * bit different from those on PXA3xx. ?Bit [7:10] are now reserved,
>>>>which
>>>>> - * were SLEEP_OE_N, SLEEP_DATA, SLEEP_SEL and the LSB of DRIVE bits.
>>>>> - *
>>>>> - * To cope with this difference and re-use the pxa3xx mfp code as
>>>>much as
>>>>> - * possible, we make the following compromise:
>>>>> - *
>>>>> - * 1. SLEEP_OE_N will always be programmed to '1' (by MFP_LPM_FLOAT)
>>>>> - * 2. DRIVE strength definitions redefined to include the reserved
>>>>bit
>>>>> - * ? ?- the reserved bit differs between pxa168 and pxa910, and the
>>>>> - * ? ? ?MFP_DRIVE_* macros are individually defined in mfp-
>>>>pxa{168,910}.h
>>>>> - * 3. Override MFP_CFG() and MFP_CFG_DRV()
>>>>> - * 4. Drop the use of MFP_CFG_LPM() and MFP_CFG_X()
>>>>> - */
>>>>> -
>>>>> -#undef MFP_CFG
>>>>> -#undef MFP_CFG_DRV
>>>>> -#undef MFP_CFG_LPM
>>>>> -#undef MFP_CFG_X
>>>>> -#undef MFP_CFG_DEFAULT
>>>>> -
>>>>> -#define MFP_CFG(pin, af) ? ? ? ? ? ? ? \
>>>>> - ? ? ? (MFP_LPM_FLOAT | MFP_PIN(MFP_PIN_##pin) | MFP_##af |
>>>>MFP_DRIVE_MEDIUM)
>>>>> -
>>>>> -#define MFP_CFG_DRV(pin, af, drv) ? ? ?\
>>>>> - ? ? ? (MFP_LPM_FLOAT | MFP_PIN(MFP_PIN_##pin) | MFP_##af |
>>>>MFP_DRIVE_##drv)
>>>>> -
>>>>> -#endif /* __ASM_MACH_MFP_H */
>>>>> diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
>>>>> index 8e6c3ac..14e6a23 100644
>>>>> --- a/arch/arm/mach-mmp/mmp2.c
>>>>> +++ b/arch/arm/mach-mmp/mmp2.c
>>>>> @@ -24,10 +24,10 @@
>>>>> ?#include <mach/cputype.h>
>>>>> ?#include <mach/irqs.h>
>>>>> ?#include <mach/dma.h>
>>>>> -#include <mach/mfp.h>
>>>>> ?#include <mach/gpio.h>
>>>>> ?#include <mach/devices.h>
>>>>> ?#include <mach/mmp2.h>
>>>>> +#include <plat/mfp.h>
>>>>>
>>>>> ?#include "common.h"
>>>>> ?#include "clock.h"
>>>>> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
>>>>> index 72b4e76..34df2b1 100644
>>>>> --- a/arch/arm/mach-mmp/pxa168.c
>>>>> +++ b/arch/arm/mach-mmp/pxa168.c
>>>>> @@ -24,7 +24,7 @@
>>>>> ?#include <mach/gpio.h>
>>>>> ?#include <mach/dma.h>
>>>>> ?#include <mach/devices.h>
>>>>> -#include <mach/mfp.h>
>>>>> +#include <plat/mfp.h>
>>>>>
>>>>> ?#include "common.h"
>>>>> ?#include "clock.h"
>>>>> diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
>>>>> index 8f92ccd..93b3b25 100644
>>>>> --- a/arch/arm/mach-mmp/pxa910.c
>>>>> +++ b/arch/arm/mach-mmp/pxa910.c
>>>>> @@ -22,8 +22,8 @@
>>>>> ?#include <mach/irqs.h>
>>>>> ?#include <mach/gpio.h>
>>>>> ?#include <mach/dma.h>
>>>>> -#include <mach/mfp.h>
>>>>> ?#include <mach/devices.h>
>>>>> +#include <plat/mfp.h>
>>>>>
>>>>> ?#include "common.h"
>>>>> ?#include "clock.h"
>>>>> diff --git a/arch/arm/plat-pxa/include/plat/mfp.h b/arch/arm/plat-
>>>>pxa/include/plat/mfp.h
>>>>> index 75f6564..b7dde0c 100644
>>>>> --- a/arch/arm/plat-pxa/include/plat/mfp.h
>>>>> +++ b/arch/arm/plat-pxa/include/plat/mfp.h
>>>>> @@ -378,6 +378,10 @@ typedef unsigned long mfp_cfg_t;
>>>>> ?#define MFP_DS13X ? ? ? ? ? ? ?(0x7 << 13)
>>>>> ?#define MFP_DS_MASK ? ? ? ? ? ?(0x7 << 13)
>>>>> ?#define MFP_DS(x) ? ? ? ? ? ? ?(((x) >> 13) & 0x7)
>>>>> +#define MFP_VERY_SLOW ? ? ? ? ?MFP_DS01X
>>>>> +#define MFP_SLOW ? ? ? ? ? ? ? MFP_DS02X
>>>>> +#define MFP_MEDIUM ? ? ? ? ? ? MFP_DS03X
>>>>> +#define MFP_FAST ? ? ? ? ? ? ? MFP_DS04X
>>>>>
>>>>> ?#define MFP_LPM_DEFAULT ? ? ? ? ? ? ? ?(0x0 << 16)
>>>>> ?#define MFP_LPM_DRIVE_LOW ? ? ?(0x1 << 16)
>>>>> diff --git a/arch/arm/plat-pxa/mfp.c b/arch/arm/plat-pxa/mfp.c
>>>>> index a9aa5ad..d335551 100644
>>>>> --- a/arch/arm/plat-pxa/mfp.c
>>>>> +++ b/arch/arm/plat-pxa/mfp.c
>>>>> @@ -19,6 +19,10 @@
>>>>> ?#include <linux/io.h>
>>>>> ?#include <linux/sysdev.h>
>>>>>
>>>>> +#ifdef CONFIG_ARCH_MMP
>>>>> +#include <mach/cputype.h>
>>>>> +#endif
>>>>> +
>>>>> ?#include <plat/mfp.h>
>>>>>
>>>>> ?#define MFPR_SIZE ? ? ?(PAGE_SIZE)
>>>>> @@ -165,8 +169,14 @@ static inline void __mfp_config_lpm(struct
>>>>mfp_pin *p)
>>>>> ?void mfp_config(unsigned long *mfp_cfgs, int num)
>>>>> ?{
>>>>> ? ? ? ?unsigned long flags;
>>>>> - ? ? ? int i;
>>>>> -
>>>>> + ? ? ? int i, drv_b11 = 0, no_lpm = 0;
>>>>> +
>>>>> +#ifdef CONFIG_ARCH_MMP
>>>>> + ? ? ? if (cpu_is_pxa910() || cpu_is_mmp2())
>>>>> + ? ? ? ? ? ? ? drv_b11 = 1;
>>>>> + ? ? ? if (cpu_is_pxa168() || cpu_is_pxa910())
>>>>> + ? ? ? ? ? ? ? no_lpm = 1;
>>>>> +#endif
>>>>> ? ? ? ?spin_lock_irqsave(&mfp_spin_lock, flags);
>>>>>
>>>>> ? ? ? ?for (i = 0; i < num; i++, mfp_cfgs++) {
>>>>> @@ -183,6 +193,10 @@ void mfp_config(unsigned long *mfp_cfgs, int
>>num)
>>>>> ? ? ? ? ? ? ? ?lpm = MFP_LPM_STATE(c);
>>>>> ? ? ? ? ? ? ? ?edge = MFP_LPM_EDGE(c);
>>>>> ? ? ? ? ? ? ? ?pull = MFP_PULL(c);
>>>>> + ? ? ? ? ? ? ? if (drv_b11)
>>>>> + ? ? ? ? ? ? ? ? ? ? ? drv = drv << 1;
>>>>> + ? ? ? ? ? ? ? if (no_lpm)
>>>>> + ? ? ? ? ? ? ? ? ? ? ? lpm = 0;
>>>>>
>>>>> ? ? ? ? ? ? ? ?/* run-mode pull settings will conflict with MFPR
>>bits
>>>>of
>>>>> ? ? ? ? ? ? ? ? * low power mode state, ?calculate mfpr_run and
>>>>mfpr_lpm
>>>>> @@ -272,6 +286,10 @@ void mfp_config_lpm(void)
>>>>> ? ? ? ?struct mfp_pin *p = &mfp_table[0];
>>>>> ? ? ? ?int pin;
>>>>>
>>>>> +#ifdef CONFIG_ARCH_MMP
>>>>> + ? ? ? if (cpu_is_pxa168() || cpu_is_pxa910())
>>>>> + ? ? ? ? ? ? ? return;
>>>>> +#endif
>>>>> ? ? ? ?for (pin = 0; pin < ARRAY_SIZE(mfp_table); pin++, p++)
>>>>> ? ? ? ? ? ? ? ?__mfp_config_lpm(p);
>>>>> ?}
>>>>> --
>>>>> 1.5.6.5
>>>>>
>>>>>
>>>
>
