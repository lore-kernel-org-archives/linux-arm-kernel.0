From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 20 Aug 2018 16:01:36 +0300
Subject: [PATCH v2 0/3] add support to non-uniform SFDP SPI NOR flash
 memories
In-Reply-To: <20180712173235.7901-1-tudor.ambarus@microchip.com>
References: <20180712173235.7901-1-tudor.ambarus@microchip.com>
Message-ID: <bb6647a7-8d3b-5487-8876-228adfc5ad53@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Marek,

Did you have the chance to look over these patches? Please advise how can I move
forward with the non-uniform erase support.

Thanks,
ta

On 07/12/2018 08:32 PM, Tudor Ambarus wrote:
> Backward compatibility test done on mx25l3273fm2i-08g.
> Non-uniform erase test done on sst26vf064b-104i/sn.
> 
> Note that in order to do the non-uniform test on the aforementioned memory
> you'll have to force the spi_nor_has_uniform_erase() to return false, because
> the erase map is tuned to come back to the uniform case. Also, you'll have to
> unlock the global protection on the flash. There was an attempt to unlock this
> protection, but for whatever reason the patch was not taken:
> https://patchwork.ozlabs.org/patch/544270/. I'm taking care of the
> global protection lock on sst26vf064b-104i/sn, I will submit a patch soon.
> 
> Changes in v2:
> - add JESD216B SFDP optional parser: Sector Map Parameter Table parser
>   and 4-byte Address Instruction Table parser (patch 2/3 and patch 3/3).
> - fix condition on finding erase regions
> - fix the list command adding
> - write_enable(nor); before erasing the sectors
> - As Boris suggested, remove likely() because it doesn't make any difference
>   given the time it takes to actually erase the block.
> - save the Erase Types from bfpt, to determine the Erase Type sizes. Sort all
>   the map's Erase Types in ascending order with the smallest erase size being
>   the first member in the erase_type array. Sort Erase Type mask in regions.
>   We sort the Erase Type by size, at init, in order to speed up the
>   process of finding the best erase command at run-time.
> - spi_nor_select_erase(): pass directly info->sector_size instead of the whole
>   flash_info structure in order to simplify the code.
> - keep the same convention as most flashes, and order erase types by size with
>   the smallest Erase Type size starting at index 0/ BIT(0).
> - return unused function: spi_nor_region_mark_end().
> - fix return value of spi_nor_has_uniform_erase().
> - remove setting of mtd->erasesize and nor->erase_opcode when parsing the Basic
>   Flash Parameter Table. mtd->erasesize was set to the maximum supported Erase
>   Type size, without verifying if that Erase Type can erase the entire flash.
>   mtd->erasesize is now set just in spi_nor_select_erase(), after we find which
>   Erase Types are supported in the uniform case.
> 
> Changes in v1 or what I've done on top of Cyrille's work (https://lkml.org/lkml/2017/4/15/70):
> - minimize the amount of erase() calls by using the best sequence of erase
>   type commands depending on alignment.
> - build the list of best fitted erase commands to be executed once we
>   validate that the erase can be performed.
> - add improvements on how the erase map is handled. The regions are
>   consecutive in the address space, walk through the regions incrementally.
> - speed up finding the best erase type command. Order erase types by
>   size, iterate them from the biggest to the smallest and stop when best
>   fitted command is found.
> - determine at init if there are erase types that can erase the entire
>   memory
> - fix support for overlaid regions.
> 
> Cyrille Pitchen (1):
>   mtd: spi-nor: parse SFDP 4-byte Address Instruction Table
> 
> Tudor Ambarus (2):
>   mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories
>   mtd: spi-nor: parse SFDP Sector Map Parameter Table
> 
>  drivers/mtd/spi-nor/spi-nor.c | 892 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/mtd/spi-nor.h   | 120 ++++++
>  2 files changed, 954 insertions(+), 58 deletions(-)
> 
