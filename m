From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 22 Apr 2016 16:12:59 +0200
Subject: [PATCHv2 0/6] efi: detect erroneous firmware IRQ manipulation
In-Reply-To: <1461333083-15529-1-git-send-email-mark.rutland@arm.com>
References: <1461333083-15529-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu8FGpZK4yDito2jKTbjuyE2jojj5tZhCa2qUwKdWL9+ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2016 at 15:51, Mark Rutland <mark.rutland@arm.com> wrote:
> Some firmware erroneously unmask IRQs (and potentially other architecture
> specific exceptions) during runtime services functions, in violation of both
> common sense and the UEFI specification. This can result in a number of issues
> if said exceptions are taken when they are expected to be masked, and
> additionally can confuse IRQ tracing if the original mask state is not
> restored prior to returning from firmware.
>
> In practice it's difficult to check that firmware never unmasks exceptions, but
> we can at least check that the IRQ flags are at least consistent upon entry to
> and return from a runtime services function call. This series implements said
> check in the shared EFI runtime wrappers code, after an initial round of
> refactoring such that this can be generic.
>
> I have left ia64 as-is, without this check, as ia64 doesn't currently use the
> generic runtime wrappers, has many special cases for the runtime calls which
> don't fit well with the generic code, and I don't expect a new, buggy ia64
> firmware to appear soon.
>
> The first time corruption of the IRQ flags is detected, we dump a stack trace,
> and set TAINT_FIRMWARE_WORKAROUND. Additionally, and in all subsequent cases,
> we log (with ratelimiting) the specific corruption of the flags, and restore
> the expected flags to avoid redundant warnings elsewhere.
>
> Since v1 [1]:
> * Fix thinko: s/local_irq_save/local_save_flags/
> * Remove ifdefs after conversion
> * Remove reundant semicolon from x86 patch
> * Move efi_call_virt_check_flags before first use
> * Add Acked-bys and Reviewed-bys
>
> Ard, I assume that your Reviewed-by still stands for the final patch, even
> though efi_call_virt_check_flags moved. Please shout if that's not the case!
>

No, that's fine. Thanks for respinning so quickly.

> Hopefully you're also happy to extend that to the new patch removing the
> ifdefs once they become superfluous.
>

Matt: in case your review bandwidth is limited atm, I'd much prefer
this series making v4.7 than the GOP stuff or the other stuff i have
been posting over the past weeks.

Thanks,
Ard.
