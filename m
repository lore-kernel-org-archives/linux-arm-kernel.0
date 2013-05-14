From: javi.merino@arm.com (Javi Merino)
Date: Tue, 14 May 2013 14:00:07 +0100
Subject: [RFC PATCH v3] drivers: bus: add ARM CCI support
In-Reply-To: <1368095640-3675-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1368095640-3675-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368095640-3675-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130514130005.GD29592@e102654-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 11:34:00AM +0100, Lorenzo Pieralisi wrote:
> On ARM multi-cluster systems coherency between cores running on
> different clusters is managed by the cache-coherent interconnect (CCI).
> It allows broadcasting of TLB invalidates and memory barriers and it
> guarantees cache coherency at system level through snooping of slave
> interfaces connected to it.
> 
> This patch enables the basic infrastructure required in Linux to handle and
> programme the CCI component.
> 
> Non-local variables used by the CCI management functions called by power
> down function calls after disabling the cache must be flushed out to main
> memory in advance, otherwise incoherency of those values may occur if they
> are sitting in the cache of some other CPU when power down functions
> execute. Driver code ensures that relevant data structures are flushed
> from inner and outer caches after the driver probe is completed.
> 
> CCI slave port resources are linked to set of CPUs through bus masters
> phandle properties that link the interface resources to masters node in
> the device tree.
> 
> Documentation describing the CCI DT bindings is provided with the patch.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cci.txt | 161 ++++++++++
>  drivers/bus/Kconfig                           |   7 +
>  drivers/bus/Makefile                          |   2 +
>  drivers/bus/arm-cci.c                         | 420 ++++++++++++++++++++++++++
>  include/linux/arm-cci.h                       |  61 ++++
>  5 files changed, 651 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cci.txt
>  create mode 100644 drivers/bus/arm-cci.c
>  create mode 100644 include/linux/arm-cci.h
> 

[...]

> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> new file mode 100644
> index 0000000..000102f
> --- /dev/null
> +++ b/drivers/bus/arm-cci.c
> @@ -0,0 +1,420 @@
> +/*
> + * CCI cache coherent interconnect driver
> + *
> + * Copyright (C) 2013 ARM Ltd.
> + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/arm-cci.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/smp_plat.h>
> +
> +#define DRIVER_NAME            "CCI"
> +
> +#define CCI_PORT_CTRL          0x0
> +#define CCI_CTRL_STATUS                0xc
> +
> +#define CCI_ENABLE_SNOOP_REQ   0x1
> +#define CCI_ENABLE_DVM_REQ     0x2
> +#define CCI_ENABLE_REQ         (CCI_ENABLE_SNOOP_REQ | CCI_ENABLE_DVM_REQ)
> +
> +struct cci_nb_ports {
> +       unsigned int nb_ace;
> +       unsigned int nb_ace_lite;
> +};
> +
> +enum cci_ace_port_type {
> +       ACE_INVALID_PORT = 0x0,
> +       ACE_PORT,
> +       ACE_LITE_PORT,
> +};
> +
> +struct cci_ace_port {
> +       void __iomem *base;
> +       enum cci_ace_port_type type;
> +       struct device_node *dn;
> +};
> +
> +static struct cci_ace_port *ports;
> +static unsigned int nb_cci_ports;
> +
> +static void __iomem *cci_ctrl_base;
> +
> +struct cpu_port {
> +       u64 mpidr;
> +       u32 port;
> +};
> +/*
> + * Use the port MSB as valid flag, shift can be made dynamic
> + * by computing number of bits required for port indexes.
> + * Code disabling CCI cpu ports runs with D-cache invalidated
> + * and SCTLR bit clear so data accesses must be kept to a minimum
> + * to improve performance; for now shift is left static to
> + * avoid one more data access while disabling the CCI port.
> + */
> +#define PORT_VALID_SHIFT       31
> +#define PORT_VALID             (0x1 << PORT_VALID_SHIFT)
> +
> +static inline void init_cpu_port(struct cpu_port *port, u32 index, u32 mpidr)

The mpidr should be u64.

> +{
> +       port->port = PORT_VALID | index;
> +       port->mpidr = mpidr;
> +}
> +
> +static inline bool cpu_port_is_valid(struct cpu_port *port)
> +{
> +       return !!(port->port & PORT_VALID);
> +}
> +
> +static inline bool cpu_port_match(struct cpu_port *port, u32 mpidr)

Same here.

> +{
> +       return port->mpidr == (mpidr & MPIDR_HWID_BITMASK);
> +}
> +

Cheers,
Javi
