From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Thu, 1 Mar 2018 15:15:06 +0100
Subject: [PATCH v2 0/2] STM32 Extended TrustZone Protection driver
In-Reply-To: <20180301140243.3uamdvdcvmsxv6im@lakrids.cambridge.arm.com>
References: <20180301135806.19982-1-benjamin.gaignard@st.com>
 <20180301140243.3uamdvdcvmsxv6im@lakrids.cambridge.arm.com>
Message-ID: <CA+M3ks6YPY6Lx-qBA+-Zrrtzr3Nqyzay=1wBHRGjd7PqJgAb0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-01 15:02 GMT+01:00 Mark Rutland <mark.rutland@arm.com>:
> On Thu, Mar 01, 2018 at 02:58:04PM +0100, Benjamin Gaignard wrote:
>> On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
>> to a secure OS running in TrustZone.
>> We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
>> because read/write accesses could generate illegale access exceptions.
>>
>> Extended TrustZone Protection driver make sure that device is disabled if
>> non-secure world can't acces to it.
>>
>> version 2:
>> - do not use notifier anymore
>> - change status property value in device-tree if needed
>> - use a list of phandle instead of hard coded array
>
> As mentioned on v1, I don't think this should be done in Linux at all.
>
> If you wish to handle this dynamically, please fixup the DT *before*
> entering Linux.
>
> If you want a sane default in the dts file, put status = "disabled" on
> all nodes which the secure world might take ownership of.

That is the case, nodes are disabled by ealier boot stages before entering
in Linux but, since mistakes and/or errors are always possible, fixup the DT
to avoid illegal access exceptions make sense for me.

Benjamin

>
> Thanks,
> Mark.
>
>> NOTE: Those patches should be applied only on
>> git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
>> until this patch: https://lkml.org/lkml/2018/2/26/386
>> find it way to mainline because KBuild will complain about them.
>>
>> Benjamin Gaignard (2):
>>   dt-bindings: stm32: Add bindings for Extended TrustZone Protection
>>   ARM: mach-stm32: Add Extended TrustZone Protection driver
>>
>>  .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       |  25 +++++
>>  arch/arm/mach-stm32/Kconfig                        |   7 ++
>>  arch/arm/mach-stm32/Makefile                       |   1 +
>>  arch/arm/mach-stm32/stm32-etzpc.c                  | 116 +++++++++++++++++++++
>>  4 files changed, 149 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
>>  create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c
>>
>> --
>> 2.15.0
>>
