From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Aug 2011 18:10:20 +0200
Subject: [PATCH 3/4] mach-ux500: export System-on-Chip information ux500
	via sysfs
In-Reply-To: <1312981422-13294-3-git-send-email-lee.jones@linaro.org>
References: <1312981422-13294-1-git-send-email-lee.jones@linaro.org>
	<1312981422-13294-3-git-send-email-lee.jones@linaro.org>
Message-ID: <201108241810.20753.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2011, Lee Jones wrote:
> +
> +static void ux500_get_soc_id(char *buf)
> +{
> +       void __iomem *uid_base;
> +       int i;
> +       ssize_t sz = 0;
> +
> +       if (dbx500_partnumber() == 0x8500) {
> +               uid_base = __io_address(U8500_BB_UID_BASE);
> +               for (i = 0; i < U8500_BB_UID_LENGTH; i++) {
> +                       sz += sprintf(buf + sz, "%08x", readl(uid_base + i * sizeof(u32)));
> +               }
> +               return;
> +       } else {
> +               /* Don't know where it is located for U5500 */
> +               sprintf(buf, "N/A");
> +               return;
> +       }
> +}
> +

This still feels like it's hanging upside-down. You add an SOC node before you know
what it is, and then attach other device to it.

Similarly, having a function named 'ux500_soc_sysfs_init' is plain wrong.

You don't initialize sysfs here, but you should be probing a device with a
driver that happens to have a sysfs interface.

All probing of devices in general should start at the root and then trickle
down as you discover the child devices:
Each board has its own init_machine() callback that knows the main devices,
most importantly the SoC and registers them. When the driver for the SoC
gets loaded, that driver knows what devices are present in the device and
registers those recursively.

When you get this right, you can also eliminate the ugly machine_is_* checks
in the board file.

	Arnd
