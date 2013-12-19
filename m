From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 19 Dec 2013 09:59:31 -0800
Subject: [PATCH 2/6] misc: fuse: Add efuse driver for Tegra
In-Reply-To: <1387468474-26521-3-git-send-email-pdeschrijver@nvidia.com>
References: <1387468474-26521-1-git-send-email-pdeschrijver@nvidia.com>
 <1387468474-26521-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20131219175931.GA18004@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 05:54:30PM +0200, Peter De Schrijver wrote:
> +int tegra_fuse_sysfs(struct device *dev, int size,
> +		     u32 (*readl)(const unsigned int offset),
> +		     struct tegra_sku_info *sku_info)

Odd function name, there's no "verb" in it to give a hint as to what it
does.

> +{
> +	int err;
> +
> +	if (fuse_size)
> +		return -ENODEV;
> +
> +	fuse_bin_attr.size = size;
> +	fuse_bin_attr.read = fuse_read;
> +
> +	fuse_size = size;
> +	fuse_readl = readl;
> +
> +	err = device_create_bin_file(dev, &fuse_bin_attr);
> +	if (err)
> +		return err;
> +
> +	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",
> +		tegra_revision_name[sku_info->revision],
> +		sku_info->sku_id, sku_info->cpu_process_id,
> +		sku_info->core_process_id);

Why pollute the kernel log with this type of thing?  Who really needs
it?

And if you really need it, please use dev_info() to properly identify
the device you are referring to.

Also, you forgot to document your new sysfs file that you created in
Documentation/ABI/ :(

thanks,

greg k-h
