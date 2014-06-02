From: amit.kachhap@gmail.com (Amit Kachhap)
Date: Mon, 2 Jun 2014 14:51:48 +0530
Subject: [PATCH v1 6/6] ACPI: thermal: processor: Use the generic cpufreq
 infrastructure
In-Reply-To: <20140529124248.GC2593@e104805>
References: <1401351334-11210-1-git-send-email-amit.daniel@samsung.com>
 <1401351334-11210-7-git-send-email-amit.daniel@samsung.com>
 <20140529124248.GC2593@e104805>
Message-ID: <CADGdYn7FZCjhzbFMtNPFtQV_naQhVk+nR1VFNH88M92_NQmfsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javi,

On 5/29/14, Javi Merino <javi.merino@arm.com> wrote:
> Hi Amit,
>
> On Thu, May 29, 2014 at 09:15:34AM +0100, Amit Daniel Kachhap wrote:
>> This patch upgrades the ACPI cpufreq cooling portions to use the generic
>> cpufreq cooling infrastructure. There should not be any functionality
>> related changes as the same behaviour is provided by the generic
>> cpufreq APIs with the notifier mechanism.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  drivers/acpi/processor_driver.c  |    6 +-
>>  drivers/acpi/processor_thermal.c |  235
>> ++++++++++++++++++--------------------
>>  include/acpi/processor.h         |    3 +-
>>  3 files changed, 115 insertions(+), 129 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c
>> b/drivers/acpi/processor_driver.c
>> index 7f70f31..10aba4a 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/cpuidle.h>
>>  #include <linux/slab.h>
>>  #include <linux/acpi.h>
>> +#include <linux/cpu_cooling.h>
>>
>>  #include <acpi/processor.h>
>>
>> @@ -178,8 +179,7 @@ static int __acpi_processor_start(struct acpi_device
>> *device)
>>         if (!cpuidle_get_driver() || cpuidle_get_driver() ==
>> &acpi_idle_driver)
>>                 acpi_processor_power_init(pr);
>>
>> -       pr->cdev = thermal_cooling_device_register("Processor", device,
>> -
>> &processor_cooling_ops);
>> +       pr->cdev = acpi_processor_cooling_register(device);
>
> With this you have removed the only cooling device whose type was
> "Processor".  There's special code for dealing with this cooling
> device in drivers/thermal/thermal_core.c:passive_store():
>
> 		list_for_each_entry(cdev, &thermal_cdev_list, node) {
> 			if (!strncmp("Processor", cdev->type,
> 				     sizeof("Processor")))
> 				thermal_zone_bind_cooling_device(tz,
> 						THERMAL_TRIPS_NONE, cdev,
> 						THERMAL_NO_LIMIT,
> 						THERMAL_NO_LIMIT);
> 		}
> 		mutex_unlock(&thermal_list_lock);
> 		if (!tz->passive_delay)
>
> With your change, that code is now "dead" as it can't do anything.  No
> I don't know what should you do with it, either remove it or make it
> match the cpufreq cooling device.  But this patch should deal with
> that code as well.
nice catch. I somehow missed modifying this section.
I think the following changes should fix this,
-                       if (!strncmp("Processor", cdev->type,
-                                    sizeof("Processor")))
+                       if (!strncmp("thermal-cpufreq", cdev->type,
+                                    sizeof("thermal-cpufreq")))
                                thermal_zone_bind_cooling_device(tz,

>
> Cheers,
> Javi
>
>
>
