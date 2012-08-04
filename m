From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 4 Aug 2012 16:50:50 +0000
Subject: arm: mvebu: Add basic address decoding support for Marvell 370/XP
In-Reply-To: <20120804182730.1ef77f23@skate>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201208031423.10561.arnd@arndb.de> <20120804182730.1ef77f23@skate>
Message-ID: <201208041650.51427.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 04 August 2012, Thomas Petazzoni wrote:
> Well, we could do something like:
> 
> addr-decoding at d0020000 {
>         compatible = "marvell,armada-addr-decoding-controller";
>         reg = <0xd0020000 0x258>;
> 
>         window at 0 {
>                 /* Window number */
>                 cell-index = <0>;                             
> 
>                 /* Physical address and size at which the device will be mapped. */
>                 reg = <0xfff00000 0x100000>;
> 
>                 /* Which device is being mapped. Can either have 1
>                    integer (for "big" devices) or 2 integers (for devices
>                    in the "Device Bus") */
>                 marvell,target = <0x1 0x1d>;
> 
>                 /* Optional. Remapping address */
>                 marvell,remap = <...>;
>         };
> 
>         window at 12 {
>                 cell-index = <12>;
>                 reg = <0x... 0x....>;
>                 marvell,target = <0x4>;
>         };
> };
> 
> This is just a rough draft, just written in the mail, I haven't even
> tried writing code that would work with it, but it should be relatively
> easy to do.
> 
> Would that make sense? Of course, suggestions welcome, I'm not an
> expert on how to decide what is the best DT encoding for such data.

The point that I'm wondering about is where the physical address
comes from. This one is not describing the hardware at all, and the OS
is free to pick any other address, so why would be put that particular
one into the device tree?

Maybe you can find a way to better represent the actual address hierarchy
in a way that shows the remapping. I don't understand how the remapping
works, but I think what we would need for this is an intermediate
large address space and a ranges property that translate the large
addresses into bus addresses, but with the option of the driver for that
intermediate bus overriding the mapping.

remapped-bus at d0020000 {
	compatible = "marvell,armada-addr-decoding-controller";
	reg = <0xd0020000 0x258>;
	#address-cells = <3>;
	#size-cells = <1>;
	ranges = <0x1 0x1d 0x0     /* device 1 address */
		  0xfff00000	   /* host address */
		  0x100000>	   /* length */
		 <02 0x1e 0x0	   /* device 2 address */
		  0xffe00000	   /* host address */
		  0x100000>	   /* length */

	device at 1.1d.0 {
		compatible = "some-device";
		reg = <0x1 0x1d 0x0 0x5000>
	};
};


	Arnd
