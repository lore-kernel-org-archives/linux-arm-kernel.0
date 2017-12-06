From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 6 Dec 2017 11:41:33 -0500
Subject: [PATCH V6 2/7] ACPI / bus: Introduce acpi_get_match_data()
 function
In-Reply-To: <CAJZ5v0iJ_47z25GrQryQFVyXiXitYNHy8mQtTCf2rtdyhnn2eQ@mail.gmail.com>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-3-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0iJ_47z25GrQryQFVyXiXitYNHy8mQtTCf2rtdyhnn2eQ@mail.gmail.com>
Message-ID: <218a717f-7fac-41a1-86e2-19f4d99a7f52@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/5/2017 5:04 PM, Rafael J. Wysocki wrote:
> On Tue, Dec 5, 2017 at 6:04 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> OF has of_device_get_match_data() function to extract driver specific data
>> structure. Add a similar function for ACPI.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Not sure yet, sorry.

OK. no problem.

> 
>> ---
>>  drivers/acpi/bus.c   | 12 ++++++++++++
>>  include/linux/acpi.h |  6 ++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 4d0979e..b271eb1 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -785,6 +785,18 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_match_device);
>>
>> +void *acpi_get_match_data(const struct device *dev)
>> +{
>> +       const struct acpi_device_id *match;
>> +
>> +       match = acpi_match_device(dev->driver->acpi_match_table, dev);
> 
> Shouldn't this check dev->driver against NULL before dereferencing it?

I'm adding these checks. I realized that acpi_match_device() is not validating
the ids either.

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -789,6 +789,12 @@ void *acpi_get_match_data(const struct device *dev)
 {
        const struct acpi_device_id *match;

+       if (!dev->driver)
+               return NULL;
+
+       if (!dev->driver->acpi_match_table)
+               return NULL;
+

I'll hold onto posting this until I hear back from Sakari.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
