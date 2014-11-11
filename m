From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Nov 2014 10:25:32 -0600
Subject: [PATCH v2 1/2] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <20141111144221.5FCDAC416AF@trevor.secretlab.ca>
References: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
 <1415645222-14909-2-git-send-email-ard.biesheuvel@linaro.org>
 <20141111144221.5FCDAC416AF@trevor.secretlab.ca>
Message-ID: <CAL_JsqKeG1dWrMZydCN119V3++WKXqsjMm1bG7Fodhf3O8owpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 8:42 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Mon, 10 Nov 2014 19:47:01 +0100
> , Ard Biesheuvel <ard.biesheuvel@linaro.org>
>  wrote:
>> Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
>> that was passed to the kernel by the bootloader. This allows userland
>> applications such as kexec to access the raw binary. The blob needs to
>> be preserved as early as possible by calling preserve_fdt().
>>
>> The fact that this node does not reside under /sys/firmware/device-tree
>> is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
>> communicate just the UEFI and ACPI entry points, but the FDT is never
>> unflattened and used to configure the system.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> On further thought, nak. I want tree modifications to be treated as
> bugs. Do a checksum CRC32 or check. It's simpler and it can be extended
> to us an in-blob CRC when the file format gets upreved to include one.

Why? MIPS Octeon is full of them BTW. So the rule is any modifications
or fixups have to be on the unflattened tree?

For the CRC, we should add it into the entropy pool.

Rob

>
> g.
>
> ---
>
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index be16ce2ffd69..adda0a16934f 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -23,6 +23,7 @@ config OF_FLATTREE
>         bool
>         select DTC
>         select LIBFDT
> +       select CRC
>
>  config OF_EARLY_FLATTREE
>         bool
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 83a8e1154602..80db46a2eab9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -10,6 +10,7 @@
>   */
>
>  #include <linux/kernel.h>
> +#include <linux/crc32.h>
>  #include <linux/initrd.h>
>  #include <linux/memblock.h>
>  #include <linux/of.h>
> @@ -420,6 +421,7 @@ int __initdata dt_root_addr_cells;
>  int __initdata dt_root_size_cells;
>
>  void *initial_boot_params;
> +u32 initial_boot_params_crc;
>
>  #ifdef CONFIG_OF_EARLY_FLATTREE
>
> @@ -1003,6 +1005,9 @@ bool __init early_init_dt_verify(void *params)
>
>         /* Setup flat device-tree pointer */
>         initial_boot_params = params;
> +       initial_boot_params_crc = crc32_be(0, params, fdt_totalsize(params));
> +       pr_info("FDT CRC: %x\n", initial_boot_params_crc);
> +
>         return true;
>  }
>
>
>
>
>> ---
>>  drivers/of/fdt.c       | 34 ++++++++++++++++++++++++++++++++++
>>  include/linux/of_fdt.h |  2 ++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index d1ffca8b34ea..e9ee3d5f7ea4 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/libfdt.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/serial_core.h>
>> +#include <linux/sysfs.h>
>>
>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>  #include <asm/page.h>
>> @@ -1103,4 +1104,37 @@ static int __init of_flat_dt_debugfs_export_fdt(void)
>>  module_init(of_flat_dt_debugfs_export_fdt);
>>  #endif
>>
>> +static u8 *raw_fdt_copy;
>> +
>> +void __init preserve_fdt(void)
>> +{
>> +     u32 fdt_size;
>> +
>> +     fdt_size = fdt_totalsize(initial_boot_params);
>> +     raw_fdt_copy = memcpy(__va(memblock_alloc(fdt_size, PAGE_SIZE)),
>> +                           initial_boot_params, fdt_size);
>> +}
>> +
>> +#ifdef CONFIG_SYSFS
>> +static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
>> +                            struct bin_attribute *bin_attr,
>> +                            char *buf, loff_t off, size_t count)
>> +{
>> +     memcpy(buf, raw_fdt_copy + off, count);
>> +     return count;
>> +}
>> +
>> +static int __init of_fdt_raw_init(void)
>> +{
>> +     static struct bin_attribute of_fdt_raw_attr =
>> +             __BIN_ATTR(fdt, S_IRUSR, of_fdt_raw_read, NULL, 0);
>> +
>> +     if (!raw_fdt_copy)
>> +             return 0;
>> +     of_fdt_raw_attr.size = fdt_totalsize(raw_fdt_copy);
>> +     return sysfs_create_bin_file(firmware_kobj, &of_fdt_raw_attr);
>> +}
>> +module_init(of_fdt_raw_init);
>> +#endif
>> +
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index 0ff360d5b3b3..7672a26305a5 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -83,6 +83,7 @@ extern const void *of_flat_dt_match_machine(const void *default_match,
>>  /* Other Prototypes */
>>  extern void unflatten_device_tree(void);
>>  extern void unflatten_and_copy_device_tree(void);
>> +extern void preserve_fdt(void);
>>  extern void early_init_devtree(void *);
>>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>>  extern u64 fdt_translate_address(const void *blob, int node_offset);
>> @@ -92,6 +93,7 @@ static inline void early_init_fdt_scan_reserved_mem(void) {}
>>  static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
>>  static inline void unflatten_device_tree(void) {}
>>  static inline void unflatten_and_copy_device_tree(void) {}
>> +static inline void preserve_fdt(void) {}
>>  #endif /* CONFIG_OF_FLATTREE */
>>
>>  #endif /* __ASSEMBLY__ */
>> --
>> 1.8.3.2
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
