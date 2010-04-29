From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 29 Apr 2010 15:35:07 -0500
Subject: Potential namespace problem for 'struct flash_platfrom_data'
In-Reply-To: <20100429201944.GJ4877@n2100.arm.linux.org.uk>
References: <0D753D10438DA54287A00B0270842697636E305F88@AUSP01VMBX24.collaborationhost.net>
	<20100429201944.GJ4877@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B0270842697636E30604F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 29, 2010 1:20 PM, Russell King wrote:
> On Thu, Apr 29, 2010 at 03:06:37PM -0500, H Hartley Sweeten wrote:
>> Hello all,
>> 
>> I was looking at an issue with a spi flash device and noticed a
>> potential namespace problem.
>> 
>> arch/arm/include/asm/mach/flash.h has this:
>> 
>> struct flash_platform_data {
>> 	const char	*map_name;
>> 	const char	*name;
>> 	unsigned int	width;
>> 	int		(*init)(void);
>> 	void		(*exit)(void);
>> 	void		(*set_vpp)(int on);
>> 	void		(*mmcontrol)(struct mtd_info *mtd, int sync_read);
>> 	struct mtd_partition *parts;
>> 	unsigned int	nr_parts;
>> };
>> 
>> and include/linux/spi/flash.h has this:
>> 
>> struct flash_platform_data {
>> 	char		*name;
>> 	struct mtd_partition *parts;
>> 	unsigned int	nr_parts;
>> 
>> 	char		*type;
>> 
>> 	/* we'll likely add more ... use JEDEC IDs, etc */
>> };
>> 
>> Should anything be done?
>
> How about unifying them both?

That would make sense.  But the include location would be strange.

The <asm/mach/flash.h> file is used by various arch/arm/mach-* files and in a
couple of drivers/mtd/maps/*.c files.

The <linux/spi/flash.h> file is also used by various arch/arm/mach-* files as
well as some arch/blackfin and arch/mips files.  It's also used by some
drivers in drivers/mtd/devices and by drivers/spi/spi_butterfly.c.

Because of the multi architecture use, the unifying should be done in the
include/linux/spi/flash.h file.  But this include in the various platform
init's might seem "strange" since the flash is not "spi".

I guess the other option would be to rename the spi version to something like:

struct spi_flash_data {
	...
};

Any comments from the mtd people?

Regards,
Hartley
