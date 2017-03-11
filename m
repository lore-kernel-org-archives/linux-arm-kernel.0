From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 11 Mar 2017 16:56:02 +0800
Subject: [PATCH v9 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <20170307143525.GA26990@red-moon>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <1488890410-15503-11-git-send-email-guohanjun@huawei.com>
 <20170307143525.GA26990@red-moon>
Message-ID: <58C3BBA2.1090600@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/3/7 22:35, Lorenzo Pieralisi wrote:
> On Tue, Mar 07, 2017 at 08:40:05PM +0800, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> For devices connecting to ITS, the devices need to identify themself
>> through a dev id; this dev id is represented in the IORT table in named
>> component node [1] for platform devices, so this patch adds code that
>> scans the IORT table to retrieve the devices' dev id.
>>
>> Leveraging the iort_node_map_platform_id() IORT API, add a new function
>> call, iort_pmsi_get_dev_id() and use it in its_pmsi_prepare() to allow
>> retrieving dev id in ACPI platforms.
>>
>> [1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> [lorenzo.pieralisi at arm.com: rewrote commit log]
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Tested-by: Ming Lei <ming.lei@canonical.com>
>> Tested-by: Wei Xu <xuwei5@hisilicon.com>
>> Tested-by: Sinan Kaya <okaya@codeaurora.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Tomasz Nowicki <tn@semihalf.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  drivers/acpi/arm64/iort.c                     | 24 ++++++++++++++++++++++++
>>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
>>  include/linux/acpi_iort.h                     |  5 +++++
>>  3 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 83cd59d..fb95ceb 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -468,6 +468,30 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>>  }
>>  
>>  /**
>> + * iort_pmsi_get_dev_id() - Get the device id for a device
>> + * @dev: The device for which the mapping is to be done.
>> + * @dev_id: The device ID found.
>> + *
>> + * Returns: 0 for successful find a dev id, -ENODEV on error
>> + */
>> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>> +{
>> +	int i;
>> +	struct acpi_iort_node *node;
>> +
>> +	node = iort_find_dev_node(dev);
>> +	if (!node)
>> +		return -ENODEV;
> I think that when specs are updated so that we can enable SMMU MSIs we
> shall have to find a way to get the acpi_iort_node for a device that is
> not a named component here (ie SMMU), I reckon we can use the
> fwnode_handle but I have to have a deeper look.

Seems we can do this as follows:

---
 drivers/acpi/arm64/iort.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 22e08d2..c794219 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -121,6 +121,31 @@ static inline void iort_delete_fwnode(struct acpi_iort_node *node)
        spin_unlock(&iort_fwnode_lock);
 }
 
+/**
+ * iort_get_iort_node() - Retrieve iort_node associated with an fwnode
+ *
+ * @fwnode: fwnode associated with device to be looked-up
+ *
+ * Returns: iort_node pointer on success, NULL on failure
+ */
+static inline
+struct acpi_iort_node *iort_get_iort_node(struct fwnode_handle *fwnode)
+{
+ struct iort_fwnode *curr;
+ struct acpi_iort_node *iort_node = NULL;
+
+ spin_lock(&iort_fwnode_lock);
+ list_for_each_entry(curr, &iort_fwnode_list, list) {
+         if (curr->fwnode == fwnode) {
+                 iort_node = curr->iort_node;
+                 break;
+         }
+ }
+ spin_unlock(&iort_fwnode_lock);
+
+ return iort_node;
+}
+
 typedef acpi_status (*iort_find_node_callback)
        (struct acpi_iort_node *node, void *context);
 
@@ -434,9 +459,25 @@ static struct acpi_iort_node *iort_find_dev_node(struct device *dev)
 {
        struct pci_bus *pbus;
 
-   if (!dev_is_pci(dev))
+ if (!dev_is_pci(dev)) {
+         struct acpi_iort_node *node;
+         /*
+          * scan iort_fwnode_list to see if it's an iort platform
+          * device (such as SMMU, PMCG),its iort node already cached
+          * and associated with fwnode when iort platform devices
+          * were initialized.
+          */
+         node = iort_get_iort_node(dev->fwnode);
+         if (node)
+                 return node;
+
+         /*
+          * if not, then it should be a platform device defined in
+          * DSDT (with Named Component node in IORT)
+          */
                return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
                                      iort_match_node_callback, dev);
+ }
 
        /* Find a PCI root bus */
        pbus = to_pci_dev(dev)->bus;


>
> This does not affect the patchset in its current form, just scanning
> the code to make sure we will be able to support SMMU MSIs too when
> time comes.

Sure, thanks!

Hanjun
