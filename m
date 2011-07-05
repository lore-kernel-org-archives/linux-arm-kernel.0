From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 5 Jul 2011 16:46:47 +0530
Subject: [PATCH 6/7] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <00bd01cc3ae1$f1dbfac0$d593f040$%kim@samsung.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<201107041859.11548.heiko@sntech.de>
	<20110704170217.GH28042@ponder.secretlab.ca>
	<201107042151.44075.heiko@sntech.de>
	<20110704232758.GB12824@ponder.secretlab.ca>
	<00bd01cc3ae1$f1dbfac0$d593f040$%kim@samsung.com>
Message-ID: <CABb+yY3UqrbBNS1J1X1gCxPLp8Kv8JSe92Pnb7JpE9x9kqTPiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2011 at 12:35 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Grant Likely wrote:
>>
>> On Mon, Jul 04, 2011 at 09:51:43PM +0200, Heiko St?bner wrote:
>> > Am Montag 04 Juli 2011, 19:02:17 schrieb Grant Likely:
>> > > On Mon, Jul 04, 2011 at 06:59:11PM +0200, Heiko St?bner wrote:
>> > > > Am Montag 04 Juli 2011, 18:42:51 schrieb Grant Likely:
>> > > > >
>> > > > > Wow. ?A lot of #ifdefs here. ?It does not look multiplatform
> friendly
>> > > > > at all. ?Are the s3c2410_dma functions obsolete when DMADEV_PL330
> is
>> > > > > selected? ?If so, can they be removed entirely, or are they
> required
>> > > > > to support certain hardware?
>> > > >
>> > > > The spi_s3c64xx driver can also support the SPI controller of the
>> > > > S3C2416/S3C2443 line of SoCs.
>> > > > As I'm currently working on a S3C2416 based project, my small wish
> from
>> > > > the sidelines would be to not break this support with whatever
> solution
>> > > > you will decide on :-) .
>> > >
>> > > I will not merge a patch that either breaks a platform, or requires
>> > > a compile time either/or choice of device support (enabling support
>> > > for one device should not break support for another).
>> >
>> > The patch above seems to contain the support for both SoCs (i.e.
>> s3c2410_dma_*
>> > for S3C2416 etc), so it wouldn't break the support.
>> > But this form will definitly break future multiplatform kernels when the
> 2416
>> > and some variant using the DMADEV_PL330 are selected at the same time.
>>
>> Yes, that's the breakage I'm talking about.
>>
>> > The 2416/2443 seem to be the first Samsung-SoCs to have a SPI-controller
> of
>> > this type. Implementing the DMA engine stuff for these SoCs would
> obviously
>> > solve the ifdef-problem but I don't know if this is possible to do.
>>
>> Of course it's possible, it's just software. ?:-D
>>
>> If a config option is either/or then it needs to be really well
>> justified before I will accept it. ?Most either/or options I've seen
>> aren't for any strong technical reason other than it was easier to
>> code that way.
>
> Hi all,
>
> Yes I know your concerns on this.
>
> First of all, please see below which is block diagram of Samsung DMA usage
> and 1st step will be finished with other patches for S5PC100 and S5PV210
> soon. Basically we need more time maybe 2 or 3 days to test on boards.
>
> +---------------------------------------------------------------------+
> | Each drivers which uses DMA ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> +---------------------------------------------------------------------+
> | S3C DMA API (such as s3c2410_dma_xxxx) ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?|
> +-------------------------------+-------------------------------------+
> | PL080 DMA driver ? ? ? ? ? ? ?| S3C PL330 DMA API driver ? ? ? ? ? ?|
> | for S3C24XX and S3C64XX ? ? ? | (arch/arm/plat-samsung/s3c-pl330.c) |
> | ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? +-------------------------------------+
> | (arch/arm/plat-s3c24xx/dma.c) | Common DMA core driver ? ? ? ? ? ? ?|
> | (arch/arm/mach-s3c64xx/dma.c) | (arch/arm/common/pl330.c) ? ? ? ? ? |
> +-------------------------------+-------------------------------------+
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ||
> ? ? ? ? ?(1st step. removing S3C DMA API for PL330)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ||
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \/
> +---------------------------------------------------------------------+
> | Each drivers which uses DMA ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> +-------------------------------+-------------------------------------+
> | S3C DMA API(s3c2410_dma_xxx) ?| DMA generic API for PL330 ? ? ? ? ? |
> +-------------------------------+-------------------------------------+
> | PL080 DMA driver ? ? ? ? ? ? ?| PL330 DMA API driver ? ? ? ? ? ? ? ?|
> | for S3C24XX and S3C64XX ? ? ? | (drivers/dma/pl330.c) ? ? ? ? ? ? ? |
> | ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? +-------------------------------------+
> | (arch/arm/plat-s3c24xx/dma.c) | Common DMA core driver ? ? ? ? ? ? ?|
> | (arch/arm/mach-s3c64xx/dma.c) | (arch/arm/common/pl330.c) ? ? ? ? ? |
> +-------------------------------+-------------------------------------+
>
> As you saw, the S3C_DMA_API is still used for PL080 DMA for compatibilities
> with this patches in each driver, e.g., spi and audio. As a note, S3C24XX
> and S3C64XX include PL080 DMAC not PL330.
Not exactly.
S3C24XX  use 2-3 different versions of Samsung's DMA implementations.
S3C6400/10  use PL080
S5P and later series use PL330

>
> Of course, if we can remove every S3C_DMA_API, that can be the best solution
> but it needs more time. I'd like to go to our goal step by step.
>
Ideally, like PL330 for S5Pxxxx, drivers/dma/pl080 should be enabled for s3c64xx
And new generic dma api drivers written for S3C24xx in drivers/dma/

-j
