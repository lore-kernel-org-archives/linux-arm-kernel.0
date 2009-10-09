From: dhaval.vasa@einfochips.com (Dhaval Vasa)
Date: Fri, 09 Oct 2009 19:33:25 +0530
Subject: [PATCH] [ARM] kirkwood: combine support for openrd base/client
	support
In-Reply-To: <200910091600.45161.dk-arm-linux@gmx.de>
References: <20091009123956.GA6085@chipmunk>
	<200910091600.45161.dk-arm-linux@gmx.de>
Message-ID: <4ACF42AD.6010103@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander, Dieter,

I will test it on saturday.

- Dhaval

Dieter Kiermaier wrote:
> Hi Alexander,
> 
> 
>> Based on the work done by Dhaval Vasa to add OpenRD Base support (and 
>> the unmerged Client) support, this patch adds support for the 
>> Kirkwood OpenRD Client board.
>>
>> I was 'inspired' by the work Hartley Sweeten had done in flattening 
>> mach-ep93xx into a single setup.c file; as there is really not much 
>> difference between the OpenRD Base and Client boards I think it is 
>> appropriate to do the same here.
>>
>> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
>>
>> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
>> index 0aca451..8e9ac7d 100644
>> --- a/arch/arm/mach-kirkwood/Kconfig
>> +++ b/arch/arm/mach-kirkwood/Kconfig
>> @@ -38,12 +38,23 @@ config MACH_TS219
>>  	  Say 'Y' here if you want your kernel to support the
>>  	  QNAP TS-119 and TS-219 Turbo NAS devices.
>>  
>> +config MACH_OPENRD
>> +        bool
>> +
>>  config MACH_OPENRD_BASE
>>  	bool "Marvell OpenRD Base Board"
>> +	select MACH_OPENRD
>>  	help
>>  	  Say 'Y' here if you want your kernel to support the
>>  	  Marvell OpenRD Base Board.
>>  
>> +config MACH_OPENRD_CLIENT
>> +	bool "Marvell OpenRD Client Board"
>> +	select MACH_OPENRD
>> +	help
>> +	  Say 'Y' here if you want your kernel to support the
>> +	  Marvell OpenRD Client Board.
>> +
>>  endmenu
>>  
>>  endif
>> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
>> index 80ab0ec..5ad19dd 100644
>> --- a/arch/arm/mach-kirkwood/Makefile
>> +++ b/arch/arm/mach-kirkwood/Makefile
>> @@ -6,6 +6,6 @@ obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
>>  obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
>>  obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
>>  obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o
>> -obj-$(CONFIG_MACH_OPENRD_BASE)		+= openrd_base-setup.o
>> +obj-$(CONFIG_MACH_OPENRD)		+= openrd-setup.o
>>  
>>  obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
>> diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
>> new file mode 100644
>> index 0000000..6bdeeab
>> --- /dev/null
>> +++ b/arch/arm/mach-kirkwood/openrd-setup.c
>> @@ -0,0 +1,109 @@
>> +/*
>> + * arch/arm/mach-kirkwood/openrd-setup.c
>> + *
>> + * Marvell OpenRD (Base|Client) Board Setup
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/ata_platform.h>
>> +#include <linux/mv643xx_eth.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <mach/kirkwood.h>
>> +#include <plat/mvsdio.h>
>> +#include "common.h"
>> +#include "mpp.h"
>> +
>> +static struct mtd_partition openrd_nand_parts[] = {
>> +	{
>> +		.name = "u-boot",
>> +		.offset = 0,
>> +		.size = SZ_1M
>> +	}, {
>> +		.name = "uImage",
>> +		.offset = MTDPART_OFS_NXTBLK,
>> +		.size = SZ_4M
>> +	}, {
>> +		.name = "root",
>> +		.offset = MTDPART_OFS_NXTBLK,
>> +		.size = MTDPART_SIZ_FULL
>> +	},
>> +};
>> +
>> +static struct mv643xx_eth_platform_data openrd_ge00_data = {
>> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
>> +};
>> +
>> +#ifdef CONFIG_MACH_OPENRD_CLIENT
>> +static struct mv643xx_eth_platform_data openrd_ge01_data = {
>> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(18),
>> +};
>> +#endif
>> +
>> +static struct mv_sata_platform_data openrd_sata_data = {
>> +	.n_ports	= 2,
>> +};
>> +
>> +static struct mvsdio_platform_data openrd_mvsdio_data = {
>> +	.gpio_card_detect = 29,	/* MPP29 used as SD card detect */
>> +};
>> +
>> +static unsigned int openrd_mpp_config[] __initdata = {
>> +	MPP29_GPIO,
>> +	0
>> +};
>> +
>> +static void __init openrd_init(void)
>> +{
>> +	/*
>> +	 * Basic setup. Needs to be called early.
>> +	 */
>> +	kirkwood_init();
>> +	kirkwood_mpp_conf(openrd_mpp_config);
>> +
>> +	kirkwood_uart0_init();
>> +	kirkwood_nand_init(ARRAY_AND_SIZE(openrd_nand_parts), 25);
>> +
>> +	kirkwood_ehci_init();
>> +
>> +	kirkwood_ge00_init(&openrd_ge00_data);
>> +#ifdef CONFIG_MACH_OPENRD_CLIENT
>> +	if (machine_is_openrd_client())
>> +		kirkwood_ge01_init(&openrd_ge01_data);
>> +#endif
> 
> shouldn't it be enough to have the if(machine_is.... statement?
> I didn't see why you test #ifdef, too?
> 
> Additionally it would be nice, if you could integrate the i2c / pcie init in your patch?
> Please see Simons patch at:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/001950.html
> 
> I have to leave now, but on monday I will do the test of your patch on my openrd-base board!
> 
> Many thanks,
> Dieter
> 
> 
> Email Scanned for Virus & Dangerous Content by : www.CleanMailGateway.com
> 
> 
-- 
_____________________________________________________________________
Disclaimer: This e-mail message and all attachments transmitted with it
are intended solely for the use of the addressee and may contain legally
privileged and confidential information. If the reader of this message
is not the intended recipient, or an employee or agent responsible for
delivering this message to the intended recipient, you are hereby
notified that any dissemination, distribution, copying, or other use of
this message or its attachments is strictly prohibited. If you have
received this message in error, please notify the sender immediately by
replying to this message and please delete it from your computer. Any
views expressed in this message are those of the individual sender
unless otherwise stated.Company has taken enough precautions to prevent
the spread of viruses. However the company accepts no liability for any
damage caused by any virus transmitted by this email.
_____________________________________________________________________
 
