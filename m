From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 13 Nov 2014 10:20:36 +0100
Subject: [PATCH v4] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <CAL_JsqK09_HawhX9zUHm16LTmEvcKDKs9-S=Pb9AUzaLFQtnLw@mail.gmail.com>
References: <1415795308-14639-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAL_JsqK09_HawhX9zUHm16LTmEvcKDKs9-S=Pb9AUzaLFQtnLw@mail.gmail.com>
Message-ID: <CAKv+Gu-G+cQz4b1ingL1hJMhSdKxzQPDXWUj4=eFNFnH4dZctg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 November 2014 17:08, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Nov 12, 2014 at 6:28 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Create a new /sys entry '/sys/firmware/fdt' to export the FDT blob
>> that was passed to the kernel by the bootloader. This allows userland
>> applications such as kexec to access the raw binary.
>>
>> The fact that this node does not reside under /sys/firmware/device-tree
>> is deliberate: FDT is also used on arm64 UEFI/ACPI systems to
>> communicate just the UEFI and ACPI entry points, but the FDT is never
>> unflattened and used to configure the system.
>>
>> A CRC32 checksum is calculated over the entire FDT blob, and verified
>> at late_initcall time. The sysfs entry is instantiated only if the
>> checksum is valid, i.e., if the FDT blob has not been modified in the
>> mean time. Otherwise, a warning is printed.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> v4: use pr_warn() instead of WARN()
>> v3: keep checksum instead of copying the entire blob, and WARN on mismatch
>>
>>  drivers/of/Kconfig |  1 +
>>  drivers/of/fdt.c   | 37 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>> index 1a13f5b722c5..0348c208343c 100644
>> --- a/drivers/of/Kconfig
>> +++ b/drivers/of/Kconfig
>> @@ -23,6 +23,7 @@ config OF_FLATTREE
>>         bool
>>         select DTC
>>         select LIBFDT
>> +       select CRC32
>>
>>  config OF_EARLY_FLATTREE
>>         bool
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index d1ffca8b34ea..0004871ebccf 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -9,6 +9,7 @@
>>   * version 2 as published by the Free Software Foundation.
>>   */
>>
>> +#include <linux/crc32.h>
>>  #include <linux/kernel.h>
>>  #include <linux/initrd.h>
>>  #include <linux/memblock.h>
>> @@ -22,10 +23,20 @@
>>  #include <linux/libfdt.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/serial_core.h>
>> +#include <linux/sysfs.h>
>>
>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>  #include <asm/page.h>
>>
>> +static u32 of_fdt_crc32;
>> +
>> +static u32 of_fdt_get_crc32(void *fdt)
>> +{
>> +       static u32 const OF_FDT_CRC32_SEED = 0x04c11db7;
>
> Where did this value come from? A comment would be useful.
>

Oops, it appears I was a bit sloppy here. I misread 'seed' in the
crc32 header as poly, but actually the implementation refers to this
polynomial directly as CRCPOLY_BE and the seed should be 0 here (or in
the verify case, the original crc, in which case the return value
should be 0)

>> +
>> +       return crc32_be(OF_FDT_CRC32_SEED, fdt, fdt_totalsize(fdt));
>> +}
>> +
>>  /*
>>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>>   * @limit: maximum entries
>> @@ -1003,6 +1014,8 @@ bool __init early_init_dt_verify(void *params)
>>                 return false;
>>         }
>>
>> +       of_fdt_crc32 = of_fdt_get_crc32(initial_boot_params);
>> +
>>         return true;
>>  }
>>
>> @@ -1103,4 +1116,28 @@ static int __init of_flat_dt_debugfs_export_fdt(void)
>>  module_init(of_flat_dt_debugfs_export_fdt);
>>  #endif
>>
>> +#ifdef CONFIG_SYSFS
>> +static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
>> +                              struct bin_attribute *bin_attr,
>> +                              char *buf, loff_t off, size_t count)
>> +{
>> +       memcpy(buf, initial_boot_params + off, count);
>> +       return count;
>> +}
>> +
>> +static int __init of_fdt_raw_init(void)
>> +{
>> +       static struct bin_attribute of_fdt_raw_attr =
>> +               __BIN_ATTR(fdt, S_IRUSR, of_fdt_raw_read, NULL, 0);
>> +
>> +       if (of_fdt_crc32 != of_fdt_get_crc32(initial_boot_params)) {
>> +               pr_warn("fdt: not creating '/sys/firmware/fdt': CRC check failed");
>> +               return 0;
>> +       }
>> +       of_fdt_raw_attr.size = fdt_totalsize(initial_boot_params);
>> +       return sysfs_create_bin_file(firmware_kobj, &of_fdt_raw_attr);
>> +}
>> +late_initcall(of_fdt_raw_init);
>> +#endif
>> +
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>
> You have a mixture of things inside and outside of
> CONFIG_OF_EARLY_FLATTREE which in theory could cause warnings. However
> looking more closely at this, it is fine for now. Instead I think we
> need to get rid of CONFIG_OF_EARLY_FLATTREE (or merge with
> OF_FLATTREE) . Every platform selects it except Sparc.
>

Well, the crc will only be computed if early_init_dt_verify() was
called, so it seems putting the initcall() here is not entirely
inappropriate.

@Grant; I will respin based on the version you posted in this thread,
and fix the crc bit.
