From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 20 Aug 2010 18:33:33 +0800
Subject: [PATCH 1/1] [ARM] pxa: encode IRQ number into .nr_irqs
In-Reply-To: <20100820111846.8d569f90.ospite@studenti.unina.it>
References: <AANLkTim52Zz=DP5Q7278bximQXuRaiPHJp81FyTt5f0u@mail.gmail.com>
	<20100820111846.8d569f90.ospite@studenti.unina.it>
Message-ID: <AANLkTimevihA2BXfTWi=Be9sd8OiQB-4nd7gaC3Wro4a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 20, 2010 at 5:18 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> On Fri, 20 Aug 2010 16:42:20 +0800
> Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>
>> From 7f69e6e31d2bf34bbf156e9385daba08079aa38c Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Fri, 20 Aug 2010 15:23:59 +0800
>> Subject: [PATCH 1/1] [ARM] pxa: encode IRQ number into .nr_irqs
>>
>> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>
> Hi Haojian, the EZX changes look incomplete, see below.
>
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/Kconfig ? ? ? ? ? ? ? ? ? ?| ? 17 ----------
>> ?arch/arm/mach-pxa/balloon3.c ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/cm-x2xx.c ? ? ? ? ? ? ? ? ?| ? ?4 ++
>> ?arch/arm/mach-pxa/eseries.c ? ? ? ? ? ? ? ? ?| ? ?7 ++++
>> ?arch/arm/mach-pxa/ezx.c ? ? ? ? ? ? ? ? ? ? ?| ? ?5 +++
>> ?arch/arm/mach-pxa/hx4700.c ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/include/mach/balloon3.h ? ?| ? ?2 +
>> ?arch/arm/mach-pxa/include/mach/eseries-irq.h | ? ?1 +
>> ?arch/arm/mach-pxa/include/mach/hx4700.h ? ? ?| ? ?1 +
>> ?arch/arm/mach-pxa/include/mach/irqs.h ? ? ? ?| ? 42 ++------------------------
>> ?arch/arm/mach-pxa/include/mach/littleton.h ? | ? ?2 +
>> ?arch/arm/mach-pxa/include/mach/lpd270.h ? ? ?| ? ?1 +
>> ?arch/arm/mach-pxa/include/mach/lubbock.h ? ? | ? ?3 ++
>> ?arch/arm/mach-pxa/include/mach/magician.h ? ?| ? ?2 +
>> ?arch/arm/mach-pxa/include/mach/mainstone.h ? | ? ?2 +
>> ?arch/arm/mach-pxa/include/mach/pcm027.h ? ? ?| ? ?2 +
>> ?arch/arm/mach-pxa/include/mach/poodle.h ? ? ?| ? ?2 +
>> ?arch/arm/mach-pxa/include/mach/tosa.h ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-pxa/include/mach/zeus.h ? ? ? ?| ? ?2 +
>> ?arch/arm/mach-pxa/include/mach/zylonite.h ? ?| ? ?2 +
>> ?arch/arm/mach-pxa/littleton.c ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-pxa/lpd270.c ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/lubbock.c ? ? ? ? ? ? ? ? ?| ? ?3 +-
>> ?arch/arm/mach-pxa/magician.c ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/mainstone.c ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-pxa/pcm027.c ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/poodle.c ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/stargate2.c ? ? ? ? ? ? ? ?| ? ?3 ++PXA_EZX, this one also h
>> ?arch/arm/mach-pxa/tosa.c ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/zeus.c ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-pxa/zylonite.c ? ? ? ? ? ? ? ? | ? ?1 +
>> ?32 files changed, 59 insertions(+), 57 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 9295110..45f93e1 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>
> Look for config PXA_EZX, this one also has PXA_HAVE_BOARD_IRQS selected.
>
> [...]
>
>> diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
>> index 626c82b..67dd3b7 100644
>> --- a/arch/arm/mach-pxa/ezx.c
>> +++ b/arch/arm/mach-pxa/ezx.c
>> @@ -38,6 +38,8 @@
>> ?#include "devices.h"
>> ?#include "generic.h"
>>
>> +#define EZX_NR_IRQS ? ? ? ? ? ? ? ? ?(IRQ_BOARD_START + 24)
>> +
>> ?#define GPIO12_A780_FLIP_LID ? ? ? ? ? ? ? ? 12
>> ?#define GPIO15_A1200_FLIP_LID ? ? ? ? ? ? ? ?15
>> ?#define GPIO15_A910_FLIP_LID ? ? ? ? ? ? ? ? 15
>> @@ -1124,6 +1126,7 @@ MACHINE_START(EZX_A910, "Motorola EZX A910")
>> ? ? ? .io_pg_offst ? ?= (io_p2v(0x40000000) >> 18) & 0xfffc,
>> ? ? ? .boot_params ? ?= 0xa0000100,
>> ? ? ? .map_io ? ? ? ? = pxa_map_io,
>> + ? ? .nr_irqs ? ? ? ?= EZX_NR_IRQS,
>> ? ? ? .init_irq ? ? ? = pxa27x_init_irq,
>> ? ? ? .timer ? ? ? ? ?= &pxa_timer,
>> ? ? ? .init_machine ? = a910_init,
>> @@ -1190,6 +1193,7 @@ MACHINE_START(EZX_E6, "Motorola EZX E6")
>> ? ? ? .io_pg_offst ? ?= (io_p2v(0x40000000) >> 18) & 0xfffc,
>> ? ? ? .boot_params ? ?= 0xa0000100,
>> ? ? ? .map_io ? ? ? ? = pxa_map_io,
>> + ? ? .nr_irqs ? ? ? ?= EZX_NR_IRQS,
>> ? ? ? .init_irq ? ? ? = pxa27x_init_irq,
>> ? ? ? .timer ? ? ? ? ?= &pxa_timer,
>> ? ? ? .init_machine ? = e6_init,
>> @@ -1230,6 +1234,7 @@ MACHINE_START(EZX_E2, "Motorola EZX E2")
>> ? ? ? .io_pg_offst ? ?= (io_p2v(0x40000000) >> 18) & 0xfffc,
>> ? ? ? .boot_params ? ?= 0xa0000100,
>> ? ? ? .map_io ? ? ? ? = pxa_map_io,
>> + ? ? .nr_irqs ? ? ? ?= EZX_NR_IRQS,
>> ? ? ? .init_irq ? ? ? = pxa27x_init_irq,
>> ? ? ? .timer ? ? ? ? ?= &pxa_timer,
>> ? ? ? .init_machine ? = e2_init,
>
> ezx.c has 6 (six) machines defined in it, you seem to be changing only
> three of them.
>
Good catch. I'll post it again.

Thanks
Haojian
