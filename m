From: lho@apm.com (Loc Ho)
Date: Fri, 23 May 2014 09:26:12 -0700
Subject: [PATCH 3/4] edac: Add APM X-Gene SoC EDAC driver
In-Reply-To: <20140520193930.GA23070@pd.tnic>
References: <1399590199-12256-1-git-send-email-lho@apm.com>
 <1399590199-12256-2-git-send-email-lho@apm.com>
 <1399590199-12256-3-git-send-email-lho@apm.com>
 <1399590199-12256-4-git-send-email-lho@apm.com>
 <20140520193930.GA23070@pd.tnic>
Message-ID: <CAPw-ZTkOYhWT_5QFJvGBM-aHOOH-1cqsMgnhOVEirRdG9FEosw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> +static int xgene_edac_mc_is_active(struct xgene_edac_mc_ctx *ctx, int mc_idx)
>> +{
>> +     u32 reg;
>> +     u32 mcu_mask;
>> +
>> +     reg = readl(ctx->csw_csr + CSW_CSWCR);
>> +     if (reg & CSW_CSWCR_DUALMCB_MASK) {
>> +             /*
>> +              * Dual MCB active - Determine if all 4 activie or just MCU0
>
> Spellcheck: "activie"

The proper spelling is "active" from online dictionary.

>> +     ctx = mci->pvt_info;
>> +     ctx->name = "xgene_edac_mc_err";
>> +     mci->pdev = &pdev->dev;
>> +     dev_set_drvdata(mci->pdev, mci);
>> +     mci->ctl_name = ctx->name;
>> +     mci->dev_name = ctx->name;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     ctx->pcp_csr = devm_ioremap(&pdev->dev, res->start,
>> +                                 resource_size(res));
>> +     if (IS_ERR(ctx->pcp_csr)) {
>> +             dev_err(&pdev->dev, "no PCP resource address\n");
>
> edac_printk(KERN_ERR, "X-Gene", ... Ditto for all other dev_err calls.

Are you sure about this? With dev_err, it prints the device node info
as well. This allows one to determine which instance that has issue.
X-Gene has 4 instance of memory controllers.

>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
>> +     ctx->mcu_csr = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(ctx->mcu_csr)) {
>> +             dev_err(&pdev->dev, "no MCU resource address\n");
>> +             rc = PTR_ERR(ctx->mcu_csr);
>> +             goto err_free;
>> +     }
>> +     /* Ignore non-active MCU */
>> +     if (!xgene_edac_mc_is_active(ctx, ((res->start >> 16) & 0xF) / 4)) {
>> +             rc = -ENODEV;
>> +             goto err_free;
>> +     }
>
> You could move edac_mc_alloc() here, after the resources have been
> collected successfully and simplify the unwinding path.

I need the ctx pointer which is part of the edac_mc_alloc. Can't move it here.

-Loc
