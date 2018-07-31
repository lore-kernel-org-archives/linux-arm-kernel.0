From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Tue, 31 Jul 2018 11:56:09 -0700
Subject: [PATCH v7 08/12] mfd: intel-peci-client: Add PECI client MFD
 driver
In-Reply-To: <20180731070117.GE4662@dell>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
 <20180723214751.1733-9-jae.hyun.yoo@linux.intel.com>
 <20180727082611.GE4628@dell>
 <acffdfef-cb20-4208-5297-d94bac5ecb1b@linux.intel.com>
 <CAL_JsqL7WkDOaegwmBDqLkRh0JfCo7O2krONVstjWMUsLiJMrg@mail.gmail.com>
 <7ab43253-1154-6e2f-b216-69b0d44b470a@linux.intel.com>
 <20180731070117.GE4662@dell>
Message-ID: <52b5342d-e31a-f4a2-f269-a159d3f58252@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On 7/31/2018 12:01 AM, Lee Jones wrote:
> On Mon, 30 Jul 2018, Jae Hyun Yoo wrote:
> 
>> Hi Rob,
>>
>> On 7/30/2018 3:10 PM, Rob Herring wrote:
>>> On Fri, Jul 27, 2018 at 11:36 AM Jae Hyun Yoo
>>> <jae.hyun.yoo@linux.intel.com> wrote:
>>>>
>>>> Hi Lee,
>>>>
>>>> On 7/27/2018 1:26 AM, Lee Jones wrote:
>>>>> On Mon, 23 Jul 2018, Jae Hyun Yoo wrote:
>>>>>
>>>>>> This commit adds PECI client MFD driver.
>>>>>>
>>>>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>>> Cc: Andrew Jeffery <andrew@aj.id.au>
>>>>>> Cc: James Feist <james.feist@linux.intel.com>
>>>>>> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
>>>>>> Cc: Joel Stanley <joel@jms.id.au>
>>>>>> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
>>>>>> ---
>>>>>>     drivers/mfd/Kconfig                   |  14 ++
>>>>>>     drivers/mfd/Makefile                  |   1 +
>>>>>>     drivers/mfd/intel-peci-client.c       | 182 ++++++++++++++++++++++++++
>>>>>>     include/linux/mfd/intel-peci-client.h |  81 ++++++++++++
>>>>>>     4 files changed, 278 insertions(+)
>>>>>>     create mode 100644 drivers/mfd/intel-peci-client.c
>>>>>>     create mode 100644 include/linux/mfd/intel-peci-client.h
>>>>>>
>>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>>> index f3fa516011ec..e38b591479d4 100644
>>>>>> --- a/drivers/mfd/Kconfig
>>>>>> +++ b/drivers/mfd/Kconfig
>>>>>> @@ -595,6 +595,20 @@ config MFD_INTEL_MSIC
>>>>>>          Passage) chip. This chip embeds audio, battery, GPIO, etc.
>>>>>>          devices used in Intel Medfield platforms.
>>>>>>
>>>>>> +config MFD_INTEL_PECI_CLIENT
>>>>>> +    bool "Intel PECI client"
>>>>>> +    depends on (PECI || COMPILE_TEST)
>>>>>> +    select MFD_CORE
>>>>>> +    help
>>>>>> +      If you say yes to this option, support will be included for the
>>>>>> +      multi-funtional Intel PECI (Platform Environment Control Interface)
>>>>>> +      client. PECI is a one-wire bus interface that provides a communication
>>>>>> +      channel from PECI clients in Intel processors and chipset components
>>>>>> +      to external monitoring or control devices.
>>>>>> +
>>>>>> +      Additional drivers must be enabled in order to use the functionality
>>>>>> +      of the device.
>>>>>> +
>>>>>>     config MFD_IPAQ_MICRO
>>>>>>        bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>>>>>>        depends on SA1100_H3100 || SA1100_H3600
>>>>>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>>>>>> index 2852a6042ecf..29e2cacc58bd 100644
>>>>>> --- a/drivers/mfd/Makefile
>>>>>> +++ b/drivers/mfd/Makefile
>>>>>> @@ -203,6 +203,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)     += intel-lpss.o
>>>>>>     obj-$(CONFIG_MFD_INTEL_LPSS_PCI)   += intel-lpss-pci.o
>>>>>>     obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)  += intel-lpss-acpi.o
>>>>>>     obj-$(CONFIG_MFD_INTEL_MSIC)       += intel_msic.o
>>>>>> +obj-$(CONFIG_MFD_INTEL_PECI_CLIENT) += intel-peci-client.o
>>>>>>     obj-$(CONFIG_MFD_PALMAS)   += palmas.o
>>>>>>     obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>>>>>>     obj-$(CONFIG_MFD_RC5T583)  += rc5t583.o rc5t583-irq.o
>>>>>> diff --git a/drivers/mfd/intel-peci-client.c b/drivers/mfd/intel-peci-client.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..d7702cf1ea50
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/mfd/intel-peci-client.c
>>>>>> @@ -0,0 +1,182 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +// Copyright (c) 2018 Intel Corporation
>>>>>> +
>>>>>> +#include <linux/bitfield.h>
>>>>>> +#include <linux/mfd/core.h>
>>>>>> +#include <linux/mfd/intel-peci-client.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/peci.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +
>>>>>> +enum cpu_gens {
>>>>>> +    CPU_GEN_HSX = 0, /* Haswell Xeon */
>>>>>> +    CPU_GEN_BRX,     /* Broadwell Xeon */
>>>>>> +    CPU_GEN_SKX,     /* Skylake Xeon */
>>>>>> +};
>>>>>> +
>>>>>> +static struct mfd_cell peci_functions[] = {
>>>>>> +    {
>>>>>> +            .name = "peci-cputemp",
>>>>>> +            .of_compatible = "intel,peci-cputemp",
>>>>>> +    },
>>>>>> +    {
>>>>>> +            .name = "peci-dimmtemp",
>>>>>> +            .of_compatible = "intel,peci-dimmtemp",
>>>>>> +    },
>>>>>> +};
>>>>>
>>>>> The more I look at this driver, the less I think it fits into MFD.
>>>>>
>>>>> What's stopping you from registering these devices directly from DT?
>>>>>
>>>>
>>>> Because DT doesn't allow 2 nodes at the same address so Rob suggested
>>>> MFD for this case.
>>>
>>> Only after I first suggested you create cpu and dimm sensors from a
>>> single hwmon driver. Perhaps you should figure out how to fix the
>>> problem with delayed registration. Perhaps you can register the
>>> sensor, but just delay returning actual data until it is ready.
>>>
>>
>> The actual reason why I divided the single hwmon driver into two is for
>> using recommended hwmon API set which doesn't allow incremental
>> creation of sysfs attributes at run time - using of
>> 'devm_hwmon_device_register_with_info' is suggested by Guenter instead
>> of using other deprecated APIs.
>>
>> The reason why the delayed registration is needed is, BMC kernel cannot
>> know how many DIMM are installed in remote machine before the machine
>> completing memory training and testing in POST. So dimm temp driver
>> cannot create hwmon attributes in advance.
>>
>> My thought is, this way is the best to address these requirements.
> 
> As I've previously explained, I do not think this is a good fit for
> MFD.  Since this whole PECI piece is a bit, let's say 'niche', perhaps
> it's better to contain the client within the PECI subsystem too.  You
> can then use the platform_device_add() API to register devices as and
> when required.
> 

If I do like that, I would face the 'DT doesn't allow 2 nodes at the
same address' issue again. Also, as I previously explained, additional
PECI sideband function drivers should be added later through this MFD
driver. For an example, remote CPU crash dump driver which would be an
misc char type driver that are sharing the same unit address also needs
to be added later, and it's definitely not an additional hwmon subsystem
driver. I'm still thinking that an MFD driver is more suitable to
support these mixed-type function drivers that are sharing a single
device unit.

Thanks,

Jae
