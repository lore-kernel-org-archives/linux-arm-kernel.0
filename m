From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 7 Jul 2014 22:43:31 +0200
Subject: [PATCH 2/2] efi: implement mandatory locking for UEFI Runtime
 Services
In-Reply-To: <20140707202954.GC27474@console-pimps.org>
References: <1404295802-28030-1-git-send-email-ard.biesheuvel@linaro.org>
 <1404295802-28030-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140707202954.GC27474@console-pimps.org>
Message-ID: <CAKv+Gu91CQADTQ8KMjXQPwVDvW1XkUYO2E5=Mu=aAtrB8B3q_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 July 2014 22:29, Matt Fleming <matt@console-pimps.org> wrote:
> On Wed, 02 Jul, at 12:10:02PM, Ard Biesheuvel wrote:
>> According to section 7.1 of the UEFI spec, Runtime Services are not fully
>> reentrant, and there are particular combinations of calls that need to be
>> serialized.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/firmware/efi/runtime-wrappers.c | 109 +++++++++++++++++++++++++++++---
>>  1 file changed, 99 insertions(+), 10 deletions(-)
>
> Ard, what's going on with this one? I didn't see it resubmitted along
> with v3 of "efi/arm64: handle missing virtual mapping for UEFI System
> Table".
>
> Note that we already have a lock to serialize access to the UEFI
> variable services in the form of __efivars->lock, see
> drivers/firmware/efi/vars.c. It's a spinlock because of the context we
> may need to create variables in from efi_pstore_write().
>

As the patch says, the UEFI spec is very clear on which combinations
of calls are not reentrant.
I don't think the rtc_lock and the efivars->lock quite cover that completely ...
