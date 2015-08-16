From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Aug 2015 15:06:39 +0100
Subject: [PATCH] spi: Mediatek: fix endian warnings
In-Reply-To: <1871097.B3YgX5rNy0@wuerfel>
References: <1439289789-29026-1-git-send-email-leilk.liu@mediatek.com>
 <1871097.B3YgX5rNy0@wuerfel>
Message-ID: <20150816140639.GE7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 15, 2015 at 10:16:03PM +0200, Arnd Bergmann wrote:
> On Tuesday 11 August 2015 18:43:09 Leilk Liu wrote:
> > @@ -359,9 +359,11 @@ static void mtk_spi_setup_dma_addr(struct spi_master *master,
> >         struct mtk_spi *mdata = spi_master_get_devdata(master);
> >  
> >         if (mdata->tx_sgl)
> > -               writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
> > +               writel((__force u32)cpu_to_le32(xfer->tx_dma),
> > +                      mdata->base + SPI_TX_SRC_REG);
> >         if (mdata->rx_sgl)
> > -               writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
> > +               writel((__force u32)cpu_to_le32(xfer->rx_dma),
> > +                      mdata->base + SPI_RX_DST_REG);
> >  }
> > 
> 
> This looks wrong: writel takes a CPU-endian argument, so the value returned
> from cpu_to_le32() is not appropriate.
> 
> The warning is correct, and you have to remove the cpu_to_le32() conversion
> in order to get the driver to behave correctly when the kernel is built
> as big-endian.

Indeed, it's about time people started thinking more about the warnings
and why we have coded things in the way we have.

Look people.  cpu_to_le32() takes a value in the CPU endian, and
converts it to a little endian 32-bit number.  See, the clue is in
the name.

All writel() implementations take a CPU number and write it in little
endian format.  Hence, writel() almost always uses cpu_to_le32()
internally.

Now think about what you're saying with "cpu_to_le32(cpu_to_le32())".
It's utter rubbish, total crap.  It's wrong no matter which way you
look at it.

We have le32_to_cpu() which does what it says on the tin.  Same with
be32_to_cpu() and cpu_to_be32().

Don't hack around this stuff with __force.  If you're having to use
__force to get rid of a warning here, you _ARE_ doing something wrong,
no questions about that.  __force in driver code is a definite sign
that you are doing something wrong.  Don't do it.  Ask the question
if you think you need it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
