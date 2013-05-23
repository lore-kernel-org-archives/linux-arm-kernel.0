From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 22:40:03 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130523202643.GQ18614@n2100.arm.linux.org.uk>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130523142301.10dbeff9@skate>
 <20130523202643.GQ18614@n2100.arm.linux.org.uk>
Message-ID: <201305232240.03959.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Russell King - ARM Linux wrote:
> On Thu, May 23, 2013 at 02:23:01PM +0200, Thomas Petazzoni wrote:
> > But that's not the case. Neither the old nor the new bootloaders are
> > changing the Device Tree in any way that allows us to know whether
> > registers are mapped at 0xd0 and 0xf1.
> 
> Who provides this DT blob?  Is it already provided with the board, or
> is it something which is provided by others?

In theory, the board could provide the DT, but we would always be able
to provide an updated DT blob if necessary. In practice, the DT blob at
the moment is always shipped alongside the kernel, as some interfaces
(e.g. the mbus or pci in case of mvebu) are not final yet.

The boot loader has ways to modify that blob in memory, in order to
pass the information that traditionally is in the ATAGS and other things
like a board specific MAC address. It is straightforward for the bootloader
to update properties like the location of the internal registers, once
we have specified the binding for the mbus, but not until then.

For older boot loaders that only support ATAGS, the update of the DT
blob happens inside of the kernel in arch/arm/boot/compressed/atags_to_fdt.c
on the blob that is appended to the zImage.

	Arnd
