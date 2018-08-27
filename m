From: stripathi@amperecomputing.com (Suman Tripathi)
Date: Mon, 27 Aug 2018 19:13:08 +0000
Subject: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG
 SATA
In-Reply-To: <d3cef828-6c18-f061-0fe8-1579bcf602c5@redhat.com>
References: <1535395673-30649-1-git-send-email-stripathi@amperecomputing.com>
 <d3cef828-6c18-f061-0fe8-1579bcf602c5@redhat.com>
Message-ID: <MWHPR01MB23360AA3459B7502DE5D5F4BB30B0@MWHPR01MB2336.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans

Thanks for your fast response.

With regards,
Suman

Please note my new email address ? stripathi at amperecomputing.com

-----Original Message-----
From: Hans de Goede <hdegoede@redhat.com> 
Sent: Monday, August 27, 2018 12:09 PM
To: Suman Tripathi <stripathi@amperecomputing.com>; tj at kernel.org; linux-ide at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; joe at perches.com; arnd at arndb.de; gregkh at linuxfoundation.org
Cc: Open Source Submission <patches@amperecomputing.com>; Rameshwar P Sahu <Rameshwar.Sahu@amperecomputing.com>; Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA

[NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.] ________________________________________________________________________________________________________________________

Hi,

On 27-08-18 20:47, Suman Tripathi wrote:
> Due to hardware errata, Ampere Computing eMAG SATA can't support AHCI 
> ALPM feature. This patch disables the AHCI ALPM feature for eMAG SATA.
>
> Signed-off-by: Suman Tripathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu 
> <rameshwar.sahu@amperecomputing.com>

Thank you for the patch. 2 remarks:

1) The ata code is maintained by Jens Axboe (added to the Cc) now, this is a very recent change, which still has to hit MAINTAINERS
[Suman Tripathi] Didn't still see him for libata subsystem. Surely will fix the comments cc him for the next version. I see him in the scsi subsystem.

2) See below


> ---
>   drivers/ata/ahci_platform.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c 
> index 99f9a89..0d0233e 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -26,7 +26,7 @@
>
>   #define DRV_NAME "ahci"
>
> -static const struct ata_port_info ahci_port_info = {
> +static struct ata_port_info ahci_port_info = {
>       .flags          = AHCI_FLAG_COMMON,
>       .pio_mask       = ATA_PIO4,
>       .udma_mask      = ATA_UDMA6,

Please do not remove const here, if you need to make a shared info struct like this non const you are usually doing something wrong (see below).

> @@ -41,6 +41,8 @@ static int ahci_probe(struct platform_device *pdev)
>   {
>       struct device *dev = &pdev->dev;
>       struct ahci_host_priv *hpriv;
> +     struct acpi_device_info *info;
> +     acpi_status status;
>       int rc;
>
>       hpriv = ahci_platform_get_resources(pdev);
> @@ -57,6 +59,15 @@ static int ahci_probe(struct platform_device *pdev)
>       if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>               hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>
> +     status = acpi_get_object_info(ACPI_HANDLE(dev), &info);
> +     if (ACPI_SUCCESS(status)) {
> +             if (info->valid & ACPI_VALID_HID) {
> +                     if (!strcmp("APMC0D33", info->hardware_id.string))
> +                             ahci_port_info.flags |= ATA_FLAG_NO_LPM;
> +             }
> +             ACPI_FREE(info);
> +     }
> +
>       rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
>                                    &ahci_platform_sht);
>       if (rc)

The normal way to get specific behavior for a specific ACPI HID is to put the HID in the ahci_acpi_match table and use the acpi_device_id field to pass some flags (or a pointer).
[Suman Tripathi] Agree on this.

So the proper way to fix this is to do something like this:

1) Add:

static const struct ata_port_info ahci_port_info_nolpm = {
         .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
         .pio_mask       = ATA_PIO4,
         .udma_mask      = ATA_UDMA6,
         .port_ops       = &ahci_platform_ops,
};

2) Modify ahci_acpi_match table to:

static const struct acpi_device_id ahci_acpi_match[] = {
        { "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
         { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
         {},
};

3) In ahci_probe() do:

        const struct ata_port_info *port;

        ...

        port = acpi_device_get_match_data(dev);
        if (!port)
                port = &ahci_port_info;

        rc = ahci_platform_init_host(pdev, hpriv, port, &ahci_platform_sht);


Regards,

Hans
