From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Wed, 10 Sep 2014 03:31:19 +0000
Subject: [PATCHv3 5/6] ARM: imx: Add initial support for Freescale LS1021A
In-Reply-To: <3532608.xLS91GQkq4@wuerfel>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <1410253952-15631-6-git-send-email-jingchang.lu@freescale.com>
 <3532608.xLS91GQkq4@wuerfel>
Message-ID: <daf5ec5b70164b3e9a810def41909c48@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>Sent: Tuesday, September 09, 2014 7:41 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Lu Jingchang-B35083; Guo Shawn-R65073; Lu Jingchang-B35083;
>devicetree at vger.kernel.org
>Subject: Re: [PATCHv3 5/6] ARM: imx: Add initial support for Freescale
>LS1021A
>
>On Tuesday 09 September 2014 17:12:31 Jingchang Lu wrote:
>> +#include "common.h"
>> +
>> +static void __init ls1021a_init_machine(void) {
>> +       mxc_arch_reset_init_dt();
>> +       of_platform_populate(NULL, of_default_bus_match_table, NULL,
>> +NULL); }
>> +
>> +static const char *ls1021a_dt_compat[] __initdata = {
>> +       "fsl,ls1021a",
>> +       NULL,
>> +};
>
>Please don't add any new users of mxc_arch_reset_init_dt(). We now have
>infrastructure to register a system-reset handler from the watchdog driver,
>so please do that instead, and clean up the existing users as well.
I just notice the restart_handler support, I will use that instead, thanks.

>
>> +DT_MACHINE_START(LS1021A, "Freescale LS1021A") #ifdef CONFIG_ZONE_DMA
>> +       .dma_zone_size  = SZ_128M,
>> +#endif
>> +       .init_machine   = ls1021a_init_machine,
>> +       .dt_compat      = ls1021a_dt_compat,
>> +       .restart        = mxc_restart,
>> +MACHINE_END
>
>I believe someone recently posted a patch to derive the dma_zone_size from
>device tree. Can yo try to find that and see if that will work for you?
>
>Can you explain what the reason is for needing a DMA zone?
>
>	Arnd
With LPAE enabled on our SoC, we meet the system complaint of
"coherent DMA mask 0xffffffff is smaller than system GFP_DMA mask 0xffffffffffffffff",
and I notice that CONFIG_ZONE_DMA and dma_zone_size is a common resolve for this.
Thanks.



Best Regards,
Jingchang
