From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 May 2015 09:16:09 +0200
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <5566911B.6060506@linaro.org>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org>
 <55653538.8020206@codeaurora.org> <2420285.dn5MbvMKXS@wuerfel>
 <55664FD9.1090808@codeaurora.org> <5566911B.6060506@linaro.org>
Message-ID: <CAKv+Gu-3weYeYZYUmjX3ba56f7Rdxr0zkU8qhhhVFYiVF47Yfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 May 2015 at 05:52, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2015?05?28? 07:14, Timur Tabi wrote:
>>
>> On 05/27/2015 11:39 AM, Arnd Bergmann wrote:
>>>
>>> ACPI support has just been merged and is still experimental. You
>>> should be able to boot your system by passing a DT blob at the
>>> initial boot that matches your hardware. Can you try if that
>>> makes kexec work?
>>
>>
>> If I had an initial DT blob that matched by hardware, I wouldn't need
>> ACPI support!  This is an ARM64 Server system.  There is no device tree
>> for the hardware.  Everything is in ACPI.
>>
>> What does x86 do?  They don't have device trees, but they do use ACPI,
>> so how does kexec work there?
>
>
> So the key point is that we need to get the root pointer to the
> ACPI tables (RSDP), which is in the UEFI configuration table as
> Ard said, I think this part is the same for ARM64 and x86.
>
> ACPI provide an early param "acpi_rsdp" for kexec use as a option,
> you can refer to Documentation/kernel-parameters.txt.
>

Yes, but acpi_rsdp= really shouldn't be needed if the kexec'ed kernel
boots via UEFI.

So I think the issue may be (but Timur really needs to confirm) that
the DT passed via kexec does not contain all the UEFI specific nodes
in /chosen that are present in /sys/firmware/fdt.

@Timur: could you try passing the contents of /sys/firmware/fdt verbatim?
