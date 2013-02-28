From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 28 Feb 2013 02:29:27 +0000
Subject: [PATCH Resend v5 02/16] spi/spi-atmel: detect the capabilities
 of SPI core by reading the VERSION register.
In-Reply-To: <CAGhQ9Vwh1Y=_ShuAB+6mfS9SLed-6UthUHk3fdJoVKDcmP6edA@mail.gmail.com>
References: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
 <1361925520-11981-1-git-send-email-wenyou.yang@atmel.com>
 <CAGhQ9Vwh1Y=_ShuAB+6mfS9SLed-6UthUHk3fdJoVKDcmP6edA@mail.gmail.com>
Message-ID: <B256D81BAE5131468A838E5D7A24364148FA43B0@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Joachim,

> -----Original Message-----
> From: Joachim Eastwood [mailto:manabian at gmail.com]
> Sent: 2013?2?28? 3:41
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; grant.likely at secretlab.ca; Ferre,
> Nicolas; plagnioj at jcrosoft.com; richard.genoud at gmail.com; Lin, JM;
> spi-devel-general at lists.sourceforge.net
> Subject: Re: [PATCH Resend v5 02/16] spi/spi-atmel: detect the capabilities of
> SPI core by reading the VERSION register.
> 
> On 27 February 2013 01:38, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> > The "has_dma_support" needed for future use with dmaengine driver.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > Cc: spi-devel-general at lists.sourceforge.net
> > Cc: linux-kernel at vger.kernel.org
> > ---
> >  drivers/spi/spi-atmel.c |   70
> ++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 57 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> > index 5bf3786..a8e091b 100644
> > --- a/drivers/spi/spi-atmel.c
> > +++ b/drivers/spi/spi-atmel.c
> > @@ -39,6 +39,7 @@
> >  #define SPI_CSR1                               0x0034
> >  #define SPI_CSR2                               0x0038
> >  #define SPI_CSR3                               0x003c
> > +#define SPI_VERSION                            0x00fc
> >  #define SPI_RPR                                        0x0100
> >  #define SPI_RCR                                        0x0104
> >  #define SPI_TPR                                        0x0108
> > @@ -71,6 +72,8 @@
> >  #define SPI_FDIV_SIZE                          1
> >  #define SPI_MODFDIS_OFFSET                     4
> >  #define SPI_MODFDIS_SIZE                       1
> > +#define SPI_WDRBT_OFFSET                       5
> > +#define SPI_WDRBT_SIZE                         1
> >  #define SPI_LLB_OFFSET                         7
> >  #define SPI_LLB_SIZE                           1
> >  #define SPI_PCS_OFFSET                         16
> > @@ -180,6 +183,11 @@
> >  #define spi_writel(port,reg,value) \
> >         __raw_writel((value), (port)->regs + SPI_##reg)
> >
> > +struct atmel_spi_caps {
> > +       bool    is_spi2;
> > +       bool    has_wdrbt;
> > +       bool    has_dma_support;
> > +};
> >
> >  /*
> >   * The core SPI transfer engine just talks to a register bank to set up
> > @@ -204,6 +212,8 @@ struct atmel_spi {
> >
> >         void                    *buffer;
> >         dma_addr_t              buffer_dma;
> > +
> > +       struct atmel_spi_caps   caps;
> >  };
> >
> >  /* Controller-specific per-slave state */
> > @@ -222,14 +232,10 @@ struct atmel_spi_device {
> >   *  - SPI_SR.TXEMPTY, SPI_SR.NSSR (and corresponding irqs)
> >   *  - SPI_CSRx.CSAAT
> >   *  - SPI_CSRx.SBCR allows faster clocking
> > - *
> > - * We can determine the controller version by reading the VERSION
> > - * register, but I haven't checked that it exists on all chips, and
> > - * this is cheaper anyway.
> >   */
> > -static bool atmel_spi_is_v2(void)
> > +static bool atmel_spi_is_v2(struct atmel_spi *as)
> >  {
> > -       return !cpu_is_at91rm9200();
> > +       return as->caps.is_spi2;
> >  }
> 
> Since you are removing cpu_is_at91rm9200() you might want to remove
> the mach/cpu.h include as well.
I ignored it , you are right.
> 
> Regarding the includes. I think asm/{io.h, gpio.h} should be converted
> to linux/{io.h, gpio.h}. In it's own patch, though.
> 
I tried it, it is OK
> <snip>
> 
> > @@ -910,6 +921,32 @@ static void atmel_spi_cleanup(struct spi_device
> *spi)
> >         kfree(asd);
> >  }
> >
> > +static inline unsigned int atmel_get_version(struct atmel_spi *as)
> > +{
> > +       return spi_readl(as, VERSION) & 0x00000fff;
> > +}
> > +
> > +static void __init atmel_get_caps(struct atmel_spi *as)
> > +{
> > +       unsigned int version;
> > +
> > +       version = atmel_get_version(as);
> > +       dev_info(&as->pdev->dev, "version: 0x%x\n", version);
> > +
> > +       as->caps.is_spi2 = false;
> > +       as->caps.has_wdrbt = false;
> > +       as->caps.has_dma_support = false;
> > +
> > +       if (version > 0x121)
> > +               as->caps.is_spi2 = true;
> > +
> > +       if (version >= 0x210)
> > +               as->caps.has_wdrbt = true;
> > +
> > +       if (version >= 0x212)
> > +               as->caps.has_dma_support = true;
> > +}
> 
> This could be just written as: as->caps.has_dma_support = (version >= 0x212);
> or using a conditional.
> 
> It would save some lines.
> 
You are right.
> regards
> Joachim Eastwood
