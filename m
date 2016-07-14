From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 14 Jul 2016 16:54:13 -0400
Subject: [PATCH v18 4/6] fpga: add fpga bridge framework
In-Reply-To: <20160712193645.9098-5-atull@opensource.altera.com>
References: <20160712193645.9098-1-atull@opensource.altera.com>
 <20160712193645.9098-5-atull@opensource.altera.com>
Message-ID: <CAP=VYLpxK7qt25pmC2byYRm1zVbVrkf2f1+xctoSTSAy+n9QdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 3:36 PM, Alan Tull <atull@opensource.altera.com> wrote:
> This framework adds API functions for enabling/
> disabling FPGA bridges under kernel control.
>
> This allows the Linux kernel to disable FPGA bridges
> during FPGA reprogramming and to enable FPGA bridges
> when FPGA reprogramming is done.  This framework is
> be manufacturer-agnostic, allowing it to be used in
> interfaces that use the FPGA Manager Framework to
> reprogram FPGA's.
>
> The functions are:
> * of_fpga_bridge_get
> * fpga_bridge_put
>    Get/put an exclusive reference to a FPGA bridge.
>
> * fpga_bridge_enable
> * fpga_bridge_disable
>    Enable/Disable traffic through a bridge.
>
> * fpga_bridge_register
> * fpga_bridge_unregister
>    Register/unregister a device-specific low level FPGA
>    Bridge driver.
>
> Get an exclusive reference to a bridge and add it to a list:
> * fpga_bridge_get_to_list
>
> To enable/disable/put a set of bridges that are on a list:
> * fpga_bridges_enable
> * fpga_bridges_disable
> * fpga_bridges_put
>
> Signed-off-by: Alan Tull <atull@opensource.altera.com>
> ---
> v2:  Minor cleanup
> v12: Bump version to line up with simple fpga bus
>      Remove sysfs
>      Improve get/put functions, get the low level driver too.
>      Clean up class implementation
>      Add kernel doc documentation
>      Rename (un)register_fpga_bridge -> fpga_bridge_(un)register
> v13: Add inlined empty functions for if not CONFIG_FPGA_BRIDGE
>      Clean up debugging
>      Remove unneeded #include in .h
>      Remove unnecessary prints
>      Remove 'label' DT binding.
>      Document the mutex
> v14: Allow bridges with no ops
>      *const* struct fpga_bridge_ops
>      Add functions to git/put/enable/disable list of bridges
>      Add list node to struct fpga_bridge
>      Do of_node_get/put in of_fpga_bridge_get()
>      Add r/o attributes: name and state
> v15: No change in this patch for v15 of this patch set
> v16: Remove of_get_fpga_bus function
> v17: No change to this patch in v17 of patch set
> v18: No change to this patch in v18 of patch set
> ---
>  drivers/fpga/Kconfig             |   7 +
>  drivers/fpga/Makefile            |   3 +
>  drivers/fpga/fpga-bridge.c       | 388 +++++++++++++++++++++++++++++++++++++++
>  include/linux/fpga/fpga-bridge.h |  55 ++++++
>  4 files changed, 453 insertions(+)
>  create mode 100644 drivers/fpga/fpga-bridge.c
>  create mode 100644 include/linux/fpga/fpga-bridge.h
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index d614102..46e20af 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -25,6 +25,13 @@ config FPGA_MGR_ZYNQ_FPGA
>         help
>           FPGA manager driver support for Xilinx Zynq FPGAs.
>
> +config FPGA_BRIDGE
> +       bool "FPGA Bridge Framework"

Same here. A bool Kconfig but module.h etc. used in the driver.

Either make the code modular with a tristate if there is a valid
use case for that, or get rid of the modular references.

Thanks,
Paul.
--
