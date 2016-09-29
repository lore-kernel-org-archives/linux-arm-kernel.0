From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Sep 2016 17:13:18 -0700
Subject: [RFC PATCH 0/3] efi: MMC proxy support for the UEFI varstore
In-Reply-To: <201609290154.34433.arnd@arndb.de>
References: <1474543806-19210-1-git-send-email-ard.biesheuvel@linaro.org>
 <201609290154.34433.arnd@arndb.de>
Message-ID: <CAKv+Gu-vPpGyY20943rQZs46orOTEuGGEcN2XEaeyV3RtsxnWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 September 2016 at 16:54, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 22 September 2016, Ard Biesheuvel wrote:
>> ================================================================================
>> NOTE: this is a work in progress, and not fully functional yet. In particular,
>> the actual MMC host protocol methods are stubbed out at the moment, and need to
>> be wired up to the Linux device drivers.
>> ================================================================================
>>
>> On mobile and embedded systems, there is usually only a single MMC device for
>> non-volatile storage, which sits behind a controller that is owned by the OS at
>> runtime. This makes it difficult to host the UEFI variable store on MMC as well,
>> since the UEFI runtime services routines expect ownership of the underlying
>> device as well.
>>
>> This series proposes an approach to work around this. It implements the UEFI
>> MMC host protocol in the kernel, in a way that makes it possible to expose it
>> to the firmware. At the same time, the firmware needs be set up for this, i.e.,
>> it needs to expose its MMC host protocol pointer via a UEFI configuration table,
>> so that the kernel can override it if it decides to expose this functionality
>> to the firmware.
>>
>> Note that these patches are based on patches in the EFI tree that are queued
>> for v4.9, which replace the runtime wrappers spinlock with a semaphore. This
>> allows us to sleep in the firmware callbacks.
>
> Would it be possible to implement the UEFI varstore more generally on top
> of the Linux pstore interface and then have a pstore backend on top of
> MMC? That could give us very similar behavior, but also a bit more flexibility.
> It would be a bit confusing to have the 'dmesg' pstore target on top of
> UEFI varstore which in turn is on top of pstore on MMC, but I think that's
> ok as long as we prevent recursion.
>

The reason for choosing MMC over block I/O or other more generic
interfaces is that it should also allow firmware implementations that
support UEFI secure boot using RPMB/MMC, where the authentication and
the RPMB related crypto are performed by a secure world component that
talks to the firmware directly.
