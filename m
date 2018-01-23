From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 23 Jan 2018 09:37:32 +0100
Subject: [PATCH v2 3/4] drivers: firmware: xilinx: Add sysfs interface
In-Reply-To: <1516220434-22204-4-git-send-email-jollys@xilinx.com>
References: <1516220434-22204-1-git-send-email-jollys@xilinx.com>
 <1516220434-22204-4-git-send-email-jollys@xilinx.com>
Message-ID: <20180123083732.GA21463@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 12:20:33PM -0800, Jolly Shah wrote:
> Add Firmware-ggs sysfs interface which provides read/write
> interface to global storage registers.
> 
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> ---
>  .../ABI/stable/sysfs-driver-zynqmp-firmware        |  33 +++
>  drivers/firmware/xilinx/zynqmp/Makefile            |   2 +-
>  drivers/firmware/xilinx/zynqmp/firmware-ggs.c      | 298 +++++++++++++++++++++
>  drivers/firmware/xilinx/zynqmp/firmware.c          |  26 ++
>  include/linux/firmware/xilinx/zynqmp/firmware.h    |   2 +
>  5 files changed, 360 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
>  create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> 
> diff --git a/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
> new file mode 100644
> index 0000000..2483215
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
> @@ -0,0 +1,33 @@
> +What:          /sys/devices/platform/zynqmp-firmware/ggs*
> +Date:          January 2018
> +KernelVersion: 4.15.0
> +Contact:       "Jolly Shah" <jollys@xilinx.com>
> +Description:
> +               Shows PMU global general storage register value,
> +               GLOBAL_GEN_STORAGE{0:3}.
> +               Global general storage register that can be used
> +               by system to pass information between masters.
> +
> +               The register is reset during system or power-on
> +               resets. Three registers are used by the FSBL and
> +               other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
> +
> +Users:         Xilinx
> +
> +What:          /sys/devices/platform/zynqmp-firmware/pggs*
> +Date:          January 2018
> +KernelVersion: 4.15.0
> +Contact:       "Jolly Shah" <jollys@xilinx.com>
> +Description:
> +               Shows PMU persistent global general storage register
> +               value, PERS_GLOB_GEN_STORAGE{0:3}.
> +               Persistent global general storage register that
> +               can be used by system to pass information between
> +               masters.
> +
> +               This register is only reset by the power-on reset
> +               and maintains its value through a system reset.
> +               Four registers are used by the FSBL and other Xilinx
> +               software products: PERS_GLOB_GEN_STORAGE{4:7}.
> +               Register is reset only by a POR reset.
> +Users:         Xilinx
> diff --git a/drivers/firmware/xilinx/zynqmp/Makefile b/drivers/firmware/xilinx/zynqmp/Makefile
> index c3ec669..6629781 100644
> --- a/drivers/firmware/xilinx/zynqmp/Makefile
> +++ b/drivers/firmware/xilinx/zynqmp/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  # Makefile for Xilinx firmwares
> 
> -obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o
> +obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o firmware-ggs.o
> diff --git a/drivers/firmware/xilinx/zynqmp/firmware-ggs.c b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> new file mode 100644
> index 0000000..be47ca2
> --- /dev/null
> +++ b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Xilinx Zynq MPSoC Firmware layer
> + *
> + *  Copyright (C) 2014-2018 Xilinx, Inc.
> + *
> + *  Jolly Shah <jollys@xilinx.com>
> + *  Rajan Vaja <rajanv@xilinx.com>
> + */
> +
> +#include <linux/compiler.h>
> +#include <linux/of.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/firmware/xilinx/zynqmp/firmware.h>

That's crazy deep nesting, why?

> +
> +static ssize_t read_register(char *buf, u32 ioctl_id, u32 reg)
> +{
> +       int ret;
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->ioctl)
> +               return 0;

Not an error?

> +
> +       ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
> +       if (ret)
> +               return ret;
> +
> +       return snprintf(buf, PAGE_SIZE, "0x%x\n", ret_payload[1]);

Minor nit, you never need to use snprintf() for a sysfs file, as you
"know" the size and you can't overflow it with just a single value.

Yeah, some tool-checkers hate to see a "raw" sprintf() call, but really,
ignore them here :)

