From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Mar 2011 16:53:02 +0000
Subject: [PATCH] arm: mmci: Add ARM variant with extended FIFO
In-Reply-To: <20110316163448.GA16538@n2100.arm.linux.org.uk>
References: <1299863887-15490-1-git-send-email-pawel.moll@arm.com>
	<4D80E46C.3010103@canonical.com>
	<20110316163448.GA16538@n2100.arm.linux.org.uk>
Message-ID: <1300294382.19700.12.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > New IO FPGA implementation for Versatile Express boards contain
> > > MMCI (PL180) cell with FIFO extended to 128 words (512 bytes).
> > > 
> > > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > 
> > Tested-by: Matt Waddel <matt.waddel@linaro.org>
> > 
> > This patch improves MMC performance on my vexpress system. Also
> > fixes "mmcblk0: error -5 transferring data" errors.
> 
> You should use the patch I sent to do dynamic clocking if you're
> concerned about performance.  That patch improves performance by
> a factor of 8 compared to anything possible by increasing the FIFO
> depth.
> 
> I am very much of the opinion that deepening the FIFOs is just a
> sticky plaster over the problem - and I said as much when it was
> first proposed, pointing out that there's other better solutions.

# cat /sys/devices/mb\:mmci/id                             
01041180
# cat /sys/module/mmci/parameters/fmax                     
12000000                                                                        
# dd if=/dev/mmcblk0 of=/dev/null bs=128k count=100        
100+0 records in                                                                
100+0 records out                                                               
13107200 bytes (13 MB) copied, 9.04218 s, 1.4 MB/s

Of course without the proper error handling, as introduced by your
patch, one will face the same problems with interrupt latency as
previously. But the peak performance seems to noticeably better...

Regards

Pawe?

PS. The FPGA with extended MMCI FIFO will be available on the next VE CD
update, which is going to be released next month.
