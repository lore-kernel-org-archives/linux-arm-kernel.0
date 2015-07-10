From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 10 Jul 2015 15:42:02 -0500
Subject: Build error with !CONFIG_SMP in v4.2-rc1 on arm multi_v7_defconfig
In-Reply-To: <20150710203933.GH2049@linaro.org>
References: <55A01D84.8070701@ti.com> <55A01EBB.2040106@codeaurora.org>
 <55A02B17.40705@ti.com> <20150710203933.GH2049@linaro.org>
Message-ID: <55A02E1A.5070307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2015 03:39 PM, Lina Iyer wrote:
> On Fri, Jul 10 2015 at 14:29 -0600, Dave Gerlach wrote:
>> On 07/10/2015 02:36 PM, Stephen Boyd wrote:
>>> On 07/10/2015 12:31 PM, Dave Gerlach wrote:
>>>> Hello,
>>>> I am seeing the following error when building v4.2-rc1 for arm with
>>>> multi_v7_defconfig with CONFIG_SMP=n:
>>>>
>>>>  LINK    vmlinux
>>>>   LD      vmlinux.o
>>>>   MODPOST vmlinux.o
>>>>   GEN     .version
>>>>   CHK     include/generated/compile.h
>>>>   UPD     include/generated/compile.h
>>>>   CC      init/version.o
>>>>   LD      init/built-in.o
>>>> drivers/built-in.o: In function `qcom_pm_collapse':
>>>> :(.text+0xaf44c): undefined reference to `qcom_scm_cpu_power_down'
>>>> drivers/built-in.o: In function `qcom_cpuidle_init':
>>>> :(.init.text+0x9508): undefined reference to `qcom_scm_set_warm_boot_addr'
>>>> make: *** [vmlinux] Error 1
>>>>
>>>>
>>>> It appears the calling functions in drivers/soc/qcom/spm.c get included by
>>>> CONFIG_QCOM_PM which is part of multi_v7_defconfig but the missing functions
>>>> from drivers/firmware/qcom_scm.c only get included by CONFIG_QCOM_SCM if SMP is
>>>> selected. I am not sure if the correct approach is to remove CONFIG_QCOM_PM
>>>> from
>>>> multi_v7_defconfig or to remove 'if SMP' from CONFIG_QCOM_SCM, or something
>>>> else
>>>> entirely. Thoughts?
>>>>
>>>>
>>>
>>> CONFIG_QCOM_PM should select CONFIG_QCOM_SCM unconditionally.
>>>
>>
>> Ok thanks, I can send a quick patch.
>>
> I sent one a few minutes ago, in reply to your mail :)

Thank you! Does indeed solve the problem.

Regards,
Dave
