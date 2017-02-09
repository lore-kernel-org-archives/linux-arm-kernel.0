From: marex@denx.de (Marek Vasut)
Date: Thu, 9 Feb 2017 11:14:19 +0100
Subject: Aarch64 kernel with 32bit userspace question
Message-ID: <0057242a-2e16-3b59-1f81-9f4ccf64216d@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm trying multilib userland on aarch64, but I'm running into a problem.
I have a simple test code:

-->8--
#include <signal.h>

int main(void) {
    return 0;
}
--8<--

If I compile that with aarch64 gcc , it compiles just fine.

If I compile the same thing with 32bit armv7ahf multilib gcc, the
build fails on "unknown type name '__uint128_t'". This comes from
arch/arm64/include/uapi/asm/sigcontext.h , which has __uint128_t in
struct fpsimd_context {} . The signal.h includes that (through a few
glibc headers) and that's what triggers the failure. __uint128_t is
defined on aarch64 , but it is not on armv7a (32bit).

Grepping through the kernel sources , __uint128_t is used in some three
places on aarch64 (and in bluetooth/ecc.c , where it's defined as a
struct of two u64 internally in that file, so irrelevant). I wonder
whether the usage of __uint128_t is really correct in sigcontext.h and
whether it shouldn't be replaced by some u64 array or such ?

Or is there any other way to use aarch64 kernel (and kernel headers)
with 32bit userspace ?

Thanks!

-- 
Best regards,
Marek Vasut
