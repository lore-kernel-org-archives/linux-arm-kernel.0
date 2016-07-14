From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 14 Jul 2016 16:47:42 -0400
Subject: [PATCH v18 6/6] ARM: socfpga: fpga bridge driver support
In-Reply-To: <20160712193645.9098-7-atull@opensource.altera.com>
References: <20160712193645.9098-1-atull@opensource.altera.com>
 <20160712193645.9098-7-atull@opensource.altera.com>
Message-ID: <CAP=VYLo2jtp57kQe5671xM=4o_ZAU6XG_W1MXU8aPv4Ws7kkDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 3:36 PM, Alan Tull <atull@opensource.altera.com> wrote:
> Supports Altera SOCFPGA bridges:
>  * fpga2sdram
>  * fpga2hps
>  * hps2fpga
>  * lwhps2fpga
>
> Allows enabling/disabling the bridges through the FPGA
> Bridge Framework API functions.
>
> The fpga2sdram driver only supports enabling and disabling
> of the ports that been configured early on.  This is due to
> a hardware limitation where the read, write, and command
> ports on the fpga2sdram bridge can only be reconfigured
> while there are no transactions to the sdram, i.e. when
> running out of OCRAM before the kernel boots.
>
> Device tree property 'init-val' configures the driver to
> enable or disable the bridge during probe.  If the property
> does not exist, the driver will leave the bridge in its
> current state.
>
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> Signed-off-by: Matthew Gerlach <mgerlach@altera.com>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
> v2:  Use resets instead of directly writing reset registers
> v12: Bump version to align with simple-fpga-bus version
>      Get rid of the sysfs interface
>      fpga2sdram: get configuration stored in handoff register
> v13: Remove unneeded WARN_ON
>      Change property from init-val to bridge-enable
>      Checkpatch cleanup
>      Fix email address
> v14: use module_platform_driver
>      remove unused struct field and some #defines
>      don't really need exclamation points on error msgs
>      *const* struct fpga_bridge_ops
> v15: No change in this patch for v15 of this patch set
> v16: No change in this patch for v16 of this patch set
> v17: No change to this patch for v17 of this patch set
> v18: Eliminate need to specify reset names since only one reset
> ---
>  drivers/fpga/Kconfig             |   7 ++
>  drivers/fpga/Makefile            |   1 +
>  drivers/fpga/altera-fpga2sdram.c | 174 ++++++++++++++++++++++++++++++++
>  drivers/fpga/altera-hps2fpga.c   | 213 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 395 insertions(+)
>  create mode 100644 drivers/fpga/altera-fpga2sdram.c
>  create mode 100644 drivers/fpga/altera-hps2fpga.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index ec81e21..b346166 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -39,6 +39,13 @@ config FPGA_BRIDGE
>           Say Y here if you want to support bridges connected between host
>          processors and FPGAs or between FPGAs.
>
> +config SOCFPGA_FPGA_BRIDGE
> +       bool "Altera SoCFPGA FPGA Bridges"
> +       depends on ARCH_SOCFPGA && FPGA_BRIDGE
> +       help
> +         Say Y to enable drivers for FPGA bridges for Altera SOCFPGA
> +         devices.
> +
>  endif # FPGA
>
>  endmenu
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 8d746c3..e658436 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)      += zynq-fpga.o
>
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)              += fpga-bridge.o
> +obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)      += altera-hps2fpga.o altera-fpga2sdram.o
>
>  # High Level Interfaces
>  obj-$(CONFIG_FPGA_REGION)              += fpga-region.o
> diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
> new file mode 100644
> index 0000000..91f4a40
> --- /dev/null
> +++ b/drivers/fpga/altera-fpga2sdram.c
> @@ -0,0 +1,174 @@
> +/*
> + * FPGA to SDRAM Bridge Driver for Altera SoCFPGA Devices
> + *
> + *  Copyright (C) 2013-2015 Altera Corporation, All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * This driver manages a bridge between an FPGA and the SDRAM used by the ARM
> + * host processor system (HPS).
> + *
> + * The bridge contains 4 read ports, 4 write ports, and 6 command ports.
> + * Reconfiguring these ports requires that no SDRAM transactions occur during
> + * reconfiguration.  The code reconfiguring the ports cannot run out of SDRAM
> + * nor can the FPGA access the SDRAM during reconfiguration.  This driver does
> + * not support reconfiguring the ports.  The ports are configured by code
> + * running out of on chip ram before Linux is started and the configuration
> + * is passed in a handoff register in the system manager.
> + *
> + * This driver supports enabling and disabling of the configured ports, which
> + * allows for safe reprogramming of the FPGA, assuming that the new FPGA image
> + * uses the same port configuration.  Bridges must be disabled before
> + * reprogramming the FPGA and re-enabled after the FPGA has been programmed.
> + */
> +
> +#include <linux/fpga/fpga-bridge.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h

Please don't use module.h in drivers controlled by a bool
Kconfig setting.

THanks,
Paul.
