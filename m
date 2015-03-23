From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 23 Mar 2015 15:13:51 +0000
Subject: linux-next: manual merge of the arm-soc tree with the arm-perf
 tree
In-Reply-To: <CAM4voanC-ur=A-UJ+Jw4qECUOnd-gZ2V87794tEVWJOqaqDT+g@mail.gmail.com>
References: <20150323113318.0319c248@canb.auug.org.au>
 <CAM4voanC-ur=A-UJ+Jw4qECUOnd-gZ2V87794tEVWJOqaqDT+g@mail.gmail.com>
Message-ID: <55102DAF.7050206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/03/15 14:41, Abhilash Kesavan wrote:
> Hi Stephen,
>
> On Mon, Mar 23, 2015 at 6:03 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> Today's linux-next merge of the arm-soc tree got a conflict in
>> drivers/bus/Kconfig between commit c9966c98697a ("arm-cci: Split the
>> code for PMU vs driver support") from the arm-perf tree and commit
>> 13fbf3c8d0f7 ("drivers: bus: Sort Kconfig entries alphabetically") from
>> the arm-soc tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary (no action
>> is required).
>
> Not sure if this has been reported elsewhere, but I am seeing core
> boot-up failures on the exynos5420 with next-20150323 due to this.
> Your conflict fix is missing the ARM_CCI symbol because of which the
> CCI does not get enabled.
>
> Suzuki, can you confirm ?
>

Yes, you are right. We need the config ARM_CCI even now, which enables 
the building of the arm-cci.c.

Stephen,

We need the following fix on the linux-next.

Suzuki


diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index f4213b1..e0eac5a 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -4,6 +4,9 @@

  menu "Bus devices"

+config ARM_CCI
+       bool
+
  config ARM_CCI400_PORT_CTRL
         bool
         depends on ARM && OF && CPU_V7


> Regards,
> Abhilash
>>
>> --
>> Cheers,
>> Stephen Rothwell                    sfr at canb.auug.org.au
>>
>> diff --cc drivers/bus/Kconfig
>> index 79e297b1f221,7e9c2674af81..000000000000
>> --- a/drivers/bus/Kconfig
>> +++ b/drivers/bus/Kconfig
>> @@@ -4,6 -4,21 +4,38 @@@
>>
>>    menu "Bus devices"
>>
>>   -config ARM_CCI
>>   -      bool "ARM CCI driver support"
>> ++config ARM_CCI400_PORT_CTRL
>> ++      bool
>> +       depends on ARM && OF && CPU_V7
>> ++      select ARM_CCI400_COMMON
>> +       help
>>   -        Driver supporting the CCI cache coherent interconnect for ARM
>>   -        platforms.
>> ++        Low level power management driver for CCI400 cache coherent
>> ++        interconnect for ARM platforms.
>> ++
>> ++config ARM_CCI400_PMU
>> ++      bool "ARM CCI400 PMU support"
>> ++      default y
>> ++      depends on ARM || ARM64
>> ++      depends on HW_PERF_EVENTS
>> ++      select ARM_CCI400_COMMON
>> ++      help
>> ++        Support for PMU events monitoring on the ARM CCI cache coherent
>> ++        interconnect.
>> ++
>> ++        If unsure, say Y
>> ++
>> ++config ARM_CCI400_COMMON
>> ++      bool
>> ++      select ARM_CCI
>> +
>> + config ARM_CCN
>> +       bool "ARM CCN driver support"
>> +       depends on ARM || ARM64
>> +       depends on PERF_EVENTS
>> +       help
>> +         PMU (perf) driver supporting the ARM CCN (Cache Coherent Network)
>> +         interconnect.
>> +
>>    config BRCMSTB_GISB_ARB
>>          bool "Broadcom STB GISB bus arbiter"
>>          depends on ARM || MIPS
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
