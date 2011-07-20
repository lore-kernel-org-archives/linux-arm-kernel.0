From: boojin.kim@samsung.com (Boojin Kim)
Date: Wed, 20 Jul 2011 15:21:11 +0900
Subject: [PATCH V3 00/13] To use DMA generic APIs for Samsung DMA
In-Reply-To: <058801cc466d$349ebe60$9ddc3b20$%kim@samsung.com>
References: <058801cc466d$349ebe60$9ddc3b20$%kim@samsung.com>
Message-ID: <002201cc46a5$397d1a70$ac774f50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> Sent: Monday, July 18, 2011 8:36 PM
> To: Kukjin Kim
> Cc: linux-arm-kernel at lists.infradead.org; linux-samsung-soc at vger.kernel.org;
> Vinod Koul; Dan Williams; Grant Likely; Liam Girdwood; Mark Brown; Linus
> Walleij
> Subject: Re: [PATCH V3 00/13] To use DMA generic APIs for Samsung DMA
>
> On Sat, Jul 16, 2011 at 12:14 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Following is diagram of this changes
> >
> > +---------------------------------------------------------------------+
> > | Each drivers which uses DMA                                         |
> > +---------------------------------------------------------------------+
> > | S3C DMA API (such as s3c2410_dma_xxxx)                              |
> > +-------------------------------+-------------------------------------+
> > | DMA driver for S3C24XX        | S3C PL330 DMA API driver            |
> > | PL080 DMA driver for S3C64XX  | (arch/arm/plat-samsung/s3c-pl330.c) |
> > |                               +-------------------------------------+
> > | (arch/arm/plat-s3c24xx/dma.c) | Common DMA core driver              |
> > | (arch/arm/mach-s3c64xx/dma.c) | (arch/arm/common/pl330.c)           |
> > +-------------------------------+-------------------------------------+
> >                               ||
> >               (removing S3C DMA API for PL330)
> >                               ||
> >                               \/
> > +---------------------------------------------------------------------+
> > | Each drivers which uses DMA                                         |
> > +-------------------------------+-------------------------------------+
> > | S3C DMA API(s3c2410_dma_xxx)  | DMA generic API for PL330           |
> > +-------------------------------+-------------------------------------+
> > | DMA driver for S3C24XX        | PL330 DMA API driver                |
> > | PL080 DMA driver for S3C64XX  | (drivers/dma/pl330.c)               |
> > |                               +-------------------------------------+
> > | (arch/arm/plat-s3c24xx/dma.c) | Common DMA core driver              |
> > | (arch/arm/mach-s3c64xx/dma.c) | (arch/arm/common/pl330.c)           |
> > +-------------------------------+-------------------------------------+
> >
>
> Please share what drivers and use-cases have been tested with the patchset.
>
> > [PATCH V3 02/13] DMA: PL330: Update PL330 DMA API driver
> > This patch updates following 3 items.
> >    1. Removes unneccessary code.
> >    2. Add AMBA, PL330 configuration
> >    3. Change the meaning of 'peri_id' variable
> >       from PL330 event number to specific dma id by user.
> Please separate this patch in to at least 2 parts and explain _why_
> you do what you do.
>
> Ex, the following two snippets looks obviously wrong to me.
> Though I doubt any better changelog can justify that, but atleast that
> will help me take it seriously. This is also why I ask for test-report.
I tested it through "SPI test application" and "aplay". It works well on both.

>
> @@ -19,7 +19,7 @@ struct dma_pl330_peri {
>          * Peri_Req i/f of the DMAC that is
>          * peripheral could be reached from.
>          */
> -       u8 peri_id; /* {0, 31} */
> +       u8 peri_id; /* specific dma id */
>
> @@ -455,7 +455,7 @@ static struct dma_pl330_desc
> *pl330_get_desc(struct dma_pl330_chan *pch)
>         async_tx_ack(&desc->txd);
>
>         desc->req.rqtype = peri->rqtype;
> -       desc->req.peri = peri->peri_id;
> +       desc->req.peri = pch->chan.chan_id;
>
> Please don't only add to changelogs, but also re-think about the above
> two changes. Hint: Read the structure definitions header file and how they
> are used in the pl330 core driver.
>
> Since the other patches would be affected by what you do here, I am not
> reviewing them until I have either justification or revert of these.


There are two reason why I change it.

First, Original DMA machine code made a "peri_id" variable to contain 
"event(interrupt) number (0~31)" information.
But, I think "event(interrupt) number (0~31)" information can be retained in 
"pch->chan.chan_id" instead of "peri_id" if DMA machine code passes the peri 
information in order of "event (interrupt) number".

I mean to say that new variable(-->'peri_id') is not need to contain "event 
(interrupt) number" information. "pch->chan.chan_id" can take place of it. And 
this makes the meaning of "pch->chan.chan_id" more informative because .

Second, A magic value is required to find the DMA channel desired by DMA 
client on multi-platform.
This value is used on "dma_filter_fn filter()" function to find the channel.
I changed that the meaning of "peri_id" to use for it from "event(interrupt) 
number (0~31)" to "a magic value".
If you can accept this change about meaning of 'peri_id', I will create new 
value on " struct dma_pl330_peri" to contain a magic value.

I think this patch is good because no need to new value for "a magic value" 
and make "pch->chan.chan_id" more infomative.
Do you still want to change this patch?

> > [PATCH V3 03/13] DMA: PL330: Add DMA capabilities
> Please don't be conservative with number of patches - segregate independent
> changes in independent patches or you make my life miserable :(

Do you want to separate this patch more finely?
If yes, I will divide it into two patches. First patch will be for 
dma_slave_config. Second patch will be for cyclic capability.

> Thnx
> -jassi
