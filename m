From: stripathi@amperecomputing.com (Suman Tripathi)
Date: Thu, 6 Sep 2018 20:08:19 +0000
Subject: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing
 eMAG SATA
In-Reply-To: <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
References: <1536257111-27948-1-git-send-email-stripathi@amperecomputing.com>
 <d3682fff-473f-021a-c805-466030b7644e@redhat.com>
Message-ID: <MWHPR01MB2336EE4B6E4923C9ED851F20B3010@MWHPR01MB2336.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,


With regards,
Suman



-----Original Message-----
From: Hans de Goede <hdegoede@redhat.com> 
Sent: Thursday, September 6, 2018 1:06 PM
To: Suman Tripathi <stripathi@amperecomputing.com>; axboe at kernel.dk; tj at kernel.org; linux-ide at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; joe at perches.com; arnd at arndb.de; gregkh at linuxfoundation.org
Cc: Open Source Submission <patches@amperecomputing.com>; Rameshwar Sahu <Rameshwar.Sahu@amperecomputing.com>
Subject: Re: [PATCH v3] ata: Disable AHCI ALPM feature for Ampere Computing eMAG SATA

[NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.] ________________________________________________________________________________________________________________________

Hi,

On 06-09-18 20:05, Suman Tripathi wrote:
> Due to hardware errata, Ampere Computing eMAG SATA can't support AHCI 
> ALPM feature. This patch disables the AHCI ALPM feature for eMAG SATA.
>
> Signed-off-by: Suman Trpathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu 
> <rameshwar.sahu@amperecomputing.com>

Sorry, but the patch is still coming through mangled. Did you use git send-email ?
[Suman Tripathi] yes. I rechecked before sending twice. Sorry for the inconvenience. Will figure the issue out

Regards,

Hans




>
> ---
> Changes for v3:
>
> * Fix the indentation and whitespace warnings.
>
> Changes for v2:
>
> * Introduce the new ata_port_info object which includes ATA_FLAG_NO_LPM.
> * Include this object for eMAG SATA inside the acpi match table.
> * Retrieve the ata_port_info from the acpi match table.
>
> ---
>   drivers/ata/ahci_platform.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c 
> index 99f9a89..9ba283f 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -33,6 +33,13 @@ static const struct ata_port_info ahci_port_info = {
>       .port_ops       = &ahci_platform_ops,
>   };
>
> +static const struct ata_port_info ahci_port_info_nolpm = {
> +     .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
> +     .pio_mask       = ATA_PIO4,
> +     .udma_mask      = ATA_UDMA6,
> +     .port_ops       = &ahci_platform_ops,
> +};
> +
>   static struct scsi_host_template ahci_platform_sht = {
>       AHCI_SHT(DRV_NAME),
>   };
> @@ -41,6 +48,7 @@ static int ahci_probe(struct platform_device *pdev)
>   {
>       struct device *dev = &pdev->dev;
>       struct ahci_host_priv *hpriv;
> +     const struct ata_port_info *port;
>       int rc;
>
>       hpriv = ahci_platform_get_resources(pdev);
> @@ -57,7 +65,11 @@ static int ahci_probe(struct platform_device *pdev)
>       if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>               hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>
> -     rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
> +     port = acpi_device_get_match_data(dev);
> +     if (!port)
> +             port = &ahci_port_info;
> +
> +     rc = ahci_platform_init_host(pdev, hpriv, port,
>                                    &ahci_platform_sht);
>       if (rc)
>               goto disable_resources;
> @@ -85,6 +97,7 @@ static const struct of_device_id ahci_of_match[] = {
>   MODULE_DEVICE_TABLE(of, ahci_of_match);
>
>   static const struct acpi_device_id ahci_acpi_match[] = {
> +     { "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
>       { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
>       {},
>   };
> --
> 2.7.4
>
