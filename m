From: james.morse@arm.com (James Morse)
Date: Thu, 30 Aug 2018 11:48:16 +0100
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
Message-ID: <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fan,

On 29/08/18 19:33, Fan Wu wrote:
> The current ghes_edac driver does not update per-dimm error
> counters when reporting memory errors, because there is no
> platform-independent way to find DIMMs based on the error
> information provided by firmware.

I'd argue there is: its in the CPER records, we just didn't do anything useful
with the information in the past!


> This patch offers a solution
> for platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records. In this case ghes_edac will
> use the module handles to locate DIMMs and thus makes per-dimm
> error reporting possible.


> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 473aeec..db527f0 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -81,6 +81,26 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>  		(*num_dimm)++;
>  }
>  
> +static int ghes_edac_dimm_index(u16 handle)
> +{
> +	struct mem_ctl_info *mci;
> +	int i;
> +
> +	if (!ghes_pvt)
> +		return -1;

ghes_edac_report_mem_error() already checked this, as its the only caller there
is no need to check it again.


> +	mci = ghes_pvt->mci;
> +
> +	if (!mci)
> +		return -1;

Can this happen? ghes_edac_report_mem_error() would have dereferenced this already!

If you need the struct mem_ctl_info, you may as well pass it in as the only
caller has it to hand.


> +
> +	for (i = 0; i < mci->tot_dimms; i++) {
> +		if (mci->dimms[i]->smbios_handle == handle)
> +			return i;
> +	}
> +	return -1;
> +}
> +
>  static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  {
>  	struct ghes_edac_dimm_fill *dimm_fill = arg;
> @@ -177,6 +197,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  				entry->total_width, entry->data_width);
>  		}
>  
> +		dimm->smbios_handle = entry->handle;

We aren't checking for duplicate handles, (e.g. they're all zero). I think this
is fine as chances are firmware on those systems won't set
CPER_MEM_VALID_MODULE_HANDLE. If it does, the handle it gives us is ambiguous,
and we pick a dimm, instead of whine-ing about broken firmware tables.

(I'm just drawing attention to it in case someone disagrees)


>  		dimm_fill->count++;
>  	}
>  }
> @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
>  	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
>  		const char *bank = NULL, *device = NULL;
> +		int index = -1;
> +
>  		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);

> +		p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
> +			     mem_err->mem_dev_handle);
>  		if (bank != NULL && device != NULL)
>  			p += sprintf(p, "DIMM location:%s %s ", bank, device);
> -		else
> -			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
> -				     mem_err->mem_dev_handle);

Why do we now print the handle every time? The handle is pretty meaningless, it
can only be used to find the location-strings, if we get those we print them
instead.


> +		index = ghes_edac_dimm_index(mem_err->mem_dev_handle);
> +		if (index >= 0) {
> +			e->top_layer = index;
> +			e->enable_per_layer_report = true;
> +		}
> +
>  	}
>  	if (p > e->location)
>  		*(p - 1) = '\0';

Looks good to me!


Thanks,

James
