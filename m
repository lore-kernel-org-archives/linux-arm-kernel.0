From: stripathi@apm.com (Suman Tripathi)
Date: Mon, 1 Feb 2016 11:43:56 -0800
Subject: [PATCH v2 2/3] libahci: Implement the capability to override the
 generic ahci interrupt handler.
In-Reply-To: <20160131113540.GX32380@htj.duckdns.org>
References: <1453888197-11368-1-git-send-email-stripathi@apm.com>
 <1453888197-11368-3-git-send-email-stripathi@apm.com>
 <20160131113540.GX32380@htj.duckdns.org>
Message-ID: <CAOHikRBmZ2Nk5knH7_4X+ieTYN9ubWrEwhTNAvQzq5cxWmLDJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 3:35 AM, Tejun Heo <htejun@gmail.com> wrote:
> On Wed, Jan 27, 2016 at 03:19:56PM +0530, Suman Tripathi wrote:
>> @@ -2466,13 +2467,19 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
>>  {
>>       struct ahci_host_priv *hpriv = host->private_data;
>>       int irq = hpriv->irq;
>> +     irqreturn_t (*ahci_irq_handler)(int irq, void *dev_instance);
>>       int rc;
>>
>>       if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX))
>>               rc = ahci_host_activate_multi_irqs(host, sht);
>
> You need to add { } to the if body too.  Please read CodingStyle.
>
>> -     else
>> -             rc = ata_host_activate(host, irq, ahci_single_level_irq_intr,
>> +     else {
>> +             ahci_irq_handler = hpriv->ahci_irq_intr ? hpriv->ahci_irq_intr :
>> +                                ahci_single_level_irq_intr;
>> +
>> +             rc = ata_host_activate(host, irq, ahci_irq_handler,
>>                                      IRQF_SHARED, sht);
>> +     }
>
> Can you please make this handled the same way as ->start_engine?
> Also, maybe print out a warning message if a driver specifies both
> AHCI_HFLAG_MULTI_MSI[X] and the irq handler override?

Ok Sure
>
> Thanks.
>
> --
> tejun



-- 
Thanks,
with regards,
Suman Tripathi
