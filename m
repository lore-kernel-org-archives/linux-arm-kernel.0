From: robherring2@gmail.com (Rob Herring)
Date: Fri, 19 Sep 2014 19:28:38 -0500
Subject: [PATCH v11 08/10] OF: PCI: Add support for parsing PCI host bridge
 resources from DT
In-Reply-To: <20140919210610.GI19374@google.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-9-git-send-email-Liviu.Dudau@arm.com>
 <20140919210610.GI19374@google.com>
Message-ID: <541CCA36.8010606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2014 04:06 PM, Bjorn Helgaas wrote:
> On Thu, Sep 18, 2014 at 02:30:23AM +0100, Liviu Dudau wrote:
>> Provide a function to parse the PCI DT ranges that can be used to
>> create a pci_host_bridge structure together with its associated
>> bus.
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> ---

[...]

>> +int of_pci_get_host_bridge_resources(struct device_node *dev,
>> +			unsigned char busno, unsigned char bus_max,
>> +			struct list_head *resources, resource_size_t *io_base)
>> +{
>> +	struct resource *res;
>> +	struct resource *bus_range;
>> +	struct of_pci_range range;
>> +	struct of_pci_range_parser parser;
>> +	char range_type[4];
>> +	int err;
>> +
>> +	if (!io_base)
>> +		return -EINVAL;
>> +	*io_base = OF_BAD_ADDR;
>> +
>> +	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);

This function does a lot of kalloc's but there is not an easy way to
undo those allocations. Hot unplug of a host bridge or probe error
handling would leak memory.

You could pass in struct device and use the devm_ variant (also
addressing Bjorn's comment), but not having an uninit/remove function
make what clean-up drivers have to do error prone. For example, on
uninit a driver needs to call pci_free_resource_list.

Rob
