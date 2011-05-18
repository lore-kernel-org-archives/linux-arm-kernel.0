From: marek.vasut.n900@gmail.com (Marek Vasut)
Date: Wed, 18 May 2011 19:36:54 +0200
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <20110518152935.GJ5913@n2100.arm.linux.org.uk>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<20110518152935.GJ5913@n2100.arm.linux.org.uk>
Message-ID: <1305740214.1526.2.camel@konomi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, May 18, 2011 at 05:18:38PM +0200, Pavel Herrmann wrote:
> > spi_sync call uses its spi_message parameter to keep completion
> > information, having this structure static is not thread-safe,
> > potentially causing one thread having pointers to memory on or above
> > other threads stack. use per-call spi_message on stack to fix this
> 
> I assume this has not been tested with DMA debugging enabled.
> 
> The DMA API does not like mapping memory from the stack, which is what
> you're potentially doing with this:

Yikes, good catch, but kmallocing this and kfreeing it again is not something I'd like to see either.

What other options do you suggest?

Btw note, this isn't the only driver doing this, maybe we have a horde of patches on the way?

> 
> > +??? uint8_t rx_buf[2] = {0, 0};
> > +??? uint8_t tx_buf = (channel << MAX1111_CTRL_SEL_SH) |
> > +??? ??? ??? MAX1111_CTRL_PD0 | MAX1111_CTRL_PD1 |
> > +??? ??? ??? MAX1111_CTRL_SGL | MAX1111_CTRL_UNI |
> > +??? ??? ??? MAX1111_CTRL_STR;
> > +
> > +??? spi_message_init(&m);
> > +??? memset(t, 0, sizeof(t));
> > +
> > +??? t[0].tx_buf = &tx_buf;
> > +??? t[0].len = 1;
> > +??? spi_message_add_tail(&t[0], &m);
> > +
> > +??? t[1].rx_buf = rx_buf;
> > +??? t[1].len = 2;
> > +??? spi_message_add_tail(&t[1], &m);
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
