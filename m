From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 02 Sep 2010 16:30:37 +0900
Subject: [PATCH 07/13] ARM: S5P64X0: Update Audio support
In-Reply-To: <AANLkTin=fmeRZt=SSrxk9YzrhZs1nLxc9M30PYO3ONEb@mail.gmail.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
	<1283324960-21629-8-git-send-email-kgene.kim@samsung.com>
	<AANLkTin=fmeRZt=SSrxk9YzrhZs1nLxc9M30PYO3ONEb@mail.gmail.com>
Message-ID: <004601cb4a70$c0d72970$42857c50$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
Hi Jassi :-)

Thanks for your review.

> On Wed, Sep 1, 2010 at 4:09 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This patch updates Audio and SPI for S5P6440 and S5P6450 SoCs.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Jassi Brar <jassi.brar@samsung.com>
> > ---
> >  arch/arm/mach-s5p6440/dev-audio.c               |  127 -----------
> >  arch/arm/mach-s5p6440/dev-spi.c                 |  176 ---------------
> >  arch/arm/mach-s5p6440/include/mach/spi-clocks.h |   17 --
> >  arch/arm/mach-s5p64x0/dev-audio.c               |  164 ++++++++++++++
> >  arch/arm/mach-s5p64x0/dev-spi.c                 |  275
> +++++++++++++++++++++++
> >  arch/arm/mach-s5p64x0/include/mach/spi-clocks.h |   20 ++
> >  arch/arm/plat-samsung/include/plat/devs.h       |    5 +
> >  7 files changed, 464 insertions(+), 320 deletions(-)
> >  delete mode 100644 arch/arm/mach-s5p6440/dev-audio.c
> >  delete mode 100644 arch/arm/mach-s5p6440/dev-spi.c
> >  delete mode 100644 arch/arm/mach-s5p6440/include/mach/spi-clocks.h
> >  create mode 100644 arch/arm/mach-s5p64x0/dev-audio.c
> >  create mode 100644 arch/arm/mach-s5p64x0/dev-spi.c
> >  create mode 100644 arch/arm/mach-s5p64x0/include/mach/spi-clocks.h
> >

(snip)

> 
> S5P6450 has 2 I2S_v2 and 1 I2S_v4, the first two are missing.
> Also missing are 3 PCM device definitions.
> 
Yeah, I know. But the remaining items will be added later.
Maybe Mr. Youn will do it ;-)

(snip)

> > +struct platform_device s5p6440_device_iis = {
> > +       .name           = "s3c64x0-iis-v4",
> 
> The assigned name is wrong. It should be "s3c64xx-iis-v4"
> 
You're right..will fix it.

> 
> > +       .id             = -1,
> > +       .num_resources  = ARRAY_SIZE(s5p64x0_iis0_resource),
> > +       .resource       = s5p64x0_iis0_resource,
> > +       .dev = {
> > +               .platform_data = &s5p6440_i2s_pdata,
> > +       },
> > +};
> > +
> > +struct platform_device s5p6450_device_iis0 = {
> > +       .name           = "s3c64x0-iis-v4",
> 
> The assigned name is wrong. It should be "s3c64xx-iis-v4"
> 
ok..

> > +       .id             = -1,
> > +       .num_resources  = ARRAY_SIZE(s5p64x0_iis0_resource),
> > +       .resource       = s5p64x0_iis0_resource,
> > +       .dev = {
> > +               .platform_data = &s5p6450_i2s_pdata,
> > +       },
> > +};
> > +

(snip)

> > +
> > +static char *s5p6440_spi_src_clks[] = {
> > +       [S5P64X0_SPI_SRCCLK_PCLK] = "pclk",
> > +       [S5P64X0_SPI_SRCCLK_SCLK] = "spi_epll",
> > +};
> > +
> > +static char *s5p6450_spi_src_clks[] = {
> > +       [S5P64X0_SPI_SRCCLK_PCLK] = "pclk",
> > +       [S5P64X0_SPI_SRCCLK_SCLK] = "sclk_spi",
> > +};
> 
> Maybe we can drop one and call the other s5p64x0_spi_src_clks
> The second clock is the same but only named differently.
> 
As you know, we use the clock name as there is in data sheet.
Anyway...will sort out.

(snip)

