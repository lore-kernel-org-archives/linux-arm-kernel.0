From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 7 Oct 2009 13:09:10 -0400
Subject: [PATCH 1/2] Update ts72xx to use generic platform nand driver
In-Reply-To: <jbvtp6-i58.ln1@chipmunk.wormnet.eu>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7967@mi8nycmail19.Mi8.com>
	<jbvtp6-i58.ln1@chipmunk.wormnet.eu>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB7A8D@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 07, 2009 1:16 AM, Alexander Clouter wrote:
> Hi,

[snip]

> These struct's are almost identical so could you not...

[snip]

> -----------
> static struct mtd_partition ts72xx_part_info[] = {
> 	{
> 		/* gut feeling for *Joe Public* is to go MTD_WRITABLE */
> 		.name		= "TS-BOOTROM",
> 		.offset		= 0,
> 		.size		= TS72XX_BOOTROM_PART_SIZE,
> 	}, {
> 		.name		= "Linux",
> 		.offset		= MTDPART_OFS_APPEND,
> 		/* to be filled in later */
> 		.size		= 0,
> 	}, {
> 		/* mask MTD_WRITABLE here too? */
> 		.name		= "Redboot",
> 		.offset		= MTDPART_OFS_APPEND,
> 		.size		= MTDPART_SIZ_FULL,
> 	}
> };
> 
> static void ts72xx_nand_set_parts(....)
> {
> 	....
> 
> 	/* or I guess you could just bailout... */
> 	if (size != SZ_32M && size != SZ_128M)
> 		pr_warning("ts72xx: Unknown nand disk size:%lluMB\n", size >> 20);
> 
> 	chip->partitions = ts72xx_part_info;
> 	chip->nr_partitions = ARRAY_SIZE(ts72xx_part_info);
> 
> 	ts72xx_part_info[1].size = size - TS72XX_REDBOOT_PART_SIZE;
> }

Thanks for pointing that out.  I like your change and will modify the patch.

I didn't think about making the "TS-BOOTROM" and "RedBoot" partitions read-only.
Probably a good idea, I'll add that also.

Updated patch coming soon.

Regards,
Hartley
