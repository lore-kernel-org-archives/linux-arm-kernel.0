From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sun, 18 Nov 2018 17:06:24 +0100
Subject: [PATCH v2 02/25] mtd: add support for reading MTD devices via
 the nvmem API
In-Reply-To: <20181113140133.17385-3-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181113140133.17385-3-brgl@bgdev.pl>
Message-ID: <20181118170624.33daaaf9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Nov 2018 15:01:10 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Alban Bedel <albeu@free.fr>
> 
> Allow drivers that use the nvmem API to read data stored on MTD devices.
> For this the mtd devices are registered as read-only NVMEM providers.
> 
> We don't support device tree systems for now.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> [Bartosz:
>   - include linux/nvmem-provider.h
>   - set the name of the nvmem provider
>   - set no_of_node to true in nvmem_config
>   - don't check the return value of nvmem_unregister() - it cannot fail
>   - tweaked the commit message]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

To the person taking this patch (Greg?): I'll need an immutable tag,
just in case we end up with other changes in mtdcore.c for this release.

> ---
>  drivers/mtd/Kconfig     |  1 +
>  drivers/mtd/mtdcore.c   | 56 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/mtd.h |  2 ++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index c77f537323ec..efbe7a6f1d8f 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -1,5 +1,6 @@
>  menuconfig MTD
>  	tristate "Memory Technology Device (MTD) support"
> +	imply NVMEM
>  	help
>  	  Memory Technology Devices are flash, RAM and similar chips, often
>  	  used for solid state file systems on embedded devices. This option
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 97ac219c082e..5f1053d995b0 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -41,6 +41,7 @@
>  #include <linux/reboot.h>
>  #include <linux/leds.h>
>  #include <linux/debugfs.h>
> +#include <linux/nvmem-provider.h>
>  
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -488,6 +489,50 @@ int mtd_pairing_groups(struct mtd_info *mtd)
>  }
>  EXPORT_SYMBOL_GPL(mtd_pairing_groups);
>  
> +static int mtd_nvmem_reg_read(void *priv, unsigned int offset,
> +			      void *val, size_t bytes)
> +{
> +	struct mtd_info *mtd = priv;
> +	size_t retlen;
> +	int err;
> +
> +	err = mtd_read(mtd, offset, bytes, &retlen, val);
> +	if (err && err != -EUCLEAN)
> +		return err;
> +
> +	return retlen == bytes ? 0 : -EIO;
> +}
> +
> +static int mtd_nvmem_add(struct mtd_info *mtd)
> +{
> +	struct nvmem_config config = {};
> +
> +	config.dev = &mtd->dev;
> +	config.name = mtd->name;
> +	config.owner = THIS_MODULE;
> +	config.reg_read = mtd_nvmem_reg_read;
> +	config.size = mtd->size;
> +	config.word_size = 1;
> +	config.stride = 1;
> +	config.read_only = true;
> +	config.root_only = true;
> +	config.no_of_node = true;
> +	config.priv = mtd;
> +
> +	mtd->nvmem = nvmem_register(&config);
> +	if (IS_ERR(mtd->nvmem)) {
> +		/* Just ignore if there is no NVMEM support in the kernel */
> +		if (PTR_ERR(mtd->nvmem) == -ENOSYS) {
> +			mtd->nvmem = NULL;
> +		} else {
> +			dev_err(&mtd->dev, "Failed to register NVMEM device\n");
> +			return PTR_ERR(mtd->nvmem);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static struct dentry *dfs_dir_mtd;
>  
>  /**
> @@ -570,6 +615,11 @@ int add_mtd_device(struct mtd_info *mtd)
>  	if (error)
>  		goto fail_added;
>  
> +	/* Add the nvmem provider */
> +	error = mtd_nvmem_add(mtd);
> +	if (error)
> +		goto fail_nvmem_add;
> +
>  	if (!IS_ERR_OR_NULL(dfs_dir_mtd)) {
>  		mtd->dbg.dfs_dir = debugfs_create_dir(dev_name(&mtd->dev), dfs_dir_mtd);
>  		if (IS_ERR_OR_NULL(mtd->dbg.dfs_dir)) {
> @@ -595,6 +645,8 @@ int add_mtd_device(struct mtd_info *mtd)
>  	__module_get(THIS_MODULE);
>  	return 0;
>  
> +fail_nvmem_add:
> +	device_unregister(&mtd->dev);
>  fail_added:
>  	of_node_put(mtd_get_of_node(mtd));
>  	idr_remove(&mtd_idr, i);
> @@ -637,6 +689,10 @@ int del_mtd_device(struct mtd_info *mtd)
>  		       mtd->index, mtd->name, mtd->usecount);
>  		ret = -EBUSY;
>  	} else {
> +		/* Try to remove the NVMEM provider */
> +		if (mtd->nvmem)
> +			nvmem_unregister(mtd->nvmem);
> +
>  		device_unregister(&mtd->dev);
>  
>  		idr_remove(&mtd_idr, mtd->index);
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index cd0be91bdefa..545070c2ee64 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -25,6 +25,7 @@
>  #include <linux/notifier.h>
>  #include <linux/device.h>
>  #include <linux/of.h>
> +#include <linux/nvmem-provider.h>
>  
>  #include <mtd/mtd-abi.h>
>  
> @@ -341,6 +342,7 @@ struct mtd_info {
>  	struct device dev;
>  	int usecount;
>  	struct mtd_debug_info dbg;
> +	struct nvmem_device *nvmem;
>  };
>  
>  int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
