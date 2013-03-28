From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 15:08:54 -0400
Subject: [PATCH v3 1/7] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <1363885160-6870-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1363885160-6870-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1363885160-6870-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130328190854.GD13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:59:14PM +0100, Thomas Petazzoni wrote:
> The Marvell EBU SoCs have a configurable physical address space
> layout: the physical ranges of memory used to address PCI(e)
> interfaces, NOR flashes, SRAM and various other types of memory are
> configurable by software, through a mechanism of so-called 'address
> decoding windows'.
> 
> This new driver mvebu-mbus consolidates the existing code to address
> the configuration of these memory ranges, which is spread into
> mach-mvebu, mach-orion5x, mach-mv78xx0, mach-dove and mach-kirkwood.
> 
> Following patches convert each Marvell EBU SoC family to use this
> driver, therefore removing the old code that was configuring the
> address decoding windows.
> 
> It is worth mentioning that the MVEBU_MBUS Kconfig option is
> intentionally added as a blind option. The new driver implements and
> exports the mv_mbus_dram_info() function, which is used by various
> Marvell drivers throughout the tree to get access to window
> configuration parameters that they require. This function is also
> implemented in arch/arm/plat-orion/addr-map.c, which ultimately gets
> removed at the end of this patch series. So, in order to preserve
> bisectability, we want to ensure that *either* this new driver, *or*
> the legacy code in plat-orion/addr-map.c gets compiled in.
> 
> By making MVEBU_MBUS a blind option, we are sure that only a platform
> that does 'select MVEBU_MBUS' will get this new driver compiled
> in. Therefore, throughout the next patches that convert the Marvell
> sub-architectures one after the other to this new driver, we add the
> 'select MVEBU_MBUS' and also ensure to remove plat-orion/addr-map.c
> from the build for this specific sub-architecture. This ensures that
> bisectability is preserved.
> 
> Ealier versions of this driver had a DT binding, but since those were
> not yet agreed upon, they were removed. The driver still uses
> of_device_id to find the SoC specific details according to the string
> passed to mvebu_mbus_init(). The plan is to re-introduce a proper DT
> binding as a followup set of patches.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/bus/Kconfig      |    7 +
>  drivers/bus/Makefile     |    1 +
>  drivers/bus/mvebu-mbus.c |  867 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mbus.h     |   24 +-
>  4 files changed, 898 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/bus/mvebu-mbus.c

Applied to mvebu/drivers as there is no drivers/bus maintainer

thx,

Jason.
