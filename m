From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 14:03:04 +0200
Subject: [PATCH v8 3/6] pci:host: Add Altera PCIe host controller driver
In-Reply-To: <20151009231540.GE16112@localhost>
References: <1444297394-3122-1-git-send-email-lftan@altera.com>
 <CAFiDJ58oMa6rgQe_STCiWRpdL+P22BN1=Nin_+QnLXC9RGiSzQ@mail.gmail.com>
 <20151009231540.GE16112@localhost>
Message-ID: <7064179.1W3LTfFPxP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 18:15:40 Bjorn Helgaas wrote:
> 
> I don't know if this should be a kernel taint, a simple warning in
> dmesg, or what.  I guess the tainting mechanism is probably too
> general-purpose for this, and add_taint() doesn't give any dmesg
> indication.  We wouldn't see the taint unless the problem actually
> caused an oops or panic.  In this case, I think I want a clue in dmesg
> so we have a chance of seeing it even if there is no oops.  So
> probably something like a dev_warn("non-compliant config accesses")
> would work.
> 
> You really should double-check with the hardware guys, because it's
> pretty obvious that the PCI spec requires 1- and 2-byte config
> accesses to work correctly.  For example, if you read/modify/write to
> update PCI_COMMAND, you will inadvertently clear the RW1C bits in
> PCI_STATUS.

Would it help to require a DT property here that flags the device
as having a broken config space?

Then we could implement both in the driver, and only use the
RMW based implementation if the firmware describes the device
as "altera,broken-pci-config-space".

	Arnd
