From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jun 2012 09:52:18 +0200
Subject: [PATCH v4 3/9] arm: mach-mvebu: add source files
In-Reply-To: <201206261617.20954.arnd@arndb.de>
References: <1340699313-29331-1-git-send-email-gregory.clement@free-electrons.com>
 <1340699313-29331-4-git-send-email-gregory.clement@free-electrons.com>
 <201206261617.20954.arnd@arndb.de>
Message-ID: <4FEABBB2.7040502@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2012 06:17 PM, Arnd Bergmann wrote:
> On Tuesday 26 June 2012, Gregory Clement wrote:
>> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Signed-off-by: Lior Amsalem <alior@marvell.com>
> 
> This driver seems to do all the right things now, good work.
> 
>> +static void __iomem *system_controller_base;
>> +static void __iomem *reset_base;
>> +static unsigned long rstoutn_mask_reset_out_en;
>> +
>> +/* System controller registers */
>> +#define ARMADA_370_XP_RESET_OFFSET		  0x60
>> +#define OTHER_MVEBU_RESET_OFFSET		 0x108
>> +#define MVEBU_RSTOUTN_MASK_OFFSET		   0x0
>> +#define   OTHER_MVEBU_RSTOUTN_MASK_RESET_OUT_EN	   0x4
>> +#define   ARMADA_370_XP_RSTOUTN_MASK_RESET_OUT_EN  0x1
>> +#define MVEBU_SYSTEM_SOFT_RESET_OFFSET		   0x4
>> +#define   MVEBU_SYSTEM_SOFT_RESET		   0x1
>> +
>> +#define OTHER_MVEBU_VARIANT	1
>> +#define ARMADA_370_XP_VARIANT	2
> 
> I think this can be expressed nicer with pointers to data structures,
> like
> 
> static void __iomem *system_controller_base;
> 
> struct mvebu_system_controller {
> 	u32 rstoutn_mask_offset;
> 	u32 system_soft_reset_offset;
> 
> 	u32 rstoutn_mask_reset_out_en;
> 	u32 system_soft_reset;
> };
> 
> const struct mvebu_system_controller armada_370_xp_system_controller = {
> 	.rstoutn_mask_offset = 0x60,
> 	.system_soft_reset_offset = 0x64,
> 	.rstoutn_mask_reset_out_en = 0x1,
> 	.system_soft_reset = 0x1,
> };
> 
> const struct mvebu_system_controller orion_system_controller = {
> 	.rstoutn_mask_offset = 0x108,
> 	.system_soft_reset_offset = 0x10c,
> 	.rstoutn_mask_reset_out_en = 0x4,
> 	.system_soft_reset = 0x1,
> };
> 
> static struct of_device_id of_system_controller_table[] = {
> 	{.compatible = "marvell,orion-system-controller",
> 	 .data = &orion,system_controller},
> 	{.compatible = "marvell,armada-370-xp-system-controller",
> 	 .data = &armada_370_xp_system_controller,
> 	{ /* end of list */ },
> };

OK I will make this improvements.

> 
>> +void mvebu_restart(char mode, const char *cmd)
>> +{
>> +	if (!system_controller_base) {
>> +		pr_warn("Cannot restart, system-controller not available\n");
>> +		return;
>> +	}
> 
> I guess returning here is a bug, you should just enter the endless
> loop.

You're right.

> 
> 	Arnd
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
