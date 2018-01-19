From: james.morse@arm.com (James Morse)
Date: Fri, 19 Jan 2018 11:39:58 +0000
Subject: [PATCH] arm64: kdump: retain reserved memory regions
In-Reply-To: <20180111113840.GF18820@linaro.org>
References: <20180110100943.6082-1-takahiro.akashi@linaro.org>
 <5A55F87F.2080501@arm.com> <20180111113840.GF18820@linaro.org>
Message-ID: <5A61D90E.1000907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 11/01/18 11:38, AKASHI Takahiro wrote:
> On Wed, Jan 10, 2018 at 11:26:55AM +0000, James Morse wrote:
>> On 10/01/18 10:09, AKASHI Takahiro wrote:
>>> This is a fix against the issue that crash dump kernel may hang up
>>> during booting, which can happen on any ACPI-based system with "ACPI
>>> Reclaim Memory."

>>> (diagnosis)
>>> * This fault is a data abort, alignment fault (ESR=0x96000021)
>>>   during reading out ACPI table.
>>> * Initial ACPI tables are normally stored in system ram and marked as
>>>   "ACPI Reclaim memory" by the firmware.
>>> * After the commit f56ab9a5b73c ("efi/arm: Don't mark ACPI reclaim
>>>   memory as MEMBLOCK_NOMAP"), those regions' attribute were changed
>>>   removing NOMAP bit and they are instead "memblock-reserved".
>>> * When crash dump kernel boots up, it tries to accesses ACPI tables by
>>>   ioremap'ing them (through acpi_os_ioremap()).
>>> * Since those regions are not included in device tree's
>>>   "usable-memory-range" and so not recognized as part of crash dump
>>>   kernel's system ram, ioremap() will create a non-cacheable mapping here.
>>
>> Ugh, because acpi_os_ioremap() looks at the efi memory map through the prism of
>> what we pulled into memblock, which is different during kdump.
>>
>> Is an alternative to teach acpi_os_ioremap() to ask
>> efi_mem_attributes() directly for the attributes to use?
>> (e.g. arch_apei_get_mem_attribute())
> 
> I didn't think of this approach.
> Do you mean a change like the patch below?

Yes. Aha, you can pretty much re-use the helper directly.

It was just a suggestion, removing the extra abstraction that is causing the bug
could be cleaner ...

> (I'm still debugging this code since the kernel fails to boot.)

... but might be too fragile.

There are points during boot when the EFI memory map isn't mapped. I think that
helper will return 'device memory' for everything when this happens.



Thanks,

James
