From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Mon, 11 Jul 2016 11:12:16 -0700
Subject: [PATCH v7 3/4] perf: xgene: Add APM X-Gene SoC Performance
 Monitoring Unit driver
In-Reply-To: <CAP=VYLrsfOTgJmMBz-R_pQ+GXa4UEb2a=jH7TJBwcHz6UTxGKQ@mail.gmail.com>
References: <1467850045-10584-1-git-send-email-ttnguyen@apm.com>
 <1467850045-10584-4-git-send-email-ttnguyen@apm.com>
 <CAP=VYLrsfOTgJmMBz-R_pQ+GXa4UEb2a=jH7TJBwcHz6UTxGKQ@mail.gmail.com>
Message-ID: <CACgAJHzrvUGDUXgajQswO-ACfs2qcy8b-BL_89QaDqWpWHPmkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Thanks for your comments.

On Sat, Jul 9, 2016 at 5:00 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On Wed, Jul 6, 2016 at 8:07 PM, Tai Nguyen <ttnguyen@apm.com> wrote:
>> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
>> ---
>>  Documentation/perf/xgene-pmu.txt |   48 ++
>>  drivers/perf/Kconfig             |    7 +
>>  drivers/perf/Makefile            |    1 +
>>  drivers/perf/xgene_pmu.c         | 1398 ++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 1454 insertions(+)
>>  create mode 100644 Documentation/perf/xgene-pmu.txt
>>  create mode 100644 drivers/perf/xgene_pmu.c
>>
>
> [...]
>
>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>> index 04e2653..4d5c5f9 100644
>> --- a/drivers/perf/Kconfig
>> +++ b/drivers/perf/Kconfig
>> @@ -12,4 +12,11 @@ config ARM_PMU
>>           Say y if you want to use CPU performance monitors on ARM-based
>>           systems.
>>
>> +config XGENE_PMU
>> +        depends on PERF_EVENTS && ARCH_XGENE
>> +        bool "APM X-Gene SoC PMU"
>
> If the driver is bool, then please avoid using module.h and anything from
> within it.  They are either no-ops when built in, or there are non-modular
> equivalents available, so it is entirely avoidable, and makes for smaller
> and better code.
>

Okay, I'll remove the module.h

>> +        default n
>> +        help
>> +          Say y if you want to use APM X-Gene SoC performance monitors.
>> +
>>  endmenu
>> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
>> index acd2397..b116e98 100644
>> --- a/drivers/perf/Makefile
>> +++ b/drivers/perf/Makefile
>> @@ -1 +1,2 @@
>>  obj-$(CONFIG_ARM_PMU) += arm_pmu.o
>> +obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
>
> [...]
>                     ver = {
>> +               .name           = "xgene-pmu",
>> +               .of_match_table = xgene_pmu_of_match,
>> +               .acpi_match_table = ACPI_PTR(xgene_pmu_acpi_match),
>> +       },
>> +};
>> +
>> +module_platform_driver(xgene_pmu_driver);
>
> builtin_platform_driver
>

Okay, I'll change it.

>> +
>> +MODULE_DESCRIPTION("APM X-Gene SoC PMU driver");
>> +MODULE_AUTHOR("Hoan Tran <hotran@apm.com>");
>> +MODULE_AUTHOR("Tai Nguyen <ttnguyen@apm.com>");
>> +MODULE_LICENSE("GPL");
>
> As long as this information is at the top of the file, then these can
> go away too -- just like MODULE_DEVICE_TABLE they are no-op.
>

Will get rid of them.

Regards,
-- 
Tai
