From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 29 Jan 2018 14:55:48 +0000
Subject: [PATCH 0/4] efi/arm64: unmap the kernel during runtime service
 calls
In-Reply-To: <bdba264b-6619-6e9f-2849-d9d82a820ab0@codeaurora.org>
References: <20180125103131.19168-1-ard.biesheuvel@linaro.org>
 <bdba264b-6619-6e9f-2849-d9d82a820ab0@codeaurora.org>
Message-ID: <CAKv+Gu-KEXJet4TdRcGBAtOH-ty79_izHcH4mu7Y7xF5UtOWsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2018 at 14:51, Jeffrey Hugo <jhugo@codeaurora.org> wrote:
> On 1/25/2018 3:31 AM, Ard Biesheuvel wrote:
>
>> Note that capsule update has been omitted. This is a bit involved, and
>> I'd rather get some feedback before burning too many cycles on that. All
>> other services should be functional, with the caveat that EFI variable
>> names are now limited to 1024 [wide] characters, and UEFI variables
>> themselves to 64 KB.
>>
>
> I'm curious, why these limitations?
>

Because mapping and unmapping things on the fly in the UEFI page
tables is a bit complicated, although I need to do something of the
kind for capsules anyway, so once I solve that, we can use the same
approach for variables.

> We don't have any concern about the name length limitation at this time, but
> the variable size one is concerning.
>
> We have a feature which creates a variable greater than 64KB that we want to
> utilize from Linux.  The size limitation would seem to prevent that.
>

Well, the limit itself is rather arbitrary, and putting >64 KB into
the fault tolerant, write ahead logging NOR flash seems mildly
inappropriate to me. But you are right, the spec currently has no such
limitations, so ideally, nor should the OS.
