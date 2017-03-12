From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 12 Mar 2017 20:53:57 +0300
Subject: [PATCH 1/3] ata: add Palmchip BK3710 PATA controller driver
In-Reply-To: <c30eeadf-c4f3-3d35-9b2f-abc9eed3e4e8@cogentembedded.com>
References: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170309130216epcas5p276d211cfa5ed9f87b11a73ebe6fcdc7c@epcas5p2.samsung.com>
 <1489064496-6270-2-git-send-email-b.zolnierkie@samsung.com>
 <c30eeadf-c4f3-3d35-9b2f-abc9eed3e4e8@cogentembedded.com>
Message-ID: <5aa862b6-d029-bbb5-c5a2-a1c9f87e7f0b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2017 08:28 PM, Sergei Shtylyov wrote:

>> +static void pata_bk3710_set_piomode(struct ata_port *ap,
>> +                    struct ata_device *adev)
>> +{
>> +    void __iomem *base = (void __iomem *)ap->ioaddr.bmdma_addr;
>> +    struct ata_device *pair = ata_dev_pair(adev);
>> +    const struct ata_timing *t = ata_timing_find_mode(adev->pio_mode);
>> +    const u16 *id = adev->id;
>> +    unsigned int cycle_time;
>> +    int is_slave = adev->devno;
>> +    const u8 pio = adev->pio_mode - XFER_PIO_0;
>> +
>> +    if (id[ATA_ID_FIELD_VALID] & 2) {
>> +        if (ata_id_has_iordy(id))
>> +            cycle_time = id[ATA_ID_EIDE_PIO_IORDY];
>> +        else
>> +            cycle_time = id[ATA_ID_EIDE_PIO];
>> +
>> +        /* conservative "downgrade" for all pre-ATA2 drives */
>> +        if (pio < 3 && cycle_time < t->cycle)
>> +            cycle_time = 0; /* use standard timing */
>> +    }
>> +
>> +    if (!cycle_time)
>> +        cycle_time = t->cycle;
>
>    This seems like a helper needed by libata in general but OK...

    No, the build bot had already reported the problem with 'cycle_time' here, 
I just forgot about it.

[...]
>
>    Well, no serious issues found, so you can stamp:
>
> Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Too early, it seems... :-)

MBR, Sergei
