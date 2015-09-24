From: lho@apm.com (Loc Ho)
Date: Thu, 24 Sep 2015 10:01:46 -0700
Subject: [PATCH v5 2/4] edac: Add L3 EDAC support to the APM X-Gene SoC
 EDAC driver
In-Reply-To: <20150924112512.GB3774@pd.tnic>
References: <1443055261-8613-1-git-send-email-lho@apm.com>
 <1443055261-8613-3-git-send-email-lho@apm.com>
 <20150924112512.GB3774@pd.tnic>
Message-ID: <CAPw-ZT==R-YwO3fedqqDLPNCPAageogqOaXdo4_B4SK9i02d5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> Add EDAC support for the L3 component.
>>
>> Signed-off-by: Loc Ho <lho@apm.com>
>> ---
>>  drivers/edac/xgene_edac.c |  669 ++++++++++++++++++++++++++++++++-------------
>>  1 files changed, 474 insertions(+), 195 deletions(-)
>
> ...
>
>> @@ -878,25 +869,16 @@ static const struct file_operations xgene_edac_pmd_debug_inject_fops[] = {
>>       { }
>>  };
>>
>> -static void xgene_edac_pmd_create_debugfs_nodes(
>> -     struct edac_device_ctl_info *edac_dev)
>> +static void
>> +xgene_edac_pmd_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
>>  {
>>       struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
>>       struct dentry *dbgfs_dir;
>> -     char name[30];
>> +     char name[10];
>
> So somehow we don't seem to understand each other. This char name[10] on
> the stack thing has a bunch of problems:
>
> 1. It is on the stack so it contains random garbage.
>
>>
>> -     if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
>> +     if (!IS_ENABLED(CONFIG_EDAC_DEBUG) || !ctx->edac->dfs)
>>               return;
>>
>> -     /*
>> -      * Todo: Switch to common EDAC debug file system for edac device
>> -      *       when available.
>> -      */
>> -     if (!ctx->edac->dfs) {
>> -             ctx->edac->dfs = edac_debugfs_create_dir(edac_dev->dev->kobj.name);
>> -             if (!ctx->edac->dfs)
>> -                     return;
>> -     }
>>       sprintf(name, "PMD%d", ctx->pmd);
>
> 2. You're sprintf-ing into it without checking its length. This can
> possibly write past the end if %d is big enough. I know, I know, %d
> is only small numbers but that assurance not good enough. You need
> snprintf() and check the ctx->pmd width for sane numbers only anyway.
>
> And debugfs goes and does strlen() on it which could lead to all kinds
> of funky stuff later.
>
> Please fix that in all its occurrences in this patchset.

Okay... Got it and will post another version using snprintf. Did you
also reviewed the SoC patch as well?

-Loc
