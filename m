From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 28 Apr 2011 09:35:26 -0400 (EDT)
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <201104271837.53983.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1104280934080.2108-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Apr 2011, Arnd Bergmann wrote:

> On Wednesday 27 April 2011 18:25:40 Alan Stern wrote:
> > On Wed, 27 Apr 2011, Rabin Vincent wrote:
> > 
> > > On Wed, Apr 27, 2011 at 00:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > On Tue, 26 Apr 2011, Rabin Vincent wrote:
> > > >> In my case it's this writel() in ehci-hub.c that gets chopped into
> > > >> strbs:
> > > >>
> > > >> ? ? ? /* force reset to complete */
> > > >> ? ? ? ehci_writel(ehci, temp & ~(PORT_RWC_BITS | PORT_RESET),
> > > >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? status_reg);
> > > >
> > > > Why would that get messed up? ?The status_reg variable doesn't have any
> > > > __atribute__((packed)) associated with it.
> > > 
> > > The initialization of status_reg is:
> > > 
> > >       u32 __iomem *status_reg
> > >               = &ehci->regs->port_status[(wIndex & 0xff) - 1];
> > > 
> > > where ehci->regs is a pointer to the packed struct ehci_regs.  So, this
> > > is the same problem of casting pointers to stricter alignment.
> > 
> > Right.  I can understand the compiler complaining about the cast to 
> > stricter alignment during the initialization.  But I don't understand 
> > why that would affect the code generated for the writel function.
> 
> The compiler does not complain, it just silently assumes that it needs
> to do byte accesses. There is no way to tell the compiler to ignore
> what it knows about the alignment, other than using inline assembly
> for the actual pointer dereference. Most architectures today do that,
> but on ARM it comes down to "*(u32 *)status_reg = temp".

Ah -- so the compiler associates the alignment attribute with the data 
value and not with the variable's type?  I didn't know that.

Alan Stern
