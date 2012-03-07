From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 7 Mar 2012 23:39:25 +0530
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Message-ID: <CABb+yY0A9=XKuw=N1fFXCB507zR3U=wofqATVcO_wtnnVrgXzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 4:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> [v2 - more or less same description. ?Including lakml in cc for the full
> set]
>
> This patch series cleans up the handling of cookies in DMA engine drivers.
> This is done by providing a set of inline library functions for common
> tasks:
>
> - moving the 'last completed cookie' into struct dma_chan - everyone
> ?has this in their driver private channel data structure
>
> - consolidate allocation of cookies to DMA descriptors
>
> - common way to update 'last completed cookie' value
>
> - standard way to implement tx_status callback and update the residue
>
> - consolidate initialization of cookies
>
> - update implementations differing from the majority of DMA engine drivers
> ?to behave the same as the majority implementation in respect of cookies
>
> What this means is that we get to the point where all DMA engine drivers
> will hand out cookie value '2' as the first, and incrementing cookie
> values up to INT_MAX, returning to cookie '1' as the next cookie.
>
> Think of this patch series as round 1... ?I am hoping over time that more
> code can be consolidated between the DMA engine drivers and end up with a
> consistent way to handle various common themes in DMA engine hardware
> (like physical channel<->peripheral request signal selection.)
>
Compilation is broken without the following minor fix.
After that you may add
       Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 49c123f..abf35a3 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -339,7 +339,6 @@ static int pl330_control(struct dma_chan *chan,
enum dma_ctrl_cmd cmd, unsigned
 		/* Mark all desc done */
 		list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
 			desc->status = DONE;
-			pch->completed = desc->txd.cookie;
 			list_move_tail(&desc->node, &list);
 		}


Thanks.
