From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 3 Jan 2014 09:13:46 +0100
Subject: [PATCH RFC] CRYPTO: Fix more AES build errors:
In-Reply-To: <CAKv+Gu9SrF_jkNc1ie+AX07YVGUdAYMGoKnJopFyirwh=acDVQ@mail.gmail.com>
References: <E1Vylu8-0005Q9-MO@rmk-PC.arm.linux.org.uk>
 <CAKv+Gu9SrF_jkNc1ie+AX07YVGUdAYMGoKnJopFyirwh=acDVQ@mail.gmail.com>
Message-ID: <CAKv+Gu8sWLFnRZtuWOw2n96amAVc604Vk_HWD-9S6q1bZ5grhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 January 2014 19:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 2 January 2014 18:17, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
>> Building a multi-arch kernel results in:
>>
>> arch/arm/crypto/built-in.o: In function `aesbs_xts_decrypt':
>> sha1_glue.c:(.text+0x15c8): undefined reference to `bsaes_xts_decrypt'
>> arch/arm/crypto/built-in.o: In function `aesbs_xts_encrypt':
>> sha1_glue.c:(.text+0x1664): undefined reference to `bsaes_xts_encrypt'
>> arch/arm/crypto/built-in.o: In function `aesbs_ctr_encrypt':
>> sha1_glue.c:(.text+0x184c): undefined reference to `bsaes_ctr32_encrypt_blocks'
>> arch/arm/crypto/built-in.o: In function `aesbs_cbc_decrypt':
>> sha1_glue.c:(.text+0x19b4): undefined reference to `bsaes_cbc_encrypt'
>>
>
> Interestingly, when I try to reproduce this, the reference is
> (correctly) reported to reside in aesbs-glue.c and not sha1_glue.c
>
>> This code is already runtime-conditional on NEON being supported, so
>> there's no point compiling it out depending on the minimum build
>> architecture.
>>
>
> Agreed. It is a leftover from the way this code was embedded into
> OpenSSL originally.
>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
>> This is more a request for acks since I'd like to keep it/push it through
>> my tree to reduce the autobuilder failures.
>>
>>  arch/arm/crypto/bsaes-armv7.pl |    2 +-
>
> The .S_shipped file produced by this script should be updated at the same time.
>

Hello Russell,

I noticed that this patch has turned up in rmk/fixes.

Please be aware that by not updating the .S_shipped file in concert
with the .pl file, we have a build time dependency on Perl now,
something we tried to avoid when we discussed the original series
http://marc.info/?l=linux-arm-kernel&m=138091140313491&w=2

Regards,
Ard.
