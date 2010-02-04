From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 05 Feb 2010 10:52:33 +1300
Subject: [PATCH] ep93xx: Add support for Snapper CL15 module
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902152BFB@mi8nycmail19.Mi8.com>
References: <4B6B34D3.1010704@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190902152BFB@mi8nycmail19.Mi8.com>
Message-ID: <4B6B41A1.9040403@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> On Thursday, February 04, 2010 1:58 PM, Ryan Mallon wrote:
>> Add support for the Bluewater Systems Snapper CL15 single board computer
>> module.
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> Cc: Hartley Sweeten <hartleys@visionengravers.com>
>>
>> ---
>>
>> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
>> index 9167c3d..71eabca 100644
>> --- a/arch/arm/mach-ep93xx/Kconfig
>> +++ b/arch/arm/mach-ep93xx/Kconfig
>> @@ -168,6 +168,13 @@ config MACH_TS72XX
>>  	  Say 'Y' here if you want your kernel to support the
>>  	  Technologic Systems TS-72xx board.
>>  
>> +config MACH_SNAPPER_CL15
>> +	bool "Support Bluewater Systems Snapper CL15 Module"
>> +	depends on EP93XX_SDCE0_PHYS_OFFSET
>> +	help
>> +	  Say 'Y' here if you want your kernel to support the Bluewater
>> +	  Systems Snapper CL15 Module.
>> +
> 
> Your will need to base this patch on Russell's -devel tree.  The Sim.One
> board is now in that.

My understanding is that this sort of thing will merge cleanly since the
patches are otherwise unrelated. I think I only need to rebase on the
-devel tree if I have direct dependencies, or expect conflicts there.
Russell?

> 
> Also, please move this so that they stay alphabetized:
> 
> config MACH_SIM_ONE
> ...
> +config MACH_SNAPPER_CL15
> +...
> config MACH_TS72XX
> ...

Will fix.

>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
> 
> #include <linux/io.h>
> 
> Should be here since you are using __raw_{read/write}w

Okay.

>> +#include <linux/gpio.h>
>> +#include <linux/i2c.h>
>> +#include <linux/i2c-gpio.h>
>> +#include <linux/fb.h>
>> +
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/mtd/nand.h>
>> +
>> +#include <mach/hardware.h>
>> +#include <mach/fb.h>
>> +
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +
>> +#define SNAPPERCL15_NAND_BASE	(EP93XX_CS7_PHYS_BASE + 0x01000000)
> 
> Maybe use SZ_16M?  Your call.

Sure.

>> +
>> +#define SNAPPERCL15_NAND_CTRL	(1 << 6)
>> +#define SNAPPERCL15_NAND_WPN	(1 << 8)
>> +#define SNAPPERCL15_NAND_ALE	(1 << 9)
>> +#define SNAPPERCL15_NAND_CLE	(1 << 10)
>> +#define SNAPPERCL15_NAND_CEN	(1 << 11)
>> +#define SNAPPERCL15_NAND_RDY	(1 << 14)
>> +
>> +#define NAND_CTRL_ADDR(chip)						\
>> +	((void __iomem *)((unsigned long)chip->IO_ADDR_W + 0x40))
> 
> The cast is probably not needed. IO_ADDR_W is already a void __iomem * and
> adding to it should not require the cast.

I'll have a look and see if I can simplify this and remove the casts. I
think I based it on one of the other platform NAND implementations that
had something similar.

>> +
>> +static unsigned long nand_state;
>> +
>> +static void snappercl15_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
>> +				      unsigned int ctrl)
>> +{
>> +	struct nand_chip *chip = mtd->priv;
>> +	static int first = 1;
>> +	unsigned set;
>> +
>> +	if (first) {
>> +		nand_state = SNAPPERCL15_NAND_CEN | SNAPPERCL15_NAND_WPN;
>> +		__raw_writew(nand_state, NAND_CTRL_ADDR(chip));
>> +		first = 0;
>> +	}
>> +
>> +	if (ctrl & NAND_CTRL_CHANGE) {
>> +		set = SNAPPERCL15_NAND_CEN;
>> +
>> +		if (ctrl & NAND_NCE)
>> +			set &= ~SNAPPERCL15_NAND_CEN;
>> +		if (ctrl & NAND_CLE)
>> +			set |= SNAPPERCL15_NAND_CLE;
>> +		if (ctrl & NAND_ALE)
>> +			set |= SNAPPERCL15_NAND_ALE;
>> +
>> +		nand_state &= ~(SNAPPERCL15_NAND_CEN |
>> +				SNAPPERCL15_NAND_CLE |
>> +				SNAPPERCL15_NAND_ALE);
>> +		nand_state |= set;
>> +		__raw_writew(nand_state, NAND_CTRL_ADDR(chip));
>> +	}
>> +
>> +	if (cmd != NAND_CMD_NONE)
>> +		__raw_writew((cmd & 0xff) | nand_state, chip->IO_ADDR_W);
>> +}
>> +
> 
> Interesting... Is your nand connected thru a fpga or something?

No, just a series of buffers. The Snapper CL15 has placement options for
either a NAND part or (for legacy reasons) an xD card connector. The
driver will work with either. For xD cards, hotplugging the cards is not
supported. However, all new Snapper CL15's are manufactured with NAND
fitted.

>> +
>> +static void snappercl15_nand_set_parts(uint64_t size,
>> +				       struct platform_nand_chip *chip)
>> +{
>> +	pr_info("Snapper CL15: %llu bytes NAND\n", size);
> 
> You only have one pr_<level> right now but you might consider defining a
> pr_fmt to prefix the "Snapper CL15: ".  Then you don't have to worry about
> adding it to any pr_<level> output later.  Just put this before the #include's:
> 
> #define pr_fmt(fmt) "Snapper CL15: " fmt
> 
> Your could also use the following but the prefix will be "snappercl15: "
> 
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Probably not worth it since I don't expect to be adding a lot of printks
to this file. I can probably remove this one even, since the MTD core
displays informtation about the NAND part and the partition layout.

>> +
>> +static struct i2c_board_info __initdata snappercl15_i2c_data[] = {
>> +	{
>> +		/* Audio codec */
>> +		I2C_BOARD_INFO("tlv320aic23", 0x1a),
>> +	},
>> +};
> 
> Are you going to add the audio support later?

Hopefully. I have some partially working code to support the audio using
the SoC audio interface. I think there is no harm in having this here
now though, and it saves having to patch it in later.

> 
> Looks good other than that.

Thanks, will post an updated patch later today.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
