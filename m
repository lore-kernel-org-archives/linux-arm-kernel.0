From: eric@anholt.net (Eric Anholt)
Date: Tue, 28 Apr 2015 13:07:12 -0700
Subject: [PATCH 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <3080299.N0ANU8WHs3@wuerfel>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-3-git-send-email-eric@anholt.net>
 <3080299.N0ANU8WHs3@wuerfel>
Message-ID: <871tj46mq7.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday 27 April 2015 16:14:08 Eric Anholt wrote:
>> This gives us a function for making mailbox property channel requests
>> of the firmware, and uses it to control the 3 power domains provided
>> by the firmware.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  arch/arm/mach-bcm/Kconfig                          |   2 +
>>  arch/arm/mach-bcm/Makefile                         |   1 +
>>  arch/arm/mach-bcm/raspberrypi-firmware.c           | 285 +++++++++++++++++++++
>
> drivers/firmware maybe?

Sounds fine to me.

> Is this firmware the same one on the Roku 2? If so, it might need a better name.

Nope.  While they apparently start from the same firmware tree, it's
quite diverged.

>> diff --git a/include/soc/bcm2835/raspberrypi-mailbox-property.h b/include/soc/bcm2835/raspberrypi-mailbox-property.h
>> new file mode 100644
>> index 0000000..787bd75
>> --- /dev/null
>> +++ b/include/soc/bcm2835/raspberrypi-mailbox-property.h
>> @@ -0,0 +1,110 @@
>> +/*
>> + *  Copyright ? 2015 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/types.h>
>> +
>> +enum raspberrypi_firmware_property_status {
>> +	raspberrypi_firmware_status_request = 0,
>> +	raspberrypi_firmware_status_success = 0x80000000,
>> +	raspberrypi_firmware_status_error =   0x80000001,
>> +};
>
> We tend to use ALL_CAPS for constants, even when they are in an enum.

Will do.

>> +struct raspberrypi_firmware_property_tag_header {
>> +	/* One of enum_mbox_property_tag. */
>> +	u32 tag;
>> +
>> +	/* The number of bytes in the value buffer following this
>> +	 * struct.
>> +	 */
>> +	u32 buf_size;
>> +
>> +	/*
>> +	 * On submit, the length of the request (though it doesn't
>> +	 * appear to be currently used by the firmware).  On return,
>> +	 * the length of the response (always 4 byte aligned), with
>> +	 * the low bit set.
>> +	 */
>> +	u32 req_resp_size;
>> +};
>
> If I read your code right, this structure is only used inside of the driver and
> not passed in from a device driver, so better move it inside of the firmware
> code.

In the code present so far, yes.  However, the vc4 driver is also making
property requests, and many of the still-downstream drivers need it too,
I believe.

> It might be best to do the same with the return codes above as well, and 
> convert them into standard Linux calling conventions as well.

The raspberrypi_firmware_status_*?  Those are getting interpreted and
turned into standard Linux return values in
raspberrypi_firmware_property().  I guess we could hide them inside that
driver, but it seems to make sense to me to live here next to the other
property channel interface enums.

>> +enum raspberrypi_firmware_property_tag {
>> +	raspberrypi_firmware_property_end = 0,
>> +	raspberrypi_firmware_get_firmware_revision =                  0x00000001,
>> +
>> +	raspberrypi_firmware_set_cursor_info =                        0x00008010,
>> +	raspberrypi_firmware_set_cursor_state =                       0x00008011,
>> +
>> +	raspberrypi_firmware_get_board_model =                        0x00010001,
>> +	raspberrypi_firmware_get_board_revision =                     0x00010002,
>> +	raspberrypi_firmware_get_board_mac_address =                  0x00010003,
>> +	raspberrypi_firmware_get_board_serial =                       0x00010004,
>> +	raspberrypi_firmware_get_arm_memory =                         0x00010005,
>> +	raspberrypi_firmware_get_vc_memory =                          0x00010006,
>> +	raspberrypi_firmware_get_clocks =                             0x00010007,
>
> How stable are these interfaces? Does the firmware guarantee to keep the ABI
> working, or might we need to version these?

They're good about ABI, as far as I can tell.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150428/93388c11/attachment-0001.sig>
