From: wufan@codeaurora.org (wufan)
Date: Thu, 30 Aug 2018 08:40:40 -0600
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
Message-ID: <000f01d4406f$6ce8f160$46bad420$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

> > The current ghes_edac driver does not update per-dimm error counters
> > when reporting memory errors, because there is no platform-independent
> > way to find DIMMs based on the error information provided by firmware.
> 
> I'd argue there is: its in the CPER records, we just didn't do anything useful
> with the information in the past!

Agreed. Will update the wording. 
 
> > +static int ghes_edac_dimm_index(u16 handle) {
> > +	struct mem_ctl_info *mci;
> > +	int i;
> > +
> > +	if (!ghes_pvt)
> > +		return -1;
> 
> ghes_edac_report_mem_error() already checked this, as its the only caller
> there is no need to check it again.

Will remove.
 
> 
> > +	mci = ghes_pvt->mci;
> > +
> > +	if (!mci)
> > +		return -1;
> 
> Can this happen? ghes_edac_report_mem_error() would have
> dereferenced this already!
> 
> If you need the struct mem_ctl_info, you may as well pass it in as the only
> caller has it to hand.

Will remove.
> 
> > +
> > +	for (i = 0; i < mci->tot_dimms; i++) {
> > +		if (mci->dimms[i]->smbios_handle == handle)
> > +			return i;
> > +	}
> > +	return -1;
> > +}
> > +
> >  static void ghes_edac_dmidecode(const struct dmi_header *dh, void
> > *arg)  {
> >  	struct ghes_edac_dimm_fill *dimm_fill = arg; @@ -177,6 +197,8 @@
> > static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
> >  				entry->total_width, entry->data_width);
> >  		}
> >
> > +		dimm->smbios_handle = entry->handle;
> 
> We aren't checking for duplicate handles, (e.g. they're all zero). I think this is
> fine as chances are firmware on those systems won't set
> CPER_MEM_VALID_MODULE_HANDLE. If it does, the handle it gives us is
> ambiguous, and we pick a dimm, instead of whine-ing about broken
> firmware tables.
> 
> (I'm just drawing attention to it in case someone disagrees)

SBMIOS tables are typically automatically generated so chances for duplicate
handles are small. 

> 
> >  		dimm_fill->count++;
> >  	}
> >  }
> > @@ -327,12 +349,20 @@ void ghes_edac_report_mem_error(int sev,
> struct cper_sec_mem_err *mem_err)
> >  		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
> >  	if (mem_err->validation_bits &
> CPER_MEM_VALID_MODULE_HANDLE) {
> >  		const char *bank = NULL, *device = NULL;
> > +		int index = -1;
> > +
> >  		dmi_memdev_name(mem_err->mem_dev_handle, &bank,
> &device);
> 
> > +		p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
> > +			     mem_err->mem_dev_handle);
> >  		if (bank != NULL && device != NULL)
> >  			p += sprintf(p, "DIMM location:%s %s ", bank, device);
> > -		else
> > -			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
> > -				     mem_err->mem_dev_handle);
> 
> Why do we now print the handle every time? The handle is pretty
> meaningless, it can only be used to find the location-strings, if we get those
> we print them instead.

For ghes_edac the bank/device is informational, and nothing would go wrong
if the bank/device numbers are the same as another entry. But the handle
is now critical for DIMM lookup, thus pull it out.

Thanks!
Fan
