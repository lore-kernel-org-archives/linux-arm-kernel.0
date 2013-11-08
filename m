From: b32955@freescale.com (Huang Shijie)
Date: Fri, 8 Nov 2013 10:39:56 +0800
Subject: [PATCH bugfix] mtd: gpmi: serialize all the dma operations
In-Reply-To: <20131107211229.GY20061@ld-irv-0074.broadcom.com>
References: <1383728007-15564-1-git-send-email-b32955@freescale.com>
 <20131107211229.GY20061@ld-irv-0074.broadcom.com>
Message-ID: <527C4EFC.8090701@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?11?08? 05:12, Brian Norris ??:
> Hi Huang,
>
> On Wed, Nov 06, 2013 at 04:53:27PM +0800, Huang Shijie wrote:
>> [1] The gpmi uses the nand_command_lp to issue the commands to NAND chips.
>>      It will issue a DMA operation when it handles a NAND_CMD_NONE control
>>      command. So when we read a page(NAND_CMD_READ0) from the NAND, we may send
>>      two DMA operations back-to-back.
>>
>>      If we do not serialize the two DMA operations, we will meet a bug when
>>
>>      1.1) we enable CONFIG_DMA_API_DEBUG, CONFIG_DMADEVICES_DEBUG,
>>           and CONFIG_DEBUG_SG.
>>
>>      1.2) Use the following commands in an UART console and a SSH console:
>>           cmd 1: while true;do dd if=/dev/mtd0 of=/dev/null;done
>>           cmd 1: while true;do dd if=/dev/mmcblk0 of=/dev/null;done
> How does mmcblk0 have anything to do with the GPMI NAND DMA?
Reading the mmcblk0 is just to heavy the arm core loading. Reading the 
mmcblk0 also revokes the
tasklets, and so make the tasklets of GPMI DMA not handled quickly enough.
>>      The kernel log shows below:
>>      -----------------------------------------------------------------
>>      kernel BUG at lib/scatterlist.c:28!
>>      Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>        .........................
>>      [<80044a0c>] (__bug+0x18/0x24) from [<80249b74>] (sg_next+0x48/0x4c)
>>      [<80249b74>] (sg_next+0x48/0x4c) from [<80255398>] (debug_dma_unmap_sg+0x170/0x1a4)
>>      [<80255398>] (debug_dma_unmap_sg+0x170/0x1a4) from [<8004af58>] (dma_unmap_sg+0x14/0x6c)
>>      [<8004af58>] (dma_unmap_sg+0x14/0x6c) from [<8027e594>] (mxs_dma_tasklet+0x18/0x1c)
>>      [<8027e594>] (mxs_dma_tasklet+0x18/0x1c) from [<8007d444>] (tasklet_action+0x114/0x164)
>>      -----------------------------------------------------------------
>>
>>      1.3) Assume the two DMA operations is X (first) and Y (second).
>>           The root cause of the bug:
>>           X's tasklet mxs_dma_tasklet trid to unmap the scatterlist, while Y is
>>           trying to set up a new DMA operation with the _SAME_ scatterlist in
>>           another ARM core.
> How are X and Y occurring concurrently? MTD/NAND has locking such that
> only one I/O operation is working on the chip at one time, right?
X and Y can not occur concurrently. X and Y is issue when the 
nand_command_lp calls the:
chip->cmd_ctrl(mtd, NAND_CMD_NONE, ....);

When we read a page from the NAND, the X and Y is issued back to back.
>> [2] This patch adds a wait queue and two helpers gpmi_enter_dma/gpmi_exit_dma to
>>      serialize all the DMA operations.
> If you really need this serialization, wouldn't a spinlock or mutex
> suffice?
>
spinlock is too short for this case.

mutex_unlock can not be call in the interrupt context, such as the in 
the tasklet.
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> Cc: stable at vger.kernel.org
> Perhaps I'm missing some things, but I don't feel like the problem is
> sufficiently well described, and I'm not sure this is the right
> solution. But please, educate me.
>
should i add more description in the section of the root cause?

thanks
Huang Shijie
