From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 12:04:28 -0600
Subject: [PATCH v2] ARM: tegra: expose chip ID and revision
In-Reply-To: <201303121259.18710.arnd@arndb.de>
References: <1363089667-15737-1-git-send-email-dahuang@nvidia.com>
 <201303121259.18710.arnd@arndb.de>
Message-ID: <513F6E2C.1000101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 06:59 AM, Arnd Bergmann wrote:
> On Tuesday 12 March 2013, Danny Huang wrote:
>>
>> +void __init tegra_soc_device_init(void)
>> +{
>> +       struct soc_device *soc_dev;
>> +       struct soc_device_attribute *soc_dev_attr;
>> +
>> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> +       if (!soc_dev_attr)
>> +               return;
>> +
>> +       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%d", tegra_chip_id);
>> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d", tegra_revision);
>> +       soc_dev_attr->family = kasprintf(GFP_KERNEL, "Tegra");
>> +
>> +       soc_dev = soc_device_register(soc_dev_attr);
>> +       if (IS_ERR_OR_NULL(soc_dev))
>> +               kfree(soc_dev_attr);
>> +
>> +       return;
> 
> You are dropping the soc_dev on the floor here by just returning.
> 
> The idea of the soc node is to have all on-soc components be children
> of that node, so you should instead pass it into of_platform_populate
> as the parent device.

Tegra DTs don't have a separate node for on-soc vs. off-soc components.
Wouldn't passing soc_dev into of_platform_populate() make everything a
child of this soc_dev; is that what we want?
