From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Thu, 1 Mar 2018 16:09:11 +0200
Subject: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
In-Reply-To: <1519154467-2896-4-git-send-email-jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-4-git-send-email-jollys@xilinx.com>
Message-ID: <CAHp75VdqDupw3E6qVj6awHJf0JrT3f7UGbO3YAeWM9Yzg-HE=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 9:21 PM, Jolly Shah <jolly.shah@xilinx.com> wrote:
> Add Firmware-ggs sysfs interface which provides read/write
> interface to global storage registers.

> +#include <linux/compiler.h>
> +#include <linux/of.h>

> +#include <linux/init.h>
> +#include <linux/module.h>

You need to leave one of them.

> +#include <linux/uaccess.h>
> +#include <linux/slab.h>

> +#include <linux/firmware/xilinx/zynqmp/firmware.h>

Keep it in order? Or add an empty line before?

> +       return sprintf(buf, "0x%x\n", ret_payload[1]);

Hmm... No leading zeroes?

> +static ssize_t write_register(const char *buf, size_t count, u32 read_ioctl,
> +                             u32 write_ioctl, u32 reg)
> +{
> +       char *kern_buff, *inbuf, *tok;
> +       long mask, value;
> +       int ret;
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
> +
> +       if (!eemi_ops || !eemi_ops->ioctl)
> +               return -EFAULT;

> +       kern_buff = kzalloc(count, GFP_KERNEL);
> +       if (!kern_buff)
> +               return -ENOMEM;
> +
> +       ret = strlcpy(kern_buff, buf, count);
> +       if (ret < 0) {
> +               ret = -EFAULT;
> +               goto err;
> +       }

kstrndup()

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

Why to shadow an error?

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

Ditto.

> +               goto err;
> +       }
> +
> +       ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
> +       if (ret) {

> +               ret = -EFAULT;

Ditto.

> +               goto err;
> +       }

> +       ret_payload[1] &= ~mask;
> +       value &= mask;
> +       value |= ret_payload[1];

Also canonical one to write in one line:

      value = (value & mask) | (ret_payload[1] & ~mask);

> +
> +       ret = eemi_ops->ioctl(0, write_ioctl, reg, value, NULL);
> +       if (ret)

> +               ret = -EFAULT;

Why to shadow an error?

> +
> +err:
> +       kfree(kern_buff);


> +       if (ret)
> +               return ret;
> +
> +       return count;

return ret ? ret : count;

> +}

-- 
With Best Regards,
Andy Shevchenko
