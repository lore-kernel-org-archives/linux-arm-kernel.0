From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 Dec 2015 09:03:54 +0100
Subject: [PATCH v3 66/77] ncr5380: Fix soft lockups
In-Reply-To: <20151222011755.965510468@telegraphics.com.au>
References: <20151222011737.980475848@telegraphics.com.au>
 <20151222011755.965510468@telegraphics.com.au>
Message-ID: <567903EA.7030803@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2015 02:18 AM, Finn Thain wrote:
> Because of the rudimentary design of the chip, it is necessary to poll the
> SCSI bus signals during PIO and this tends to hog the CPU. The driver will
> accept new commands while others execute, and this causes a soft lockup
> because the workqueue item will not terminate until the issue queue is
> emptied.
>
> When exercising dmx3191d using sequential IO from dd, the driver is sent
> 512 KiB WRITE commands and 128 KiB READs. For a PIO transfer, the rate is
> is only about 300 KiB/s, so these are long-running commands. And although
> PDMA may run at several MiB/s, interrupts are disabled for the duration
> of the transfer.
>
> Fix the unresponsiveness and soft lockup issues by calling cond_resched()
> after each command is completed and by limiting max_sectors for drivers
> that don't implement real DMA.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> ---
>
> Changed since v2:
> - Moved max_sectors initialization to wrapper drivers. It isn't really
>    relevant to the core driver and compile-time configuration using macros
>    like REAL_DMA should be avoided.
>
> ---
>   drivers/scsi/NCR5380.c       |    6 ++++--
>   drivers/scsi/arm/cumana_1.c  |    1 +
>   drivers/scsi/arm/oak.c       |    1 +
>   drivers/scsi/atari_NCR5380.c |    6 ++++--
>   drivers/scsi/dmx3191d.c      |    1 +
>   drivers/scsi/dtc.c           |    1 +
>   drivers/scsi/g_NCR5380.c     |    1 +
>   drivers/scsi/mac_scsi.c      |    1 +
>   drivers/scsi/pas16.c         |    1 +
>   drivers/scsi/t128.c          |    1 +
>   10 files changed, 16 insertions(+), 4 deletions(-)
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
