From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 4 Aug 2012 18:27:30 +0200
Subject: arm: mvebu: Add basic address decoding support for Marvell 370/XP
In-Reply-To: <201208031423.10561.arnd@arndb.de>
References: <1343999430-31816-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201208031423.10561.arnd@arndb.de>
Message-ID: <20120804182730.1ef77f23@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Fri, 3 Aug 2012 14:23:09 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> On Friday 03 August 2012, Thomas Petazzoni wrote:
> > Here is a small patch set that introduces basic support for address
> > decoding on Armada 370 and Armada XP. The aim of this basic support
> > is essentially to be able to configure a window to remap the
> > BootROM, which is needed to startup the secondary CPUs for the SMP
> > support.
> > 
> > As we had discussed already, the address decoding configuration is
> > not described in the Device Tree, it is for now hardcoded on a
> > per-SoC basis. We might later discuss how to extend this to the
> > Device Tree.
> 
> Makes sense. I wonder if there is a proper way to describe the
> setting in the device tree anyway, given that there is more than one
> valid option to do it.

Well, we could do something like:

addr-decoding at d0020000 {
        compatible = "marvell,armada-addr-decoding-controller";
        reg = <0xd0020000 0x258>;

        window at 0 {
		/* Window number */
		cell-index = <0>;                             

		/* Physical address and size at which the device will be mapped. */
		reg = <0xfff00000 0x100000>;

		/* Which device is being mapped. Can either have 1
		   integer (for "big" devices) or 2 integers (for devices
		   in the "Device Bus") */
                marvell,target = <0x1 0x1d>;

		/* Optional. Remapping address */
		marvell,remap = <...>;
	};

	window at 12 {
		cell-index = <12>;
		reg = <0x... 0x....>;
		marvell,target = <0x4>;
	};
};

This is just a rough draft, just written in the mail, I haven't even
tried writing code that would work with it, but it should be relatively
easy to do.

Would that make sense? Of course, suggestions welcome, I'm not an
expert on how to decide what is the best DT encoding for such data.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
