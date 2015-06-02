From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 2 Jun 2015 14:29:53 +0800
Subject: [Patch v3 6/7] x86/PCI/ACPI: Use common interface to support
 PCI host bridge
In-Reply-To: <556D45A3.9070708@linux.intel.com>
References: <1431593803-5213-1-git-send-email-jiang.liu@linux.intel.com>
 <1431593803-5213-7-git-send-email-jiang.liu@linux.intel.com>
 <555F355E.7060706@linaro.org> <556D45A3.9070708@linux.intel.com>
Message-ID: <556D4D61.8080509@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/6/2 13:56, Jiang Liu wrote:
> On 2015/5/22 21:55, Hanjun Guo wrote:
>> On 2015?05?14? 16:56, Jiang Liu wrote:
>>> Use common interface to simplify ACPI PCI host bridge implementation.
>>>
>>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>>> ---
>>>   arch/x86/pci/acpi.c |  292
>>> +++++++++++++++------------------------------------
>>>   1 file changed, 85 insertions(+), 207 deletions(-)
>>>
>> [...]
>>> -static void release_pci_root_info(struct pci_host_bridge *bridge)
>>> +static void pci_acpi_root_release_info(struct acpi_pci_root_info *ci)
>>>   {
>>> -    struct resource *res;
>>> -    struct resource_entry *entry;
>>> -    struct pci_root_info *info = bridge->release_data;
>>> -
>>> -    resource_list_for_each_entry(entry, &bridge->windows) {
>>> -        res = entry->res;
>>> -        if (res->parent &&
>>> -            (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
>>> -            release_resource(res);
>>> -    }
>>> -
>>> -    teardown_mcfg_map(info);
>>> -    kfree(info);
>>> +    teardown_mcfg_map(ci);
>>> +    kfree(ci);
>> Implicit pointer cast? I think add a comment here that %p of ci
>> is same as %p of info would be helpful for review and easy understood.
> Good point, will change as:
> 	kfree(container_of(ci, struct pci_root_info, common));

This way is better :)

Thanks
Hanjun
