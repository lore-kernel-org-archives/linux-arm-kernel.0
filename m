From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 09:11:38 +0100
Subject: [PATCH V4 03-1/13] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
References: <1311158773-30314-1-git-send-email-boojin.kim@samsung.com>
	<1311158773-30314-3-git-send-email-boojin.kim@samsung.com>
	<CABb+yY2_XKyCr2mEzqd0bCYJk3U7+sg8Xz4b4ma2KB1BconYOw@mail.gmail.com>
Message-ID: <20110721081138.GL26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 12:47:49AM +0530, Jassi Brar wrote:
> On Wed, Jul 20, 2011 at 4:16 PM, Boojin Kim <boojin.kim@samsung.com> wrote:
> > + ? ? ? ? ? ? ? if (slave_config->direction == DMA_TO_DEVICE) {
> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->dst_addr)
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->fifo_addr = slave_config->dst_addr;
> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->dst_addr_width)
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->burst_sz = __ffs(slave_config->dst_addr_width);
> > + ? ? ? ? ? ? ? } else if (slave_config->direction == DMA_FROM_DEVICE) {
> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->src_addr)
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->fifo_addr = slave_config->src_addr;
> > + ? ? ? ? ? ? ? ? ? ? ? if (slave_config->src_addr_width)
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? peri->burst_sz = __ffs(slave_config->src_addr_width);
> > + ? ? ? ? ? ? ? }
> PL330 has fixed channels to peripherals.
> So FIFO addresses(burst_sz too?) should already be set via platform data.
> Client drivers shouldn't bother.

That's utter crap, and isn't what the DMA engine API is about.

The above looks correctly implemented.  Slave DMA engine users are
supposed to supply the device DMA register address via this
DMA_SLAVE_CONFIG call.  Doing this via platform data for the DMA
device is braindead.
