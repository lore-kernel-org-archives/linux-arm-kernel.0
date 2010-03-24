From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Wed, 24 Mar 2010 22:38:59 +0100
Subject: [PATCH 1/5] ARM: define the PrimeCell DMA API
In-Reply-To: <e9c3a7c21003241408g2a704425g47ccdfb60d606683@mail.gmail.com>
References: <1268056327-16577-1-git-send-email-linus.walleij@stericsson.com>
	<e9c3a7c21003241408g2a704425g47ccdfb60d606683@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A0391EEB1@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it happens I'm entertaining myself with this patchset
right now...

> > +void dma_set_ambaconfig(struct dma_chan *chan,
> > + ? ? ? ? ? ? ? ? ? ? ? struct amba_dma_channel_config *config);
> > +void dma_stop_channel(struct dma_chan *chan);
> > +u32 dma_get_channel_bytes_left(struct dma_chan *chan);
> 
> I question if these last two can be generically promoted to dmaengine?

OK...

I renamed get_channel_bytes_left() to get_channel_residue() btw.

>  I already discussed a potential dma_get_channel_bytes() synonym with
> Guennadi [1] (wrap ->device_is_tx_complete()),
> and dma_stop_channel()
> looks like it could wrap ->device_terminate_all().

Actually its a little bit like STOP/PAUSE/UNPAUSE on a tape
recorder, I find that in practice I have these two usecases:

* STOP (as in cancel) the DMA transfer and retrieve the number
  of bytes left at that point

* PAUSE the DMA transfer and retrieve the number of bytes
  left at that point, later UNPAUSE or STOP

* retrieve the number of bytes left in an ongoing transfer,
  a fluctuating value. This is typically nice for audio
  progress bars to take some simple example.

Right now, for the PrimeCells, I only need to be able to STOP the
channel and get the residual bytes at this time. So I'll create
something like dma_get_residue() in the DMA devices, and specify
the sematics such that if device_terminate_all() is called before
this point the residual at that time shall be returned, else
the current fluctuating value, would that be OK?

Yours,
Linus Walleij
