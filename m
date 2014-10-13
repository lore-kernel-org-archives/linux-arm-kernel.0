From: semen.protsenko@linaro.org (Sam Protsenko)
Date: Mon, 13 Oct 2014 19:14:15 +0300
Subject: [PATCH] efi/arm64: store Runtime Services revision
In-Reply-To: <20140826090533.GA3193@arm.com>
References: <1408028122-1784-1-git-send-email-semen.protsenko@linaro.org>
 <20140826090533.GA3193@arm.com>
Message-ID: <CAGBcZGe2eYUH5i0P+ffkXABdLGYrBciYQLO6Jwd8kKAWtcBkKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I doubt it makes any difference

It really does. The whole reason I made this patch is that I was
unable to call UpdateCapsule() runtime service, because when you try
to call it, kernel code first tests if we have UEFI with certain
Runtime Services revision. In this code
(drivers/firmware/efi/runtime.c):

static efi_status_t virt_efi_update_capsule(efi_capsule_header_t **capsules,
                                            unsigned long count,
                                            unsigned long sg_list)
{
        if (efi.runtime_version < EFI_2_00_SYSTEM_TABLE_REVISION)
                return EFI_UNSUPPORTED;

        return efi_call_virt(update_capsule, capsules, count, sg_list);
}

Condition is false, because efi.runtime_version == 0. The same stuff
was happening about some other Runtime Services. So this patch just
fixes this.

> but can we assign this before we call efi_native_runtime_setup please?

Yeah, it's quite late for this as patch is already upstreamed :)
Anyway, if you could explain why it's essential -- I can make another
patch moving this code to correct place.

On 26 August 2014 12:05, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Aug 14, 2014 at 03:55:22PM +0100, Semen Protsenko wrote:
>> "efi" global data structure contains "runtime_version" field which must
>> be assigned in order to use it later in Runtime Services virtual calls
>> (virt_efi_* functions).
>>
>> Before this patch "runtime_version" was unassigned (0), so each
>> Runtime Service virtual call that checks revision would fail.
>>
>> Runtime Services revision being passed in UEFI system table from UEFI
>> to kernel (see efi_entry() function). In UEFI it's being stored at
>> MdePkg/Include/Uefi/UefiSpec.h as EFI_RUNTIME_SERVICES_REVISION.
>>
>> Signed-off-by: Semen Protsenko <semen.protsenko@linaro.org>
>> ---
>>  arch/arm64/kernel/efi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
>> index e72f310..5dbb7bd 100644
>> --- a/arch/arm64/kernel/efi.c
>> +++ b/arch/arm64/kernel/efi.c
>> @@ -463,6 +463,8 @@ static int __init arm64_enter_virtual_mode(void)
>>       efi_native_runtime_setup();
>>       set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
>>
>> +     efi.runtime_version = efi.systab->hdr.revision;
>> +
>>       return 0;
>
> I doubt it makes any difference, but can we assign this before we call
> efi_native_runtime_setup please?
>
> Will
