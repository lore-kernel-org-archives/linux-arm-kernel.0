From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Jan 2013 12:47:25 -0700
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130129094143.1aad9377@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org> <20130129094143.1aad9377@skate>
Message-ID: <5108274D.5020601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 01:41 AM, Thomas Petazzoni wrote:
> Dear Stephen Warren,
> 
> On Mon, 28 Jan 2013 15:21:45 -0700, Stephen Warren wrote:
> 
>>> +Mandatory properties:
>>> +- compatible: must be "marvell,armada-370-xp-pcie"
>>> +- status: either "disabled" or "okay"
>>
>> status is a standard DT property; I certainly wouldn't expect its
>> presence to be mandatory (there's a defined default), nor would I expect
>> each device's binding to redefine this property.
> 
> Ok.
> 
>>> +- marvell,pcie-port: the physical PCIe port number
>>
>> Should the standardized cell-index property be used here instead? Or,
>> perhaps that property is deprecated/discouraged...
> 
> The problem is that I need two identifiers, the pcie-port and
> pcie-lane, and it would be strange to have one referenced as
> cell-index, and the other one as marvell,pcie-lane, no?

Yes, using a custom property for half of the information and a standard
property for the other half would be odd.

> Unless of
> course we can put two numbers in the cell-index property, but a quick
> grep in Documentation/devicetree/bindings/ seems to indicate that all
> users of cell-index use it with a single identifier.
> 
> Just tell me what to do here, I don't have a strong opinion on this.

It's probably fine as-is then. Although I wasn't sure exactly what
port/lane meant; is there some kind of mux/cross-bar between the PCIe
root ports and the physical lanes/balls/pins on the chip?

>>> diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
>>
>>> +obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>>> +ccflags-$(CONFIG_PCI_MVEBU) += \
>>> +	-I$(srctree)/arch/arm/plat-orion/include \
>>> +	-I$(srctree)/arch/arm/mach-mvebu/include
>>
>> That seems a little dangerous w.r.t. multi-platform zImage. Can the
>> required headers be moved out to somewhere more public to avoid this?
> 
> Why is this dangerous for multi-platform zImage? For this specific
> driver only, some SoC-specific headers are used. I don't think it
> prevents another PCI driver (such as the Tegra one) from being built
> into the same kernel image, no?

Aren't those ccflags applied to everything that's built by that
Makefile? If they were applied only to one .o file, it'd probably be OK,
but I don't see how that's specified.

I'm not especially bothered with reaching into the mach/plat include
directories especially since you're well aware it needs cleaning up, I
just don't think that Tegra's PCIe driver is going to compile too well
against an Orion/mvebu header if one was to get picked up first.
