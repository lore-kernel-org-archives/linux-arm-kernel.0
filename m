From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 27 Apr 2011 12:25:40 -0400 (EDT)
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <BANLkTimxLjvq2GC8_TJJk9OXZ9fPc-JKiA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1104271224030.2239-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Apr 2011, Rabin Vincent wrote:

> On Wed, Apr 27, 2011 at 00:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 26 Apr 2011, Rabin Vincent wrote:
> >> In my case it's this writel() in ehci-hub.c that gets chopped into
> >> strbs:
> >>
> >> ? ? ? /* force reset to complete */
> >> ? ? ? ehci_writel(ehci, temp & ~(PORT_RWC_BITS | PORT_RESET),
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? status_reg);
> >
> > Why would that get messed up? ?The status_reg variable doesn't have any
> > __atribute__((packed)) associated with it.
> 
> The initialization of status_reg is:
> 
> 	u32 __iomem *status_reg
> 		= &ehci->regs->port_status[(wIndex & 0xff) - 1];
> 
> where ehci->regs is a pointer to the packed struct ehci_regs.  So, this
> is the same problem of casting pointers to stricter alignment.

Right.  I can understand the compiler complaining about the cast to 
stricter alignment during the initialization.  But I don't understand 
why that would affect the code generated for the writel function.

Alan Stern
