From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 7 Aug 2016 13:37:07 +0200 (CEST)
Subject: [PATCH RFC 0/3] mmc: mxs-mmc: Implement DDR support
In-Reply-To: <299761257.114585.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <ef08cd86-8366-31b3-1f05-d0c7251cded6@denx.de>
 <299761257.114585.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
Message-ID: <98368157.110813.d9cd30e0-7476-4a28-8bab-dde17515cd9c.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 6. August 2016 um 15:48
> geschrieben:
> 
> 
> Hi Marek,
> 
> > Marek Vasut <marex@denx.de> hat am 6. August 2016 um 15:10 geschrieben:
> > 
> > 
> > On 08/06/2016 02:55 PM, Stefan Wahren wrote:
> > > Based on these discussions: [1], [2] this patch series implements
> > > DDR support for the MXS MMC host driver. This feature has never been
> > > ported from the vendor kernel.
> > > 
> > > It has been tested on a i.MX28 board with eMMC which is currently
> > > not in mainline (Duckbill 2).
> > > 
> > > * without DDR support
> > > dd if=/dev/zero of=test bs=8k count=10000
> > > 81920000 bytes (82 MB) copied, 14.3321 s, 5.7 MB/s
> > > 
> > > * with DDR support:
> > > dd if=/dev/zero of=test bs=8k count=10000
> > > 81920000 bytes (82 MB) copied, 13.4781 s, 6.1 MB/s
> > 
> > Not much of a speedup, how so ?
> 
> i agree. Unfortunately i never had the time for a deeper analysis, but i
> noticed
> big write performance differences between the vendor kernel 2.6.35 and current
> mainline kernel in case of writing 100 MB directly to an eMMC partition
> (factor
> 2). Implementation of DDR mode was the lower fruit.
> 
> I've the suspicion that is related to the usage of DMA engine. Maybe the
> overhead for AC/BC commands is to big. In the Freescale kernel is an
> optimization [1].
> 
> [1] -
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/?h=imx_2.6.35_maintain&id=b09358887fb4b67f6d497fac8cc48475c8bd292d
> 

here are some additional thoughts about the too little performance gain of DDR
mode:

* The DDR mode applies only to the DATA lines not to the CMD line. So the plain
MMC commands can't benefit from that.

* The i.MX28 reference manual mentions a relevant setting:

  17.8.2.2 eMMC DDR operation
  To boost the performance of SSP running in DDR mode and at the maximum
frequency, 
  the DMA interface allows a burst of 4 or 8 32-bit APB transfers per DMA
request.

I tried to change HW_SSP_DDR_CTRL_DMA_BURST_TYPE with no luck (in case of 8
bursts the communication to the MMC get lost). AFAIK this register is never
touched in the vendor kernel.

Regards
Stefan
