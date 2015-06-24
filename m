From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 Jun 2015 10:51:06 +0200
Subject: [PATCH] XOR implementation for ARMv8
In-Reply-To: <558A6A76.6060705@linaro.org>
References: <463b2fe9.7d02.14e245e3541.Coremail.liuxiaodong@nudt.edu.cn>
 <558A6A76.6060705@linaro.org>
Message-ID: <CAKv+Gu8hpKzcdeZ7eZjKNHqtP+xSb415tjL000oD-BBxM_J2Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2015 at 10:29, J?r?me Forissier <jerome.forissier@linaro.org> wrote:
>
>
> On 06/24/2015 09:00 AM, ??? wrote:
>> Use the 128-bit SIMD registers and SIMD arithmetic instructions for XOR calculation in assembly language.
>
> Don't you need kernel_neon_begin()/kernel_neon_end() somewhere? (see
> Documentation/arm/kernel_mode_neon.txt).
>

Jerome is right: use of this driver will corrupt the FP/SIMD state of
arbitrary userland tasks if you don't explicitly claim the NEON for
in-kernel use by calling kernel_neon_begin)_ and end()

Since XOR may be called in interrupt context, this could add a fixed
overhead to each call, even if you are calling the function many times
in a row. This means you may be better off using even fewer registers,
and use kernel_neon_begin_partial() instead.

May I ask what kind of core you tested this on?

-- 
Ard.
