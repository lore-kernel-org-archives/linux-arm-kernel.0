From: rabin@rab.in (Rabin Vincent)
Date: Wed, 27 Apr 2011 19:36:00 +0530
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <Pine.LNX.4.44L0.1104261447481.2035-100000@iolanthe.rowland.org>
References: <BANLkTi=-DFfdiBKZzRBxF-yMJFtWnzuk1g@mail.gmail.com>
	<Pine.LNX.4.44L0.1104261447481.2035-100000@iolanthe.rowland.org>
Message-ID: <BANLkTimxLjvq2GC8_TJJk9OXZ9fPc-JKiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 00:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 26 Apr 2011, Rabin Vincent wrote:
>> In my case it's this writel() in ehci-hub.c that gets chopped into
>> strbs:
>>
>> ? ? ? /* force reset to complete */
>> ? ? ? ehci_writel(ehci, temp & ~(PORT_RWC_BITS | PORT_RESET),
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? status_reg);
>
> Why would that get messed up? ?The status_reg variable doesn't have any
> __atribute__((packed)) associated with it.

The initialization of status_reg is:

	u32 __iomem *status_reg
		= &ehci->regs->port_status[(wIndex & 0xff) - 1];

where ehci->regs is a pointer to the packed struct ehci_regs.  So, this
is the same problem of casting pointers to stricter alignment.
