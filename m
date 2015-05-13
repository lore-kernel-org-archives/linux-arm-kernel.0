From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Wed, 13 May 2015 13:36:08 +0800
Subject: [RFC v2 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
In-Reply-To: <5550B056.2080608@linaro.org>
References: <1430793970-11159-1-git-send-email-jiang.liu@linux.intel.com>
 <1430793970-11159-6-git-send-email-jiang.liu@linux.intel.com>
 <5550B056.2080608@linaro.org>
Message-ID: <5552E2C8.70307@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/11 21:36, Hanjun Guo wrote:
> Hi Jiang,
> 
> I have comments inline.
> 
> On 2015?05?05? 10:46, Jiang Liu wrote:
>> Introduce common interface acpi_pci_root_create() and related data
>> structures to create PCI root bus for ACPI PCI host bridges. It will
>> be used to kill duplicated arch specific code for IA64 and x86. It may
>> also help ARM64 in future.
>>
>> Tested-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>> +                     struct acpi_pci_root_ops *ops,
>> +                     size_t extra_size)
>> +{
>> +    int ret, busnum = root->secondary.start;
>> +    struct acpi_device *device = root->device;
>> +    struct acpi_pci_root_info_common *info;
>> +    struct pci_bus *bus;
>> +
>> +    info = kzalloc(sizeof(*info) + extra_size, GFP_KERNEL);
> 
> For x86, the memory is allocated on its local numa node if memory
> is available by using kzalloc_node(), and if
> node = acpi_get_node(device->handle) is NUMA_NO_NODE, the code will
> get the numa node info by using x86_pci_root_bus_node() (which you
> consolidate them as a function pci_acpi_root_get_node() in later
> patch).
> 
> but the code here just ignore that information, so the code
> here has functional change for x86 code since you didn't use numa
> information.
> 
> I'm not sure how frequently used for the info after init, so
> not sure about the performance impact, but I think we should
> keep consistence with the code behavior as before.
Hi Hanjun,
	Good catch, will change code to respect NUMA node
info when allocating memory.

> 
> Further more, there is a implicit cast for
> struct acpi_pci_root_info_common *info to arch specific
> struct pci_root_info *info by using extra size, it's not
> easy to understand (at least for me :) ), so how about
> alloc the memory in arch specific function, and pass
> struct acpi_pci_root_info_common *info fr this function?
Good suggestion.
Thanks!
Gerry

> other than that, this code is pretty good, I reworked ARM64
> ACPI based PCI host bridge init code, and this patch simplified
> the coed a lot, will have a test tomorrow and let you know
> the result.
> 
> Thanks
> Hanjun
