From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 11 Jul 2012 16:08:41 +0900
Subject: [GIT PULL] Samsung devel-dma ops for v3.6
In-Reply-To: <201207101242.41867.arnd@arndb.de>
References: <0c5001cd5e41$87daa1b0$978fe510$%kim@samsung.com>
 <201207101242.41867.arnd@arndb.de>
Message-ID: <0e1301cd5f34$008fe1e0$01afa5a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Tuesday 10 July 2012, Kukjin Kim wrote:
> > Hi Arnd, Olof,
> >
> > Here is updating DMA common operation for Samsung SoCs.
> >
> > Since some DMA client driver such as spi needs to change the
> configuration
> > after dma_request() so this branch adds dma_config() can configure DMA
> > transmit option which is included in dma_request() after that.
> >
> > Note, according to the changes, needs to update spi and ASoC drivers for
> > Samsung SoCs and only got the ack from Mark Brown not Grant Likely and
> as I
> > know, he is busy for moving. But I think, the spi change has no problem
> and
> > it is simple.
> >
> > If any problems, please kindly let me know.
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/devel-dma-ops
> 
> I've applied this to a new next/dma branch for now, as it sounds that you
> need these changes.
> 
Arnd, thanks.

> However, my feeling is that the s3c-dma-ops support is moving in the wrong
> direction, or at least I do not see where you're heading with it.
> 
> From what I see, there is the
> 
> * arch/arm/plat-s3c24xx/dma.c driver with a proprietary s3c2410_dma_*
>   interface, used by s3cmci and some asoc drivers.
> * arch/arm/mach-s3c64xx/dma.c implementing the same interface and
> exporting
>   the same symbols.
> * The arch/arm/plat-samsung/dma-ops.c which is a wrapper around the
> generic
>   dmaengine API, hardcoding the pl330 DMA driver
> * The arch/arm/plat-samsung/include/plat/dma-ops.h interface abstraction
>   that gets used to pick between the two at compile time, and being used
> by
>   the spi driver and again other asoc drivers
> 
> Can you (or someone on the Cc list) explain what the plan is for this?
> Are you moving over the s3c2410_dma*() function to a dmaengine driver
> eventually? Do you expect to see more users of the nonstandard intefaces
> in the samsung code, or are they going away?
> 
Yeah, let me explain the status for Samsung SoCs' DMA. There are 3 different
DMA IPs, samsung specific s3c24xx dma, pl080 and pl330. As you know, pl330
already moved in drivers/dma for using common DMA engine and Alim is
re-working on pl080
(http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg10954.html
) and let me check its progress. But s3c24xx dma is not ready yet. When
pl330 was moving, my colleague, Boojin Kim posted to use common DMA APIs for
Samsung drivers which are using DMA such as spi and ASoC. But it was
including too many ifdef for checking which DMA is used and it can occur
breakage for multiplatform
(http://www.spinics.net/lists/arm-kernel/msg131137.html). So we implemented
to use some dma_ops after discussing with Grant Likely
(http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/058171.html
).

Anyway, we will try to use common DMA APIs for all Samsung SoCs. But need
more time ;)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
