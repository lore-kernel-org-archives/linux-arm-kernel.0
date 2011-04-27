From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2011 22:48:15 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110427202603.GY17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<201104272221.48601.arnd@arndb.de>
	<20110427202603.GY17290@n2100.arm.linux.org.uk>
Message-ID: <201104272248.15969.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2011 22:26:03 Russell King - ARM Linux wrote:
> Maybe something in asm/pci.h - but that invites having lots of bus
> specific header files in asm/.
> 
> A better solution imho would be to have an architecture callback for
> struct device which gets registered, which can inspect the type of
> the device, and set the flag depending on where it appears in the
> tree.

Ah, I was under the assumption that there was already a callback
for this. We have a dma_set_coherent_mask() implementation in
some pci hosts (ixp4xx and it8152), but that's not a proper
callback that can be override per host and it does not
actually do what we were talking about here. I guess the callback
should live in struct hw_pci in case of ARM, and set a new field
in struct device_dma_parameters.

Maybe we don't even need a new flag if we just set
device->coherent_dma_mask to zero.

	Arnd
