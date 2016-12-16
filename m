From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Fri, 16 Dec 2016 11:06:38 +0100
Subject: mmc: core: complete/wait_for_completion performance
In-Reply-To: <875319194.240552.1481827900469@email.1und1.de>
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
Message-ID: <1481882798.31185.3.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Thu, 2016-12-15 at 19:51 +0100, Stefan Wahren wrote:
> Hi J?rg,
> 
> > J?rg Krause <joerg.krause@embedded.rocks> hat am 15. Dezember 2016
> > um 14:50 geschrieben:
> > 
> > 
> > Hi Stefan,
> > 
> > On Wed, 2016-12-14 at 19:57 +0100, Stefan Wahren wrote:
> > > Hi J?rg,
> > > 
> > 
> > [snip]
> > 
> > > > > 
> > > > > did you try cyclictest [1]?
> > > > 
> > > > Not yet. Not sure what to measure and which values to compare
> > > > here.
> > > 
> > > i tought you have the vendor kernel and the mainline kernel
> > > available
> > > for your platform.
> > > 
> > > So you could compare the both kernels.
> > 
> > Yes, that's right. I will have a look at this tool.
> > 
> > > > 
> > > > > 
> > > > > Beside the time for a request the amount of requests for the
> > > > > complete
> > > > > iperf test
> > > > > would we interesting. Maybe there are retries.
> > > > > 
> > > > > I'm still interested in your PIO mode patches for mxs-mmc
> > > > > even
> > > > > without clean up.
> > > > 
> > > > Actually, the patch does not implement a PIO mode, but drops
> > > > DMA
> > > > and
> > > > uses polling instead. I've attached the patch.
> > > 
> > > Thanks. I applied it, but unfortunately this breaks SD card
> > > support
> > > for my Duckbill and the kernel isn't able to mount the rootfs:
> > > 
> > > [????2.267073] mxs-mmc 80010000.ssp: initialized
> > > [????2.272624] mxs-mmc 80010000.ssp: AC command error 0xffffff92
> > 
> > Sorry, I messed up the branches. I attached the correct patch which
> > is
> > working for me on Linux v4.9.
> 
> i tested the second version but there isn't any performance gain with
> the patch.

In the vendor kernel the polling is used only for small chunks of <=
1024 bytes to save the context switches when using DMA. This patch does
not use DMA at all, but only polling.

As I said before, I guess the limitation in the mxs-mmc driver is the
time needed to return the mmc request to the mmc core driver.

I have a Cubietruck with the same wifi chipset as on my i.MX28 target
where I get ~20Mbps throughput. Furthermore, I've found a benchmark on
a NXP thread [1] measuring about 30Mbps for an i.MX6 target and a
similiar wifi chip.

Looking at the sunxi-mmc driver shows that it calls mmc_request_done()
in an interrupt context and does not use the dmaengine driver@all.

For now, I would drop the polling mode and look how to optimize the
control flow between the DMA controller and the MMC host.
Unfortunately, this will need some time...

> Duckbill with class 10 SD card
> Linux 4.8 without patch
> 
> dd if=/dev/zero of=test bs=1k count=10000
> 10000+0 records in
> 10000+0 records out
> 10240000 bytes (10 MB) copied, 2.68934 s, 3.8 MB/s
> 
> dd if=/dev/zero of=test bs=8k count=10000
> 10000+0 records in
> 10000+0 records out
> 81920000 bytes (82 MB) copied, 8.24305 s, 9.9 MB/s
> 
> 
> Duckbill with class 10 SD card
> Linux 4.8 with patch
> 
> dd if=/dev/zero of=test bs=1k count=10000
> 10000+0 records in
> 10000+0 records out
> 10240000 bytes (10 MB) copied, 3.41193 s, 3.0 MB/s
> 
> dd if=/dev/zero of=test bs=8k count=10000
> 10000+0 records in
> 10000+0 records out
> 81920000 bytes (82 MB) copied, 14.4564 s, 5.7 MB/s
> 
> Additionally i get these warning during boot:
> 
> [????2.278445] mxs-mmc 80010000.ssp: initialized
> [????2.283996] mxs-mmc 80010000.ssp: AC command error -110
> [????2.305158] mxs-mmc 80010000.ssp: AC command error -110
> [????2.322975] mxs-mmc 80010000.ssp: AC command error -110
> [????2.338660] mxs-mmc 80010000.ssp: AC command error -110
> [????2.344289] mxs-mmc 80010000.ssp: AC command error -110
> [????2.365653] mxs-mmc 80010000.ssp: AC command error -110

I get this errors, too. The MMC host is sending some commands and the
MMC client is not (yet) responding to those commands. I haven't looked
any closer at this.

[1] https://community.nxp.com/thread/317396
