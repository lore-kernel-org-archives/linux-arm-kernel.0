From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Wed, 4 Feb 2015 13:19:04 +0200
Subject: [PATCH v4 0/6] Introducing the Alpine platform.
In-Reply-To: <4916446.z10l5moOdI@wuerfel>
References: <54d0cd21.WWf8LEKnly7HnqEK%tsahee@annapurnalabs.com>
 <4916446.z10l5moOdI@wuerfel>
Message-ID: <CABM=7kn-Q-poN-6xam419we-CFV-_GyLLFx4UZ-Q4RdKMbJ6dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arnd!

On 3 February 2015 at 15:55, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 03 February 2015 15:29:05 Tsahee Zidenberg wrote:
>> If possible to introduce this into 3.20 - I would really appreciate it. If any
>> action by me can make it happen - please let me know.
>>
>
> Hi Tsahee,
>
> This is not directly related to your patches, but since I got curious I
> looked at the source code published by Synology. I don't know how far
> you've come in modernizing this, but this is what I found:
>
> * The hardware looked really nice
> * You only have a couple of custom drivers, but they all have the
>   same mistake in using a private 'hardware abstraction layer'. Don't
>   do this, and use the kernel's interfaces directly

The main motivations for adding a HAL:
* re-using code between linux kernel and other systems.
* re-using common code between different drivers (e.g. - different
hardware units use the same DMA engine)
* a basic approach that states our HAL is in-fact part of the chip's API
I believe we will find a middle ground that will allow keeping these
benefits without compromise of the kernel coding style. The HALs were
written from day 1 with kernel coding-style in mind, and we do realize
there may be some more changes required in the process.

> * The serdes driver should register as a generic PHY driver
> * If possible, move the PCI initialization into the boot loader
>   and use drivers/pci/pci_host_generic.c to avoid having your
>   own driver.

PCI support will probably be the next topic for Alpine merging. I am
working on the patchset, and it will use the generic pci driver and
device-tree node.

> * the memory controller driver should live in drivers/memory
> * the baseidx addition to the pl061 driver is not going in, use
>   the new devm_gpiod_* interfaces to avoid relying on particular
>   gpio numbers.
> * The spi driver already has a binding, which is incompatible to
>   the one you use.

Thank you! We will take these into consideration!
>
>         Arnd