> +}
> +
> +static ssize_t write_register(const char *buf, size_t count,
> +                             u32 ioctl_id, u32 reg)
> +{
> +       char *kern_buff;
> +       char *inbuf;
> +       char *tok;
> +       long mask;
> +       long value;
> +       int ret;
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->ioctl)
> +               return -EFAULT;
> +
> +       kern_buff = kzalloc(count, GFP_KERNEL);
> +       if (!kern_buff)
> +               return -ENOMEM;
> +
> +       ret = strlcpy(kern_buff, buf, count);
> +       if (ret < 0) {
> +               ret = -EFAULT;
> +               goto err;
> +       }
> +
> +       inbuf = kern_buff;
> +
> +       /* Read the write mask */
> +       tok = strsep(&inbuf, " ");
> +       if (!tok) {
> +               ret = -EFAULT;
> +               goto err;
> +       }
> +
> +       ret = kstrtol(tok, 16, &mask);
> +       if (ret) {
> +               ret = -EFAULT;
> +               goto err;
> +       }
> +
> +       /* Read the write value */
> +       tok = strsep(&inbuf, " ");
> +       if (!tok) {
> +               ret = -EFAULT;
> +               goto err;
> +       }
> +
> +       ret = kstrtol(tok, 16, &value);
> +       if (ret) {
> +               ret = -EFAULT;
> +               goto err;
> +       }

