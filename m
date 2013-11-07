From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 07 Nov 2013 11:12:49 +0100
Subject: [PATCH v3 9/9] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <20131107134033.59bd127a@xhacker>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-10-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131107134033.59bd127a@xhacker>
Message-ID: <527B67A1.3020803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/13 06:40, Jisheng Zhang wrote:
> On Tue, 5 Nov 2013 06:28:43 -0800
> Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
>
>> This adds initial support for the Marvell Berlin SoC family with
>> Armada 1500 (88DE3100) and Armada 1500-mini (88DE3005) SoCs.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> Reviewed-by: Jason Cooper <jason@lakedaemon.net>
>> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> ---
[...]
>> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
>> new file mode 100644
>> index 0000000..c5b39b1
>> --- /dev/null
>> +++ b/arch/arm/mach-berlin/Kconfig
>> @@ -0,0 +1,30 @@
>> +config ARCH_BERLIN
>> +	bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
>> +	select GENERIC_CLOCKEVENTS
>> +	select GENERIC_IRQ_CHIP
>> +	select COMMON_CLK
>> +	select DW_APB_ICTL
>> +	select DW_APB_TIMER_OF
>> +
>> +if ARCH_BERLIN
>> +
>> +menu "Marvell Berlin SoC variants"
>> +
>> +config MACH_BERLIN_BG2
>> +	bool "Marvell Armada 1500 (BG2)"
>> +	select ARM_GIC
> ARM_GIC is common on berlin SoCs. we can put it below ARCH_BERLIN?

Sure, I guess BG3 is also using GIC?

>> +	select CACHE_L2X0
> ditto

You already re-replied to that. I leave L2X0 here, BG3 will be
different, as you stated.

>> +	select CPU_PJ4B
>> +	select HAVE_ARM_TWD
>> +	select HAVE_SMP
>> +
>> +config MACH_BERLIN_BG2CD
>> +	bool "Marvell Armada 1500-mini (BG2CD)"
>> +	select ARM_GIC
>> +	select CACHE_L2X0
>> +	select CPU_V7
>> +	select HAVE_ARM_TWD
> BG2CD is single core, I'm not sure it have twd. I will check with SoC people.
> But can twd be really used in single CA9 system?

 From a quick view into Cortex-A9 MPCore TRM, I cannot see why it
shouldn't be there even for single-core. If you can get more info,
that would be great.

Actually, IIRC smp_twd does not compile without SMP set, so the above
should at least be 'HAVE_ARM_TWD if SMP'. If you shrink MULTI_V7 down
to non-SMP cores, you can disable it and it will fail to compile.

>> +
>> +endmenu
>> +
>> +endif
>> diff --git a/arch/arm/mach-berlin/Makefile b/arch/arm/mach-berlin/Makefile
>> new file mode 100644
>> index 0000000..ab69fe9
>> --- /dev/null
>> +++ b/arch/arm/mach-berlin/Makefile
>> @@ -0,0 +1 @@
>> +obj-y += berlin.o
>> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
>> new file mode 100644
>> index 0000000..16c2942
>> --- /dev/null
>> +++ b/arch/arm/mach-berlin/berlin.c
>> @@ -0,0 +1,39 @@
>> +/*
>> + * Device Tree support for Marvell Berlin SoCs.
>> + *
>> + * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> + *
>> + * based on GPL'ed 2.6 kernel sources
>> + *  (c) Marvell International Ltd.
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of_platform.h>
>> +#include <asm/hardware/cache-l2x0.h>
>> +#include <asm/mach/arch.h>
>> +
>> +static void __init berlin_init_machine(void)
>> +{
>> +	/*
>> +	 * with DT probing for L2CCs, berlin_init_machine can be removed.
>> +	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
>> +	 */
>> +	l2x0_of_init(0x70c00000, 0xfeffffff);
> Per my experience, put l2x0 initialization in init_machine is too late. It
> did cause some boot stability problems during our product massive bootup test.
> In our internal 3.10.y tree, we put it in init_early, I also suggest we do
> this too in mainline.

Ok.

>> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> If l2 initialization is put in init_early, this is not needed any more.

Right, that's already in the comment right above l2x0_of_init ;)

>> +}
>> +
>> +static const char * const berlin_dt_compat[] = {
>> +	"marvell,berlin",
>> +	NULL,
>> +};
>> +
>> +DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
>> +	.dt_compat      = berlin_dt_compat,
>> +	.init_machine   = berlin_init_machine,
>> +MACHINE_END
>
