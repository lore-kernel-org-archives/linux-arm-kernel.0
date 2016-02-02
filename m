From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 2 Feb 2016 12:09:41 +0100
Subject: [PATCH 1/3] arm64: efistub: drop __init annotation from
 handle_kernel_image()
In-Reply-To: <20160202110821.GB2642@codeblueprint.co.uk>
References: <1453979254-25374-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453979254-25374-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160128225809.GF2571@codeblueprint.co.uk>
 <CAKv+Gu9sE4oJrFmSK8sEjTrU8A7k53Hj1S1pTyCqyA5Gsba2Kw@mail.gmail.com>
 <20160129160006.GD2611@codeblueprint.co.uk>
 <CAKv+Gu96tdf8ZrGHDi_YKacsRF_b336Nu4Anh61j4u3Lg18BHg@mail.gmail.com>
 <20160202110821.GB2642@codeblueprint.co.uk>
Message-ID: <CAKv+Gu_rvLMFF9ssdY4GCWpdcOwaXVsaCvBTYG30NS0zw5xBWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2016 at 12:08, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Fri, 29 Jan, at 05:03:16PM, Ard Biesheuvel wrote:
>> On 29 January 2016 at 17:00, Matt Fleming <matt@codeblueprint.co.uk> wrote:
>> > On Fri, 29 Jan, at 10:36:03AM, Ard Biesheuvel wrote:
>> >> On 28 January 2016 at 23:58, Matt Fleming <matt@codeblueprint.co.uk> wrote:
>> >> >
>> >> > Would it make more sense to #undef __init in one of the arm64 efistub
>> >> > header files? I'm thinking of the case where some poor unsuspecting
>> >> > developer writes a new function and marks it as __init, and we miss it
>> >> > during review.
>> >> >
>> >>
>> >> Yes, I can add it to efistub.h, and make sure it gets included in all the files
>> >>
>> >> Should we #undef it and #define it to a string that is easily grep'ed
>> >> for, so it is easy to find the explanatory comment that goes along
>> >> with it?
>> >> E.g.,
>> >>
>> >> #define __init __init_not_supported_in_efi_stub
>> >
>> > This would produce a compilation failure if someone tags something as
>> > __init right? Looks fine to me.
>>
>> Yes, but it makes the error message difficult to decipher, since
>> __init is printed and not what it resolves to. Locally, I tried this,
>> which seems to work:
>>
>> #undef __init
>> #define __init __attribute__((__init_not_supported_in_efi_stub))
>> #pragma GCC diagnostic error "-Wattributes"
>>
>> which produces
>>
>>   CC      drivers/firmware/efi/libstub/arm-stub.o
>> /home/ard/linux-2.6/drivers/firmware/efi/libstub/arm-stub.c:24:1:
>> error: ?__init_not_supported_in_efi_stub? attribute directive ignored
>> [-Werror=attributes]
>>  {
>>  ^
>> cc1: some warnings being treated as errors
>>
>> which is slightly dodgy, but at least puts the string right in the error message
>
> What about,
>
> #define __init __compiletime_error("__init not supported in EFI boot stub")
>

That only works for invocations, i.e., it needs to be used in header
files, and will trigger the error if a call to the function remains
after optimization. We want it at function definition time instead.
