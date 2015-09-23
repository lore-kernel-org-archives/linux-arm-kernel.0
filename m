From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Sep 2015 10:01:01 +0200
Subject: [PATCH v3 4/6] PCI: generic: Correct, and avoid overflow,
 in bus_max calculation.
In-Reply-To: <1442965757-12925-5-git-send-email-ddaney.cavm@gmail.com>
References: <1442965757-12925-1-git-send-email-ddaney.cavm@gmail.com>
 <1442965757-12925-5-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1496061.0ds89jTH75@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 September 2015 16:49:15 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> There are two problems with the bus_max calculation:
> 
> 1) The u8 data type can overflow for large config space windows.
> 
> 2) The calculation is incorrect for a bus range that doesn't start at
>    zero.
> 
> Since the configuration space is relative to bus zero, make bus_max
> just be the size of the config window scaled by bus_shift.  Then clamp
> it to a maximum of 255, per PCI.  Use a data type of int to avoid
> overflow problems.
> 
> Update host-generic-pci.txt to clarify the semantics of the "reg"
> property with respect to non-zero starting bus numbers.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Not sure about this one

> diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.txt b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> index cf3e205..105a968 100644
> --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> @@ -34,7 +34,9 @@ Properties of the host controller node:
>  - #size-cells    : Must be 2.
>  
>  - reg            : The Configuration Space base address and size, as accessed
> -                   from the parent bus.
> +                   from the parent bus.  The base address corresponds to
> +                   bus zero, even though the "bus-range" property may specify
> +                   a different starting bus number.

This sounds like very unusual behavior. If you have a system with faked
bus numbers where the registers only physically exist for a subset of the
buses, this requires defining a reg property that contains MMIO space
which is outside of the device and potentially contains other devices.

What would break if we instead defined it the expected way and only
list the registers for the bus numbers in the "bus-range" property?

	Arnd
