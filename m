From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Jul 2014 11:45:03 +0200
Subject: [PATCH 2/2] efi: implement mandatory locking for UEFI Runtime
 Services
In-Reply-To: <20140708092958.GD27474@console-pimps.org>
References: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
 <1404295802-28030-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140707202954.GC27474@console-pimps.org>
 <CAKv+Gu91CQADTQ8KMjXQPwVDvW1XkUYO2E5=Mu=aAtrB8B3q_A@mail.gmail.com>
 <CAKv+Gu8LbfuuEYyhAeu3dUiKHqzN_UFMbOjY0agVihbmmVL9CA@mail.gmail.com>
 <20140708092958.GD27474@console-pimps.org>
Message-ID: <CAKv+Gu9HkJgsnzUAROVwPKaHGHRU9FwAp+eOT8N8kYDR3Dda+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 July 2014 11:29, Matt Fleming <matt@console-pimps.org> wrote:
> On Tue, 08 Jul, at 10:54:13AM, Ard Biesheuvel wrote:
>>
>> After doing a bit more research, I still think there is work needed if
>> we aim to adhere to the UEFI spec, or at least be safe from the
>> hazards it points out.
>
> Note that I never claimed there wasn't a need for an EFI runtime lock, I
> was just pointing out that you need to consider the efi-pstore scenario,
> and that a mutex isn't suitable in that case.
>
> I did in fact make a half-arsed attempt at introducing a runtime lock
> here,
>
>   http://git.kernel.org/cgit/linux/kernel/git/mfleming/efi.git/commit/?h=capsule-blkdev&id=c0a88ac5b21f3c837121748be2e59e995126a6cb
>
> Provided we can get away with a single EFI runtime lock like that patch,
> your recent efi_call_virt() changes actually make the required patch
> much simpler, at least for arm64 and x86.
>

Indeed.

>> So the current status is:
>> - get/set time calls are serialized with respect to one another using
>> rtc_lock at the wrapper level
>
> The time functions are completely unused on x86, which is why no proper
> runtime locking exists. It's basically dead code.
>

OK. That may be different on ARM, though ...

>> - get/set variable calls are serialized using the efivars->lock in the
>> efivars module
>> - get_next_variable() calls use the BKL
>
> It uses __efivars->lock just like the other variable services. Is that
> what you meant by BKL?
>

Well, that is what is says in the comment:
         * ops.get_next_variable() is only called from register_efivars()
         * or efivar_update_sysfs_entries(),
         * which is protected by the BKL, so that path is safe.

>> The two things I am most concerned with are:
>> - reset system while other calls are in flight; is this handled
>> implicitly in some other way?
>
> No, it isn't handled, so yeah, it needs fixing. I think on x86 we
> actually wait for other cpus to shutdown before issuing the reset but
> it's obviously not possible to make that guarantee across architectures.
>

Exactly.

>> - things like settime()/setwakeuptime() and setvariable() poking into
>> the flash at the same time.
>>
>> Perhaps it would be sufficient to have a single spinlock cover all
>> these cases? Or just let efivars grab the rtc_lock as well?
>
> I think we need to introduce a separate lock, logically below all other
> subsystem specific ones (rtc_lock, __efivars->lock, etc). It needs to be
> the final lock you grab before invoking the runtime services.
>
> I don't think the additional complexity of introducing multiple locks to
> parallelise access to, say, GetTime() and GetVariable(), is really worth
> the headache. Definitely not without someone making a really compelling
> case for why they need to squeeze every ounce of performance out of that
> scenario.


I agree. So shall I update my patch to add a single spin_lock that is
used by all wrappers?
We will likely need the wrappers on ARM as well, only ia64 needs
another approach (if desired)

-- 
Ard.
