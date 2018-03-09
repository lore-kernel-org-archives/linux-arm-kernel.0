From: eric@anholt.net (Eric Anholt)
Date: Fri, 09 Mar 2018 13:06:55 -0800
Subject: [PATCH RFC 2/3] nvmem: add driver for Raspberry Pi OTP
In-Reply-To: <1520602328-28972-3-git-send-email-stefan.wahren@i2se.com>
References: <1520602328-28972-1-git-send-email-stefan.wahren@i2se.com>
 <1520602328-28972-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87tvtpgdqo.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This patch brings read-only support for the Raspberry Pi Customer OTP.
> The driver accesses the OTP via the mailbox property interface
> provided by the VPU firmware.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/nvmem/Kconfig           |  10 +++
>  drivers/nvmem/Makefile          |   2 +
>  drivers/nvmem/raspberrypi-otp.c | 138 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/nvmem/raspberrypi-otp.c
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index ff505af..76b8af3 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -175,4 +175,14 @@ config NVMEM_SNVS_LPGPR
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem-snvs-lpgpr.
>  
> +config NVMEM_RASPBERRYPI_OTP
> +	tristate "Raspberry Pi Customer OTP support"
> +	depends on (ARCH_BCM2835 && RASPBERRYPI_FIRMWARE) || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)
> +	depends on RASPBERRYPI_FIRMWARE
> +	help
> +	  This is a driver for access to the Customer OTP on the Raspberry Pi.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-raspberrypi-otp.
> +
>  endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index e54dcfa..3b53b0b 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -37,3 +37,5 @@ obj-$(CONFIG_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
>  nvmem_meson_mx_efuse-y		:= meson-mx-efuse.o
>  obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
>  nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
> +obj-$(CONFIG_NVMEM_RASPBERRYPI_OTP)	+= nvmem-raspberrypi-otp.o
> +nvmem-raspberrypi-otp-y		:= raspberrypi-otp.o
> diff --git a/drivers/nvmem/raspberrypi-otp.c b/drivers/nvmem/raspberrypi-otp.c
> new file mode 100644
> index 0000000..e925435
> --- /dev/null
> +++ b/drivers/nvmem/raspberrypi-otp.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Raspberry Pi Customer OTP driver
> + *
> + * Copyright (C) 2018 Stefan Wahren <stefan.wahren@i2se.com>
> + */
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define CUSTOMER_CELLS 8
> +
> +struct rpi_otp {
> +	struct nvmem_device *nvmem;
> +	struct rpi_firmware *fw;
> +};
> +
> +/*
> + * Packet definition used by RPI_FIRMWARE_GET_CUSTOMER_OTP
> + */
> +struct rpi_customer_otp_packet {
> +	u32 index;
> +	u32 length;
> +	u32 cells[CUSTOMER_CELLS];
> +};
> +
> +static int rpi_otp_read(void *context, unsigned int offset, void *val,
> +			size_t bytes)
> +{
> +	struct rpi_customer_otp_packet packet;
> +	struct rpi_otp *otp = context;
> +	u32 *buf = val;
> +	int ret;
> +
> +	packet.index = 0;
> +	packet.length = CUSTOMER_CELLS;
> +	memset(packet.cells, 0xff, sizeof(packet.cells));
> +
> +	ret = rpi_firmware_property(otp->fw, RPI_FIRMWARE_GET_CUSTOMER_OTP,
> +				    &packet, sizeof(packet));
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Request rejected by firmware */
> +	if (packet.index)
> +		return -EIO;
> +
> +	while (bytes) {
> +		if ((offset / 4) < sizeof(packet.cells))
> +			*buf = packet.cells[offset / 4];
> +		else
> +			*buf = 0;
> +
> +		buf++;
> +		bytes -= 4;
> +		offset += 4;
> +	}

It looks like nvmem core makes sure that offset + bytes <= nvmem->size,
so I think you can turn this loop into just a memcpy.

Other than that,

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180309/5edec855/attachment.sig>
