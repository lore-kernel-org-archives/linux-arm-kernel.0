From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 12 Jun 2011 01:02:21 +0400
Subject: [PATCH 2/3] ts72xx: use MTDPART_OFS_RETAIN for mtd partitioning
In-Reply-To: <20110611092224.GB16318@ibawizard.net>
References: <1307369056-29319-1-git-send-email-dbaryshkov@gmail.com>
	<1307369056-29319-3-git-send-email-dbaryshkov@gmail.com>
	<20110611092224.GB16318@ibawizard.net>
Message-ID: <BANLkTik4vJ6y6Y1igb_9HfaJ+ADeZ4xT0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, colleagues,

On 6/11/11, Petr ?tetiar <ynezz@true.cz> wrote:
> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> [2011-06-06 18:04:15]:
>> Instead of specifying a callback for dynamic partitioning, use
>> MTDPART_OFS_RETAIN for reserving a place near the end of flash for
>> RedBoot.
>
> [...]
>
>> -		.offset		= MTDPART_OFS_APPEND,
>> -		.size		= 0,			/* filled in later */
>> +		.offset		= MTDPART_OFS_RETAIN,
>> +		.size		= TS72XX_REDBOOT_PART_SIZE,
>> +				/* leave so much for last partition */
>
> thank you for the mtd cleanup work. While testing this patch, I've noticed,
> that the TS72XX_REDBOOT_PART_SIZE is by 16K bigger, then it should be:
>
> Redboot:
>
> 	RedBoot> fis list
> 	Name              FLASH addr  Mem addr    Length      Entry point
> 	(reserved)        0x60000000  0x60000000  0x01D04000  0x00000000
> 	RedBoot           0x61D04000  0x61D04000  0x00040000  0x00000000
> 	vmlinux           0x61D44000  0x00218000  0x000C0000  0x00218000
> 	FIS directory     0x61FFC000  0x61FFC000  0x00003000  0x00000000
> 	RedBoot config    0x61FFF000  0x61FFF000  0x00001000  0x00000000
>
> Linux:
>
> 	0x000000000000-0x000000004000 : "TS-BOOTROM"
> 	0x000000004000-0x000001d00000 : "Linux"
> 	0x000001d00000-0x000002000000 : "RedBoot"
>
> So if I simply read now first 4 bytes from /dev/mtdblock2, there's no 'CRUS'
> or 'SURC' boot HeaderID/signature and it means, that there's no valid
> Redboot
> for ep93xx. The correct value is:
>
> 	#define TS72XX_REDBOOT_PART_SIZE	(SZ_2M + SZ_1M - SZ_16K)

Could you please verify/ack the attached patch?

-- 
With best wishes
Dmitry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ts72xx-correct-partition-sizes.patch
Type: text/x-patch
Size: 1132 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110612/15ef0706/attachment.bin>
