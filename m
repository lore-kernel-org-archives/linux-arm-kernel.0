From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Sep 2015 17:24:09 +0200
Subject: [RFC PATCH] arm64/efi: isolate EFI stub from the kernel proper
In-Reply-To: <20150915144629.GG31157@arm.com>
References: <1442311903-19213-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150915144629.GG31157@arm.com>
Message-ID: <CAKv+Gu8j1APZkGnFhZArNAtoyYOokP2bgemYH5n7Pn8jQ1b1XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 September 2015 at 16:46, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Sep 15, 2015 at 11:11:43AM +0100, Ard Biesheuvel wrote:
>> Since arm64 does not use a builtin decompressor, the EFI stub is built
>> into the kernel proper. So far, this has been working fine, but actually,
>> since the stub is in fact a PE/COFF relocatable binary that is executed
>> at an unknown offset in the 1:1 mapping provided by the UEFI firmware, we
>> should not be seamlessly sharing code with the kernel proper, which is a
>> position dependent executable linked at a high virtual offset.
>>
>> So instead, separate the contents of libstub and its dependencies, by
>> putting them into their own namespace by prefixing all of its symbols
>> with __efistub. This way, we have tight control over what parts of the
>> kernel proper are referenced by the stub.
>
> Could we add an __efistub annotation to spit out warnings if the stub
> calls into unexpected kernel code, like we do for __init/__ref?
>

Currently, it will break the build rather than warn if you use a
disallowed symbol, which I think is not unreasonable.

But I suppose that the objcopy step in this patch could rename the
sections to .efistub.xxx sections, which would allow us to reuse some
of the section mismatch code.
However, this would involve marking things like the generic string and
memcpy routines __efistub as well, which I think may be too much.
Also, note that the logic is inverted here: with __init, we disallow
normal code to call __init functions, but with __efistub, it will be
the other way around, which may be more difficult to accomplish
(Rutland and I did discuss this option when we talked about this over
IRC)

-- 
Ard.