> > +
> > +static struct s3c64x0_spi_info s5p6440_spi0_pdata = {
> > +       .cfg_gpio       = s5p6440_spi_cfg_gpio,
> > +       .fifo_lvl_mask  = 0x1ff,
> > +       .rx_lvl_offset  = 15,
> > +};
> 
> I think you forgot to compile check in hurry ?

hahaha, I'm always remembering it :-) about all of s3c and s5p defconfigs.
Actually, there is no build error...and kernel booting works well on the board.

But I didn't audio test...just moved your original code into the new machine directory.
...And now, not selected S3C64XX_DEV_SPI...so not compiled dev-spi.c.
Anyway, I will check all files ;-)
Thanks.

> There is no s3c64x0_spi_info, but only s3c64xx_spi_info
> 
Yeah, you're right...will fix it.

> > +
> > +static struct s3c64x0_spi_info s5p6450_spi0_pdata = {
> > +       .cfg_gpio       = s5p6450_spi_cfg_gpio,
> > +       .fifo_lvl_mask  = 0x1ff,
> > +       .rx_lvl_offset  = 15,
> > +};
> > +
> > +static u64 spi_dmamask = DMA_BIT_MASK(32);
> > +
> > +struct platform_device s5p6440_device_spi0 = {
> > +       .name           = "s3c64x0-spi",
> 
> %s/64xx/64x0 ? :)

Maybe...yes? ;-)

> The device name should be kept same "s3c64xx-spi"
> 
It's my mistake...will fix it.

> > +       .id             = 0,
> > +       .num_resources  = ARRAY_SIZE(s5p64x0_spi0_resource),
> > +       .resource       = s5p64x0_spi0_resource,
> > +       .dev = {
> > +               .dma_mask               = &spi_dmamask,
> > +               .coherent_dma_mask      = DMA_BIT_MASK(32),
> > +               .platform_data = &s5p6440_spi0_pdata,
> > +       },
> > +};
> > +
> > +struct platform_device s5p6450_device_spi0 = {
> > +       .name           = "s3c64x0-spi",
> 
> same here
> 
ok...

> > +       .id             = 0,
> > +       .num_resources  = ARRAY_SIZE(s5p64x0_spi0_resource),
> > +       .resource       = s5p64x0_spi0_resource,
> > +       .dev = {
> > +               .dma_mask               = &spi_dmamask,
> > +               .coherent_dma_mask      = DMA_BIT_MASK(32),
> > +               .platform_data = &s5p6450_spi0_pdata,
> > +       },
> > +};

(snip)

> > +
> > +struct platform_device s5p6440_device_spi1 = {
> > +       .name           = "s3c64x0-spi",
> 
> same here...
> 
ok...

> > +       .id             = 1,
> > +       .num_resources  = ARRAY_SIZE(s5p64x0_spi1_resource),
> > +       .resource       = s5p64x0_spi1_resource,
> > +       .dev = {
> > +               .dma_mask               = &spi_dmamask,
> > +               .coherent_dma_mask      = DMA_BIT_MASK(32),
> > +               .platform_data = &s5p6440_spi1_pdata,
> > +       },
> > +};
> > +
> > +struct platform_device s5p6450_device_spi1 = {
> > +       .name           = "s3c64x0-spi",
> 
> same here ....
> 
ok...

> > +       .id             = 1,
> > +       .num_resources  = ARRAY_SIZE(s5p64x0_spi1_resource),
> > +       .resource       = s5p64x0_spi1_resource,
> > +       .dev = {
> > +               .dma_mask               = &spi_dmamask,
> > +               .coherent_dma_mask      = DMA_BIT_MASK(32),
> > +               .platform_data = &s5p6450_spi1_pdata,
> > +       },
> > +};
> > +
> > +void __init s5p6440_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
> 
> maybe we could call it s5p64x0_spi_set_info, and remove other other one ?
> 
mm...will sort out.

> > +{
> > +       struct s3c64x0_spi_info *pd;
> > +
> > +       /* Reject invalid configuration */
> > +       if (!num_cs || src_clk_nr < 0
> > +                       || src_clk_nr > S5P6440_SPI_SRCCLK_SCLK) {
>  you need to change all references to S5P6440_SPI_SRCCLK_..... as well.
> 
Yeah, ok.

> > +               printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);
> > +               return;
> > +       }
> > +

(snip)

> 
> just to say the least.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
