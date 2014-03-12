From: lho@apm.com (Loc Ho)
Date: Wed, 12 Mar 2014 12:01:42 -0700
Subject: [PATCH v16 3/4] ata: Add APM X-Gene SoC AHCI SATA host controller
 driver
In-Reply-To: <2172234.huOH9CEWA3@amdc1032>
References: <1394575895-7039-1-git-send-email-lho@apm.com>
 <1394575895-7039-3-git-send-email-lho@apm.com>
 <1394575895-7039-4-git-send-email-lho@apm.com>
 <2172234.huOH9CEWA3@amdc1032>
Message-ID: <CAPw-ZTmvG1dMckif4xKrv-rg=8jAode0RWgFBjoi_5OXrB2RHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> +MODULE_DEVICE_TABLE(of, xgene_ahci_of_match);
>> +
>> +static struct platform_driver xgene_ahci_driver = {
>> +     .probe = xgene_ahci_probe,
>> +     .remove = ata_platform_remove_one,
>
> It is good to use ata_platform_remove_one() here but some code still needs
> to callback ahci_platform_disable_resources() before the driver is removed
> completely.  The way other drivers do it is to define custom ->host_stop
> method and add it to port ops (xgene_ahci_ops in this case).  For X-Gene
> AHCI driver ->host_stop function can be quite simple and look like this:
>
> static void xgene_ahci_host_stop(struct ata_host *host)
> {
>         struct ahci_host_priv *hpriv = host->private_data;
>
>         ahci_platform_disable_resources(hpriv);
> }

Will do.

>
>> +     .driver = {
>> +             .name = "xgene-ahci",
>> +             .owner = THIS_MODULE,
>> +             .of_match_table = xgene_ahci_of_match,
>> +     },
>
> Power Management support is missing for this driver.  If your platform
> doesn't support Suspend to RAM yet it would be good to add a comment
> about this explaining the lack of PM.  Otherwise it should be fixed (you
> can take a look at ahci_imx.c and ahci_sunxi.c for examples).

In order to support PM, I will need an other errata fix in libachi.c.
For now PM, will NOT be support.

>
> Otherwise the driver looks good to me and (FWIW) you can add:
>
>         Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>
> Once the aforementioned issues are fixed.

I will post another version. If you ack'ed that version, Tejun can add
you to the Reviewed-by list.

-Loc
