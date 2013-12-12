From: al.stone@linaro.org (Al Stone)
Date: Thu, 12 Dec 2013 13:31:48 -0700
Subject: [Linaro-acpi] [PATCH v3 1/5] ACPI: introduce
 CONFIG_ACPI_REDUCED_HARDWARE to enable this ACPI mode
In-Reply-To: <20131210224912.996FCC40CE1@trevor.secretlab.ca>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org> <
 1386192127-28564-2-git-send-email-al.stone@linaro.org> <20131210123717.
 59493C40A27@trevor.secretlab.ca> <52A72D9F.1070004@linaro.org>
 <20131210224912.996FCC40CE1@trevor.secretlab.ca>
Message-ID: <52AA1D34.3080808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2013 03:49 PM, Grant Likely wrote:
> Hi Hanjun,
>
> Okay, so after talking with Al and Graeme on IRC, I think I understand
> what is going on. The fact that ACPICA doesn't allow for both normal and
> hardware reduced support in the same build is a very big problem.
> However, it isn't a problem for ARM since we'll never support
> non-hardware reduced mode. The x86 folks need to work that out when/if
> they ever add support for hardware reduced mode.
>
> So I would say the thing to do is only allow hardware reduced mode to be
> enabled on ARM, and make it ultra clear in the config text that it
> cannot be supported on x86 before ACPICA is fixed.
>
> g.

Agreed.  Will make it so in the next version.

> On Tue, 10 Dec 2013 23:05:03 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> On 2013???12???10??? 20:37, Grant Likely wrote:
>>> On Wed,  4 Dec 2013 14:22:03 -0700, al.stone at linaro.org wrote:
>>>> From: Al Stone <al.stone@linaro.org>
>>>>
>>>> To enable the hardware reduced mode of ACPI on some platforms (such as
>>>> ARM), we need to modify the kernel code and set ACPI_REDUCED_HARDWARE
>>>> to TRUE in the ACPICA source.
>>>>
>>>> This can be done more resonably by introducing a kernel config item
>>>> to enable/disable ACPI_REDUCED_HARDWARE.  We can then change the kernel
>>>> config instead of having to modify the kernel source directly to enable
>>>> the reduced hardware mode of ACPI.
>>>>
>>>> Lv Zheng suggested that this configuration item does not belong in ACPICA,
>>>> the upstream source for much of the ACPI internals, but rather to the
>>>> Linux kernel itself.  Hence, we introduce this flag so that we can make
>>>> ACPI_REDUCED_HARDWARE configurable.  For the details of the discussion,
>>>> please refer to: http://www.spinics.net/lists/linux-acpi/msg46369.html
>>>>
>>>> Support for X86 in hardware reduced mode is also provided to make it
>>>> simpler to debug this mode, and to provide for probable use in such
>>>> products.  Hardware reduced mode, despite the name, exists primarily
>>>> to allow newer platforms to use a much simpler form of ACPI that does
>>>> not require supporting the legacy of previous versions of the specification,
>>>> and is likely to be used more often in the near future as a result.
>>>>
>>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>>> ---
>>>>    drivers/acpi/Kconfig            | 8 ++++++++
>>>>    include/acpi/platform/aclinux.h | 6 ++++++
>>>>    2 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index 5d92485..66e6bb2 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -343,6 +343,14 @@ config ACPI_BGRT
>>>>    	  data from the firmware boot splash. It will appear under
>>>>    	  /sys/firmware/acpi/bgrt/ .
>>>>
>>>> +config ACPI_REDUCED_HARDWARE
>>>> +	bool "Hardware-reduced ACPI support"
>>>> +	depends on X86 || ARM || ARM64
>>>> +	help
>>>> +	This config adds support for Hardware-reduced ACPI. When this option
>>>> +	is selected, will generate a specialized version of ACPICA that ONLY
>>>> +	supports the ACPI "reduced hardware".
>>>> +
>>>>    source "drivers/acpi/apei/Kconfig"
>>>>
>>>>    config ACPI_EXTLOG
>>>> diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
>>>> index 28f4f4d..a33f502 100644
>>>> --- a/include/acpi/platform/aclinux.h
>>>> +++ b/include/acpi/platform/aclinux.h
>>>> @@ -52,6 +52,12 @@
>>>>
>>>>    #ifdef __KERNEL__
>>>>
>>>> +/* Compile for reduced hardware mode if requested for this kernel config */
>>>> +
>>>> +#ifdef CONFIG_ACPI_REDUCED_HARDWARE
>>>> +#define ACPI_REDUCED_HARDWARE 1
>>>> +#endif
>>> Will this change the way ACPICA is compiled? Will it disable
>>> non-hardware-reduced mode?
>>
>> Both yes. ACPICA supports reduced hardware mode when
>> ACPI_REDUCED_HARWARE is TRUE at compile time. There is
>> no way to support both normal ACPI and hardware reduced
>> ACPI with single binary image for now.
>>
>>> If so, then this is a big problem. Enabling
>>> the hardware reduced feature should *not* break normal ACPI usage.
>>
>> It will break normal ACPI usage but it is ok I think. Since
>> lots of features are not supported in the hardware in hardware
>> reduced mode, and normal ACPI will not run probably such as
>> leading kernel panic when refer to some registers which are not
>> exist on reduced hardware, we should introduce this kernel
>> config and modify the ACPI drivers to avoid such failures.
>>
>> Thanks
>> Hanjun
>>
>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone at linaro.org
-----------------------------------
