From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 19 Dec 2013 09:19:39 +0100
Subject: [PATCH 0/6] net: cpsw: Support for am335x chip MACIDs
In-Reply-To: <52B1D722.3040500@ti.com>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <52B1D4C7.6030004@ti.com> <20131218170818.GR4970@saruman.home>
 <52B1D722.3040500@ti.com>
Message-ID: <20131219081939.GC23493@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 18, 2013 at 10:40:58PM +0530, Mugunthan V N wrote:
> On Wednesday 18 December 2013 10:38 PM, Felipe Balbi wrote:
> > On Wed, Dec 18, 2013 at 10:30:55PM +0530, Mugunthan V N wrote:
> >> On Wednesday 18 December 2013 10:17 PM, Markus Pargmann wrote:
> >>> Hi,
> >>>
> >>> This series introduces a driver to read and use the MACIDs stored in the am335x
> >>> control module. These are read-only registers for a unique MACID. At the moment
> >>> the MACIDs are generated randomly or they are set by the bootloader.
> >>>
> >>> A device node is added in am33xx dtsi and used by the cpsw slaves in the bone
> >>> board files.
> >>>
> >>> Regards,
> >>>
> >>> Markus
> >>>
> >>>
> >>> Markus Pargmann (6):
> >>>   DT doc: net: cpsw mac-address is optional
> >>>   net: cpsw: header, Add missing include
> >>>   net: cpsw: Add control-module macid driver
> >>>   net: cpsw: Use cpsw-ctrl-macid driver
> >>>   arm: dts: am33xx, Add device node for cpsw-ctrl-macid
> >>>   arm: dts: am335x beagle bone use processor macids
> >>>
> >>>  .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  31 +++++
> >>>  Documentation/devicetree/bindings/net/cpsw.txt     |   7 +-
> >>>  arch/arm/boot/dts/am335x-bone.dts                  |   8 ++
> >>>  arch/arm/boot/dts/am335x-boneblack.dts             |   8 ++
> >>>  arch/arm/boot/dts/am33xx.dtsi                      |   7 ++
> >>>  drivers/net/ethernet/ti/Kconfig                    |   8 ++
> >>>  drivers/net/ethernet/ti/Makefile                   |   1 +
> >>>  drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++++++++++
> >>>  drivers/net/ethernet/ti/cpsw.c                     |  18 ++-
> >>>  drivers/net/ethernet/ti/cpsw.h                     |   3 +
> >>>  10 files changed, 224 insertions(+), 5 deletions(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> >>>  create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c
> >>>
> >> Mac ID is to be filled by U-Boot and this kind of approach is already
> >> rejected in linux-omap list.
> >>
> >> If proper ethaddr/eth*addr is populated in U-boot environment variable
> >> then mac-address dt property in ethernet* device nodes will be populated
> >> before boot kernel in U-boot. So I don't think this patch series is
> >> required.
> > but will u-boot read MACID from control module ?
> >
> Yes, U-Boot will read the MACID from control module and if a customer
> wants to have his own MACID, U-boot ENV variable ethaddr/eth1addr must
> be updated.

I think we should not rely on any bootloader to setup the macids
correctly.

U-Boot is not the only bootloader. There are others which may not
support cpsw or don't support devicetree or don't load the cpsw driver
automatically when no ethernet connection is used. Most installed
bootloaders use their local storage to load the kernel, so how can we be
certain that the bootloader added the correct MACIDs to the devicetree?
Why can't the kernel be bootloader independent?


A cpsw slave defined in am33xx.dtsi:

cpsw_emac0: slave at 4a100200 {
	/* Filled in by U-Boot */
	mac-address = [ 00 00 00 00 00 00 ];
};

This is not a proper hardware description, only a clear statement that
the kernel depends on U-Boot or any other bootloader that does always
set the mac-address the same way U-Boot does. But that DT is not usable
in anything else than Linux and U-Boot.

The TI reference manual clearly lists the MACID registers in the control
module so we can use that to describe the source of the MACIDs in DT,
independent of U-Boot. Any bootloader can use such a devictree and parse
the correct location in the control module.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
