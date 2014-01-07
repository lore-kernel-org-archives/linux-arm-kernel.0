From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 Jan 2014 17:22:58 +0100
Subject: [PATCH v5 3/4] ARM: BCM5301X: add dts files for BCM4708 SoC
In-Reply-To: <52CB1D6C.9040303@hauke-m.de>
References: <1388965601-18329-1-git-send-email-hauke@hauke-m.de>
 <20140106020023.52f28c76@skate> <52CB1D6C.9040303@hauke-m.de>
Message-ID: <201401071722.58395.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 January 2014, Hauke Mehrtens wrote:
> On 01/06/2014 02:00 AM, Thomas Petazzoni wrote:

> > I don't know if that has been discussed before, but most of the DTS
> > group the internal SoC peripherals in some top-level node that
> > represents the internal bus (or busses) of the SoC, like:
> > 
> > 	<some bus name> {
> > 		uart at ... {
> > 			...
> > 		};
> > 
> > 		gic at ... {
> > 			...
> > 		};
> > 	};
> > 
> > This allows to have the in-SoC peripherals cleanly separated from other
> > things in the DTS. It would also you to use a ranges = <...> property
> > to do an address translation on this bus, and replace the absolute
> > addresses for each of the peripherals by offsets relative to the base
> > address of where all peripherals are mapped.
> > 
> > That said, having this top-level node is most likely not a requirement,
> > so my comment is mainly meant to open the discussion. I'm sure Arnd
> > will give his opinion on this :)
> > 
> 
> I spited it up like it was done for the rockchip SoCs.
> One dtsi file for a line of SoCs, one for the specific SoC and one for
> the device. How does this ranges stuff work, do you have an example for me?

kirkwood.dtsi has some good examples. For instance there is a UART at
0xf1012000, which gets described as a device at local address 0x12000,
and a parent bus that translates the global 1MB range at 0xf1000000 to
local address range 0x00000000. The organization of the buses should
match the physical layout of the chip as described in the data sheet.

Note that in case of kirkwood, the 1MB register range is actually
relocatable and the devices are described using offsets in the data
sheet. On other SoCs the internal bus still uses a full 32-bit
address. It still makes sense to split up the device nodes by buses
then, but the you may want a ranges property like 

	ranges = <0x190000000 0x19000000 0x01000000>;

rather than 

	ranges = <0 0x19000000 0x01000000>;

in that case, so the addresses in the device nodes still match
the numbers from the data sheet. You can also have an empty "ranges"
property that just states that all addresses are available on the
bus, if that is what the hardware does.

	Arnd
