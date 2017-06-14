From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jun 2017 11:06:41 +0100
Subject: Using __always_inline attribute
In-Reply-To: <2a762f1f3b355e71c5bca6a6e00bffe0@codeaurora.org>
References: <2a762f1f3b355e71c5bca6a6e00bffe0@codeaurora.org>
Message-ID: <20170614100641.GB16190@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Prasad,

On Tue, Jun 13, 2017 at 03:39:37PM -0700, Sodagudi Prasad wrote:
> With a variant of a CLANG(based on 4.0) following errors observed on Linux
> 4.12-rc5 tag.

How are you building the kernel with clang, btw? I'd be keen to try the same
thing, but I thought the LLVMLinux project was largely dead at his point. Do
you still need build system patches, or is this now integrated with Kbuild?

> net/built-in.o: In function `__xchg_mb':
> arch/arm64/include/asm/cmpxchg.h:99: \
>                     undefined reference to `__compiletime_assert_99'
> arch/arm64/include/asm/cmpxchg.h:99: \
>                     undefined reference to `__compiletime_assert_99
> 
> Clang does not seems to be marking this macro as inline and causing above
> compilation issue due to BUILD_BUG().

The only BUILD_BUG I see around here is if the size parameter (which is
calculated using sizeof) is not known to be 1,2,4 or 8 at compile time. It
would be interesting to know which call site is confusing clang in this way
and what code is actually being emitted here.

If it's just that __xchg_mb isn't being inlined into the __xchg_wrapper
macro, then your patch should be ok, but I'd like to be sure it's not
something else. I'm also surprised you haven't see this crop up in other
places.

Will
