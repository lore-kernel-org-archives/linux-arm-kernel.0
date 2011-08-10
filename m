From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Aug 2011 13:48:05 +0100
Subject: Subject: L2x0 OF properties do not include interrupt #
Message-ID: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm working on a driver for the PMU found in L220/PL310 L2 Cache Controllers
(as an extension to the existing L2x0 code).

I've taken a look into what BSP support would be required and mocked up some
platform_device support, though I notice that Rob Herring has provided
devicetree bindings for the L2x0 ("l2x0: Add OF based initialization") which
should probably be used to initialize the PMU (if present) from devicetree.

The L2x0 hardware supports a combined interrupt line, which is present on the
Vexpress A9x4, EB11MPcore, PB1176, etc. This can be used to signal errors on
read/write, parity checks, etc. The PMU also fires an interrupt on this line
when any of its counters saturate.

Unfortunately the L2x0 OF bindings introduced by the patch don't include an
(optional) interrupt property, which means the PMU driver won't be able to be
initialised via devicetree. As we want to get as much as possible dynamically
configured via devicetree, this is problematic.

I realise I'm a bit late to the party here, but I'd like to propose adding an
optional interrupt parameter to the binding. I'm not aware of any
implementations which use separate interrupts, but given the binding
seems to be generic across L2CC implementations (and is not limited simply to
the L2x0), having a list rather than a single interrupt may be appropriate for
someone.

This would boil down to (for the moment) a Documentation change along the lines of:

> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
> index f50e021..d4b387b 100644
> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
> @@ -28,6 +28,7 @@ Optional properties:
>  - arm,filter-ranges : <start length> Starting address and length of window to
>    filter. Addresses in the filter window are directed to the M1 port. Other
>    addresses will go to the M0 port.
> +- interrupt : A combined interrupt.
>  
>  Example:
>  
> @@ -39,4 +40,5 @@ L2: cache-controller {
>          arm,filter-latency = <0x80000000 0x8000000>;
>          cache-unified;
>          cache-level = <2>;
> +        interrupt = <45>;
>  };

Any thoughts?

Thanks,
Mark
