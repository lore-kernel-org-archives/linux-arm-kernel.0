From: b32955@freescale.com (Huang Shijie)
Date: Mon, 12 Mar 2012 16:35:13 +0800
Subject: [PATCH] mtd/gpmi : fix the wrong DMA command.
In-Reply-To: <20120312075107.GB3928@pengutronix.de>
References: <1331518938-24047-1-git-send-email-b32955@freescale.com>
 <20120312075107.GB3928@pengutronix.de>
Message-ID: <4F5DB541.3000107@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?03?12? 15:51, Wolfram Sang ??:
> On Mon, Mar 12, 2012 at 10:22:18AM +0800, Huang Shijie wrote:
>> The last DMA command of ECC read page is used to disable the BCH module.
>> But the original code missed to set the pio[2] which is used to set the
>> GPMI_HW_GPMI_ECCCTRL register. fix it now.
>>
>> Signed-off-by: Huang Shijie <b32955@freescale.com>
> Thanks! What does happen because of this bug? Additional checksum errors? I
> haven't seen many on MX28 IIRC, so I wonder.
>
The MX28 runs well without this patch. I guess the speed of mx28 is too
slow.

The bug only observed in mx6q. A DMA timeout occurs.

But if you apply this patch to mx28's code. A dma timeout occurs too.
This is why i sent the patch
"mxs-dma : rewrite the last parameter of mxs_dma_prep_slave_sg()"

IC guy told me to add a WAIT4END in the middle one of the ECC read page
chain, and disable the BCH in the last
DMA command of the chain. After this patch, the code follows this rule.


BR
Huang Shijie
