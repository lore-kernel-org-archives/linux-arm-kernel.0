From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Sep 2015 12:17:36 +0100
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
Message-ID: <20150917111735.GN25444@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 02:42:17PM +0000, Jungseok Lee wrote:
> Currently, kernel context and interrupts are handled using a single
> kernel stack navigated by sp_el1. This forces many systems to use
> 16KB stack, not 8KB one. Low memory platforms naturally suffer from
> memory pressure accompanied by performance degradation.
> 
> This patch addresses the issue as introducing a separate percpu IRQ
> stack to handle both hard and soft interrupts with two ground rules:
> 
>   - Utilize sp_el0 in EL1 context, which is not used currently
>   - Do not complicate current_thread_info calculation
> 
> It is a core concept to trace struct thread_info using sp_el0 instead
> of sp_el1. This approach helps arm64 align with other architectures
> regarding object_is_on_stack() without additional complexity.

I'm still trying to understand how this patch works. I initially thought
that we would set SPSel = 0 while in kernel thread mode to make use of
SP_EL0 but I can't find any such code. Do you still use SP_EL1 all the
time and SP_EL0 just for temporary saving the thread stack?

-- 
Catalin
