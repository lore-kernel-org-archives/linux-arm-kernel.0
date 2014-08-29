From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 29 Aug 2014 18:12:48 +0200
Subject: [PATCH 2/2] efi/arm64: use UEFI for system reset
In-Reply-To: <20140829160448.GF4995@arm.com>
References: <1409324757-12607-1-git-send-email-ard.biesheuvel@linaro.org>
 <1409324757-12607-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140829160448.GF4995@arm.com>
Message-ID: <CAKv+Gu-u6Q_t9yU4Cb=0-XmEkmejuMwpy2AN8cBABUHEZxg4dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 August 2014 18:04, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Aug 29, 2014 at 04:05:57PM +0100, Ard Biesheuvel wrote:
>> If UEFI Runtime Services are available, they are preferred over direct
>> PSCI calls or other methods to reset the system.
>>
>> For the reset case, we need to hook into machine_restart(), as the
>> arm_pm_restart function pointer may be overwritten by modules.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/process.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 1309d64aa926..335a93da5eeb 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -177,6 +177,13 @@ void machine_restart(char *cmd)
>>       local_irq_disable();
>>       smp_send_stop();
>>
>> +     /*
>> +      * arm_pm_restart is exported to modules, so the only way to supersede
>> +      * it with efi_reboot() is to call it here.
>> +      */
>
> Why do you make this the preferred method? Is there a risk that UEFI is
> broken and we want to override it with a SoC-specific driver (I wouldn't
> like it but it's still an option).
>

For poweroff (the other patch), it may not make a huge difference, but
the SBBR does state it explicitly.

For reboot, we *have* to use EFI reboot in order to support capsules:
when using capsules (for instance, for updating the firmware), you
need to use EFI reboot as you need to pass the return code of
UpdateCapsule() (a runtime service) to ResetSystem()

> There are also some patches here that try to get rid of arm_pm_restart:
>
> https://lkml.org/lkml/2014/8/19/665
>
> Once there are no drivers for arm64 setting arm_pm_restart explicitly
> I'll remove it.
>

OK, good to know. I will revisit this once that stuff is in.

-- 
Ard.

>> +     if (IS_ENABLED(CONFIG_EFI) && efi_enabled(EFI_RUNTIME_SERVICES))
>
> efi_enabled always returns false if !IS_ENABLED(CONFIG_EFI).
>
>> +             efi_reboot(REBOOT_WARM, NULL);
>> +
>>       /* Now call the architecture specific reboot code. */
>>       if (arm_pm_restart)
>>               arm_pm_restart(reboot_mode, cmd);
>> --
>> 1.8.3.2
>>
>>
>
> --
> Catalin
