From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 22 Dec 2015 11:39:03 +0000
Subject: [PATCH v3 66/77] ncr5380: Fix soft lockups
In-Reply-To: <20151222011755.965510468@telegraphics.com.au>
References: <20151222011737.980475848@telegraphics.com.au>
 <20151222011755.965510468@telegraphics.com.au>
Message-ID: <20151222113903.06422dbe@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015 12:18:44 +1100
Finn Thain <fthain@telegraphics.com.au> wrote:

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

Is there a reason for not doing some limiting in the DMA case too. A 512K
write command even with DMA on a low end 68K box introduces a second of
latency before another I/O can be scheduled ?

Alan
