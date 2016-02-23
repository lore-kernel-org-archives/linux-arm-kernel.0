From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 23 Feb 2016 19:13:29 +0800
Subject: [PATCH v4 16/17] FDT: Add a helper to get specified name subnode
In-Reply-To: <CAL_JsqK8F6PQX2kC_+CtDk1-ykKRB3YB54o4FaypsRY_tNzK5w@mail.gmail.com>
References: <1454641552-12576-1-git-send-email-zhaoshenglong@huawei.com>
 <1454641552-12576-17-git-send-email-zhaoshenglong@huawei.com>
 <CAL_JsqK8F6PQX2kC_+CtDk1-ykKRB3YB54o4FaypsRY_tNzK5w@mail.gmail.com>
Message-ID: <56CC3ED9.5000101@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/2/9 13:04, Rob Herring wrote:
> On Thu, Feb 4, 2016 at 9:05 PM, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> Sometimes it needs to check if there is a node in FDT by full path.
> 
> I'm confused. Are you searching by full path or...
> 
>> Introduce this helper to get the specified name subnode if it exists.
> 
> name of sub node?
> 
get the offset of sub node by specified name.

> Either way, fdt_subnode_offset or fdt_path_offset doesn't work?
> 
Ah?right?both of them should work. Does it need to add a wrapper in
drivers/of/fdt.c for them or directly use them with the parameter
initial_boot_params?

Thanks,
>>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>> CC: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/of/fdt.c       | 25 +++++++++++++++++++++++++
>>  include/linux/of_fdt.h |  2 ++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 655f79d..eacb188 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -645,6 +645,31 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
>>  }
>>
>>  /**
>> + * of_get_flat_dt_subnode_by_name - get subnode of specified node by name
>> + *
>> + * @node: the parent node
>> + * @uname: the name of subnode
>> + * @return offset of the subnode, or -FDT_ERR_NOTFOUND if there is none
>> + */
>> +
>> +int of_get_flat_dt_subnode_by_name(unsigned long node, const char *uname)
>> +{
>> +       const void *blob = initial_boot_params;
>> +       int offset;
>> +       const char *pathp;
>> +
>> +       for (offset = fdt_first_subnode(blob, node);
>> +            offset >= 0;
>> +            offset = fdt_next_subnode(blob, offset)) {
>> +               pathp = fdt_get_name(blob, offset, NULL);
>> +               if (strcmp(pathp, uname) == 0)
>> +                       return offset;
>> +       }
>> +
>> +       return -FDT_ERR_NOTFOUND;
>> +}
>> +
>> +/**
>>   * of_get_flat_dt_root - find the root node in the flat blob
>>   */
>>  unsigned long __init of_get_flat_dt_root(void)
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index df9ef38..fc28162 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -52,6 +52,8 @@ extern char __dtb_end[];
>>  extern int of_scan_flat_dt(int (*it)(unsigned long node, const char *uname,
>>                                      int depth, void *data),
>>                            void *data);
>> +extern int of_get_flat_dt_subnode_by_name(unsigned long node,
>> +                                         const char *uname);
>>  extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
>>                                        int *size);
>>  extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
>> --
>> 2.0.4
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 

-- 
Shannon
