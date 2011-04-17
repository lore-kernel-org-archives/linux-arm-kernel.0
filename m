From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 17 Apr 2011 10:23:20 +0300
Subject: [PATCH] ARM: fix badly implementation of wmb
In-Reply-To: <1302884511-14152-1-git-send-email-tom.leiming@gmail.com>
References: <1302884511-14152-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <BANLkTikByisrp7wDnRK+hFcD-Vcy8eYYvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 April 2011 19:21,  <tom.leiming@gmail.com> wrote:
> From: Ming Lei <tom.leiming@gmail.com>
>
> Commit e7c5650f6067f65f8e961394f376d4862808d0d2
>
> ? ? ? ?ARM: 5996/1: ARM: Change the mandatory barriers implementation (4/4)
>
> implements wmb as dsb plus outer_sync, which will make wmb
> much more strict than required. In fact, it is enough for dmb to
> keep the partial order of two stores, so restore wmb as dmb to
> fix possible performance degrade caused by the commit e7c5650f.
>
> Also the patch defines __iowmb as mb to fix the issue which the
> commit e7c5650f addressed.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

NAK.

I thought that after the whole discussion around my rmb() patch it was
clear that we need a dsb for both wmb and rmb.

Three points:

1. Linux I/O accessors must be ordered in relation to Normal
non-cacheable memory (DMA buffers) accesses (Linus' requirement - they
should behave like x86). Therefore they need DSBs around them.

2. You can use relaxed I/O accessors with explicit mb()/wmb()/rmb().
In this case, you also need DSB in the mandatory barriers.

3. Because Normal non-cacheable memory acceses are buffered at the L2
cache level, we need to drain its buffer in the mb()/wmb() case, hence
the outer_sync() call.

If you find alternatives to the points above I may agree with your patch.

Please note that there have been several discussions on LKML around
barriers for I/O vs Normal memory and the consensus was *not* to
introduce additional barrier types since device drivers don't use them
anyway.

Can you show many situations where you would need mandatory barriers
but not in relation to I/O?

-- 
Catalin
