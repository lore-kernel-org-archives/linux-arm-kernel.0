From: sricharan@codeaurora.org (Sricharan)
Date: Fri, 20 Jan 2017 11:01:55 +0530
Subject: [PATCH V5 10/12] drivers: acpi: Configure acpi devices dma
 operation at probe time
In-Reply-To: <20170119164222.GA28483@red-moon>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
 <1484838356-24962-11-git-send-email-sricharan@codeaurora.org>
 <20170119164222.GA28483@red-moon>
Message-ID: <000001d272de$86fa4320$94eec960$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

>On Thu, Jan 19, 2017 at 08:35:54PM +0530, Sricharan R wrote:
>> With all the DT based devices getting their dma ops configured
>> during probe time to have the right iommu setup, let us do the
>> same for acpi based devices as well.
>>
>> Configuring DMA ops at probe time will allow deferring device probe when
>> the IOMMU isn't available yet. The dma_configure for the device is
>> now called from the generic device_attach callback just before the
>> bus/driver probe is called. This way, configuring the DMA ops for the
>> device would be called at the same place for all bus_types, hence the
>> deferred probing mechanism should work for all buses as well.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  * Removed the dma configuration for the pci devices in case of ACPI
>>    from pci_dma_configure which was hanging outside separately and
>>    doing it in dma_configure function itself.
>>
>>  drivers/acpi/glue.c        |  5 -----
>>  drivers/base/dma-mapping.c | 13 ++++++++++++-
>>  drivers/pci/probe.c        | 25 -------------------------
>>  3 files changed, 12 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
>> index fb19e1c..c05f241 100644
>> --- a/drivers/acpi/glue.c
>> +++ b/drivers/acpi/glue.c
>> @@ -176,7 +176,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>>  	struct list_head *physnode_list;
>>  	unsigned int node_id;
>>  	int retval = -EINVAL;
>> -	enum dev_dma_attr attr;
>>
>>  	if (has_acpi_companion(dev)) {
>>  		if (acpi_dev) {
>> @@ -233,10 +232,6 @@ int acpi_bind_one(struct device *dev, struct acpi_device *acpi_dev)
>>  	if (!has_acpi_companion(dev))
>>  		ACPI_COMPANION_SET(dev, acpi_dev);
>>
>> -	attr = acpi_get_dma_attr(acpi_dev);
>> -	if (attr != DEV_DMA_NOT_SUPPORTED)
>> -		acpi_dma_configure(dev, attr);
>> -
>>  	acpi_physnode_link_name(physical_node_name, node_id);
>>  	retval = sysfs_create_link(&acpi_dev->dev.kobj, &dev->kobj,
>>  				   physical_node_name);
>> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
>> index f82212c..294942d 100644
>> --- a/drivers/base/dma-mapping.c
>> +++ b/drivers/base/dma-mapping.c
>> @@ -7,6 +7,7 @@
>>   * This file is released under the GPLv2.
>>   */
>>
>> +#include <linux/acpi.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/export.h>
>>  #include <linux/gfp.h>
>> @@ -352,6 +353,7 @@ int dma_configure(struct device *dev)
>>  {
>>  	struct device *_dev = dev;
>>  	int is_pci = dev_is_pci(dev);
>> +	enum dev_dma_attr attr;
>>  	int ret = 0;
>>
>>  	if (is_pci) {
>> @@ -361,8 +363,16 @@ int dma_configure(struct device *dev)
>>  			_dev = _dev->parent;
>>  	}
>>
>> -	if (_dev->of_node)
>> +	if (_dev->of_node) {
>>  		ret = of_dma_configure(dev, _dev->of_node);
>> +	} else if (has_acpi_companion(_dev)) {
>> +		attr = acpi_get_dma_attr(to_acpi_device_node(_dev->fwnode));
>> +
>> +		if (attr == DEV_DMA_NOT_SUPPORTED)
>> +			dev_warn(dev, "DMA not supported.\n");
>
>The changes you are making are correct but now this dev_warn spits hell
>for non-pci devices that do not support DMA (ie they do not have a _CCA
>on CONFIG_ACPI_CCA_REQUIRED systems), so you will have to remove it
>given that this path is now shared.
>

ok, will remove this WARN now.

Regards,
 Sricharan
