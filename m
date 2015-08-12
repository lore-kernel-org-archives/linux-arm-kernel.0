From: lho@apm.com (Loc Ho)
Date: Wed, 12 Aug 2015 10:50:52 -0700
Subject: [PATCH v3 3/4] edac: Add L3/SoC EDAC support to the APM X-Gene
 SoC EDAC driver
In-Reply-To: <20150812105121.GE14011@nazgul.tnic>
References: <1439326077-25507-1-git-send-email-lho@apm.com>
 <1439326077-25507-2-git-send-email-lho@apm.com>
 <1439326077-25507-3-git-send-email-lho@apm.com>
 <1439326077-25507-4-git-send-email-lho@apm.com>
 <20150812105121.GE14011@nazgul.tnic>
Message-ID: <CAPw-ZTkRytHUsUsDmTkfzzTYbcZnmTVRMkzNzg_9ZpdQH76rZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

>> ---
>>  drivers/edac/xgene_edac.c |  827 ++++++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 815 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
>> index ba06904..d5e33bf 100644
>> --- a/drivers/edac/xgene_edac.c
>> +++ b/drivers/edac/xgene_edac.c
>> @@ -66,6 +66,8 @@ struct xgene_edac {
>>
>>       struct list_head        mcus;
>>       struct list_head        pmds;
>> +     struct list_head        l3s;
>> +     struct list_head        socs;
>>
>>       struct mutex            mc_lock;
>>       int                     mc_active_mask;
>> @@ -877,8 +879,8 @@ static const struct file_operations xgene_edac_pmd_debug_inject_fops[] = {
>>       { }
>>  };
>>
>> -static void xgene_edac_pmd_create_debugfs_nodes(
>> -     struct edac_device_ctl_info *edac_dev)
>> +static void
>> +xgene_edac_pmd_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
>>  {
>>       struct xgene_edac_pmd_ctx *ctx = edac_dev->pvt_info;
>>       struct dentry *edac_debugfs;
>> @@ -887,10 +889,6 @@ static void xgene_edac_pmd_create_debugfs_nodes(
>>       if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
>>               return;
>>
>> -     /*
>> -      * Todo: Switch to common EDAC debug file system for edac device
>> -      *       when available.
>> -      */
>>       if (!ctx->edac->dfs) {
>>               ctx->edac->dfs = debugfs_create_dir(edac_dev->dev->kobj.name,
>>                                                   NULL);
>
> Why is this removing only the comment and not the debugfs_create_dir()
> and the rest of the gunk?

I intentional left this code as is so that the driver will still works
with older version of the EDAC code. Since you don't want this, I will
get rip of this.

>
> xgene_edac_l3_create_debugfs_nodes() does call debugfs_create_dir()
> creating a top-level edac debugfs node too. Why?

Each subnode will create an folder under the edac debug fs. It is no
different than the EDAC MC debug file system. You will see:

/sys/kernel/debug/edac/mc0, ..
/sys/kernel/debug/edac/mc2
/sys/kernel/debug/edac/pmd0, ...
/sys/kernel/debug/edac/pmd3
/sys/kernel/debug/edac/l3c4

>
> Please go through the previous comments I had and make sure you've
> incorporated them all. I'm not wasting time reviewing half-baked stuff.

As for your comments from previous v2 email:

>> +static void xgene_edac_l3_hw_init(struct edac_device_ctl_info *edac_dev,
>> +                               bool enable)
>
>arg alignment. It should be
>
>function name(arg1, arg2,
>              arg3, arg4,
>              arg5...
>
> Check your other functions too.

[Loc Ho]
I looked over the entire v3 driver and they are all aligned correct.

>> +static void xgene_edac_l3_create_debugfs_nodes(
>> +     struct edac_device_ctl_info *edac_dev)
>
>This "(" brace at the end looks ugly. Simply leave it on the same line,
>even if if it is longer than 80-cols.
>
>You can do:
>
>static void xgene_edac_l3_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
>{
>
>or:
>
>static void
>xgene_edac_l3_create_debugfs_nodes(struct edac_device_ctl_info *edac_dev)
>{
>
>which is more readable.

[Loc Ho]
I looked over the entire v3 driver and they are all aligned correct.

>> +     /*
>> +      * Todo: Switch to common EDAC debug file system for edac device
>> +      *       when available.
>> +      */
>
>What is that?

[Loc Ho]
This one was change in v3.

>> +
>> +     if (edac_op_state == EDAC_OPSTATE_POLL)
>> +             edac_dev->edac_check = xgene_edac_l3_check;
>
>So depending on what SoC elements you detect, the last one's check
>function will win?
>
>If xgene_edac loads on multiple SoC elements, you need a global xgene
>check function for which l3, soc, mc, etc register...

[Loc Ho]
I already commented on this one. It is per subnode type.

>> +     dev_info(edac->dev, "X-Gene EDAC L3 registered\n");
>> +     return 0;
>> +
>> +err1:
>> +     edac_device_free_ctl_info(edac_dev);
>> +err:
>
>Those labels need to be better named.

[Loc Ho]
I looked over the entire v3 driver and they are with proper naming.

>> +             if (reg & (DED_ERR_MASK | MDED_ERR_MASK))
>> +                     edac_device_handle_ue(edac_dev, 0, 0,
>> +                                           edac_dev->ctl_name);
>> +     }
>
>You can flip the logic in that function:
>
>        if (!reg)
>
>and use goto labels and thus save an indentation level. Which looks like
>you could use it.

[Loc Ho]

I had already reversed the logic for the L3 and SoC. Are you asking
for the MC/PMD (earlier posting)? The MC/PMD routine isn't that big.
Functions in general fit in an screen of 80 column?

>> +static const char * const *xgene_edac_soc_mem_data(
>> +     struct xgene_edac_dev_ctx *ctx)
>> +{
>> +     switch (ctx->version) {
>> +     case 1:
>> +             return soc_mem_err_v1;
>> +     default:
>> +             return NULL;
>> +     }
>> +}
>
>That's one badly formatted function used only once. Just move the logic
>there and kill it.

[Loc Ho]
I already killed this function.

>> +     list_for_each_entry(node, &ctx->socs, next) {
>> +             xgene_edac_soc_check(node->edac_dev);
>> +     }
>
>Loops with single statements don't need {}

[Loc Ho]
I already got rip of un-necessary { }

So, is there something that I am missing?

-Loc
