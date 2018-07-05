From: james.morse@arm.com (James Morse)
Date: Thu, 5 Jul 2018 12:02:15 +0100
Subject: [PATCH v2 3/4] efi/arm: map UEFI memory map earlier on boot
In-Reply-To: <20180705094313.GL28220@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-4-takahiro.akashi@linaro.org>
 <20180704170655.GD8370@arm.com>
 <CAKv+Gu9_rYYyQ+t89otz46DR0D4GDj-cCjhx9q=p+D8LWFRkgQ@mail.gmail.com>
 <20180705094313.GL28220@linaro.org>
Message-ID: <ec1a5f0f-99e3-fda1-9a64-5c2539817190@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 05/07/18 10:43, AKASHI Takahiro wrote:
> On Wed, Jul 04, 2018 at 08:49:32PM +0200, Ard Biesheuvel wrote:
>> On 4 July 2018 at 19:06, Will Deacon <will.deacon@arm.com> wrote:
>>> On Tue, Jun 19, 2018 at 03:44:23PM +0900, AKASHI Takahiro wrote:
>>>> Since arm_enter_runtime_services() was modified to always create a virtual
>>>> mapping of UEFI memory map in the previous patch, it is now renamed to
>>>> efi_enter_virtual_mode() and called earlier before acpi_load_tables()
>>>> in acpi_early_init().
>>>>
>>>> This will allow us to use UEFI memory map in acpi_os_ioremap() to create
>>>> mappings of ACPI tables using memory attributes described in UEFI memory
>>>> map.

>>> Hmm, this is ugly as hell. Is there nothing else we can piggy-back off?
>>> It's also fairly jarring that, on x86, efi_enter_virtual_mode() is called
>>> a few lines later, *after* acpi_early_init() has been called.

>> Currently, there is a gap where we have already torn down the early
>> mapping and haven't created the definitive mapping of the UEFI memory
>> map. There are other reasons why this is an issue, and I recently
>> proposed [0] myself to address one of them

>> Akashi-san, could you please confirm whether the patch below would be
>> sufficient for you? Apologies for going back and forth on this, but I
>> agree with Will that we should try to avoid warts like the one above
>> in generic code.
>>
>> [0] https://marc.info/?l=linux-efi&m=152930773507524&w=2
> 
> I think that this patch will also work.
> Please drop my patch#2 and #3 if you want to pick up my patchset, Will.

Patch 2 is what changes arm_enable_runtime_services() to map the efi memory map
before bailing out due to efi=noruntime.

Without it, 'efi=noruntime' means no-acpi-tables.


Thanks,

James
