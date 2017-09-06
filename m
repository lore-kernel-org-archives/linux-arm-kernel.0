From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Sep 2017 00:46:36 +0200
Subject: [PATCH v3 1/5] scsi: ufs: add Hisilicon ufs driver code
In-Reply-To: <20170829084116.106695-2-liwei213@huawei.com>
References: <20170829084116.106695-1-liwei213@huawei.com>
 <20170829084116.106695-2-liwei213@huawei.com>
Message-ID: <CAK8P3a0vV94g=iNLfHXXgR-XFHaaK-mHoQQ45FDYG+FVQhix6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 10:41 AM, Li Wei <liwei213@huawei.com> wrote:
itel(host, UFS_ARESET, PERRSTDIS3_OFFSET);
> +
> +       /* disable lp_reset_n */
> +       ufs_sys_ctrl_set_bits(host, BIT_SYSCTRL_LP_RESET_N, RESET_CTRL_EN);
> +       mdelay(1);
> +
> +       if (gpio_is_valid(host->reset_gpio))
> +               gpio_direction_output(host->reset_gpio, 1);
> +
> +       ufs_sys_ctrl_writel(host, MASK_UFS_DEVICE_RESET | BIT_UFS_DEVICE_RESET,
> +               UFS_DEVICE_RESET_CTRL);
> +
> +       mdelay(20);

Could those mdelay() be turned into msleep() functions?

> +static int ufs_hisi_get_resource(struct ufs_hisi_host *host)
> +{
> +       struct resource *mem_res;
> +       struct device_node *np = NULL;
> +       struct device *dev = host->hba->dev;
> +       struct platform_device *pdev = to_platform_device(dev);
> +
> +       /* get resource of ufs sys ctrl */
> +       mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       host->ufs_sys_ctrl = devm_ioremap_resource(dev, mem_res);
> +       if (IS_ERR(host->ufs_sys_ctrl))
> +               return PTR_ERR(host->ufs_sys_ctrl);
> +
> +       np = of_find_compatible_node(NULL, NULL, "hisilicon,hi3660-crgctrl");

It's generally not a good idea to look up one device by its "compatible"
string. What is the "crgctrl"? Does it have a proper DT binding?
Maybe there should be a driver for it, or you could make it a "syscon"
device and look it up by phandle instead.

> diff --git a/drivers/scsi/ufs/ufs-hisi.h b/drivers/scsi/ufs/ufs-hisi.h
> new file mode 100644
> index 000000000000..52430a2aca90
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufs-hisi.h


If the header is only used in one file, you don't need it, just move
the definitions
into the other file.

      Arnd
