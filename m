From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Apr 2015 09:56:06 +0200
Subject: [PATCH 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <1430176449-12322-3-git-send-email-eric@anholt.net>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-3-git-send-email-eric@anholt.net>
Message-ID: <3080299.N0ANU8WHs3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 April 2015 16:14:08 Eric Anholt wrote:
> This gives us a function for making mailbox property channel requests
> of the firmware, and uses it to control the 3 power domains provided
> by the firmware.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  arch/arm/mach-bcm/Kconfig                          |   2 +
>  arch/arm/mach-bcm/Makefile                         |   1 +
>  arch/arm/mach-bcm/raspberrypi-firmware.c           | 285 +++++++++++++++++++++

drivers/firmware maybe?

Is this firmware the same one on the Roku 2? If so, it might need a better name.

> diff --git a/include/soc/bcm2835/raspberrypi-mailbox-property.h b/include/soc/bcm2835/raspberrypi-mailbox-property.h
> new file mode 100644
> index 0000000..787bd75
> --- /dev/null
> +++ b/include/soc/bcm2835/raspberrypi-mailbox-property.h
> @@ -0,0 +1,110 @@
> +/*
> + *  Copyright ? 2015 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/types.h>
> +
> +enum raspberrypi_firmware_property_status {
> +	raspberrypi_firmware_status_request = 0,
> +	raspberrypi_firmware_status_success = 0x80000000,
> +	raspberrypi_firmware_status_error =   0x80000001,
> +};

We tend to use ALL_CAPS for constants, even when they are in an enum.

> +struct raspberrypi_firmware_property_tag_header {
> +	/* One of enum_mbox_property_tag. */
> +	u32 tag;
> +
> +	/* The number of bytes in the value buffer following this
> +	 * struct.
> +	 */
> +	u32 buf_size;
> +
> +	/*
> +	 * On submit, the length of the request (though it doesn't
> +	 * appear to be currently used by the firmware).  On return,
> +	 * the length of the response (always 4 byte aligned), with
> +	 * the low bit set.
> +	 */
> +	u32 req_resp_size;
> +};

If I read your code right, this structure is only used inside of the driver and
not passed in from a device driver, so better move it inside of the firmware
code.

It might be best to do the same with the return codes above as well, and 
convert them into standard Linux calling conventions as well.

> +enum raspberrypi_firmware_property_tag {
> +	raspberrypi_firmware_property_end = 0,
> +	raspberrypi_firmware_get_firmware_revision =                  0x00000001,
> +
> +	raspberrypi_firmware_set_cursor_info =                        0x00008010,
> +	raspberrypi_firmware_set_cursor_state =                       0x00008011,
> +
> +	raspberrypi_firmware_get_board_model =                        0x00010001,
> +	raspberrypi_firmware_get_board_revision =                     0x00010002,
> +	raspberrypi_firmware_get_board_mac_address =                  0x00010003,
> +	raspberrypi_firmware_get_board_serial =                       0x00010004,
> +	raspberrypi_firmware_get_arm_memory =                         0x00010005,
> +	raspberrypi_firmware_get_vc_memory =                          0x00010006,
> +	raspberrypi_firmware_get_clocks =                             0x00010007,

How stable are these interfaces? Does the firmware guarantee to keep the ABI
working, or might we need to version these?

	Arnd
