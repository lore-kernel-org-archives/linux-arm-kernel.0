From: dtor@chromium.org (Dmitry Torokhov)
Date: Thu, 26 Jan 2017 08:42:20 -0800
Subject: [PATCH 2/2] spi: mediatek: Only do dma for 4-byte aligned buffers
In-Reply-To: <20170126162154.124287-2-djkurtz@chromium.org>
References: <20170126162154.124287-1-djkurtz@chromium.org>
 <20170126162154.124287-2-djkurtz@chromium.org>
Message-ID: <CAE_wzQ_kC4nc28VU-msZkMAnChtkY6uWiSWFv8x4BHh3B7RJXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Jan 26, 2017 at 8:21 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Mediatek SPI DMA only works when tx and rx buffer addresses are 4-byte
> aligned.
>
> Unaligned DMA transactions appeared to work previously, since we the
> spi core was incorrectly using the spi_master device for dma, which
> had a 0 dma_mask, and therefore the swiotlb dma map operations were
> falling back to using bounce buffers.  Since each DMA transaction would
> use its own buffer, the mapped starting address of each transaction was
> always aligned.  When doing real DMA, the mapped address will share the
> alignment of the raw tx/rx buffer provided by the SPI user, which may or
> may not be aligned.
>
> If a buffer is not aligned, we cannot use DMA, and must use FIFO based
> transaction instead.

>From spi.h:

/**
 * struct spi_transfer - a read/write buffer pair
 * @tx_buf: data to be written (dma-safe memory), or NULL
 * @rx_buf: data to be read (dma-safe memory), or NULL

DMA-safe memory is ___cacheline_aligned, so it appears to be user (of
the SPI) error providing "bad" memory for transfers.

Thanks,
Dmitry
