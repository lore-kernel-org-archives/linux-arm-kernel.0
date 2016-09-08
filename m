From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 8 Sep 2016 20:19:05 +0200
Subject: [PATCH] atomic64: No need for
 CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
In-Reply-To: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
References: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
Message-ID: <20160908181905.GY10153@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 09:28:18AM -0700, Vineet Gupta wrote:
> This came to light when implementing native 64-bit atomics for ARCv2.
> 
> The atomic64 self-test code uses CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> to check whether atomic64_dec_if_positive() is available.
> It seems it was needed when not every arch defined it.
> However as of current code the Kconfig option seems needless
> 
> - for CONFIG_GENERIC_ATOMIC64 it is auto-enabled in lib/Kconfig and a
>   generic definition of API is present lib/atomic64.c
> - arches with native 64-bit atomics select it in arch/*/Kconfig and
>   define the API in their headers
> 
> So I see no point in keeping the Kconfig option
> 
> Compile tested for 2 representatives:
>  - blackfin (CONFIG_GENERIC_ATOMIC64)
>  - x86 (!CONFIG_GENERIC_ATOMIC64)
> 
> Also logistics wise it seemed simpler to just do this in 1 patch vs.
> splitting per arch - but I can break it up if maintainer feel that
> is better to avoid conflicts.

Works for me; you want me to take this, or do you need it for you ARCv2
patches?
