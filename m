From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 16 Dec 2014 11:10:18 -0800
Subject: [PATCH] ARM: at91: board-dt-sama5: add phy_fixup to override
 NAND_Tree which improperly strapp-in during the reset period.
In-Reply-To: <54900779.9030509@atmel.com>
References: <1418283069-5648-1-git-send-email-wenyou.yang@atmel.com>
 <54900779.9030509@atmel.com>
Message-ID: <5490839A.304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/14 02:20, Nicolas Ferre wrote:
> Le 11/12/2014 08:31, Wenyou Yang a ?crit :
>> Appearance: On some SAMA5D4EK boards, after power up, the Eth1 doesn't work.
>>
>> Reason: The PIOE2 pin is connected to the NAND_Tree# of KSZ8081,
>> But it outputs LOW during the reset period, which cause the NAND_Tree# enabled.
>>
>> Add phy_fixup() to disable NAND_Tree by overriding the Operation
>> Mode Strap Override register(i.e. Register 16h) to clear the NAND_Tree bit.
>>
>> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> It seems correct to me.

Just one minor nit, see below

> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Anyway, I add Florian in the loop as he is the one who proposed this
> solution. So it would have been good to have his feeling about the
> implementation...
> 
> Bye,
> 
>> ---
>>  arch/arm/mach-at91/board-dt-sama5.c |   18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
>> index 8fb9ef5..97f7367 100644
>> --- a/arch/arm/mach-at91/board-dt-sama5.c
>> +++ b/arch/arm/mach-at91/board-dt-sama5.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/phy.h>
>>  #include <linux/clk-provider.h>
>> +#include <linux/phy.h>
>>  
>>  #include <asm/setup.h>
>>  #include <asm/irq.h>
>> @@ -26,8 +27,25 @@
>>  
>>  #include "generic.h"
>>  
>> +static int ksz8081_phy_fixup(struct phy_device *phy)
>> +{
>> +	int value;
>> +
>> +	value = phy_read(phy, 0x16);
>> +	value &= ~0x20;
>> +	phy_write(phy, 0x16, value);
>> +
>> +	return 0;
>> +}
>> +
>>  static void __init sama5_dt_device_init(void)
>>  {
>> +	if (of_machine_is_compatible("atmel,sama5d4ek") &&
>> +	   IS_ENABLED(CONFIG_PHYLIB)) {
>> +		phy_register_fixup_for_id("fc028000.etherne:00",
>> +						ksz8081_phy_fixup);

Matching the bus id certainly works, but I would rather match on your
specific PHY device 32-bits OUI to make sure that if you ever change the
PHY on a different design, this is not inadvertently writing to a
register that is not micrel specific?

>> +	}
>> +
>>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
>>  
>>
> 
> 
