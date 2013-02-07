From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Feb 2013 09:45:56 +0100
Subject: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
In-Reply-To: <201302070804.12256.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302062241.14444.arnd@arndb.de> <20130207000715.0b3d662d@skate>
 <201302070804.12256.arnd@arndb.de>
Message-ID: <20130207094556.423de279@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 7 Feb 2013 08:04:12 +0000, Arnd Bergmann wrote:
> 	address-map {
> 		/* this device translates 64 bit MMIO bus addresses into 32 bit CPU addresses */
> 		compatible = "marvell,armada-addr-decoding-controller";
> 		reg = <0xd0020000 0x258>;
> 		#addres-cells = <2>;
> 		#address-cells = <1>;
> 
> 		/* each remapped window has one entry here */
> 		ranges = <0xa 0 0xc0000000 0x10000>,     /* map window a to 0xc0000000 */
> 		         <0xb 0 0xc1000000 0x08000000>,  /* map window b to 0xc1000000 */
> 			 <...>; /* more windows */
> 
> 		pciex {
> 			#addres-cells = <3>;
> 			#size-cells = <2>;
> 			ranges = <0x81000000 0 0 0xa 0 0 0x00010000,  /* I/O is window a */
> 				  0x82000000 0 0 0xb 0 0 0x08000000>; /* non-prefetchable memory */
> 			...
> 		};
> 
> 
> 		something-else {
> 			...
> 			reg = <0xc 0 0x10000>; /* window c */
> 		};
> 	};
> };

Unfortunately, this means the windows are statically defined in the DT,
which is simply not possible for PCIe, as we have already explained
several times in this thread.

Any solution where the PCIe windows are statically described is
simply /not/ acceptable.

We have 10 PCIe interfaces, each requiring up to two windows, and we
have on the system a *total* of 20 windows. Doing static assignments of
windows is simply not an option.

Of course, you'll tell me that it's up to each board .dts to have a
number of windows that matches the number of actually existing PCIe
interface. But it means that each and every developer adding the
support for a new board must understand this complex problem, which is
something we do not want. We have a solution that makes all of this
PCIe window assignment dynamic, so it surprises me that we have to
continue to explain why a static solution is not appropriate.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
