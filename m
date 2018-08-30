From: john.garry@huawei.com (John Garry)
Date: Thu, 30 Aug 2018 17:50:53 +0100
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <5eab89c6-c063-cbc2-4d02-459faf87698a@arm.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <5eab89c6-c063-cbc2-4d02-459faf87698a@arm.com>
Message-ID: <6cc3c5e2-3827-a89c-e37b-09728a34f21f@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/2018 17:34, James Morse wrote:

Hi James,

Zhengqiang no longer works on this topic, so I have cc'ed some more guys 
who should be able to help.

John

> Hi Zhengqiang,
>
> On 29/08/18 19:33, Fan Wu wrote:
>> The current ghes_edac driver does not update per-dimm error
>> counters when reporting memory errors, because there is no
>> platform-independent way to find DIMMs based on the error
>> information provided by firmware. This patch offers a solution
>> for platforms whose firmwares provide valid module handles
>> (SMBIOS type 17) in error records. In this case ghes_edac will
>> use the module handles to locate DIMMs and thus makes per-dimm
>> error reporting possible.
>
> Does your platform set CPER_MEM_VALID_MODULE_HANDLE in GHES Memory errors? If
> so, any chance you could test this patch on your platform? [0]
> (original patch: https://lore.kernel.org/patchwork/patch/978928/)
>
> Thanks,
>
> James
>
> [0] https://marc.info/?l=linux-edac&m=152603960002324
>
>
>> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
>> index 473aeec..db527f0 100644
>> --- a/drivers/edac/ghes_edac.c
>> +++ b/drivers/edac/ghes_edac.c
>> @@ -81,6 +81,26 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>>  		(*num_dimm)++;
>>  }
>>
>> +static int ghes_edac_dimm_index(u16 handle)
>> +{
>> +	struct mem_ctl_info *mci;
>> +	int i;
>> +
>> +	if (!ghes_pvt)
>> +		return -1;
>> +
>> +	mci = ghes_pvt->mci;
>> +
>> +	if (!mci)
>> +		return -1;
>> +
>> +	for (i = 0; i < mci->tot_dimms; i++) {
>> +		if (mci->dimms[i]->smbios_handle == handle)
>> +			return i;
>> +	}
>> +	return -1;
>> +}
>> +
>>  static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>>  {
>>  	struct ghes_edac_dimm_fill *dimm_fill = arg;
>> @@ -177,6 +197,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>>  				entry->total_width, entry->data_width);
>>  		}
>>
>> +		dimm->smbios_handle = entry->handle;
>> +
>>  		dimm_fill->count++;
>>  	}
>>  }
>> @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>>  		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
>>  	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
>>  		const char *bank = NULL, *device = NULL;
>> +		int index = -1;
>> +
>>  		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
>> +		p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>> +			     mem_err->mem_dev_handle);
>>  		if (bank != NULL && device != NULL)
>>  			p += sprintf(p, "DIMM location:%s %s ", bank, device);
>> -		else
>> -			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
>> -				     mem_err->mem_dev_handle);
>> +
>> +		index = ghes_edac_dimm_index(mem_err->mem_dev_handle);
>> +		if (index >= 0) {
>> +			e->top_layer = index;
>> +			e->enable_per_layer_report = true;
>> +		}
>> +
>>  	}
>>  	if (p > e->location)
>>  		*(p - 1) = '\0';
>> diff --git a/include/linux/edac.h b/include/linux/edac.h
>> index bffb978..a45ce1f 100644
>> --- a/include/linux/edac.h
>> +++ b/include/linux/edac.h
>> @@ -451,6 +451,8 @@ struct dimm_info {
>>  	u32 nr_pages;			/* number of pages on this dimm */
>>
>>  	unsigned csrow, cschannel;	/* Points to the old API data */
>> +
>> +	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
>>  };
>>
>>  /**
>>
>
>
> .
>
