From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 2 Aug 2017 16:24:19 +0200
Subject: [patch v1 1/2] drivers: jtag: Add JTAG core driver
In-Reply-To: <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <f5777e30-58d6-5864-294c-35b9c9cb7f8f@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2017 03:18 PM, Oleksandr Shamray wrote:
> JTAG class driver provide infrastructure to support hardware/software
> JTAG platform drivers. It provide user layer API interface for flashing
> and debugging external devices which equipped with JTAG interface
> using standard transactions.
> 
> Driver exposes set of IOCTL to user space for:
> - XFER:
> - SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
> - SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> - RUNTEST (Forces the IEEE 1149.1 bus to a run state for a specified
>   number of clocks).
> - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
> 
> Driver core provides set of internal APIs for allocation and
> registration:
> - jtag_register;
> - jtag_unregister;
> - jtag_alloc;
> - jtag_free;
> 
> Platform driver on registration with jtag-core creates the next
> entry in dev folder:
> /dev/jtagX
> 
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> ---
>  Documentation/ioctl/ioctl-number.txt |    2 +
>  MAINTAINERS                          |    8 +
>  drivers/Kconfig                      |    2 +
>  drivers/Makefile                     |    1 +
>  drivers/jtag/Kconfig                 |   18 ++
>  drivers/jtag/Makefile                |    2 +
>  drivers/jtag/jtag.c                  |  347 ++++++++++++++++++++++++++++++++++
>  include/linux/jtag.h                 |   63 ++++++
>  include/uapi/linux/jtag.h            |  133 +++++++++++++
>  9 files changed, 576 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/jtag/Kconfig
>  create mode 100644 drivers/jtag/Makefile
>  create mode 100644 drivers/jtag/jtag.c
>  create mode 100644 include/linux/jtag.h
>  create mode 100644 include/uapi/linux/jtag.h
> 
> diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
> index 3e3fdae..1af2508 100644
> --- a/Documentation/ioctl/ioctl-number.txt
> +++ b/Documentation/ioctl/ioctl-number.txt
> @@ -321,6 +321,8 @@ Code  Seq#(hex)	Include File		Comments
>  0xB0	all	RATIO devices		in development:
>  					<mailto:vgo@ratio.de>
>  0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
> +0xB2	00-0f	linux/jtag.h		JTAG driver
> +					<mailto:oleksandrs@mellanox.com>
>  0xB3	00	linux/mmc/ioctl.h
>  0xB4	00-0F	linux/gpio.h		<mailto:linux-gpio@vger.kernel.org>
>  0xB5	00-0F	uapi/linux/rpmsg.h	<mailto:linux-remoteproc@vger.kernel.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 205d397..141aeaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7292,6 +7292,14 @@ L:	linux-serial at vger.kernel.org
>  S:	Maintained
>  F:	drivers/tty/serial/jsm/
>  
> +JTAG SUBSYSTEM
> +M:	Oleksandr Shamray <oleksandrs@mellanox.com>
> +M:	Vadim Pasternak <vadimp@mellanox.com>
> +S:	Maintained
> +F:	include/linux/jtag.h
> +F:	include/uapi/linux/jtag.h
> +F:	drivers/jtag/
> +
>  K10TEMP HARDWARE MONITORING DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	linux-hwmon at vger.kernel.org
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 505c676..2214678 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -208,4 +208,6 @@ source "drivers/tee/Kconfig"
>  
>  source "drivers/mux/Kconfig"
>  
> +source "drivers/jtag/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index dfdcda0..6a2059b 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -182,3 +182,4 @@ obj-$(CONFIG_FPGA)		+= fpga/
>  obj-$(CONFIG_FSI)		+= fsi/
>  obj-$(CONFIG_TEE)		+= tee/
>  obj-$(CONFIG_MULTIPLEXER)	+= mux/
> +obj-$(CONFIG_JTAG)		+= jtag/
> diff --git a/drivers/jtag/Kconfig b/drivers/jtag/Kconfig
> new file mode 100644
> index 0000000..a8d0149
> --- /dev/null
> +++ b/drivers/jtag/Kconfig
> @@ -0,0 +1,18 @@
> +menuconfig JTAG
> +	tristate "JTAG support"
> +	default n
> +	---help---
> +	  This provides basic core functionality support for jtag class devices
> +	  Hardware equipped with JTAG microcontroller which can be built
> +	  on top of this drivers. Driver exposes the set of IOCTL to the
> +	  user space for:
> +	  SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
> +	  SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> +	  RUNTEST (Forces IEEE 1149.1 bus to a run state for specified
> +	  number of clocks).
> +
> +	  If you want this support, you should say Y here.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called jtag.
> +
> diff --git a/drivers/jtag/Makefile b/drivers/jtag/Makefile
> new file mode 100644
> index 0000000..e811330
> --- /dev/null
> +++ b/drivers/jtag/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_JTAG)		+= jtag.o
> +
> diff --git a/drivers/jtag/jtag.c b/drivers/jtag/jtag.c
> new file mode 100644
> index 0000000..a933bc1
> --- /dev/null
> +++ b/drivers/jtag/jtag.c
> @@ -0,0 +1,347 @@
> +/*
> + * Copyright (c) 2017 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2017 Oleksandr Shamray <oleksandrs@mellanox.com>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the names of the copyright holders nor the names of its
> + *    contributors may be used to endorse or promote products derived from
> + *    this software without specific prior written permission.
> + *
> + * Alternatively, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") version 2 as published by the Free
> + * Software Foundation.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + */

Maybe using SPDX-License-Identifier could save us from hundred of useless lines !

Neil
