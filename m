From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Wed, 24 Mar 2010 23:08:12 +0100
Subject: [PATCH 1/5] ARM: define the PrimeCell DMA API
In-Reply-To: <e9c3a7c21003241425m595f983fg520c9cace7ddce91@mail.gmail.com>
References: <1268056327-16577-1-git-send-email-linus.walleij@stericsson.com>
	<e9c3a7c21003241425m595f983fg520c9cace7ddce91@mail.gmail.com>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A0391EEB6@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Dan]

> > +/**
> > + * struct amba_dma_channel_request - this struct is passed in as
> > + * configuration data to a DMA engine in order to set up a certain
> > + * channel for DMA transport. Anything the DMA engine needs to
> > + * know about the PrimeCell shall be passed through this struct.
> > + * The DMA engine has to provide an additional function:
> > + * dma_set_ambaconfig() in order for it to work with PrimeCells.
> > + * @addr: this is the physical address where DMA data should be
> > + * read (RX) or written (TX)
> > + * @addr_width: this is the width of the source (RX) or target
> > + * (TX) register where DMA data shall be read/written, in bytes.
> > + * legal values: 1, 2, 4, 8.
> > + */
> > +struct amba_dma_channel_config {
> > + ? ? ? dma_addr_t addr;
> > + ? ? ? u8 addr_width:4;
> > +};
> 
> The usages of this seem to be constant data based off something that
> comes from the platform data or 'slave' device.  Could this constant
> data just be munged/merged into the platform data and we can look it
> up at runtime via chan->private.  Or am I oversimplifying?

Well actually, the addr is constant in the cases I've seen so
far but doesn't have to be, e.g. for a bidirectional channel
which shall do RX from one address and TX from a different address,
though I haven't seen such a thing.

addr_width is subject to the above case as well, however now I
also have DMA for the PL022 driver cooking and that actually needs
to switch the width of the address endpoint in runtime. (Soon
to come...)

So this needs some specific function call or alter chan->private
in runtime.

> None the of the usages seem to justify forking from core dmaengine at
> this point (I reserve the right to be proven wrong later).

It's more of a superset than a fork really...

I think the crucial point is that a client driver, say
drivers/serial/amba-pl011.c need to supply PrimeCell-specific
configuration in runtime without knowing which DMA engine
is being used.

If I just assign PrimeCell configuration say something like
this:

struct amba_dma_channel_config conf;
chan->private = &conf;

Then the DMA engine has to either:

- Only support primecells and cast all chan->private to
  struct amba_dma_channel_config (this is rarely the case,
  we have a lot of other custom devices which are not
  primecells at all so won't work for us)

- Or know which channels are assigned to primecells before
  we assign this configuration, so it can keep track of it
  internally in some

struct mypriv {
	bool is_amba;
	struct amba_dma_channel_config *ambaconf;
	bool is_other;
	struct other_config *otherconf;
}
struct mypriv foo = {
	.is_amba = true,
	...
};
chan->private = &foo;

  And is_amba must be set to true for all primecells before
  we start probing clients. In runtime this would require
  things like this:

struct mypriv *foo = chan->private;
foo->ambaconf->addr_width = 2;

Do you prefer this latter solution? I'm OK with either, I just
think the runtime dma_set_ambaconfig() is a bit more elegant.

Linus
