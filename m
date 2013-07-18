From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 18 Jul 2013 11:05:51 -0300
Subject: [PATCH] ARM: Kirkwood: Fix the internal register ranges
 translation
In-Reply-To: <51E59639.3000207@keymile.com>
References: <1371569479-31498-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <51E5145A.90404@keymile.com> <20130716125531.GD2317@localhost>
 <51E59639.3000207@keymile.com>
Message-ID: <20130718140550.GA3364@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gerlando,

On Tue, Jul 16, 2013 at 08:51:37PM +0200, Gerlando Falauto wrote:
[...]
> >
> > Also, speaking of "device bus" this nand node should be behind a devicebus node.
> >
> > 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000   /* internal-regs */
> > 			  MBUS_ID(0x01, 0x2f) 0 0 0xf4000000 0x400>;
> >
> > 		devbus {
> > 			status = "okay";
> > 			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0x400>;
> >
> > 			/* nand */
> > 			nand {
> > 				compatible = "marvell,orion-nand";
> > 				reg = <0 0x400>;
> > 			};
> > 		};
> 
> I believe that makes a lot more sense this way... I guess this feature 
> (device bus) requires your latest set of patches, right? (either v7 as 
> you posted yesterday or your tree at 
> git://github.com/MISL-EBU-System-SW/mainline-public.git/marvell-mvebu-mbus-v7)
> 

No, not really. The device-bus driver is already merged, so we only need
to use it, and maybe extend it a bit to support kirkwood (in case it's
needed). You can see in:

  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts

for an example.

I would prefer that to be done *after* the MBus is accepted...
but that's just a personal preference.

> > (notice this will allow you to relocate the base address of the NAND windows
> > easily if it conflicts with your PCIe needs).
> 
> I sort of had the impression I could do already do that somehow, though 
> I am not quite sure anymore...
> 

Well, you can do it by patching and re-building the kernel as the
MBus windows are created from C-files.

With the MBus DT binding, all you need is to change the DT.

> >> avoid a later incosistency between the "unit-address" and the first
> >> "reg" address:
> >>
> >>>    		#address-cells = <1>;
> >>>    		#size-cells = <1>;
> >>> @@ -171,7 +172,7 @@
> >>   >   		nand at 3000000 {
> >> 		     ^^^^^^^
> >
> > Oh, this should be fixed. I just missed it, and nobody noticed either.
> >
> 
> So, in the end, you think it's OK to have a set of nodes with "relative" 
> addresses (gpio at 10140, serial at 12000 etc...) and some with "absolute" 
> addresses (nand at 0xf4000000, where the ranges property does a 0-offset 
> translation)?
> Even though I understand this is just some transitional state, and it 
> will all be fixed like your example above, once we get the rest of the 
> rework merged (mbus/devbus).

Mmm.. I see your point. In the end, it's just as you say, the current state
is only transitional. There's no way to have a proper DT without the MBus DT
binding.

The reason for this mess is that the current layout mixes the actual
address space. Feel free to take a look at the latest MBus series and
try to add MBus DT binding for Kirkwood.

If you do, don't hesitate in asking as many questions as you need and/or
posting RFCs for us to look at.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
