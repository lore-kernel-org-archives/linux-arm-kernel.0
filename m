From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 29 Mar 2017 19:52:48 +0800
Subject: [PATCH v9 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <20170329101400.GA10807@red-moon>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <1488890410-15503-11-git-send-email-guohanjun@huawei.com>
 <20170329101400.GA10807@red-moon>
Message-ID: <58DBA010.1020002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 03/29/2017 06:14 PM, Lorenzo Pieralisi wrote:
> Hi Hanjun, Marc,
>
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
>>   drivers/acpi/arm64/iort.c                     | 24 ++++++++++++++++++++++++
>>   drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
>>   include/linux/acpi_iort.h                     |  5 +++++
>>   3 files changed, 31 insertions(+), 1 deletion(-)
>
> To simplify merging ACPI/IRQCHIP changes via different trees it
> would be good to split this patch; I am not sure what's the best
> way of handling it though given that we would end up in a merge
> ordering dependency anyway (ie we can create an empty stub
> for iort_pmsi_get_dev_id() but that would create a dependency
> between ARM64 and irqchip trees anyway).

The first 12 patches for ACPI platform MSI and later 3 patches
for mbigen have no "physical" dependency, which means they can
be merged and compiled independently, they only have functional
dependency only.

We already had SAS, XGE, USB and even UART drivers depend on
the mbigen ACPI support, so I don't think the dependency of ACPI
platform MSI and mbigen patches cares much if those two parts are
merged in one merge window, even they are merged independently via
different tree.

>
> Please let me know what's your preferred way of handling this.

So in my opinion, they can be merged independently via ARM64 and
irqchip tree with no ordering dependency, is it OK?

Thanks
Hanjun
