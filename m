From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Oct 2016 21:35:00 +0100
Subject: [PATCH 1/2] efi: add support for seeding the RNG from a UEFI
 config table
In-Reply-To: <CAGXu5jKx5cvZsBwC1AJZ3Q4CCn-nxD3Jejs5irQLRan+j305Cw@mail.gmail.com>
References: <1475749646-10844-1-git-send-email-ard.biesheuvel@linaro.org>
 <1475749646-10844-2-git-send-email-ard.biesheuvel@linaro.org>
 <20161019110926.GG9616@leverpostej>
 <CAKv+Gu9g1W8EfnJN2Y_Xgo=QKC1gHa95rjO32Dqt4uT+amzhnQ@mail.gmail.com>
 <20161019112243.GD31476@codeblueprint.co.uk>
 <CAGXu5jJ-KTVJLwAp6iZ-tp5AKnAzSHz80yZkg4dh3uYDz3MsJw@mail.gmail.com>
 <CAKv+Gu92dC6BK7Adb2xLvPwNXv=z15A0zhss_XVNfd+r0NA0SA@mail.gmail.com>
 <CAGXu5jKx5cvZsBwC1AJZ3Q4CCn-nxD3Jejs5irQLRan+j305Cw@mail.gmail.com>
Message-ID: <8029158E-6144-4842-884C-918F1F916E05@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 19 Oct 2016, at 21:20, Kees Cook <keescook@chromium.org> wrote:
> 
> On Wed, Oct 19, 2016 at 1:18 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 19 October 2016 at 21:14, Kees Cook <keescook@chromium.org> wrote:
>>>> On Wed, Oct 19, 2016 at 4:22 AM, Matt Fleming <matt@codeblueprint.co.uk> wrote:
>>>>> On Wed, 19 Oct, at 12:13:55PM, Ard Biesheuvel wrote:
>>>>>> On 19 October 2016 at 12:09, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>> 
>>>>>> I think to some extent this mush be treated as an ABI, given cases like
>>>>>> kexec.
>>>>>> 
>>>>> 
>>>>> Perhaps, yes. That would also allow GRUB or other EFI aware
>>>>> bootloaders to generate the seed.
>>>> 
>>>> If we're going to go down this route, we should try and get the GUID
>>>> into the UEFI spec.
>>> 
>>> It seems like maybe under UEFI, both this table (which sounds like
>>> it'll not be rotated regularly)
>> 
>> What do you mean 'rotated'? It is generated at boot. My 2/2 patch
>> generates it from the stub using the EFI_RNG_PROTOCOL on ARM/arm64
> 
> Oh! I entirely misunderstood. I thought doing regular writes to EFI
> variables was discouraged (since they may be stored in NVRAM that
> would "wear out")

Uefi config tables only live in memory. They are used to provide the os with data that the firmware generates at boot, e.g., smbios and acpi tables etc

>>> could be mixed with calls to
>>> EFI_PROTOCOL_RNG by the kernel? (Similar to how kaslr is seeded?)
>>> 
>> 
>> That is kind of the point. KASLR is different because we need the
>> entropy before even jumping to C code, but for all other uses of early
>> entropy, this seemed like a useful approach
> 
> Yup, cool. If the table changes per boot, yeah, my suggestion is pointless. :)
> 

Yes, but as Mark pointed out, we need to decide how to handle kexec, which does not go through the stub
