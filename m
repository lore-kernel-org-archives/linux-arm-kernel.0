From: dhdang@apm.com (Duc Dang)
Date: Tue, 28 Jun 2016 09:12:55 -0700
Subject: [RFC PATCH v4 3/5] PCI: Check platform specific ECAM quirks
In-Reply-To: <577275EA.7010002@codeaurora.org>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
 <1467100442-28078-4-git-send-email-tn@semihalf.com>
 <577275EA.7010002@codeaurora.org>
Message-ID: <CADaLNDkhPZuG7UJ4SK_j5v_nXbd782Q17LAcXduG0uEObaFF=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 6:04 AM, Christopher Covington
<cov@codeaurora.org> wrote:
> Hi Tomasz,
>
> On 06/28/2016 03:54 AM, Tomasz Nowicki wrote:
>
>> diff --git a/drivers/pci/host/mcfg-quirks.c b/drivers/pci/host/mcfg-quirks.c
>> new file mode 100644
>> index 0000000..fb2b184
>> --- /dev/null
>> +++ b/drivers/pci/host/mcfg-quirks.c
>> @@ -0,0 +1,88 @@
>
>> +static bool pci_mcfg_fixup_match(struct pci_cfg_fixup *f,
>> +                              struct acpi_table_header *mcfg_header)
>> +{
>> +     int olen = min_t(u8, strlen(f->oem_id), ACPI_OEM_ID_SIZE);
>> +     int tlen = min_t(u8, strlen(f->oem_table_id), ACPI_OEM_TABLE_ID_SIZE);
>> +
>> +     return (!strncmp(f->oem_id, mcfg_header->oem_id, olen) &&
>> +             !strncmp(f->oem_table_id, mcfg_header->oem_table_id, tlen) &&
>> +             f->oem_revision == mcfg_header->oem_revision);
>> +}
>
> Ard's comments on v3 included:
>
> "... exact OEM table/rev id matches ..."
> "... substring match ... out of the question ..."
>
> I originally advocated the substring match approach because
> space-padding the input strings was unfamiliar. But given that some
> vendors have a "PLAT    " then "PLAT2   " naming scheme, where the
> former needs quirks and the latter (hopefully) doesn't, I agree with Ard
> and think space-padded inputs is the better way to go. Sorry for the
> lack of foresight.

I think having OEM Table ID as "PLAT   " and then "PLAT2  " (the the
next version of the SoC)
is common. So yes, matching full string is better as we can use "PLAT2  "
in MCFG table and not worry about the "PLAT" sub-string match causes the quirk
to be applied unintentionally.

>
> (I'm happy to rip it out, test, and communicate the delta however you'd
> prefer--just let me know.)
>
> Regards,
> Cov
>
> --
> Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
Regards,
Duc Dang.
