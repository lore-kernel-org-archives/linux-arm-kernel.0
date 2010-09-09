From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 9 Sep 2010 15:39:15 +0800
Subject: [PATCH 1/3] ARM: pxa168: added support for Teton BGA platform
In-Reply-To: <201009090321.24440.marek.vasut@gmail.com>
References: <1283914607-10570-1-git-send-email-mark.brown314@gmail.com>
	<201009081751.22841.marek.vasut@gmail.com>
	<AANLkTim+heO9nDOUhKYatAKts6QcPvcE0tBs=wVtvF4g@mail.gmail.com>
	<201009090321.24440.marek.vasut@gmail.com>
Message-ID: <AANLkTing3Zk1kNsq-j2EXva5VhSGz44GmhmOQQ6KMCP_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 9, 2010 at 9:21 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne ?t 9. z??? 2010 01:42:36 Mark F. Brown napsal(a):
>> On Wed, Sep 8, 2010 at 11:51 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> > Dne St 8. z??? 2010 04:56:45 Mark F. Brown napsal(a):
>> >
>> > ---------------------------
>> > Description is missing here
>> > ---------------------------
>> >
>> >> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
>> >> ---
>> >> ?arch/arm/mach-mmp/Kconfig ? ? | ? ?7 ++++++
>> >> ?arch/arm/mach-mmp/Makefile ? ?| ? ?1 +
>> >> ?arch/arm/mach-mmp/teton_bga.c | ? 47
>> >> +++++++++++++++++++++++++++++++++++++++++ 3 files changed, 55
>> >> insertions(+), 0 deletions(-)
>> >> ?create mode 100644 arch/arm/mach-mmp/teton_bga.c
>> >>
>> >> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
>> >> index 6ab843e..0711d3b 100644
>> >> --- a/arch/arm/mach-mmp/Kconfig
>> >> +++ b/arch/arm/mach-mmp/Kconfig
>> >> @@ -57,6 +57,13 @@ config MACH_MARVELL_JASPER
>> >> ? ? ? ? PXA910-based development board. Since MMP2 is compatible to
>> >> ? ? ? ? ARMv6 architecture.
>> >>
>> >> +config MACH_TETON_BGA
>> >> + ? ? bool "Marvell's PXA168 Teton BGA Development Board"
>> >> + ? ? select CPU_PXA168
>> >> + ? ? help
>> >> + ? ? ? Say 'Y' here if you want to support the Marvell PXA168-based
>> >> + ? ? ? Teton BGA Development Board.
>> >> +
>> >> ?endmenu
>> >>
>> >> ?config CPU_PXA168
>> >> diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
>> >> index 8b66d06..751cdbf 100644
>> >> --- a/arch/arm/mach-mmp/Makefile
>> >> +++ b/arch/arm/mach-mmp/Makefile
>> >> @@ -17,3 +17,4 @@ obj-$(CONFIG_MACH_TAVOREVB) += tavorevb.o
>> >> ?obj-$(CONFIG_MACH_TTC_DKB) ? += ttc_dkb.o
>> >> ?obj-$(CONFIG_MACH_FLINT) ? ? += flint.o
>> >> ?obj-$(CONFIG_MACH_MARVELL_JASPER) += jasper.o
>> >> +obj-$(CONFIG_MACH_TETON_BGA) += teton_bga.o
>> >> diff --git a/arch/arm/mach-mmp/teton_bga.c
>> >> b/arch/arm/mach-mmp/teton_bga.c new file mode 100644
>> >> index 0000000..014cc37
>> >> --- /dev/null
>> >> +++ b/arch/arm/mach-mmp/teton_bga.c
>> >> @@ -0,0 +1,47 @@
>> >> +/*
>> >> + * ?linux/arch/arm/mach-mmp/teton_bga.c
>> >> + *
>> >> + * ?Support for the Marvell PXA168 Teton BGA Development Platform.
>> >
>> > Authoring information of this file are missing. Also, MAINTAINERS entry
>> > is missing.
>> >
>> >> + *
>> >> + * ?This code is based on aspenite.c
>> >> + *
>> >> + * ?This program is free software; you can redistribute it and/or
>> >> modify + * ?it under the terms of the GNU General Public License
>> >> version 2 as + * ?publishhed by the Free Software Foundation.
>> >> + */
>> >> +
>> >> +#include <linux/init.h>
>> >> +#include <linux/kernel.h>
>> >> +#include <linux/platform_device.h>
>> >> +
>> >> +#include <asm/mach-types.h>
>> >> +#include <asm/mach/arch.h>
>> >> +#include <mach/addr-map.h>
>> >> +#include <mach/mfp-pxa168.h>
>> >> +#include <mach/pxa168.h>
>> >> +#include <mach/gpio.h>
>> >
>> > use ... #include <linux/gpio.h>
>> >
>> >> +
>> >> +#include "common.h"
>> >> +
>> >> +static unsigned long teton_bga_pin_config[] __initdata = {
>> >> + ? ? /* UART1 */
>> >> + ? ? GPIO107_UART1_TXD,
>> >> + ? ? GPIO108_UART1_RXD,
>> >> +};
>> >> +
>> >> +static void __init teton_bga_init(void)
>> >> +{
>> >> + ? ? mfp_config(ARRAY_AND_SIZE(teton_bga_pin_config));
>> >> +
>> >> + ? ? /* on-chip devices */
>> >> + ? ? pxa168_add_uart(1);
>> >
>> > Don't we have enum for these magic numbers on pxa168 ?
>> >
>> >> +}
>> >> +
>> >> +MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
>> >> + ? ? .phys_io ? ? ? ?= APB_PHYS_BASE,
>> >> + ? ? .io_pg_offst ? ?= (APB_VIRT_BASE >> 18) & 0xfffc,
>> >> + ? ? .map_io ? ? ? ? = mmp_map_io,
>> >> + ? ? .init_irq ? ? ? = pxa168_init_irq,
>> >> + ? ? .timer ? ? ? ? ?= &pxa168_timer,
>> >> + ? ? .init_machine ? = teton_bga_init,
>> >> +MACHINE_END
>> >
>> > Cheers
>>
>> I am assuming you mean the magic number for .io_pg_offst:
>> ?.io_pg_offst ? ?= (APB_VIRT_BASE >> 18) & 0xfffc,
>
> Nope, sorry, I meant this:
>
> + ? ? pxa168_add_uart(1);
>
> The (1) seems weird, but whatever. I don't have any pxa168 device.
>

Actually the parameter means the device ID, so pxa168_add_uart(1)
means to add UART1 on pxa168, so it's quite straight-forward.
