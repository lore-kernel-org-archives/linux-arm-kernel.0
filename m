From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 9 Jul 2016 19:45:07 -0400
Subject: [PATCH V2 04/10] firmware: tegra: add IVC library
In-Reply-To: <20160705090431.5852-5-josephl@nvidia.com>
References: <20160705090431.5852-1-josephl@nvidia.com>
 <20160705090431.5852-5-josephl@nvidia.com>
Message-ID: <CAP=VYLoX5CkXGFrXtMFYYuJUs_+_9zzzus1o+_7twvf4rkU_Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2016 at 5:04 AM, Joseph Lo <josephl@nvidia.com> wrote:
> The Inter-VM communication (IVC) is a communication protocol, which is
> designed for interprocessor communication (IPC) or the communication
> between the hypervisor and the virtual machine with a guest OS on it. So
> it can be translated as inter-virtual memory or inter-virtual machine
> communication. The message channels are maintained on the DRAM or SRAM
> and the data coherency should be considered. Or the data could be
> corrupted or out of date when the remote client checking it.
>
> Inside the IVC, it maintains memory-based descriptors for the TX/RX
> channels and the coherency issue of the counter and payloads. So the
> clients can use it to send/receive messages to/from remote ones.
>
> We introduce it as a library for the firmware drivers, which can use it
> for IPC.
>
> Based-on-the-work-by:
> Peter Newman <pnewman@nvidia.com>
>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> Changes in V2:
> - None
> ---
>  drivers/firmware/Kconfig        |   1 +
>  drivers/firmware/Makefile       |   1 +
>  drivers/firmware/tegra/Kconfig  |  13 +
>  drivers/firmware/tegra/Makefile |   1 +
>  drivers/firmware/tegra/ivc.c    | 659 ++++++++++++++++++++++++++++++++++++++++
>  include/soc/tegra/ivc.h         | 102 +++++++
>  6 files changed, 777 insertions(+)
>  create mode 100644 drivers/firmware/tegra/Kconfig
>  create mode 100644 drivers/firmware/tegra/Makefile
>  create mode 100644 drivers/firmware/tegra/ivc.c
>  create mode 100644 include/soc/tegra/ivc.h
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 5e618058defe..bbd64ae8c4c6 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -200,5 +200,6 @@ config HAVE_ARM_SMCCC
>  source "drivers/firmware/broadcom/Kconfig"
>  source "drivers/firmware/google/Kconfig"
>  source "drivers/firmware/efi/Kconfig"
> +source "drivers/firmware/tegra/Kconfig"
>
>  endmenu
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 474bada56fcd..9a4df8171cc4 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -24,3 +24,4 @@ obj-y                         += broadcom/
>  obj-$(CONFIG_GOOGLE_FIRMWARE)  += google/
>  obj-$(CONFIG_EFI)              += efi/
>  obj-$(CONFIG_UEFI_CPER)                += efi/
> +obj-y                          += tegra/
> diff --git a/drivers/firmware/tegra/Kconfig b/drivers/firmware/tegra/Kconfig
> new file mode 100644
> index 000000000000..1fa3e4e136a5
> --- /dev/null
> +++ b/drivers/firmware/tegra/Kconfig
> @@ -0,0 +1,13 @@
> +menu "Tegra firmware driver"
> +
> +config TEGRA_IVC
> +       bool "Tegra IVC protocol"

If this driver is not tristate, then why does the driver include the
module.h header below?

> +       depends on ARCH_TEGRA
> +       help
> +         IVC (Inter-VM Communication) protocol is part of the IPC
> +         (Inter Processor Communication) framework on Tegra. It maintains the
> +         data and the different commuication channels in SysRAM or RAM and
> +         keeps the content is synchronization between host CPU and remote
> +         processors.
> +
> +endmenu
> diff --git a/drivers/firmware/tegra/Makefile b/drivers/firmware/tegra/Makefile
> new file mode 100644
> index 000000000000..92e2153e8173
> --- /dev/null
> +++ b/drivers/firmware/tegra/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_TEGRA_IVC)                += ivc.o
> diff --git a/drivers/firmware/tegra/ivc.c b/drivers/firmware/tegra/ivc.c
> new file mode 100644
> index 000000000000..3e736bb9915a
> --- /dev/null
> +++ b/drivers/firmware/tegra/ivc.c
> @@ -0,0 +1,659 @@
> +/*
> + * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I'm sure it "works" since module.h includes nearly everything else,
but that is less than ideal for exactly the same reason.

Thanks,
Paul.
--

> +
> +#include <soc/tegra/ivc.h>
> +
> +#define IVC_ALIGN 64
> +
