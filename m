From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 05 Apr 2013 22:16:34 +0400
Subject: [PATCH v5 3/3] ARM: shmobile: sh73a0: add CPUFreq support
In-Reply-To: <Pine.LNX.4.64.1304051959500.997@axis700.grange>
References: <1365156038-12467-1-git-send-email-g.liakhovetski@gmx.de>
 <1365156038-12467-4-git-send-email-g.liakhovetski@gmx.de>
 <515EF6C6.6050006@cogentembedded.com>
 <Pine.LNX.4.64.1304051959500.997@axis700.grange>
Message-ID: <515F1502.3080301@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 10:04 PM, Guennadi Liakhovetski wrote:

>>> This patch enables the use of the generic cpufreq-cpu0 driver on sh73a0.
>>> Providing a regulator, a list of OPPs in DT, combined with a virtual
>>> cpufreq-cpu0 platform device and a clock, attached to it is everything,
>>> the cpufreq-cpu0 driver needs. The first sh73a0 platform, implementing
>>> such CPUFreq support is kzm9g-reference.
>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>>> ---
>>> v5: remove sh73a0-kzm9g-reference.dts hunk, it's now merged into patch 2/3
>>>    arch/arm/mach-shmobile/Kconfig        |    2 ++
>>>    arch/arm/mach-shmobile/setup-sh73a0.c |    5 +++++
>>>    2 files changed, 7 insertions(+), 0 deletions(-)
>>> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
>>> index 1a517e2..4ac5bf9 100644
>>> --- a/arch/arm/mach-shmobile/Kconfig
>>> +++ b/arch/arm/mach-shmobile/Kconfig
>> [...]
>>> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c
>>> b/arch/arm/mach-shmobile/setup-sh73a0.c
>>> index d10ded0..9a522f9 100644
>>> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
>>> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
>>> @@ -1003,6 +1003,8 @@ static const struct of_dev_auxdata
>>> sh73a0_auxdata_lookup[] __initconst = {
>>>
>>>    void __init sh73a0_add_standard_devices_dt(void)
>>>    {
>>> +	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id =
>>> -1, };
>>     With NULL .parent? Shouldn't it be 'platform_bus'?
> Look at platform_device_add():
>
> 	if (!pdev->dev.parent)
> 		pdev->dev.parent = &platform_bus;

    Ah, thanks for pointing that out -- I didn't follow the call chain.
I could have passed NULL to platform_device_register_resndata()
too then... Well, now it's too late, and it doesn't matter much anyway.

WBR, Sergei
