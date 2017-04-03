From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Mon, 03 Apr 2017 15:05:16 +0530
Subject: [PATCH v9 04/12] soc: samsung: add exynos chipid driver support
In-Reply-To: <e054813c-7566-61cc-21cb-733aadd1a9c7@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131427epcas5p4c3d238022dc75694ad3baa8a1018ea04@epcas5p4.samsung.com>
 <1490879826-16754-5-git-send-email-pankaj.dubey@samsung.com>
 <e054813c-7566-61cc-21cb-733aadd1a9c7@samsung.com>
Message-ID: <f5b08b44-0bb2-e1a3-d834-1640cd37d066@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Monday 03 April 2017 01:27 PM, Marek Szyprowski wrote:
> Hi Pankaj
> 
> On 2017-03-30 15:16, Pankaj Dubey wrote:
>> Exynos SoCs have Chipid, for identification of product IDs and SoC
>> revisions. This patch intends to provide initialization code for all
>> these functionalities, at the same time it provides some sysfs entries
>> for accessing these information to user-space.
>>
>> This driver uses existing binding for exynos-chipid.

snip

>> +
>> +static const struct exynos_soc_id {
>> +    const char *name;
>> +    unsigned int id;
>> +    unsigned int mask;
>> +} soc_ids[] = {
>> +    { "EXYNOS3250", 0xE3472000, 0xFFFFF000 },
>> +    { "EXYNOS4210", 0x43210000, 0xFFFFF000 },
> 
> You have once again changed the mask for Exynos4 SoCs, so please add
> following line to the above array:

Yes, this time I cross-verified from the UM of respective SoC's and
added it.

> 
> { "EXYNOS4210", 0x43200000, 0xFFFFF000 },       /* EVT0 revision */
> 
> Otherwise Exynos C210 (4210 EVT0) is not properly detected:
> 
> soc soc0: Exynos: CPU[UNKNOWN] PRO_ID[0x43200200] REV[0x0] Detected

Thanks for testing, I will add support for this.

> 
>> +    { "EXYNOS4212", 0x43220000, 0xFFFFF000 },
>> +    { "EXYNOS4412", 0xE4412000, 0xFFFFF000 },
>> +    { "EXYNOS5250", 0x43520000, 0xFFFFF000 },
>> +    { "EXYNOS5260", 0xE5260000, 0xFFFFF000 },
>> +    { "EXYNOS5410", 0xE5410000, 0xFFFFF000 },
>> +    { "EXYNOS5420", 0xE5420000, 0xFFFFF000 },
>> +    { "EXYNOS5440", 0xE5440000, 0xFFFFF000 },
>> +    { "EXYNOS5800", 0xE5422000, 0xFFFFF000 },
>> +    { "EXYNOS7420", 0xE7420000, 0xFFFFF000 },
>> +    { "EXYNOS5433", 0xE5433000, 0xFFFFF000 },
>> +};
> 
> Now the mask is same for all revisions, so you can remove it from the above
> array and directly use some kind of define in the code.

Yes, I also observed, but somehow I missed to update this part. I will
change this in next version.

> 
>> +
>> +static const char * __init product_id_to_soc_id(unsigned int product_id)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(soc_ids); i++)
>> +        if ((product_id & soc_ids[i].mask) == soc_ids[i].id)
>> +            return soc_ids[i].name;
>> +    return "UNKNOWN";
>> +}
>> +
>> +int __init exynos_chipid_early_init(void)
>> +{
>> +    struct soc_device_attribute *soc_dev_attr;
>> +    void __iomem *exynos_chipid_base;
>> +    struct soc_device *soc_dev;
>> +    struct device_node *root;
>> +    struct device_node *np;
>> +    struct device *dev;
>> +    u32 product_id;
>> +    u32 revision;
>> +
>> +    /* look up for chipid node */
>> +    np = of_find_compatible_node(NULL, NULL,
>> "samsung,exynos4210-chipid");
>> +    if (!np)
>> +        return -ENODEV;
>> +
>> +    exynos_chipid_base = of_iomap(np, 0);
>> +    of_node_put(np);
>> +
>> +    if (!exynos_chipid_base) {
>> +        pr_err("%s: failed to map chipid\n", np->name);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    product_id = readl_relaxed(exynos_chipid_base);
>> +    revision = product_id & EXYNOS_REV_MASK;
>> +    iounmap(exynos_chipid_base);
>> +
>> +    soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> +    if (!soc_dev_attr)
>> +        return -ENODEV;
>> +
>> +    soc_dev_attr->family = "Samsung Exynos";
>> +
>> +    root = of_find_node_by_path("/");
>> +    of_property_read_string(root, "model", &soc_dev_attr->machine);
>> +    of_node_put(root);
>> +
>> +    soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x", revision);
>> +    soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
>> +
>> +    soc_dev = soc_device_register(soc_dev_attr);
>> +    if (IS_ERR(soc_dev)) {
>> +        kfree(soc_dev_attr->revision);
>> +        kfree_const(soc_dev_attr->soc_id);
>> +        kfree(soc_dev_attr);
>> +        return PTR_ERR(soc_dev);
>> +    }
>> +    dev = soc_device_to_device(soc_dev);
>> +
>> +    dev_info(dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
>> +            soc_dev_attr->soc_id, product_id, revision);
>> +
>> +    return 0;
>> +}
>> +early_initcall(exynos_chipid_early_init);
> 
> Best regards


Thanks,
Pankaj Dubey
