From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 17 Nov 2015 21:21:46 +0800
Subject: [PATCH v3 24/62] arm: Introduce a generic way to use a device
 from acpi
In-Reply-To: <564B2023.8010801@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-25-git-send-email-shannon.zhao@linaro.org>
 <564B2023.8010801@citrix.com>
Message-ID: <564B29EA.3060107@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/17 20:40, Julien Grall wrote:
> Hi Shannon,
> 
> On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
>> From: Parth Dixit <parth.dixit@linaro.org>
>>
>> Add generic way to use device from acpi similar to the way it is
>> supported in device tree.
>>
>> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
>> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
>> ---
>>  xen/arch/arm/device.c        | 19 +++++++++++++++++++
>>  xen/arch/arm/xen.lds.S       |  7 +++++++
>>  xen/include/asm-arm/device.h | 30 ++++++++++++++++++++++++++++++
>>  3 files changed, 56 insertions(+)
>>
>> diff --git a/xen/arch/arm/device.c b/xen/arch/arm/device.c
>> index 0b53f6a..5494de0 100644
>> --- a/xen/arch/arm/device.c
>> +++ b/xen/arch/arm/device.c
>> @@ -22,6 +22,7 @@
>>  #include <xen/lib.h>
>>  
>>  extern const struct device_desc _sdevice[], _edevice[];
>> +extern const struct acpi_device_desc _asdevice[], _aedevice[];
>>  
>>  int __init device_init(struct dt_device_node *dev, enum device_class class,
>>                         const void *data)
>> @@ -50,6 +51,24 @@ int __init device_init(struct dt_device_node *dev, enum device_class class,
>>      return -EBADF;
>>  }
>>  
>> +int __init acpi_device_init(enum device_class class, const void *data, int class_type)
> 
> As said on a previous version, please explain what means class_type and
> how this will fit with every
> ACPI device tables.
> 
> AFAICT, it does only works for SPCR table used for UART device. For the
> GIC you've hardcoded the value and I can't find any version number in
> the table.
> 
No, I didn't hardcode the GIC version. Since ACPI 6.0 introduces GIC
version in generic distributor table, it could get the version from
that. Please see [PATCH v3 28/62].

> You may need to introduce another way to find the device such as a
> callback taking the table in parameter.
> 

-- 
Shannon
