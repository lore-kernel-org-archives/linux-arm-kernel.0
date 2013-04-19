From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 14:19:17 +0100
Subject: [PATCH] ARM: pci: pass a parent to pci_common_init()
In-Reply-To: <20130412134811.GA26188@arm.com>
References: <1365719096-11639-1-git-send-email-linus.walleij@linaro.org>
 <201304121326.56030.arnd@arndb.de> <20130412120538.GA32488@arm.com>
 <201304121501.48866.arnd@arndb.de> <20130412134811.GA26188@arm.com>
Message-ID: <20130419131917.GN14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 02:48:11PM +0100, Andrew Murray wrote:
> Yes, though the new PCIe host/bridge drivers with DT support all seem to call
> pci_common_init at probe with a non-statically defined hw_pci with the
> nr_controllers always set to 1 (meaning that pci_common_init can be called
> multiple times). Also hw_pci now has a field for private_data anyway which
> breaks this assumption...
> 
> Is there an argument for removing hw_pci or at least .nr_controllers and call
> pci_common_init multiple times (as is potential current use case for DT PCI
> drivers)?

Well, I notice that there's bunches of code which have been introduced
post my cleanup of the PCI stuff which insist on doing their stuff using
the pre-cleanup ways...  I guess I need to go through and fix peoples
stuff up again in this area when I finish reading the mail backlog...

The idea behind bios32.c is that all buses get scanned and _then_ setup,
rather than each get scanned and setup in sequence.  This allows for
a variety of setups where the buses may share a space - it allows the
scan to be done, then the postinit hook to be called which can then do
any post-processing prior to resources being setup.
