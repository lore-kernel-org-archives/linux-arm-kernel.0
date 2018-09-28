From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 28 Sep 2018 14:13:58 -0700
Subject: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
In-Reply-To: <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-7-takahiro.akashi@linaro.org>
 <CAL_JsqKwmcdQ+2eK3LGHhcQ2Wb+Yz1-Atz0-3K6WKNZQt_woVw@mail.gmail.com>
Message-ID: <6a8d3ddb-c3bc-c044-4d6c-55e110d89e72@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/18 06:44, Rob Herring wrote:
> +David Gibson
> 
> On Fri, Sep 28, 2018 at 1:48 AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>>
>> These functions will be used later to handle kexec-specific properties
>> in arm64's kexec_file implementation.

As I requested in version 14:

  The intent of the helper functions is related to properties whose values are
   tuples of the same format as the "reg" property of the "/memory" nodes.  For
   example, the "linux,usable-memory-range" and "linux,elfcoredhr" properties of
   the "/chosen" node.

   The patch header and the function names should be updated to reflect this intent.


>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> Cc: devicetree at vger.kernel.org
>> ---

Missing list of changes since version 14.


>>  drivers/of/fdt.c       | 56 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of_fdt.h |  4 +++
>>  2 files changed, 60 insertions(+)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 800ad252cf9c..c65c31562ccb 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/debugfs.h>
>>  #include <linux/serial_core.h>
>>  #include <linux/sysfs.h>
>> +#include <linux/types.h>
>>
>>  #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>>  #include <asm/page.h>
>> @@ -1323,3 +1324,58 @@ late_initcall(of_fdt_raw_init);
>>  #endif
>>
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */

In v14 I requested:

   Please add comment:

   /* helper functions for arm64 kexec */


>> +
>> +#define FDT_ALIGN(x, a)        (((x) + (a) - 1) & ~((a) - 1))
>> +#define FDT_TAGALIGN(x)        (FDT_ALIGN((x), FDT_TAGSIZE))
>> +
>> +int fdt_prop_len(const char *prop_name, int len)

In v14, I requested:

   Please rename as fdt_len_added_prop()

I'm not really happy with my suggested name, but do not have a
better one yet.  As Rob notes, maybe David G will have a helpful
comment.


>> +{
>> +       return (strlen(prop_name) + 1) +
>> +               sizeof(struct fdt_property) +
>> +               FDT_TAGALIGN(len);
> 
> Looks like you are using this to calculate how much space you need to
> allocate in addition to the current DTB for a couple of new or
> replaced properties. I'm not sure that this calculation is completely
> accurate. And it is strange there doesn't seem to be any libfdt
> function for this already. It would be simpler to just add some fixed
> additional amount.
> 
> Maybe David G has comments on this?
> 
>> +}
>> +
> 
> The rest of this should go in drivers/of/fdt_address.c. Ultimately, it
> should go into libfdt, but I'm fine with having it in the kernel for
> now.
> 
>> +static void fill_property(void *buf, u64 val64, int cells)

In v14 I requested:

Please rename as cpu64_to_fdt_cells()


>> +{
>> +       __be32 val32;
>> +
>> +       while (cells) {
>> +               val32 = cpu_to_fdt32((val64 >> (32 * (--cells))) & U32_MAX);
>> +               memcpy(buf, &val32, sizeof(val32));
>> +               buf += sizeof(val32);
> 
> This is kind of hard to read. I would copy u-boot's fdt_pack_reg function.
> 
> BTW, for purposes of moving to libfdt, we'll need the authors'
> (Masahiro Yamada and Hans de Goede) permission to dual license.
> 
>> +       }
>> +}
>> +
>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
>> +                                               u64 addr, u64 size)
>> +{
>> +       int addr_cells, size_cells;

unsigned


>> +       char buf[sizeof(__be32) * 2 * 2];
>> +               /* assume dt_root_[addr|size]_cells <= 2 */
>> +       void *prop;
>> +       size_t buf_size;
>> +
>> +       addr_cells = fdt_address_cells(fdt, 0);
>> +       if (addr_cells < 0)
>> +               return addr_cells;
>> +       size_cells = fdt_size_cells(fdt, 0);
>> +       if (size_cells < 0)
>> +               return size_cells;
>> +
>> +       /* if *_cells >= 2, cells can hold 64-bit values anyway */
>> +       if ((addr_cells == 1) && (addr > U32_MAX))
>> +               return -FDT_ERR_BADVALUE;
>> +
>> +       if ((size_cells == 1) && (size > U32_MAX))
>> +               return -FDT_ERR_BADVALUE;

In v14 I requested:

   Should also check that base + size does not wrap around.


>> +
>> +       buf_size = (addr_cells + size_cells) * sizeof(u32);
>> +       prop = buf;
>> +
>> +       fill_property(prop, addr, addr_cells);
>> +       prop += addr_cells * sizeof(u32);
>> +
>> +       fill_property(prop, size, size_cells);
>> +
>> +       return fdt_setprop(fdt, nodeoffset, name, buf, buf_size);
>> +}
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index b9cd9ebdf9b9..842af6ea92ea 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -108,5 +108,9 @@ static inline void unflatten_device_tree(void) {}
>>  static inline void unflatten_and_copy_device_tree(void) {}
>>  #endif /* CONFIG_OF_EARLY_FLATTREE */
>>
>> +int fdt_prop_len(const char *prop_name, int len);
>> +int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
>> +                                               u64 addr, u64 size);
>> +
>>  #endif /* __ASSEMBLY__ */
>>  #endif /* _LINUX_OF_FDT_H */
>> --
>> 2.19.0
>>
> 
