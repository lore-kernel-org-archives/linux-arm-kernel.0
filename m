From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 12 Nov 2014 10:42:05 +0000
Subject: [PATCH v2 1/2] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <1415645222-14909-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
 <1415645222-14909-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <5463397D.7060506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/14 18:47, Ard Biesheuvel wrote:
> Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
> that was passed to the kernel by the bootloader. This allows userland
> applications such as kexec to access the raw binary. The blob needs to
> be preserved as early as possible by calling preserve_fdt().
>
> The fact that this node does not reside under /sys/firmware/device-tree
> is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
> communicate just the UEFI and ACPI entry points, but the FDT is never
> unflattened and used to configure the system.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>   drivers/of/fdt.c       | 34 ++++++++++++++++++++++++++++++++++
>   include/linux/of_fdt.h |  2 ++
>   2 files changed, 36 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1ffca8b34ea..e9ee3d5f7ea4 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -22,6 +22,7 @@
>   #include <linux/libfdt.h>
>   #include <linux/debugfs.h>
>   #include <linux/serial_core.h>
> +#include <linux/sysfs.h>
>
>   #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>   #include <asm/page.h>
> @@ -1103,4 +1104,37 @@ static int __init of_flat_dt_debugfs_export_fdt(void)
>   module_init(of_flat_dt_debugfs_export_fdt);
>   #endif
>
> +static u8 *raw_fdt_copy;
> +
> +void __init preserve_fdt(void)
> +{
> +	u32 fdt_size;
> +
> +	fdt_size = fdt_totalsize(initial_boot_params);
> +	raw_fdt_copy = memcpy(__va(memblock_alloc(fdt_size, PAGE_SIZE)),
> +			      initial_boot_params, fdt_size);
> +}
> +
> +#ifdef CONFIG_SYSFS
> +static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
> +			       struct bin_attribute *bin_attr,
> +			       char *buf, loff_t off, size_t count)
> +{
> +	memcpy(buf, raw_fdt_copy + off, count);
Should we check for the off+count, not to exceed the fdt_size that we 
actually copied ?

Thanks
Suzuki
