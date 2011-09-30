From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 30 Sep 2011 14:59:51 +0530
Subject: [PATCH 9/9] regulator: map consumer regulator based on device tree
In-Reply-To: <20110930013819.GI12606@ponder.secretlab.ca>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-10-git-send-email-rnayak@ti.com>
	<20110930013819.GI12606@ponder.secretlab.ca>
Message-ID: <4E858C0F.5070405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 September 2011 07:08 AM, Grant Likely wrote:
> On Tue, Sep 27, 2011 at 03:42:52PM +0530, Rajendra Nayak wrote:
>> Look up the regulator for a given consumer from device tree, during
>> a regulator_get(). If not found fallback and lookup through
>> the regulator_map_list instead.
>>
>> Devices can associate with one or more regulators by providing a
>> list of phandles and supply names.
>>
>> For Example:
>>          devicenode: node at 0x0 {
>>                  ...
>>                  ...
>>                  vmmc-supply =<&regulator1>;
>>                  vpll-supply =<&regulator2>;
>>          };
>>
>> When a device driver calls a regulator_get, specifying the
>> supply name, the phandle and eventually the regulator node
>> is extracted from the device node.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> ---
>>   drivers/regulator/core.c         |   14 ++++++++++++++
>>   include/linux/regulator/driver.h |    3 +++
>>   2 files changed, 17 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
>> index d8e6a42..47b851c 100644
>> --- a/drivers/regulator/core.c
>> +++ b/drivers/regulator/core.c
>> @@ -25,9 +25,11 @@
>>   #include<linux/mutex.h>
>>   #include<linux/suspend.h>
>>   #include<linux/delay.h>
>> +#include<linux/of.h>
>>   #include<linux/regulator/consumer.h>
>>   #include<linux/regulator/driver.h>
>>   #include<linux/regulator/machine.h>
>> +#include<linux/regulator/of_regulator.h>
>>
>>   #define CREATE_TRACE_POINTS
>>   #include<trace/events/regulator.h>
>> @@ -1155,6 +1157,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
>>   	struct regulator_map *map;
>>   	struct regulator *regulator = ERR_PTR(-ENODEV);
>>   	const char *devname = NULL;
>> +	struct device_node *node;
>>   	int ret;
>>
>>   	if (id == NULL) {
>> @@ -1167,6 +1170,15 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
>>
>>   	mutex_lock(&regulator_list_mutex);
>>
>> +	if (dev->of_node) {
>> +		node = of_get_regulator(dev, id);
>> +		if (!node)
>> +			goto retry; /* fallback and chk regulator_map_list */
>> +		list_for_each_entry(rdev,&regulator_list, list)
>> +			if (node == rdev->node)
>> +				goto found;
>> +	}
>> +retry:
>>   	list_for_each_entry(map,&regulator_map_list, list) {
>>   		/* If the mapping has a device set up it must match */
>>   		if (map->dev_name&&
>> @@ -2619,6 +2631,8 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
>>   	rdev->reg_data = driver_data;
>>   	rdev->owner = regulator_desc->owner;
>>   	rdev->desc = regulator_desc;
>> +	if (dev&&  dev->of_node)
>> +		rdev->node = dev->of_node;
>>   	INIT_LIST_HEAD(&rdev->consumer_list);
>>   	INIT_LIST_HEAD(&rdev->list);
>>   	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
>> diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
>> index 1a80bc7..4aebbf5 100644
>> --- a/include/linux/regulator/driver.h
>> +++ b/include/linux/regulator/driver.h
>> @@ -196,6 +196,9 @@ struct regulator_dev {
>>   	struct mutex mutex; /* consumer lock */
>>   	struct module *owner;
>>   	struct device dev;
>> +#ifdef CONFIG_OF
>> +	struct device_node *node;
>> +#endif
>
> There is already an of_node pointer in regulator_dev->dev.of_node.
> Why does another need to be added here?

Yes, I guess it doesn't. Will remove it.
Thanks.

>
> g.
>
