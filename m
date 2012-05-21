From: rattanni@gmail.com (Rich Rattanni)
Date: Mon, 21 May 2012 17:11:44 -0400
Subject: MMC driver hangs when reading faulty card
Message-ID: <CA+kQo=M8fOgOBj91xYQhnxtmrCo2H6Q7-6MYJS6kgSdMd3pgWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have had an issue logging data to SD cards on my PXA based system.
Periodically an SD card appears to fail that causes the system to hang
indefinitely while mounting the SD card.  It became enough of a
problem that I finally decided to debug the issue.

Processor: PXA270
MMC driver: Linux 3.4rc7

In my application I have eight development boards scattered around my
house doing sensor monitoring.  I write about 200MB of data per day to
the SD card.  Occasionally a board will stop responding and I find out
the system reset (watchdog) and hung attempting to mount the SD card.
If I replace the SD card then system runs fine (for the record I am
running EXT3 on top of the SD card).  I am tired of running to Generic
Office Supply Store for SD cards, so I decided to dig into the issue.
A week ago I had a card begin to show the aforementioned problems so I
began to investigate.  Here is what I found:

On card insert the kernel reports the following (via dmesg):
--- dmesg output ---
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SDHC card at address b368
mmcblk0: mmc0:b368 USD   3.75 GiB
 mmcblk0: p1
---------------------------
When the card is mounted (mount /dev/mmcblk0p1 /media/card), the mount
never returns and cannot be stopped or killed.  dmesg shows the
following:
--- dmesg output ---
EXT3-fs: barriers not enabled
attempt to access beyond end of device
mmcblk0p1: rw=0, want=2584260648, limit=7874560
attempt to access beyond end of device
mmcblk0p1: rw=0, want=2573879920, limit=78745
attempt to access beyond end of device
mmcblk0p1: rw=0, want=2293235720, limit=7874560
attempt to access beyond end of device
mmcblk0p1: rw=0, want=2416179208, limit=7874560
journal_bmap: journal block not found at offset 20 on mmcblk0p1
JBD: bad block at offset 20
--------------
Running top shows mmcqd sitting at 50% CPU.  The system is noticeably
less responsive.  Several printk's and kernel rebuilds later I found
out the mmc driver is stuck in the following while loop:

File: ./linux-3.4-rc7/drivers/mmc/card/block.c Line: 1003
-- BEGIN CODE --
static int mmc_blk_err_check(struct mmc_card *card,
              struct mmc_async_req *areq)
{
....snip...
/*
    * Everything else is either success, or a data error of some
    * kind.  If it was a write, we may have transitioned to
    * program mode, which we have to wait for it to complete.
    */
   if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
      u32 status;
      do {
         int err = get_card_status(card, &status, 5);
         if (err) {
            pr_err("%s: error %d requesting status\n",
                   req->rq_disk->disk_name, err);
            return MMC_BLK_CMD_ERR;
         }
         /*
          * Some cards mishandle the status bits,
          * so make sure to check both the busy
          * indication and the card state.
          */
      } while (!(status & R1_READY_FOR_DATA) ||
          (R1_CURRENT_STATE(status) == R1_STATE_PRG));
   }

....snip...
}
-- END CODE --

My initial thoughts are hanging here indefinitely is not the best
solution.  I have a single threaded user space process that handles
writing information to the card then transmitting a status via
wireless to a master node, so when cards go bad and the board
watchdogs and reboots the device is temporarily bricked.  If I did
pass this work off to another thread/process then I still have a power
issue.  The SD card draws  ~14mA of current while spinning in the
request status loop instead of 1mA.  In addition to the power wasted
from mmcqd busy waiting.

I am trying to think about possible solutions, but I have no
experience with the MMC driver architecture so that is why I am
reaching out for help.  I could kick myself for throwing out a dozen
or so cards before finally deciding to investigate this issue.  As it
stands I only have one card that causes this symptom.  Any help on the
matter would be appreciated, in the mean time I shall attempt to learn
and experiment further.

--
Rich