What exactly is the format for the data to be written here?  You do not
document it in the ABI/ file above, and it looks to be non-trivial to
understand from the code :(

> +
> +       ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
> +       if (ret) {
> +               ret = -EFAULT;
> +               goto err;
> +       }
> +       ret_payload[1] &= ~mask;
> +       value &= mask;
> +       value |= ret_payload[1];
> +
> +       ret = eemi_ops->ioctl(0, ioctl_id, reg, value, NULL);
> +       if (ret)
> +               ret = -EFAULT;
> +
> +err:
> +       kfree(kern_buff);
> +       if (ret)
> +               return ret;
> +
> +       return count;
> +}
> +
> +/**
> + * ggs_show - Show global general storage (ggs) sysfs attribute
> + * @dev: Device structure
> + * @attr: Device attribute structure
> + * @buf: Requested available shutdown_scope attributes string
> + * @reg: Register number
> + *
> + * Return:Number of bytes printed into the buffer.
> + *
> + * Helper function for viewing a ggs register value.
> + *
> + * User-space interface for viewing the content of the ggs0 register.
> + * cat /sys/devices/platform/firmware/ggs0
> + */
> +static ssize_t ggs_show(struct device *dev,
> +                       struct device_attribute *attr,
> +                       char *buf,
> +                       u32 reg)
> +{
> +       return read_register(buf, IOCTL_READ_GGS, reg);
> +}
> +
> +/**
> + * ggs_store - Store global general storage (ggs) sysfs attribute
> + * @dev: Device structure
> + * @attr: Device attribute structure
> + * @buf: User entered shutdown_scope attribute string
> + * @count: Size of buf
> + * @reg: Register number
> + *
> + * Return: count argument if request succeeds, the corresponding
> + * error code otherwise
> + *
> + * Helper function for storing a ggs register value.
> + *
> + * For example, the user-space interface for storing a value to the
> + * ggs0 register:
> + * echo 0xFFFFFFFF 0x1234ABCD > /sys/devices/platform/firmware/ggs0
> + */
> +static ssize_t ggs_store(struct device *dev,
> +                        struct device_attribute *attr,
> +                        const char *buf,
> +                        size_t count,
> +                        u32 reg)
> +{
> +       if (!dev || !attr || !buf || !count || reg >= GSS_NUM_REGS)
> +               return -EINVAL;
> +
> +       return write_register(buf, count, IOCTL_WRITE_GGS, reg);
> +}
> +
> +/* GGS register show functions */
> +#define GGS0_SHOW(N) \
> +       ssize_t ggs##N##_show(struct device *dev, \
> +                        struct device_attribute *attr, \
> +                        char *buf) \
> +       { \
> +               return ggs_show(dev, attr, buf, N); \
> +       }
> +
> +static GGS0_SHOW(0);
> +static GGS0_SHOW(1);
> +static GGS0_SHOW(2);
> +static GGS0_SHOW(3);
> +
> +/* GGS register store function */
> +#define GGS0_STORE(N) \
> +       ssize_t ggs##N##_store(struct device *dev, \
> +                                  struct device_attribute *attr, \
> +                                  const char *buf, \
> +                                  size_t count) \
> +       { \
> +               return ggs_store(dev, attr, buf, count, N); \
> +       }
> +
> +static GGS0_STORE(0);
> +static GGS0_STORE(1);
> +static GGS0_STORE(2);
> +static GGS0_STORE(3);
> +
> +/* GGS register device attributes */
> +static DEVICE_ATTR_RW(ggs0);
> +static DEVICE_ATTR_RW(ggs1);
> +static DEVICE_ATTR_RW(ggs2);
> +static DEVICE_ATTR_RW(ggs3);
> +
> +#define CREATE_GGS_DEVICE(dev, N) \
> +do { \
> +       if (device_create_file(dev, &dev_attr_ggs##N)) \
> +               dev_err(dev, "unable to create ggs%d attribute\n", N); \
> +} while (0)
> +
> +/**
> + * pggs_show - Show persistent global general storage (pggs) sysfs attribute
> + * @dev: Device structure
> + * @attr: Device attribute structure
> + * @buf: Requested available shutdown_scope attributes string
> + * @reg: Register number
> + *
> + * Return:Number of bytes printed into the buffer.
> + *
> + * Helper function for viewing a pggs register value.
> + */
> +static ssize_t pggs_show(struct device *dev,
> +                        struct device_attribute *attr,
> +                        char *buf,
> +                        u32 reg)
> +{
> +       return read_register(buf, IOCTL_READ_GGS, reg);
> +}
> +
> +/**
> + * pggs_store - Store persistent global general storage (pggs) sysfs attribute
> + * @dev: Device structure
> + * @attr: Device attribute structure
> + * @buf: User entered shutdown_scope attribute string
> + * @count: Size of buf
> + * @reg: Register number
> + *
> + * Return: count argument if request succeeds, the corresponding
> + * error code otherwise
> + *
> + * Helper function for storing a pggs register value.
> + */
> +static ssize_t pggs_store(struct device *dev,
> +                         struct device_attribute *attr,
> +                         const char *buf,
> +                         size_t count,
> +                         u32 reg)
> +{
> +       return write_register(buf, count, IOCTL_WRITE_PGGS, reg);
> +}
> +
> +#define PGGS0_SHOW(N) \
> +       ssize_t pggs##N##_show(struct device *dev, \
> +                        struct device_attribute *attr, \
> +                        char *buf) \
> +       { \
> +               return pggs_show(dev, attr, buf, N); \
> +       }
> +
> +/* PGGS register show functions */
> +static PGGS0_SHOW(0);
> +static PGGS0_SHOW(1);
> +static PGGS0_SHOW(2);
> +static PGGS0_SHOW(3);
> +
> +#define PGGS0_STORE(N) \
> +       ssize_t pggs##N##_store(struct device *dev, \
> +                                  struct device_attribute *attr, \
> +                                  const char *buf, \
> +                                  size_t count) \
> +       { \
> +               return pggs_store(dev, attr, buf, count, N); \
> +       }
> +
> +/* PGGS register store functions */
> +static PGGS0_STORE(0);
> +static PGGS0_STORE(1);
> +static PGGS0_STORE(2);
> +static PGGS0_STORE(3);
> +
> +/* PGGS register device attributes */
> +static DEVICE_ATTR_RW(pggs0);
> +static DEVICE_ATTR_RW(pggs1);
> +static DEVICE_ATTR_RW(pggs2);
> +static DEVICE_ATTR_RW(pggs3);
> +
> +#define CREATE_PGGS_DEVICE(dev, N) \
> +do { \
> +       if (device_create_file(dev, &dev_attr_pggs##N)) \
> +               dev_err(dev, "unable to create pggs%d attribute\n", N); \

Ick, no, just use an attribute group please.  Handles all of this mess
for you automatically, and will unwind properly if you have an error
(which this macro does not do.)

thanks,

greg k-h
