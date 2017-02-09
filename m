From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 9 Feb 2017 10:51:43 +0000
Subject: Aarch64 kernel with 32bit userspace question
In-Reply-To: <0057242a-2e16-3b59-1f81-9f4ccf64216d@denx.de>
References: <0057242a-2e16-3b59-1f81-9f4ccf64216d@denx.de>
Message-ID: <CAKv+Gu-U484qCRJ+VS4kX3eRLzdJN=_1Z57atR8VgZidQfv7Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 February 2017 at 10:14, Marek Vasut <marex@denx.de> wrote:
> Hi,
>
> I'm trying multilib userland on aarch64, but I'm running into a problem.
> I have a simple test code:
>
> -->8--
> #include <signal.h>
>
> int main(void) {
>     return 0;
> }
> --8<--
>
> If I compile that with aarch64 gcc , it compiles just fine.
>
> If I compile the same thing with 32bit armv7ahf multilib gcc, the
> build fails on "unknown type name '__uint128_t'". This comes from
> arch/arm64/include/uapi/asm/sigcontext.h , which has __uint128_t in
> struct fpsimd_context {} . The signal.h includes that (through a few
> glibc headers) and that's what triggers the failure. __uint128_t is
> defined on aarch64 , but it is not on armv7a (32bit).
>

This is a toolchain or glibc bug: the arm64 version of that header
should never be pulled in when using a AArch32 toolchain, regardless
of whether you run it on arm64, ARM (or x86, for that matter)



> Grepping through the kernel sources , __uint128_t is used in some three
> places on aarch64 (and in bluetooth/ecc.c , where it's defined as a
> struct of two u64 internally in that file, so irrelevant). I wonder
> whether the usage of __uint128_t is really correct in sigcontext.h and
> whether it shouldn't be replaced by some u64 array or such ?
>
> Or is there any other way to use aarch64 kernel (and kernel headers)
> with 32bit userspace ?
>
> Thanks!
>
> --
> Best regards,
> Marek Vasut
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
