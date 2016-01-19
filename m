From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Tue, 19 Jan 2016 21:19:05 +0800
Subject: [Xen-devel] [PATCH v2 14/16] Xen: EFI: Parse DT parameters for
 Xen specific UEFI
In-Reply-To: <alpine.DEB.2.02.1601181533010.16178@kaball.uk.xensource.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-15-git-send-email-zhaoshenglong@huawei.com>
 <alpine.DEB.2.02.1601181533010.16178@kaball.uk.xensource.com>
Message-ID: <569E37C9.6040700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/1/18 23:41, Stefano Stabellini wrote:
> CC'ing Matt Fleming
>
> On Fri, 15 Jan 2016, Shannon Zhao wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> Add a new function to parse DT parameters for Xen specific UEFI just
>> like the way for normal UEFI. Then it could reuse the existing codes.
>>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>
> Please CC the maintainers, use ./scripts/get_maintainer.pl to find out
> who they are.
>
>
>>   drivers/firmware/efi/efi.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 38 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
>> index 027ca21..2dbc2ac 100644
>> --- a/drivers/firmware/efi/efi.c
>> +++ b/drivers/firmware/efi/efi.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/of_fdt.h>
>>   #include <linux/io.h>
>>   #include <linux/platform_device.h>
>> +#include <xen/xen.h>
>>
>>   struct efi __read_mostly efi = {
>>   	.mps			= EFI_INVALID_TABLE_ADDR,
>> @@ -498,12 +499,14 @@ device_initcall(efi_load_efivars);
>>   		FIELD_SIZEOF(struct efi_fdt_params, field) \
>>   	}
>>
>> -static __initdata struct {
>> +struct params {
>>   	const char name[32];
>>   	const char propname[32];
>>   	int offset;
>>   	int size;
>> -} dt_params[] = {
>> +};
>> +
>> +static struct params fdt_params[] __initdata = {
>>   	UEFI_PARAM("System Table", "linux,uefi-system-table", system_table),
>>   	UEFI_PARAM("MemMap Address", "linux,uefi-mmap-start", mmap),
>>   	UEFI_PARAM("MemMap Size", "linux,uefi-mmap-size", mmap_size),
>> @@ -511,6 +514,14 @@ static __initdata struct {
>>   	UEFI_PARAM("MemMap Desc. Version", "linux,uefi-mmap-desc-ver", desc_ver)
>>   };
>>
>> +static struct params xen_fdt_params[] __initdata = {
>> +	UEFI_PARAM("System Table", "xen,uefi-system-table", system_table),
>> +	UEFI_PARAM("MemMap Address", "xen,uefi-mmap-start", mmap),
>> +	UEFI_PARAM("MemMap Size", "xen,uefi-mmap-size", mmap_size),
>> +	UEFI_PARAM("MemMap Desc. Size", "xen,uefi-mmap-desc-size", desc_size),
>> +	UEFI_PARAM("MemMap Desc. Version", "xen,uefi-mmap-desc-ver", desc_ver)
>> +};
>> +
>>   struct param_info {
>>   	int found;
>>   	void *params;
>> @@ -520,15 +531,28 @@ static int __init fdt_find_uefi_params(unsigned long node, const char *uname,
>>   				       int depth, void *data)
>>   {
>>   	struct param_info *info = data;
>> +	struct params *dt_params;
>> +	unsigned int size;
>>   	const void *prop;
>>   	void *dest;
>>   	u64 val;
>>   	int i, len;
>>
>> -	if (depth != 1 || strcmp(uname, "chosen") != 0)
>> -		return 0;
>> +	if (efi_enabled(EFI_PARAVIRT)) {
>> +		if (depth != 2 || strcmp(uname, "uefi") != 0)
>
> You are already introducing this check in the previous patch when
> setting EFI_PARAVIRT, why do this again now?  But if we need to do this
> check again, then, like Mark suggested, it should be done against the
> full path.
>
This check just wants to confirm that the current node is the "uefi" 
node and we can parse it with xen_fdt_params now.

> Also you added below to efi_get_fdt_params:
>
> 	if (efi_enabled(EFI_PARAVIRT))
> 		dt_params = xen_fdt_params;
> 	else
> 		dt_params = fdt_params;
>
> efi_get_fdt_params is the sole caller of fdt_find_uefi_params: it makes
> sense to set dt_params only once, then pass it to fdt_find_uefi_params
> as parameter.
>
Sure.
>
>> +			return 0;
>>
>> -	for (i = 0; i < ARRAY_SIZE(dt_params); i++) {
>> +		dt_params = xen_fdt_params;
>> +		size = ARRAY_SIZE(xen_fdt_params);
>> +	} else {
>> +		if (depth != 1 || strcmp(uname, "chosen") != 0)
>> +			return 0;
>> +
>> +		dt_params = fdt_params;
>> +		size = ARRAY_SIZE(fdt_params);
>> +	}
>> +
>> +	for (i = 0; i < size; i++) {
>>   		prop = of_get_flat_dt_prop(node, dt_params[i].propname, &len);
>>   		if (!prop)
>>   			return 0;
>> @@ -552,6 +576,7 @@ static int __init fdt_find_uefi_params(unsigned long node, const char *uname,
>>   int __init efi_get_fdt_params(struct efi_fdt_params *params)
>>   {
>>   	struct param_info info;
>> +	struct params *dt_params;
>>   	int ret;
>>
>>   	pr_info("Getting EFI parameters from FDT:\n");
>> @@ -559,12 +584,18 @@ int __init efi_get_fdt_params(struct efi_fdt_params *params)
>>   	info.found = 0;
>>   	info.params = params;
>>
>> +	if (efi_enabled(EFI_PARAVIRT))
>> +		dt_params = xen_fdt_params;
>> +	else
>> +		dt_params = fdt_params;
>> +
>>   	ret = of_scan_flat_dt(fdt_find_uefi_params, &info);
>> -	if (!info.found)
>> +	if (!info.found) {
>>   		pr_info("UEFI not found.\n");
>> -	else if (!ret)
>> +	} else if (!ret) {
>>   		pr_err("Can't find '%s' in device tree!\n",
>>   		       dt_params[info.found].name);
>> +	}
>>
>>   	return ret;
>>   }
>> --
>> 2.0.4
>>
>>
>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel at lists.xen.org
>> http://lists.xen.org/xen-devel
>>

-- 
Shannon
