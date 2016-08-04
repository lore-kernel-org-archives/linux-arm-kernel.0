From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 4 Aug 2016 17:11:23 +0100
Subject: [PATCH 2/2] coresight: fix handling of ETM trace register access
 via sysfs
In-Reply-To: <CANLsYkyX--cokkFOQHDxyw1NeT1kPkkpCjHoyJrKpfYATGpuSg@mail.gmail.com>
References: <1470240752-17331-1-git-send-email-sudeep.holla@arm.com>
 <1470240752-17331-2-git-send-email-sudeep.holla@arm.com>
 <CANLsYkyX--cokkFOQHDxyw1NeT1kPkkpCjHoyJrKpfYATGpuSg@mail.gmail.com>
Message-ID: <ca19d0fc-8c88-9dfa-7c9a-3ba0c3d75a25@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/08/16 17:02, Mathieu Poirier wrote:
> On 3 August 2016 at 10:12, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> The ETM registers are classified into 2 categories: trace and management.
>> The core power domain contains most of the trace unit logic including
>> all(except TRCOSLAR and TRCOSLSR) the trace registers. The debug power
>> domain contains the external debugger interface including all management
>> registers.
>>
>> This patch adds coresight unit specific function coresight_simple_func
>> which can be used for ETM trace registers by providing a ETM specific
>> read function which does smp cross call to ensure the trace core is
>> powered up before the register is accessed.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-etb10.c      |  2 +-
>>  .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  2 +-
>>  .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 58 ++++++++++++++++------
>>  drivers/hwtracing/coresight/coresight-etm4x.h      |  1 +
>>  drivers/hwtracing/coresight/coresight-priv.h       |  9 +++-
>>  drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
>>  drivers/hwtracing/coresight/coresight-tmc.c        |  2 +-
>>  7 files changed, 54 insertions(+), 22 deletions(-)
>>
>> Hi Mathieu,
>>
>> I think the latest release of the firmware(inparticular SCP v1.16.0) for
>> Juno fixes the issue you had previously encountered. However there's a
>> pending issue with A53 ETM management register access when it's powered
>> down.
>>
>> I don't think Juno platform should block these changes as ETMv4
>> specification is clear on the power management and register access
>> perspective.
>>
>> Regards,
>> Sudeep
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>> index 8a4927ca9181..d7325c6534ad 100644
>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -559,7 +559,7 @@ static const struct file_operations etb_fops = {
>>  };
>>
>>  #define coresight_etb10_simple_func(name, offset)                       \
>> -       coresight_simple_func(struct etb_drvdata, name, offset)
>> +       coresight_simple_func(struct etb_drvdata, NULL, name, offset)
>>
>>  coresight_etb10_simple_func(rdp, ETB_RAM_DEPTH_REG);
>>  coresight_etb10_simple_func(sts, ETB_STATUS_REG);
>> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>> index 02d4b629891f..4856c8098416 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
>> @@ -1222,7 +1222,7 @@ static struct attribute *coresight_etm_attrs[] = {
>>  };
>>
>>  #define coresight_etm3x_simple_func(name, offset)                      \
>> -       coresight_simple_func(struct etm_drvdata, name, offset)
>> +       coresight_simple_func(struct etm_drvdata, NULL, name, offset)
>>
>>  coresight_etm3x_simple_func(etmccr, ETMCCR);
>>  coresight_etm3x_simple_func(etmccer, ETMCCER);
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> index 7c84308c5564..2390ee43e3d9 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>> @@ -2039,15 +2039,38 @@ static struct attribute *coresight_etmv4_attrs[] = {
>>         NULL,
>>  };
>>
>> +struct etm_reg {
>> +       void __iomem *addr;
>> +       u32 data;
>> +};
>> +

And this is just declaration, so it's static implicitly unless someone
includes this .c file :)

[...]

>>
>>  static struct attribute *coresight_etmv4_trcidr_attrs[] = {
>>         &dev_attr_trcidr0.attr,
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 2629954429a1..ba4dd2e820ea 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -185,6 +185,7 @@
>>
>>  /* PowerDown Control Register bits */
>>  #define TRCPDCR_PU                     BIT(3)
>> +#define TRCPDSR_POWER                  BIT(0)
>
> I forgot - this isn't referenced anywhere.
>

Right will remove it, added it while I was experimenting things out.

-- 
Regards,
Sudeep
