From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Jun 2011 18:26:13 +0200
Subject: [PATCH] USB: ehci: use packed,
	aligned(4) instead of removing the packed attribute
In-Reply-To: <Pine.LNX.4.44L0.1106201049420.2113-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1106201049420.2113-100000@iolanthe.rowland.org>
Message-ID: <201106201826.13478.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 June 2011, Alan Stern wrote:
> On Sun, 19 Jun 2011, Nicolas Pitre wrote:
> 
> > > > The question is: does the structure really has to be packed?
> > > 
> > > What do you mean?  The structure really does need to be allocated
> > > without padding between the fields; is that the same thing?  So do a
> > > bunch of other structures that currently have no annotations at all.
> > 
> > Yes, that's the same thing.  The packed attribute tells the compiler 
> > that you don't want it to insert padding in it as it sees fit.
> 
> I thought the packed attribute does more than that.  For example, on
> some architectures doesn't it also force the compiler to use
> byte-oriented instructions for accessing the structure's fields?

Correct, and ARM is one of those. Giving  both packed and aligned(4)
will make gcc use 32-bit accesses again-

> > > > If the answer is yes in both cases, then having packed,aligned(4) is not 
> > > > a frivolity but rather a correctness issue.
> > > 
> > > Why so?  Current systems work just fine without it.
> > 
> > Doesn't mean that because it used to work that it is strictly correct.  
> > Wouldn't be the first time that a GCC upgrade broke the kernel because 
> > the kernel wasn't describing things properly enough.
> 
> It seems most unlikely that a gcc upgrade would cause unnecessary 
> padding to be added between a bunch of fields, all of the same size and 
> alignment.

I agree. The issue is mostly between EABI and oABI compilers behaving
differently on ARM, as well as differences between architectures.

> On the other hand, one of the other structures you haven't been 
> considering looks like this (with a bunch of uninteresting #define 
> lines omitted):
> 
> struct ehci_qtd {
> 	/* first part defined by EHCI spec */
> 	__hc32			hw_next;	/* see EHCI 3.5.1 */
> 	__hc32			hw_alt_next;    /* see EHCI 3.5.2 */
> 	__hc32			hw_token;       /* see EHCI 3.5.3 */
> 	__hc32			hw_buf [5];        /* see EHCI 3.5.4 */
> 	__hc32			hw_buf_hi [5];        /* Appendix B */
> 
> 	/* the rest is HCD-private */
> 	dma_addr_t		qtd_dma;		/* qtd address */
> 	struct list_head	qtd_list;		/* sw qtd list */
> 	struct urb		*urb;			/* qtd's urb */
> 	size_t			length;			/* length of buffer */
> } __attribute__ ((aligned (32)));
> 
> (__hc32 is an unsigned 32-bit type which can be either big-endian or 
> little-endian, depending on the device hardware.)
> 
> Only the first 5 fields need to be allocated without padding; the last 
> 4 can be laid out arbitrarily because they do not correspond to 
> anything in the hardware.  Once again, I do not think the ((packed)) 
> attribute is needed here -- in fact, we probably want to avoid it 
> because dma_addr_t can be 64 bits even on 32-bit architectures.

Agreed as well. The packing only ever matters for data structures
interpreted outside of the kernel -- user space, hardware or
network. The first five members in this structure seem to be
accessed by hardware, but they are all aligned correctly. The
other members are only used inside of the kernel and that has to
be built using only one ABI. goto no_problem;

	Arnd
