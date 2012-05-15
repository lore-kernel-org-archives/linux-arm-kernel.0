From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 May 2012 10:31:58 -0600
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <201205151437.55286.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515161655.504f1403@skate> <4FB26904.1060308@codethink.co.uk>
 <201205151437.55286.arnd@arndb.de>
Message-ID: <4FB284FE.10203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2012 08:37 AM, Arnd Bergmann wrote:
> On Tuesday 15 May 2012, Ben Dooks wrote:
>>>   * Maybe those mappings can be done using a normal ioremap() rather
>>>     than in ->map_io(), according to DT informations (but most other ARM
>>>     SoC support at the moment seem to do PCI mappings using static
>>>     mappings in ->map_io)
>> That's a very old way of doing it. I'm pretty sure there's no reason to
>> get these allocated so early.
> 
> Well, you might actually still want to use static mappings for any large
> areas that are accessed a lot in the kernel, because that lets you
> use larger page TLB entries, which ioremap by itself cannot. The host
> driver should however still use ioremap, it will now just get the area
> that was set up with map_io.
> 
>> I believe you can probably leave the PCI/PCIe bindings until you have
>> enough kernel state to do ioremap() or similar and then associate the
>> necessary mappings with the bus creation.
> 
> I think it was Stephen Warrent who told me that he can actually do
> a PCI host driver as a loadable module now, with only a few changes
> in the ARM core code.

Thierry Redding was working on this (actually, perhaps PCIe as a
platform driver rather than as a module, but I'm not sure) in the
context of the Tegra PCIe driver. See some of the patches at
http://patchwork.ozlabs.org/project/linux-tegra/list/, e.g. "PCI: Keep
pci_fixup_irqs() around after init" and "ARM: pci: Keep
pci_common_init() around after init" IIRC.
