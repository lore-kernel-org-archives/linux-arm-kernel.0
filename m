From: marex@denx.de (Marek Vasut)
Date: Thu, 9 Feb 2017 12:14:22 +0100
Subject: Aarch64 kernel with 32bit userspace question
In-Reply-To: <CAKv+Gu-U484qCRJ+VS4kX3eRLzdJN=_1Z57atR8VgZidQfv7Dg@mail.gmail.com>
References: <0057242a-2e16-3b59-1f81-9f4ccf64216d@denx.de>
 <CAKv+Gu-U484qCRJ+VS4kX3eRLzdJN=_1Z57atR8VgZidQfv7Dg@mail.gmail.com>
Message-ID: <0747bd41-7a87-6dd6-11bf-58729ad2c3d8@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2017 11:51 AM, Ard Biesheuvel wrote:
> On 9 February 2017 at 10:14, Marek Vasut <marex@denx.de> wrote:
>> Hi,
>>
>> I'm trying multilib userland on aarch64, but I'm running into a problem.
>> I have a simple test code:
>>
>> -->8--
>> #include <signal.h>
>>
>> int main(void) {
>>     return 0;
>> }
>> --8<--
>>
>> If I compile that with aarch64 gcc , it compiles just fine.
>>
>> If I compile the same thing with 32bit armv7ahf multilib gcc, the
>> build fails on "unknown type name '__uint128_t'". This comes from
>> arch/arm64/include/uapi/asm/sigcontext.h , which has __uint128_t in
>> struct fpsimd_context {} . The signal.h includes that (through a few
>> glibc headers) and that's what triggers the failure. __uint128_t is
>> defined on aarch64 , but it is not on armv7a (32bit).
>>
> 
> This is a toolchain or glibc bug: the arm64 version of that header
> should never be pulled in when using a AArch32 toolchain, regardless
> of whether you run it on arm64, ARM (or x86, for that matter)

Aha. So which version of the header should be pulled in ? The one from
arch/arm/include/uapi/asm/sigcontext.h (that doesn't make much sense to
me) ?

-- 
Best regards,
Marek Vasut
