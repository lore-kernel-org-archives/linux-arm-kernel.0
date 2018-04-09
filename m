From: eric@anholt.net (Eric Anholt)
Date: Mon, 09 Apr 2018 12:39:37 -0700
Subject: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies
 return failure
In-Reply-To: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
References: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
Message-ID: <87muycw4na.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> If CONFIG_RASPBERRYPI_FIRMWARE=n:
>
>     drivers/gpio/gpio-raspberrypi-exp.c: In function ?rpi_exp_gpio_get_polarity?:
>     drivers/gpio/gpio-raspberrypi-exp.c:71: warning: ?get.polarity? is used uninitialized in this function
>     drivers/gpio/gpio-raspberrypi-exp.c: In function ?rpi_exp_gpio_get_direction?:
>     drivers/gpio/gpio-raspberrypi-exp.c:150: warning: ?get.direction? is used uninitialized in this function
>
> The dummy firmware interface functions return 0, which means success,
> causing subsequent code to make use of the never initialized output
> parameter.
>
> Fix this by making the dummy functions return an error code (-ENOSYS)
> instead.
>
> Note that this assumes the firmware always fills in the requested data
> in the CONFIG_RASPBERRYPI_FIRMWARE=y case.
>
> Fixes: d45f1a563b92dac7 ("staging: vc04_services: fix up rpi firmware functions")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

You should definitely not be calling these if rpi_firmware_get() failed,
so this seems like a good solution.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180409/427f33ca/attachment-0001.sig>
