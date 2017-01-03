From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 3 Jan 2017 09:43:21 +0100
Subject: [PATCH v6 05/14] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <1483363905-2806-6-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <13cb0c87-e1c0-c4d6-4793-a3edd20944dc@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02.01.2017 14:31, Hanjun Guo wrote:
> For devices connecting to ITS, it needs dev id to identify
> itself, and this dev id is represented in the IORT table in
> named componant node [1] for platform devices, so in this
> patch we will scan the IORT to retrieve device's dev id.
>
> Introduce iort_pmsi_get_dev_id() with pointer dev passed
> in for that purpose.
>
> [1]: https://static.docs.arm.com/den0049/b/DEN0049B_IO_Remapping_Table.pdf
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Sinan Kaya <okaya@codeaurora.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/acpi/arm64/iort.c                     | 26 ++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3-its-platform-msi.c |  4 +++-
>  include/linux/acpi_iort.h                     |  8 ++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 174e983..ab7bae7 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -444,6 +444,32 @@ u32 iort_msi_map_rid(struct device *dev, u32 req_id)
>  }
>
>  /**
> + * iort_pmsi_get_dev_id() - Get the device id for a device
> + * @dev: The device for which the mapping is to be done.
> + * @dev_id: The device ID found.
> + *
> + * Returns: 0 for successful find a dev id, errors otherwise
> + */
> +int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
> +{
> +	struct acpi_iort_node *node;
> +
> +	if (!iort_table)
> +		return -ENODEV;
> +
> +	node = iort_find_dev_node(dev);
> +	if (!node) {
> +		dev_err(dev, "can't find related IORT node\n");
> +		return -ENODEV;
> +	}
> +
> +	if(!iort_node_get_id(node, dev_id, IORT_MSI_TYPE, 0))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +/**
Giving that you are extending this to NC->
SMMU->ITS case in later patch, we can use existing helpers from iort.c, 
like that:

+/**
+ * iort_pmsi_get_dev_id() - Get the device id for a device
+ * @dev: The device for which the mapping is to be done.
+ * @dev_id: The device ID found.
+ *
+ * Returns: 0 for successful find a dev id, errors otherwise
+ */
+int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	struct acpi_iort_node *node;
+
+	node = iort_find_dev_node(dev);
+	if (!node)
+		return -ENODEV;
+
+	if (!iort_node_map_rid(node, 0, dev_id, IORT_MSI_TYPE))
+		return -ENODEV;
+
+	return 0;
+}

Correct me if I am wrong.

Tomasz
