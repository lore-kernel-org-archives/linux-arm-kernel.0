From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 8 Nov 2017 12:37:26 -0500
Subject: [PATCH V2 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <fe23cb49-d617-fd79-8fb6-08d45fc88bce@codeaurora.org>
References: <1510158582-5343-1-git-send-email-okaya@codeaurora.org>
 <1510158582-5343-2-git-send-email-okaya@codeaurora.org>
 <e673a03d-1707-fe4a-7f5d-df1466981893@codeaurora.org>
 <c55ecc2c-332c-e9e6-c74c-3c67fd2ab89a@codeaurora.org>
 <fe23cb49-d617-fd79-8fb6-08d45fc88bce@codeaurora.org>
Message-ID: <76b030eb-232f-e075-f5e8-09731a5b6670@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/8/2017 12:12 PM, Timur Tabi wrote:
> On 11/08/2017 10:58 AM, Sinan Kaya wrote:
>> Besides, C compiler also won't let me put two arrays together like this.
>>
>> struct my_struct {
>> ????struct some_struct array1[]
>> ????struct some_struct array2[]
>> }
> 
> Why not this:
> 
> const struct of_device_id hidma_msi_of_ids[] = {
> ????{.compatible = "qcom,hidma-1.1",},
> ????{.compatible = "qcom,hidma-1.2",},
> ????{},
> },
> 
> static const struct acpi_device_id hidma_msi_acpi_ids[] = {
> ????{"QCOM8001", QDF2XXX_V1},
> ????{"QCOM8002", QDF2XXX_V2},
> ????{},
> };
> 
> struct hidma_cap {
> ????const struct of_device_id *of;
> ????const struct acpi_device_id *acpi;
> };
> 
> static struct hidma_cap hidma_msi_cap = {
> ????hidma_msi_of_ids,
> ????hidma_msi_acpi_ids
> }
> 

I think we are talking styles here. I started with your proposal and wanted to group
the settings together as much as I can for maintenance reasons only because 
I don't have to remember that there are two different arrays that I need to take care
of when I add a new HW in the future.

+static struct hidma_cap hidma_msi_cap = {
+	.of = {
+		{.compatible = "qcom,hidma-1.1",},
+		{.compatible = "qcom,hidma-1.2",},
+		{},
+	},
+
+	.acpi = {
+		{"QCOM8062"},
+		{"QCOM8063"},
+		{},
+	}
+};

I like this better than what you are proposing.

> Keep in mind that you also need to add MODULE_DEVICE_TABLE entries, which you can't really do with your approach.
> 
> MODULE_DEVICE_TABLE(of, hidma_msi_of_ids);
> MODULE_DEVICE_TABLE(acpi, hidma_msi_acpi_ids);
> 

HIDMA capable devices are a subset of the devices that need to be probed. That's also
why I don't touch the device_table.

In the end both approaches work. It is a choice between what is more manageable. That
was the initial objection. I tried to close on this request.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
