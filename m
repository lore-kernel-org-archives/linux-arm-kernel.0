From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Feb 2015 14:55:41 +0100
Subject: [PATCH v4 0/6] Introducing the Alpine platform.
In-Reply-To: <54d0cd21.WWf8LEKnly7HnqEK%tsahee@annapurnalabs.com>
References: <54d0cd21.WWf8LEKnly7HnqEK%tsahee@annapurnalabs.com>
Message-ID: <4916446.z10l5moOdI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 February 2015 15:29:05 Tsahee Zidenberg wrote:
> If possible to introduce this into 3.20 - I would really appreciate it. If any 
> action by me can make it happen - please let me know.
> 

Hi Tsahee,

This is not directly related to your patches, but since I got curious I
looked at the source code published by Synology. I don't know how far
you've come in modernizing this, but this is what I found:

* The hardware looked really nice
* You only have a couple of custom drivers, but they all have the
  same mistake in using a private 'hardware abstraction layer'. Don't
  do this, and use the kernel's interfaces directly
* The serdes driver should register as a generic PHY driver
* If possible, move the PCI initialization into the boot loader
  and use drivers/pci/pci_host_generic.c to avoid having your
  own driver.
* the memory controller driver should live in drivers/memory
* the baseidx addition to the pl061 driver is not going in, use
  the new devm_gpiod_* interfaces to avoid relying on particular
  gpio numbers.
* The spi driver already has a binding, which is incompatible to
  the one you use.

	Arnd
