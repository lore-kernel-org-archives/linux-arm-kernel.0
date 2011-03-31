From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 31 Mar 2011 10:17:27 +0100
Subject: [PATCH] ARM: vfp: Remote obsolete fpmx_state field from
	vfp_hard_struct
In-Reply-To: <20110330175236.GB2939@n2100.arm.linux.org.uk>
References: <1301489184-4112-1-git-send-email-dave.martin@linaro.org>
	<1301489184-4112-2-git-send-email-dave.martin@linaro.org>
	<20110330175236.GB2939@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikhKRZF=hirQRRZPFP8N+v0-rkDG8t710axMBz=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 6:52 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Mar 30, 2011 at 01:46:24PM +0100, Dave Martin wrote:
>> The fpmx_state field was presumably used in the past, when
>> FSTMX/FLDMX were used to save and resture the VFP state.
>>
>> This was been deprecated since ARMv6, the context switch code
>> has been ported to use the double-precision load/store variants
>> many years ago, and now it appears that nothing in the kernel
>> references this field any more.
>
> Wrong.
>
> ? ? ? ?.macro ?VFPFSTMIA, base, tmp
> #if __LINUX_ARM_ARCH__ < 6
> ? ? ? ?STC ? ? p11, cr0, [\base],#33*4 ? ? ? ? ? ? @ FSTMIAX \base!, {d0-d15}
> #else
> ? ? ? ?STC ? ? p11, cr0, [\base],#32*4 ? ? ? ? ? ? @ FSTMIAD \base!, {d0-d15}
> #endif
>
> So, building for pre-ARMv6, it's still used.
>

Fair point -- looks like my grepping missed those.  Oops.

While I'm looking at this file though...  vfpmacros.h starts with:

@ Macros to allow building with old toolkits (with no VFP support)

I don't think we support building the kernel with such old binutils
any more.  Maybe this file could be simplified?  arch/arm/vfp/ seems
to be built with -mfpu=softvfp+vfp, which appears to enable most of
the affected mnemonics.

vfpmacros.h also contains some oddities such as:

#ifdef CONFIG_VFPv3
#if __LINUX_ARM_ARCH__ <= 6
    /*...*/

Since we don't support building a single kernel across ARMv5 and
ARMv7, are these blocks effectively dead code?

Cheers
---Dave
