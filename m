From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 16:45:07 +0000
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130129172055.0ca5f341@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130129155820.GB23505@n2100.arm.linux.org.uk>
 <20130129172055.0ca5f341@skate>
Message-ID: <201301291645.08040.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Thomas Petazzoni wrote:
> And the Linux PCI resource allocation code complies with this, so that
> if I have two PCI-to-PCI bridges (each having downstream a device with
> an I/O BAR), then the first PCI-to-PCI bridge gets its I/O base address
> register set to ADDR + 0x0, and the second bridge gets its I/O base
> address set to ADDR + 0x1000. And this doesn't play well with the
> requirements of Marvell address decoding windows for PCIe I/O regions,
> which must be 64 KB aligned.

But we normally only assign a 64 KB I/O window to each PCI host bridge.
Requiring PCI bridges to be space 64 KB apart would mean that we cannot
actually support bridges at all.

Is this just about your "virtual" bridges? If each one has its
own 64 KB I/O range and its own configuration space, that sounds
a lot like you should make them appear as individual domains instead.

	Arnd
