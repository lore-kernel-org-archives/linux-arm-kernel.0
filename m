From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 04 May 2011 10:17:13 +0300
Subject: [PATCH 3/4] omap: move detection of NAND CS to
	common-board-devices
In-Reply-To: <20110504064614.GG27860@atomide.com>
References: <cover.1303682352.git.mike@compulab.co.il>
	<e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il>
	<724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru>
	<44342B2F-34C0-490C-91B8-96A9EA683F9B@linuxhacker.ru>
	<4DC0F469.9030406@compulab.co.il>
	<20110504064614.GG27860@atomide.com>
Message-ID: <4DC0FD79.2020005@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/11 09:46, Tony Lindgren wrote:
> * Mike Rapoport <mike@compulab.co.il> [110504 09:35]:
>> On 05/04/11 07:10, Oleg Drokin wrote:
>>> Ok, so here's a simple patch to save everyone trouble, I guess.
>>>
>>> Though on the other hand I can imagine that perhaps including this generic common-board-devices.c
>>> might not be desirable for people that don't use anything from that file.
>>
>> Since the common-board-devices.c has TWL initialization I doubt there would a
>> board that does not use it at all...
>>
>>> Would it be a better idea to split it to a file-per-feature?
>>
>> Splitting the common-board-devices into a file-per-feature will diminish its
>> added value, IMO.
>> We can either continue to use #ifdef CONFIG_SOMETHING in both
>> common-board-devices.[ch] as your fix proposes or just drop #ifdefs and inlines
>> from the header.
>> Tony, what is your preference?
> 
> We should consider the code size too.. Maybe see if you can make them
> weak instead of the ifdefs?

Unless I completely misunderstand how weak works, we'll still have ifdefs in .c
file, i.e.

common-board-devices.h:

void __omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts)
{
}

void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts)
__attribute__((weak, alias("__omap_nand_flash_init")));

common-board-devices.c:
#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts)
{
...
}
#endif

Yet, we can keep the ifdefs only in common-board-devices.c and get rid if
inlines in the header.
Also, all the code in common-board-devices.c is __init, so it's eventually
dropped in runtime

> Tony


-- 
Sincerely yours,
Mike.
