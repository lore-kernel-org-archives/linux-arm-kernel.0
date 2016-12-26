From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 27 Dec 2016 00:03:09 +0100 (CET)
Subject: mmc: core: complete/wait_for_completion performance
In-Reply-To: <1481882798.31185.3.camel@embedded.rocks>
References: <1479644869.2653.3.camel@embedded.rocks>
 <585759233.283839.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <1479652929.2841.1.camel@embedded.rocks>
 <187975187.249177.bccdc17e-e9c6-48c2-aeaf-3b81f1b61ec7.open-xchange@email.1und1.de>
 <1479669034.1975.1.camel@embedded.rocks>
 <1198138554.59982.63209ba1-8fb4-4a13-9ee0-f746a192f4c7.open-xchange@email.1und1.de>
 <1481095953.17027.0.camel@embedded.rocks>
 <123257138.400786.e58aee3b-9fc2-4b39-a030-c2409c5b92fc.open-xchange@email.1und1.de>
 <1481706204.3994.4.camel@embedded.rocks>
 <962480933.163666.1481741832090@email.1und1.de>
 <1481809814.29241.2.camel@embedded.rocks>
 <875319194.240552.1481827900469@email.1und1.de>
 <1481882798.31185.3.camel@embedded.rocks>
Message-ID: <692865692.72725.1482793390055@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J?rg,

> J?rg Krause <joerg.krause@embedded.rocks> hat am 16. Dezember 2016 um 11:06 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Thu, 2016-12-15 at 19:51 +0100, Stefan Wahren wrote:
> > Hi J?rg,
> > 
> > > J?rg Krause <joerg.krause@embedded.rocks> hat am 15. Dezember 2016
> > > um 14:50 geschrieben:
> > > 
> > > 
> > > Hi Stefan,
> > > 
> > > On Wed, 2016-12-14 at 19:57 +0100, Stefan Wahren wrote:
> > > > Hi J?rg,
> > > > 
> > > 
> > > [snip]
> > > 
> > > > > > 
> > > > > > did you try cyclictest [1]?
> > > > > 
> > > > > Not yet. Not sure what to measure and which values to compare
> > > > > here.
> > > > 
> > > > i tought you have the vendor kernel and the mainline kernel
> > > > available
> > > > for your platform.
> > > > 
> > > > So you could compare the both kernels.
> > > 
> > > Yes, that's right. I will have a look at this tool.
> > > 
> > > > > 
> > > > > > 
> > > > > > Beside the time for a request the amount of requests for the
> > > > > > complete
> > > > > > iperf test
> > > > > > would we interesting. Maybe there are retries.
> > > > > > 
> > > > > > I'm still interested in your PIO mode patches for mxs-mmc
> > > > > > even
> > > > > > without clean up.
> > > > > 
> > > > > Actually, the patch does not implement a PIO mode, but drops
> > > > > DMA
> > > > > and
> > > > > uses polling instead. I've attached the patch.
> > > > 
> > > > Thanks. I applied it, but unfortunately this breaks SD card
> > > > support
> > > > for my Duckbill and the kernel isn't able to mount the rootfs:
> > > > 
> > > > [    2.267073] mxs-mmc 80010000.ssp: initialized
> > > > [    2.272624] mxs-mmc 80010000.ssp: AC command error 0xffffff92
> > > 
> > > Sorry, I messed up the branches. I attached the correct patch which
> > > is
> > > working for me on Linux v4.9.
> > 
> > i tested the second version but there isn't any performance gain with
> > the patch.
> 
> In the vendor kernel the polling is used only for small chunks of <=
> 1024 bytes to save the context switches when using DMA. This patch does
> not use DMA at all, but only polling.

also the vendor kernel uses polling for AC and BC commands. I tried this approach (use polling for AC/BC/BCR commands and DMA for all ADTC commands) [1] on Duckbill with SD card but the resulting read and write performance stays the same. Maybe you want to give it a try with Wifi over SDIO.

Here are some read performance values with Duckbill (Kernel 4.8, class 10 microSD card):

dd if=/dev/mmcblk0p2 of=/dev/null
64260+0 records in
64260+0 records out
32901120 bytes (33 MB) copied, 1.68618 s, 19.5 MB/s

> 
> As I said before, I guess the limitation in the mxs-mmc driver is the
> time needed to return the mmc request to the mmc core driver.

I don't think this is the problem. I added some GPIO handling into mxs-mmc driver and i couldn't see any big delay between the mmc requests with a logic analyzer.

> 
> I have a Cubietruck with the same wifi chipset as on my i.MX28 target
> where I get ~20Mbps throughput. Furthermore, I've found a benchmark on
> a NXP thread [1] measuring about 30Mbps for an i.MX6 target and a
> similiar wifi chip.
> 
> Looking at the sunxi-mmc driver shows that it calls mmc_request_done()
> in an interrupt context and does not use the dmaengine driver at all.
> 
> For now, I would drop the polling mode and look how to optimize the
> control flow between the DMA controller and the MMC host.
> Unfortunately, this will need some time...

I also rebased an old patch from Shawn Guo [2] with pre_req and post_req support, tried to call the DMA channel callback from the interrupt context instead of scheduling the tasklet within the DMA engine driver and implement CMD23 support [3]. But none of them show any measurable performance improvement.

Btw here are some really performance critical kernel config parameter which really needs to be disabled:

# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_PROVE_RCU is not set

[1] - https://github.com/lategoodbye/linux-mxs-power/commit/beb341ed948ae9b8afe7378cff6b9d50144fd0b9
[2] - https://github.com/lategoodbye/linux-mxs-power/commit/e96b28e8730ccfcfecb7ec286102bc6969aa1ee0
[3] - https://github.com/lategoodbye/linux-mxs-power/commit/e53a3c9169a63eb61f9e67ff88724972acf312a9
