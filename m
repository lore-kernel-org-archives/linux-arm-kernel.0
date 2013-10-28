From: gerg@uclinux.org (Greg Ungerer)
Date: Mon, 28 Oct 2013 16:38:23 +1000
Subject: [PATCH 4/8] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <CAL_JsqJhM=K+vovDALQnjUSXBcuzHev1CUpxEnNqCYfOfGVsWQ@mail.gmail.com>
References: <1382076260-6422-1-git-send-email-gerg@uclinux.org>
 <1382076260-6422-5-git-send-email-gerg@uclinux.org>
 <CAL_JsqJhM=K+vovDALQnjUSXBcuzHev1CUpxEnNqCYfOfGVsWQ@mail.gmail.com>
Message-ID: <526E065F.60206@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 24/10/13 21:11, Rob Herring wrote:
> On Fri, Oct 18, 2013 at 1:04 AM,  <gerg@uclinux.org> wrote:
>> From: Greg Ungerer <gerg@uclinux.org>
>>
>> Add machine support code for the Freescale IMX50 SoC.
>>
>> It is very similar to the Freescale IMX53, it contains many of the same
>> periperhal hardware modules, at the same address offsets as the IMX53.
>> (Notable exceptions are that the IMX50 contains no CAN bus hardware, less
>> GPIO, no VPU, it does contain an Electrophoretic display controller though).
>>
>> So this support code just uses the IMX53 definitions as they are today.
>> We can add the extra IMX50 definitions in the future when required.
>>
>> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
>> ---
>>  arch/arm/mach-imx/Makefile     |  1 +
>>  arch/arm/mach-imx/mach-imx50.c | 52 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+)
>>  create mode 100644 arch/arm/mach-imx/mach-imx50.c
>>
>> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
>> index 5383c58..9d94f47 100644
>> --- a/arch/arm/mach-imx/Makefile
>> +++ b/arch/arm/mach-imx/Makefile
>> @@ -110,6 +110,7 @@ obj-$(CONFIG_MACH_EUKREA_CPUIMX51SD) += mach-cpuimx51sd.o
>>  obj-$(CONFIG_MACH_EUKREA_MBIMXSD51_BASEBOARD) += eukrea_mbimxsd51-baseboard.o
>>
>>  obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
>> +obj-$(CONFIG_SOC_IMX50) += mach-imx50.o
>>  obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
>>
>>  obj-$(CONFIG_SOC_VF610) += clk-vf610.o mach-vf610.o
>> diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
>> new file mode 100644
>> index 0000000..4ac1b91
>> --- /dev/null
>> +++ b/arch/arm/mach-imx/mach-imx50.c
>> @@ -0,0 +1,52 @@
>> +/*
>> + * Copyright 2013 Greg Ungerer <gerg@uclinux.org>
>> + * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + * Copyright 2011 Linaro Ltd.
>> + *
>> + * The code contained herein is licensed under the GNU General Public
>> + * License. You may obtain a copy of the GNU General Public License
>> + * Version 2 or later at the following locations:
>> + *
>> + * http://www.opensource.org/licenses/gpl-license.html
>> + * http://www.gnu.org/copyleft/gpl.html
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_platform.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/time.h>
>> +
>> +#include "common.h"
>> +#include "mx53.h"
>> +
>> +static void __init imx50_dt_init(void)
>> +{
>> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>> +}
>> +
>> +static const char *imx50_dt_board_compat[] __initdata = {
>> +       "fsl,imx50",
>> +       NULL
>> +};
>> +
>> +static void __init imx50_timer_init(void)
>> +{
>> +       mx50_clocks_init_dt();
>> +}
>> +
>> +DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
>> +       .map_io         = mx53_map_io,
>> +       .init_early     = imx53_init_early,
>> +       .init_irq       = mx53_init_irq,
>> +       .handle_irq     = imx53_handle_irq,
>> +       .init_time      = imx50_timer_init,
>> +       .init_machine   = imx50_dt_init,
>> +       .init_late      = imx53_init_late,
>> +       .dt_compat      = imx50_dt_board_compat,
>> +       .restart        = mxc_restart,
>> +MACHINE_END
> 
> This seems like a lot of duplication. It seems like mx53 and mx50
> could be combined into a single machine_desc. init_time should not be
> needed in 3.13.

Are you suggesting that "fsl,imx50" be added to the board compat list
in mach-imx53.c instead?

Regards
Greg
