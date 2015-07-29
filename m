From: lho@apm.com (Loc Ho)
Date: Wed, 29 Jul 2015 16:39:10 -0700
Subject: [PATCH v2 2/3] edac: Add L3/SoC support to the APM X-Gene SoC
 EDAC driver
In-Reply-To: <20150729142941.GC17367@nazgul.tnic>
References: <1437808063-17592-1-git-send-email-lho@apm.com>
 <1437808063-17592-2-git-send-email-lho@apm.com>
 <1437808063-17592-3-git-send-email-lho@apm.com>
 <20150729142941.GC17367@nazgul.tnic>
Message-ID: <CAPw-ZTkZ7q8PUWydFad5TXrhcY6YBRjdVvz+SR+LV4sOLDKkEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

>> +
>> +static void xgene_edac_l3_hw_init(struct edac_device_ctl_info *edac_dev,
>> +                               bool enable)
>
> arg alignment. It should be
>
> function name(arg1, arg2,
>               arg3, arg4,
>               arg5...
>
> Check your other functions too.

I will check and fix other functions if any. But this function is just
fine. It may be off just by the + extra character with patch
generation only.

>> +{
>> +     struct xgene_edac_dev_ctx *ctx = edac_dev->pvt_info;
>> +     struct dentry *edac_debugfs;
>> +     char name[30];
>> +
>> +     if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
>> +             return;
>> +
>> +     /*
>> +      * Todo: Switch to common EDAC debug file system for edac device
>> +      *       when available.
>> +      */
>
> What is that?

Debug folder node shows up at /sys/kernel/debug/<file here> while the
MC debug node shows up at /sys/kernel/debug/edac where <file here> is
the driver node name. It would be better if everything shows up at
/sys/kernel/debug/edac. For this to happen, I need EDAC core change to
provide an parent node.

>
>> +     if (!ctx->edac->dfs) {
>> +             ctx->edac->dfs = debugfs_create_dir(edac_dev->dev->kobj.name,
>> +                                                 NULL);
>> +             if (!ctx->edac->dfs)
>> +                     return;
>> +     }
>> +     sprintf(name, "l3c%d", ctx->edac_idx);
>> +     edac_debugfs = debugfs_create_dir(name, ctx->edac->dfs);
>> +     if (!edac_debugfs)
>> +             return;
>> +
>> +     debugfs_create_file("l3_inject_ctrl", S_IWUSR, edac_debugfs, edac_dev,
>> +                         &xgene_edac_l3_debug_inject_fops);
>> +}
>> +
>> +static int xgene_edac_l3_add(struct xgene_edac *edac, struct device_node *np,
>> +                          int version)
>> +{
>> +     struct edac_device_ctl_info *edac_dev;
>> +     struct xgene_edac_dev_ctx *ctx;
>> +     struct resource res;
>> +     void __iomem *dev_csr;
>> +     int edac_idx;
>> +     int rc = 0;
>> +
>> +     if (!devres_open_group(edac->dev, xgene_edac_l3_add, GFP_KERNEL))
>> +             return -ENOMEM;
>> +
>> +     rc = of_address_to_resource(np, 0, &res);
>> +     if (rc < 0) {
>> +             dev_err(edac->dev, "no L3 resource address\n");
>> +             goto err;
>> +     }
>> +     dev_csr = devm_ioremap_resource(edac->dev, &res);
>> +     if (IS_ERR(dev_csr)) {
>> +             dev_err(edac->dev,
>> +                     "devm_ioremap_resource failed for L3 resource address\n");
>> +             rc = PTR_ERR(dev_csr);
>> +             goto err;
>> +     }
>>
>> +     edac_idx = edac_device_alloc_index();
>> +     edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
>> +                                           "l3c", 1, "l3c", 1, 0, NULL, 0,
>> +                                           edac_idx);
>> +     if (!edac_dev) {
>> +             rc = -ENOMEM;
>> +             goto err;
>> +     }
>> +
>> +     ctx = edac_dev->pvt_info;
>> +     ctx->dev_csr = dev_csr;
>> +     ctx->name = "xgene_l3_err";
>> +     ctx->edac_idx = edac_idx;
>> +     ctx->edac = edac;
>> +     ctx->edac_dev = edac_dev;
>> +     ctx->ddev = *edac->dev;
>> +     ctx->version = version;
>> +     edac_dev->dev = &ctx->ddev;
>> +     edac_dev->ctl_name = ctx->name;
>> +     edac_dev->dev_name = ctx->name;
>> +     edac_dev->mod_name = EDAC_MOD_STR;
>> +
>> +     if (edac_op_state == EDAC_OPSTATE_POLL)
>> +             edac_dev->edac_check = xgene_edac_l3_check;
>
> So depending on what SoC elements you detect, the last one's check
> function will win?
>
> If xgene_edac loads on multiple SoC elements, you need a global xgene
> check function for which l3, soc, mc, etc register...

No... each EDAC instance has its own context as we allocated via
function edac_device_alloc_ctl_info. Per type of instance will use the
same type function.

>> +
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
> That's one badly formatted function used only once. Just move the logic
> there and kill it.

For format, code looks fine. In any case, I will roll this into the code.

>> +static int xgene_edac_soc_add(struct xgene_edac *edac, struct device_node *np,
>> +                           int version)
>> +{
>> +     struct edac_device_ctl_info *edac_dev;
>> +     struct xgene_edac_dev_ctx *ctx;
>> +     void __iomem *dev_csr;
>> +     struct resource res;
>> +     int edac_idx;
>> +     int rc = 0;
>> +
>> +     if (!devres_open_group(edac->dev, xgene_edac_soc_add, GFP_KERNEL))
>> +             return -ENOMEM;
>> +
>> +     rc = of_address_to_resource(np, 0, &res);
>> +     if (rc < 0) {
>> +             dev_err(edac->dev, "no SoC resource address\n");
>> +             goto err;
>> +     }
>> +     dev_csr = devm_ioremap_resource(edac->dev, &res);
>> +     if (IS_ERR(dev_csr)) {
>> +             dev_err(edac->dev,
>> +                     "devm_ioremap_resource failed for soc resource address\n");
>> +             rc = PTR_ERR(dev_csr);
>> +             goto err;
>> +     }
>> +
>> +     edac_idx = edac_device_alloc_index();
>> +     edac_dev = edac_device_alloc_ctl_info(sizeof(*ctx),
>> +                                           "SOC", 1, "SOC", 1, 2, NULL, 0,
>> +                                           edac_idx);
>> +     if (!edac_dev) {
>> +             rc = -ENOMEM;
>> +             goto err;
>> +     }
>> +
>> +     ctx = edac_dev->pvt_info;
>> +     ctx->dev_csr = dev_csr;
>> +     ctx->name = "xgene_soc_err";
>> +     ctx->edac_idx = edac_idx;
>> +     ctx->edac = edac;
>> +     ctx->edac_dev = edac_dev;
>> +     ctx->ddev = *edac->dev;
>> +     ctx->version = version;
>> +     edac_dev->dev = &ctx->ddev;
>> +     edac_dev->ctl_name = ctx->name;
>> +     edac_dev->dev_name = ctx->name;
>> +     edac_dev->mod_name = EDAC_MOD_STR;
>> +
>> +     if (edac_op_state == EDAC_OPSTATE_POLL)
>> +             edac_dev->edac_check = xgene_edac_soc_check;
>
> Same here about the ->edac_check function.

Same comment as above.

-Loc
