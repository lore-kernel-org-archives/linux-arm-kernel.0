From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 1 Sep 2011 12:48:19 -0400 (EDT)
Subject: [PATCH 0/3] RFC: addition to DMA API
In-Reply-To: <CACVXFVOSCS-J8iXcRpCN9TD41pWqcJOiPahtGjBmPpXBLozZyA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1109011244340.1896-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Sep 2011, Ming Lei wrote:

> > Suppose A and B are _both_ part of the dma descriptor. ?The device
> > might see A==1 and B==0, if the memory accesses occur like this:
> >
> > ? ? ? ?CPU ? ? ? ? ? ? device
> > ? ? ? ?--- ? ? ? ? ? ? ------
> > ? ? ? ?A = 1;
> > ? ? ? ?wmb();
> > ? ? ? ? ? ? ? ? ? ? ? ?read B
> > ? ? ? ? ? ? ? ? ? ? ? ?read A
> > ? ? ? ?B = 2;
> >
> > When this happens, the device will observe a non-atomic update of the
> > descriptor. ?There's no way to prevent this.
> 
> If device doesn't find that B is 2, it will not fetch descriptor of A,
> and will observe
> a atomic update, which is just EHCI does for many cases(such as 4.10.2).

You didn't read what I wrote above.  Suppose A and B are _both_ part of 
the same descriptor, like hw_token and hw_qtd_next.


> > The memory barrier in your qh_link_async() example can make sure that
> > the device always sees consistent data. ?It doesn't guarantee that the
> > write to head->hw->hw_next will be flushed to memory in a reasonably
> > short time, which is the problem you are trying to solve.
> 
> Yes, up to now, it is the only case in which the flush can address to,
> and in which kind of cases device will poll DMA coherent memory contiguously,
> I am not sure if there are other devices except for EHCI(maybe have uhci/ohci).

Yes: UHCI, OHCI, EHCI, and XHCI all poll memory constantly.

> If there are many such kind of devices, the flush operation introduced will
> make sense.
> 
> As far as I know, for most of devices, dma operation of bus master is triggered
> by writing into mmio register instead of writing into coherent memory, and the
> flush is not required in this case surely.

That's right.  It is needed only when the device polls automatically.

Alan Stern
