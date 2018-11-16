From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 16 Nov 2018 15:30:10 +0100
Subject: [PATCH] firmware: raspberrypi: Fix firmware calls with large
 buffers
In-Reply-To: <20181116140722.1203-1-james.hughes@raspberrypi.org>
References: <20181116140722.1203-1-james.hughes@raspberrypi.org>
Message-ID: <890be6cb-327e-6862-8f80-9dde0d2e3b1a@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Am 16.11.18 um 15:07 schrieb James Hughes:
> Commit a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
> moved away from VLA's to a fixed maximum size for mailbox data.
> However, some mailbox calls use larger data buffers
> than the maximum allowed in that change. This fix therefor
> moves from using fixed buffers to kmalloc to ensure all sizes
> are catered for.
>
> There is some documentation, which is somewhat out of date,
> on the mailbox calls here :
> https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
>
> v2: Changes to commit message and format only. No code change.
>
> Fixes: a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
>
> Signed-off-by: James Hughes <james.hughes@raspberrypi.org>
> ---
>  drivers/firmware/raspberrypi.c | 35 +++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)

just some nits. Please place your change log here, not in the commit log.

You also missed the version number in the subject.

>
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index a200a2174611..9257bee7860f 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/slab.h>
>  #include <soc/bcm2835/raspberrypi-firmware.h>
>  
>  #define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
> @@ -21,8 +22,6 @@
>  #define MBOX_DATA28(msg)		((msg) & ~0xf)
>  #define MBOX_CHAN_PROPERTY		8
>  
> -#define MAX_RPI_FW_PROP_BUF_SIZE	32
> -
>  static struct platform_device *rpi_hwmon;
>  
>  struct rpi_firmware {
> @@ -144,28 +143,30 @@ EXPORT_SYMBOL_GPL(rpi_firmware_property_list);
>  int rpi_firmware_property(struct rpi_firmware *fw,
>  			  u32 tag, void *tag_data, size_t buf_size)
>  {
> -	/* Single tags are very small (generally 8 bytes), so the
> -	 * stack should be safe.
> -	 */
> -	u8 data[sizeof(struct rpi_firmware_property_tag_header) +
> -		MAX_RPI_FW_PROP_BUF_SIZE];
> -	struct rpi_firmware_property_tag_header *header =
> -		(struct rpi_firmware_property_tag_header *)data;
>  	int ret;
> +	struct rpi_firmware_property_tag_header *header;

please don't move the declaration of rpi_firmware_property_tag_header
and only remove the assignment.

Thanks
Stefan
