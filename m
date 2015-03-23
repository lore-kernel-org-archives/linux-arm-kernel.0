From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Mar 2015 17:03:50 +0100
Subject: [PATCH] ARM: kvm: implement replacement for ld's LOG2CEIL()
In-Reply-To: <20150323114001.GF11189@arm.com>
References: <1427107977-18591-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150323114001.GF11189@arm.com>
Message-ID: <CAKv+Gu8vGsSO0bMWy_7mWuUB9vDpFq8PkbcnHrX-hVwbOQAdxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 March 2015 at 12:40, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Mar 23, 2015 at 10:52:57AM +0000, Ard Biesheuvel wrote:
>> Commit 06f75a1f6200 ("ARM, arm64: kvm: get rid of the bounce
>> page") uses ld's builtin function LOG2CEIL() to align the
>> KVM init code to a log2 upper bound of its size. However,
>> this function turns out to be a fairly recent addition to
>> binutils, which breaks the build for older toolchains.
>>
>> So instead, implement a replacement LOG2_ROUNDUP() using
>> the C preprocessor.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> Linker map output after applying this patch:
>>
>>                 0xc09a2590                __idmap_text_end = .
>>                 [...]
>>  *fill*         0xc09a2590       0x70
>>                 0xc09a2600                __hyp_idmap_text_start = .
>>  *(.hyp.idmap.text)
>>  .hyp.idmap.text
>>                 0xc09a2600      0x100 arch/arm/kvm/built-in.o
>>                 0xc09a2600                __kvm_hyp_init
>>                 0xc09a26ec                __kvm_hyp_init_end
>>                 0xc09a2700                __hyp_idmap_text_end = .
>>
>> which confirms that the alignemnt is correct. The size of the region
>> is 0xec bytes, and 0x70 bytes of padding are emitted to align it at
>> a 0x100 byte boundary
>>
>>  arch/arm/kernel/vmlinux.lds.S | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> Thanks Ard. I pushed this on top of kvm-bounce-page and re-generated
> for-next/core.
>

OK. I double checked the ARM build with your version, and it looks the same.

I also built and booted it on my Seattle using 4k/3 levels, and
everything works as expected.

Cheers,
Ard.
